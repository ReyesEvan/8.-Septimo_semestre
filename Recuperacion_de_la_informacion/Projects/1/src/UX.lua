local Query = require "src/Query"

-- User interaction Module
local UX = {}



--Display available commands from global table COMMAND_OPTIONS
function displayCommands()

    -- check global
    if COMMAND_OPTIONS == nil then
        io.write("Command options not set")
        return
    end

    --iterate over available commands
    for i,command in ipairs(COMMAND_OPTIONS) do
        io.write(command)
    end

end

--Display query info
function queryInfo()
    io.write("\n")
    line()
    io.write("\tYou can enter your query by using terms and boolean operators.\n")
    io.write("\tThe only accepted operators are: \n")
    io.write("\t\t ! for boolean negation (NOT). It has to be written before the term to be negated\n")
    io.write("\t\t & for boolean conjuctive (AND). It must have one term on each side\n")
    io.write("\t\t | for boolean disjuntive (OR). It must have one term on each side\n")
    io.write("\t\t You may use parentheses to order your operators\n")
    io.write("\n\tAny operator or word that do not fulfill the previous specifications will be ignored\n")
    io.write("\tEnter / to signal end of session\n")
    line()
    --io.write("\tEnter EXIT to exit the program\n")
end

-- Print a break line
function line()
    io.write("----------------------------------------------------------------------------------------------------------\n")
end


-- Display greeting and usage info
function UX.welcome()
    line()
    io.write("Welcome to Brumple (BRMwPL).\nWhat will you search today?\n\n")
    queryInfo()

end

-- Display exit mesage
function UX.goodbye()
    line()
    io.write("\nHave a nice day\n")
end

-- Wait for input in order to continue
function UX.continue()
    io.write("\nPress enter to continue...\n")
    return io.read("*line")
end

-- Detect a command , or single backslash
function UX.escape(input)
    if string.match(input, "/") then
        return true
    else
        return false
    end
end

-- Ask for valid command from global COMMAND_OPTIONS
function UX.getCommand()
    local input

    io.write("\n\nPlease select an option\n")
    io.write("Available commands:\n")
    displayCommands()

    input = io.read("*line") -- read a number
    input = tonumber(input)
    while input == nil or input <= 0 or input > #COMMAND_OPTIONS do
        io.write("Invalid option, please select a valid command\n")
        displayCommands()
        input = io.read("*line") -- read a number
        input = tonumber(input)
    end

    return input
end

-- Ask for a user query
function UX.getQuery()
    local input
    local valid = false

    line()
    io.write("\nInput your query: \n")

    input = io.read("*line")
    valid = Query.validate(input)
    while not valid do
        io.write("Invalid squery entered. Only symbols accepted: a-z, A-Z, &, |, (), ! and spaces\n")
        io.write("Please enter a valid query\n")
        queryInfo()
        input = io.read("*line")
        valid = Query.validate(input)
    end

    return input
end

-- Prints results of query search
function UX.printResults(r)
    if type(r) == "String" then
        io.write(r)
    else
        line()
        line()
        io.write("Search results: \n")
        for k, v in pairs(finalResult) do
            io.write("Document ",k,"\t\t")
        end
    end
    io.write("\n\n")
end

return UX
