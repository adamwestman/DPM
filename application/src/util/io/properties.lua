local M = {}

function M.exists(path)
   local f=io.open(path,"r")
   if f~=nil then io.close(f) return true else return false end
end

function M.load(path)
    assert(path, "Requires a path|filename")

    local properties = {}

    local category = nil
    for line in io.lines(path) do
        if string.match(line, "^%[.+") then
            category = string.match(line, "^%[(.+)%]$")
            properties[category] = {}
        elseif category and string.match(line, "^(.+)%=(.+)$") then 
            local key, value = string.match(line, "^(.+)%=(.+)$")
            properties[category][key]=value
        end
    end

    return properties
end

function M.save(properties, path)
    assert(properties, "Requires properties")
    assert(path, "Requires a path|filename")

    local file = io.open(path, "w+")

    for category, fields in pairs(properties) do
        file:write(string.format("[%s]\n", category))
        for key, value in pairs(fields) do
            file:write(string.format("%s=%s\n", key, tostring(value)))
        end
        file:write("\n")
    end

    file:close()
end

return M