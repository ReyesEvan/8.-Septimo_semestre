-- Database reader and cache reader/writer
local Reader = {}

--open a file and read line by line

local file                      = assert(io.open("cran/cran.all.1400", r))
local currentLine               -- Current line to be scanned
local count                     = 0


-- Table where all the documents will be stored
Reader.documents = {}


-- FUNCTIONS

-- Given a multiline string, returns an iterator that iterates on each line
function Reader.stringIterator(s)
    if s:sub(-1) ~= "\n" then s = s .. "\n" end
    return s:gmatch("(.-)\n")
end

-- Given a string with document-format, obtain the single line containing the .I tag and returns the digit alongside
-- now stored as an int instead of string
function Reader.getIndex(str)
    for line in Reader.stringIterator(str) do
        if string.match(line, ".I ") then
            return tonumber(string.match(line, "%d+"))
        end
    end
    print("This string doesn't contain an ID tag")
end

-- Generic. Given a string with document-format, returns the data located below a tag.
function Reader.getTag(str,tag)
    local read -- boolean
    local get = "" -- holds data, might be multi-line

    for line in Reader.stringIterator(str) do

        -- Found another section
        if (string.match(line, ".%u") and read==true) then
            read = false

        -- Section found, add to result
        elseif read then
            get = get..line.." "

        end

        -- section found, read next line
        if string.match(line, tag) then
            read = true
        end

    end


    if get ~= "" and get ~= nil then
        return get
    else
        -- TODO: Check documents with missing tags
        -- print("This string doesnt have tag "..tag)
    end

end

-- Given a read document in memory 'doc', prints the internal information
function Reader.printDoc(doc)
    print(doc.I)
    print(doc.T)
    print(doc.A)
    print(doc.B)
    print(doc.W)
end

-- Given a source document, or cran.all.1400 by default, generates a table containing all the documents
function Reader.generate(source)
    --optional source
    if source ~= nil then
        file = assert(io.open(source, r))
    end
    -- Begins the iteration over the file
    local currentLine = file:read("*line")

     -- Stops when currentLine == nil == EOF
    while currentLine do

        local currentDocument           = {}    -- Table with the following structure: {I=, T=, A= , B= , W=, ...}. Will contain every document found and be appended to the documents table
        local currentDocumentText       = ""    -- String containing the current document to be processed
        local currentComponents         = 0     -- Counter of the components found in the currently processing document (a component is a line with a tag ".[ITABW]")

        -- print("---------- BEGIN DOCUMENT ----------")
        while (currentLine and (currentComponents < 5 or not string.match(currentLine, ".I"))) do
            if string.match(currentLine, "%.[ITABW]") then
                currentComponents = currentComponents + 1
            end

            currentDocumentText = currentDocumentText .. currentLine .. "\n"

            currentLine = file:read("*line")
        end

        currentDocumentText = string.gsub(currentDocumentText, "'s", "s")
        currentDocumentText = string.gsub(currentDocumentText, "-", " ")
        --currentDocumentText = string.gsub(currentDocumentText, "\n", " ")
        -- print(currentDocumentText)
        -- print("Components: " .. currentComponents)
        -- print("---------- END DOCUMENT ----------")

        count = count + 1

        currentDocument.I = Reader.getIndex(currentDocumentText)
        currentDocument.A = Reader.getTag(currentDocumentText, ".A")
        currentDocument.T = Reader.getTag(currentDocumentText, ".T")
        currentDocument.B = Reader.getTag(currentDocumentText, ".B")
        currentDocument.W = Reader.getTag(currentDocumentText, ".W")

        -- printDoc(currentDocument)

        Reader.documents[currentDocument.I] = currentDocument
    end

    return Reader.documents
end



return Reader
