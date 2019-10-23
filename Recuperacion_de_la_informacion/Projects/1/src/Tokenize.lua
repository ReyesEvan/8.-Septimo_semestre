-- TODO description
local Tokenize = {}

local document1 = {
    I = "1",
    T = "title 1 .",
    A = "author 1 .",
    B = "data 1 .",
    W = [[
        experimental investigation of the aerodynamics of a
wing in a slipstream .
  an experimental study of a wing in a propeller slipstream was
made in order to determine the spanwise distribution of the lift
increase due to slipstream at different angles of attack of the wing
and at different free stream to slipstream velocity ratios .  the
results were intended in part as an evaluation basis for different
theoretical treatments of this problem .
  the comparative span loading curves, together with
supporting evidence, showed that a substantial part of the lift increment
produced by the slipstream was due to a /destalling/ or
boundary-layer-control effect .  the integrated remaining lift
increment, after subtracting this destalling lift, was found to agree
well with a potential flow theory .
  an empirical evaluation of the destalling effects was made for
the specific configuration of the experiment .
    ]]
}

local document2 = {
    I = "2",
    T = "title 2 .",
    A = "author 2 .",
    B = "data 2 .",
    W = [[
        simple shear flow past a flat plate in an incompressible fluid of small
viscosity .
in the study of high-speed viscous flow past a two-dimensional body it
is usually necessary to consider a curved shock wave emitting from the
nose or leading edge of the body .  consequently, there exists an
inviscid rotational flow region between the shock wave and the boundary
layer .  such a situation arises, for instance, in the study of the
hypersonic viscous flow past a flat plate .  the situation is somewhat
different from prandtl's classical boundary-layer problem . in prandtl's
original problem the inviscid free stream outside the boundary layer is
irrotational while in a hypersonic boundary-layer problem the inviscid
free stream must be considered as rotational .  the possible effects of
vorticity have been recently discussed by ferri and libby .  in the
present paper, the simple shear flow past a flat plate in a fluid of small
viscosity is investigated .  it can be shown that this problem can again
be treated by the boundary-layer approximation, the only novel feature
being that the free stream has a constant vorticity .  the discussion
here is restricted to two-dimensional incompressible steady flow .
    ]]
}

local document3 = {
    I = "3",
    T = "title 3 .",
    A = "author 3 .",
    B = "data 3 .",
    W = [[the boundary layer in simple shear flow past a flat plate .
    the boundary-layer equations are presented for steady
    incompressible flow with no pressure gradient .
    ]]
}

local documents = {document1, document2, document3}



-- Local variables
local postingList = {}



-- Given a table with documents structured in {ITABW} form, generte a posting list
function Tokenize.generatePostingList(source)
    if not source then source = documents end

    -- Get a document with its id
    for id, components in pairs(source) do
        -- post contents of document
        if components.W then post(components.W, id) end
        if components.A then post(components.A, id) end
        if components.B then post(components.T, id) end
    end

    serialize(postingList)
    return postingList
end

-- Given a posting list stored as a lua module, reads the contents to the internal table
function Tokenize.readCache()
    C = require "cache"
    --io.write(cache.val,"\n")
    -- io.write(tostring(C.PL))
    return C.PL
end



-- Given a string, adds the words to the posting list if they dont exist, and adds a reference to the document ID
function post(content, id)
    for word in content:gmatch("%w+") do
        -- if postingList[word] then
        --     postingList[word][id] = true
        -- else
        --     postingList[word] = {}
        --     postingList[word][id] = true
        -- end
        if not postingList[word] then postingList[word] = {} end
        postingList[word][id] = true
    end
end



-- Serializes the posting list into a string for printing
function serialize(pl)
    local CF = assert(io.open("cache.lua", "w"))

    --CF:write("local cache = {}\n\n")
    --CF:write("cache.postingList = { \n")
    --for key,value in pairs(pl) do

    --    CF:write("\t\"",key,"\"={\n")
    --    local output = ""
    --    for k,v in pairs(value) do
    --        --io.write("\t\t\"",k,"\"=",tostring(v),",\n")
    --        output = output.."\t\t\""..k.."\"="..tostring(v)..",\n"
    --    end
    --    output = output:sub(1,-3).."\n\t},\n"
    --    CF:write(output)
    --end
    --CF:write("\t1\n}")

    CF:write("local C = {}\n\n\n")
    CF:write("C.PL = {} \n\n")
    for key,value in pairs(pl) do

        CF:write("C.PL[\"",key,"\"] = {}\n")
        for k,v in pairs(value) do
            --io.write("\t\t\"",k,"\"=",tostring(v),",\n")
            --output = output.."\t\t\""..k.."\"="..tostring(v)..",\n"
            CF:write("\tC.PL[\"", key, "\"][", k, "] = true\n")
        end
        --CF:write("\n\t},\n")
    end
    --CF:write("\t1\n}")

    CF:write("\nreturn C\n")
    CF:close()
end




return Tokenize
