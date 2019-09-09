-- open modules
UX                              = require "src/UX"
Reader                          = require "src/Reader"
Stack                           = require "src/Stack"
Tokenize                        = require "src/Tokenize"
Postfix                         = require "src/Postfix"
Query                           = require "src/Query"



-- Actions --

-- Read Posting List from Cached memory
function loadCache()
    POSTING_LIST = Tokenize.readCache()
end

-- Generate Posting List from document store
function generatePL()
    DOCUMENTS = Reader.generate()
    --POSTING_LIST = Tokenize.generatePostingList()
    POSTING_LIST = Tokenize.generatePostingList(DOCUMENTS)

end




-- Gloabl Variables
COMMAND_OPTIONS                 = { " 1. Loade Cache\n", " 2. Generate Posting List\n"}
COMMAND_ACTIONS                 = { loadCache , generatePL }
DOCUMENTS                       = {}
POSTING_LIST                    = {}



-- MAIN --

-- Local Variables
local option                    -- User selected option
local query                     -- User defined query


-- User interaction
UX.welcome()

option = UX.getCommand()
COMMAND_ACTIONS[option]()

while true do
    query = UX.getQuery()
    if UX.escape(query) then break end
    UX.printResults( Query.process(query) )
end

UX.goodbye()
