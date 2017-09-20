local log = require "util.log"
local dpm = require "dpm"

local help_txt = [[
    DPM - the Defold Package Manager

    Commands:
    -h --help        : output DPM usage information
    -V --version     : output DPM version number
    init             : setup a new local DPM library
    install          : add a project dependency

    Options:
    --debug          : output all debug information
    --info           : output info level and above debug information
    --warning        : output warning level and above debug information
    --error          : output error level and above debug information
]]

while #arg > 0 do
    local cmd = table.remove(arg, 1)
    
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
    elseif cmd == "-V" or cmd == "--version" then
        print("DPM Version: ", dpm.VERSION)
    end

    log.d("cmd", cmd)
    
    dpm.command(cmd, arg)
end
