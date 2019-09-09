local Stack = require "bin/Stack"
local Postfix = require "bin/Postfix"
local Tokenize = require "bin/Tokenize"



local PL = {}

-- Given a subpart of the query, extracts and returns a table of tokens for its later processing
function getTokens(str)
    tokens = {}
    for token in str:gmatch "[!&|(]" do
        table.insert(tokens, token)
    end

    postingListFound = PL[str:match "%w+"]

    if postingListFound then
        table.insert(tokens, postingListFound)
    else
        table.insert(tokens, {})
    end

    for token in str:gmatch "[)]" do
        table.insert(tokens, token)
    end

    return tokens
end

-- ------- FUNCTIONS TO PROCESS EACH OPERATOR WITHIN A QUERY ----------

-- @param operand1, operand2 - tables whose keys correspond to the documents' IDs that contains one word
function AND(operand1, operand2)
    result = {}
    for i = 1, 1400 do
        result[i] = operand1[i] and operand2[i]
    end

    return result
end

function OR(operand1, operand2)
    result = {}
    for i = 1, 1400 do
        result[i] = operand1[i] or operand2[i]
    end

    return result
end

function NOT(operand)
    result = {}

    for i = 1, 1400 do
        if operand[i] then
            result[i] = nil
        else
            result[i] = true
        end
    end

    -- return "(! " .. operand .. ")"
    return result
end

-- Associative table that links an operator to the function
-- that should be applied whenever that operation is found
-- along with the amount of arguments it requires to work
-- Will be send to Postfix.executeExpression
local functions = {}
functions["!"] = {argsExpected = 1, fun = NOT}
functions["&"] = {argsExpected = 2, fun = AND}
functions["|"] = {argsExpected = 2, fun = OR}

--------------------------------------------------


-- * Obtaining the query from the user
print("Welcome to this boolean retrieval model\n\n")
print("\t\tYou can enter your own query by using terms and boolean operators")
print("\t\tThe only accepted operators are: ")
print("\t\t\t ! for boolean negation (NOT). It has to be written before the term to be negated")
print("\t\t\t & for boolean conjuctive (AND). It has to have one term at each side")
print("\t\t\t | for boolean disjuntive (OR). It has to have one term at each side")
print("\n\tAny operator or word that do not fulfill the previous specifications will be ignored")
print("\n\n\n\t\tInput your query: ")
-- input = io.read("*l")
input = "aerodynamics | arises"
PL = Tokenize.generatePostingList()

-- * Reject any query that includes any symbol that cannot be searched
if string.match(input, "[^%a%s!&|()%d]") then
    print("Invalid symbol entered. Only symbols accepted: a-z, A-Z, &, |, ! and spaces")

else
    infixTokens = {} -- Table that'll hold the *useful* tokens in the query (neatly)

    -- The first [negated] term of the query is the only way a term can be either alone
    -- or without operator at its right, that's why its separated, to assure that it always exists
    -- and it's valid (might begin with ! but always holds a word after that)
    firstWordStart, firstWordEnd = input:find "^%(*!?%(*%w+%)?"

    if firstWordStart then
        inputHead = input:sub(firstWordStart, firstWordEnd) -- first [negated] term of the query
        inputTail = input:sub(firstWordEnd + 1, #input) -- rest of the query

        -- The valid tokens [!, word] of the query's first part are obtained and pushed into infixTokens table
        for _, token in pairs(getTokens(inputHead)) do
            table.insert(infixTokens, token)
        end

        -- The rest of the query is analyzed here.
        -- Only the ocurrences where a valid operator (&, |) is followed by an optional NOT (!) and a term are considered
        -- The iteration occurs only over those "pairs" (operator [not] word). The rest is ignored.
        -- The pairs are "tokenized" and its valid tokens are pushed into the infixTokens table
        for pair in inputTail:gmatch "[&|]%s*%(*%s*!*%s*%(*%w+%)*" do
            for _, token in pairs(getTokens(pair)) do
                table.insert(infixTokens, token)
            end
        end

        -- The user is informed of the parts of their query that are going to be taked into account
        -- print("Your query will be interpreted as: " .. table.concat(infixTokens, " ")) -- TODO: fix to work with non-only-string tables

        -- The *valid* query then is transformed into an equivalent postfix expression
        postfixTokens = Postfix.convertToPostfix(infixTokens)

        if postfixTokens == -1 then
            print("There were a closing parentheses without its opening one")
        elseif postfixTokens == -2 then
            print("There were an opening parentheses without its closing one")
        else
            print("Succesfully converted")
        end

        -- The postfix expression is now actually evaluated by using the custom functions
        -- assigned to each operator in the table functions
        finalResult = Postfix.executeExpression(postfixTokens, functions)
    else
        print("The query is not written correctly. It has to begin with either a term or a NOT (!) operator")
    end
end
