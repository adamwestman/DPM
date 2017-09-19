--local project = require "defold.project"

local verbose = false

local help_txt = [[
    DPM - the Defold Package Manager

    Commands:
    -help -h        : Print this
    -verbose -v     : Set verbose printing
]]

for i, arg in ipairs({...}) do
    if arg == "-v" then
        verbose = true
        print("Verbose")
    end
    
    if arg == "-h" or arg == "--help" then
        print(help_txt)
    end

    if verbose then
        print("Arg", i, '=', arg)
    end
end

print("From main")

--project.new()