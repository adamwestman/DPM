local log = require "util.log"

local project = require "defold.project"

local M = {}

M.VERSION = "0.0.2"

function M.version()
    print("DPM Version: ", M.VERSION)
end

function M.init()
    log.i("Init new project")
    local proj = project.new()

    project.save_to_file(proj)
end

function M.command(cmd)
    if cmd == "-V" or cmd == "--version" then
        M.version()
    end
    
    if cmd == "-i" or cmd == "--init" then
        M.init()
    end
end

return M