local Stack = require "src/Stack"
local PostfixModule = {}

local precedence                = {}
precedence["!"]                 = 3
precedence["&"]                 = 2
precedence["|"]                 = 1


-- Given a sequence of tokens sorted in infix order, converts and returns it in postfix order
function PostfixModule.convertToPostfix(infix)
    local stack = Stack.stack:Create()
    local postfix = {}
    local parenthesesCounter = 0

    for _, token in pairs(infix) do
        if type(token) == 'table' then
            table.insert(postfix, token)
        elseif token == "(" then
            stack:push(token)
            parenthesesCounter = parenthesesCounter + 1
        elseif token == ")" then
            if parenthesesCounter == 0 then
                return -1 -- * There were a closing parentheses without its opening one
            else
                popped = stack:pop()
                while popped ~= "(" do
                    table.insert(postfix, popped)
                    popped = stack:pop()
                end
                parenthesesCounter = parenthesesCounter - 1
            end
        else
            peeked = stack:peek()
            if not peeked or peeked:match "[(]" then
                stack:push(token)
            else
                while peeked and not peeked:match "%(" and precedence[token] <= precedence[peeked] do
                    popped = stack:pop()
                    table.insert(postfix, popped)
                    peeked = stack:peek()
                end
                stack:push(token)
            end
        end
    end

    if parenthesesCounter ~= 0 then return -2 end -- * There were an opening parentheses without its closing one

    -- *: iterate over the remaining in the stack and enqueue them into postfix
    while stack:peek() do
        p = stack:pop()
        table.insert(postfix, p)
    end

    return postfix
end

-- Generic function that takes an postfix expression and returns the result of it
-- @param postfix - a key ordered table where each key's value correspond to an operand or operator in postfix order: {1: 3, 2: 5, 3: +}
-- @param functions - a table with keys referencing to the operator,
--          each element should be a table containing the function to apply when that operator is found and the number or arguments it expects
function PostfixModule.executeExpression(postfix, functions)
    local operandStack = Stack.stack:Create()
    local result

    for _, token in pairs(postfix) do
        if type(token) == 'table' then
            operandStack:push(token)
        else
            args = {}
            for i = 1, functions[token]["argsExpected"] do
                p = operandStack:pop()
                table.insert(args, p)
            end
            result = functions[token]["fun"](unpack(args))
            operandStack:push(result)
        end
    end

    finalResult = operandStack:pop()

    return finalResult
end


return PostfixModule
