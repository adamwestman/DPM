local project = require "defold.project"
--local commands = require("commands")

local VERSION = "0.0.1"

local help_txt = [[
    DPM - the Defold Package Manager

    Commands:
    -h --help        : output usage information
    -V --version     : output the version number

    Options:
    --debug          : output all debug information
    --info           : output info level and above debug information
    --warning        : output warning level and above debug information
    --error          : output error level and above debug information
]]

local log_level = 3
local function log(level, tag, ...)
    if level >= log_level then
        print(tag, ...)
    end
end
local debug = function(...) 
    log(1, "DEBUG", ...)
end
local info = function(...) 
    log(2, "INFO", ...)
end
local warning = function(...) 
    log(3, "WARNING", ...)
end
local critial = function(...) 
    log(4, "CRITIAL", ...)
    if log_level > 2 then
        error("Failed at execution.\nTo output additional information specify --debug or --info")
    else
        error("Failed at execution")
    end
end

for i, cmd in ipairs(arg) do
    if cmd == "--debug" then
        log_level = 1
    end
    if cmd == "--info" then
        log_level = 2
    end
    if cmd == "--warning" then
        log_level = 3
    end
    if cmd == "--error" then
        log_level = 4
    end
    
    if cmd == "-h" or cmd == "--help" then
        print(help_txt)
    end

    if cmd == "-V" or cmd == "--version" then
        print("DPM Version: ", VERSION)
    end

    debug("cmd", i , "=", cmd)
end

print("From main")

project.new()