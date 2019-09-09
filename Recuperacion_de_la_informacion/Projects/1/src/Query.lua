local Query = {}



-- Given a subpart of the query, extracts and returns a table of tokens for its later processing
function getTokens(str)
    tokens = {}
    for token in str:gmatch "[!&|]" do
        table.insert(tokens, token)
    end

    postingListFound = POSTING_LIST[str:match "%w+"]

    if postingListFound then
        table.insert(tokens, postingListFound)
    else
        table.insert(tokens, {})
    end

    return tokens
end



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


-- given an input string, checks wether or not it has appropriate syntax
function Query.validate(input)

    -- * Reject any query that includes any symbol that cannot be searched
    if string.match(input, "[^%a%s!&|()%d/]") then
        return false
    else
        return true
    end

end

-- given a valid query string, processes and returns adequate documents
function Query.process(query)
    infixTokens = {} -- Table that'll hold the *useful* tokens in the query (neatly)

    -- The first [negated] term of the query is the only way a term can be either alone
    -- or without operator at its right, that's why its separated, to assure that it always exists
    -- and it's valid (might begin with ! but always holds a word after that)
    firstWordStart, firstWordEnd = query:find "^%(*%s*!?%(*%w+%)*"

    if firstWordStart then
        queryHead = query:sub(firstWordStart, firstWordEnd) -- first [negated] term of the query
        queryTail = query:sub(firstWordEnd + 1, #query) -- rest of the query

        queryToInterpret = queryHead

        -- The valid tokens [!, word] of the query's first part are obtained and pushed into infixTokens table
        for _, token in pairs(getTokens(queryHead)) do
            table.insert(infixTokens, token)
        end

        -- The rest of the query is analyzed here.
        -- Only the ocurrences where a valid operator (&, |) is followed by an optional NOT (!) and a term are considered
        -- The iteration occurs only over those "pairs" (operator [not] word). The rest is ignored.
        -- The pairs are "tokenized" and its valid tokens are pushed into the infixTokens table
        for pair in queryTail:gmatch "[&|]%s*%(*%s*!*%s*%(*%w+%)*" do
            queryToInterpret = queryToInterpret .. " " .. pair
            for _, token in pairs(getTokens(pair)) do
                table.insert(infixTokens, token)
            end
        end
        -- The user is informed of the parts of their query that are going to be taked into account
        print("Your query will be interpreted as: " .. queryToInterpret)

        -- The *valid* query then is transformed into an equivalent postfix expression
        postfixTokens = Postfix.convertToPostfix(infixTokens)
        -- print("Your query has been transformed into: " .. table.concat(postfixTokens, " "))
        if postfixTokens == -1 then
            -- io.write("There was a closing parentheses without its opening one\n")
            return "There was a closing parentheses without its opening one\n"
        elseif postfixTokens == -2 then
            -- io.write("There was an opening parentheses without its closing one\n")
            return "There was an opening parentheses without its closing one\n"
        end

        -- The postfix expression is now actually evaluated by using the custom functions
        -- assigned to each operator in the table functions
        return Postfix.executeExpression(postfixTokens, functions)
    else
        return "The query is not written correctly. It has to begin with either a term or a NOT (!) operator\n"
    end

end


return Query
