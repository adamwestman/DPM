local log = require "util.log"
local dpm = require "dpm"

local help_txt = [[
    DPM - the Defold Package Manager

    Commands:
    -h --help        : output DPM usage information
    -V --version     : output DPM version number
    init             : setup a new local DPM library
    install          : add a project dependency
    version          : output project version number

    Options:
    --debug          : output all debug information
    --info           : output info level and above debug information
    --warning        : output warning level and above debug information
    --error          : output error level and above debug information
]]


for i, cmd in ipairs(arg) do
    if cmd == "--debug" then
        log.set_level(1)
    end
    if cmd == "--info" then
        log.set_level(2)
    end
    if cmd == "--warning" then
        log.set_level(3)
    end
    if cmd == "--error" then
        log.set_level(4)
    end
    
    if cmd == "-h" or cmd == "--help" then
        print(help_txt)
    end

    dpm.command(cmd)

    log.d("cmd", i , "=", cmd)
end
