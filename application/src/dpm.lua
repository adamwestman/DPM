local log = require "util.log"

local project = require "defold.project"

local M = {}

M.VERSION = "0.0.2"

function M.version()
    print("DPM Version: ", M.VERSION)
end

function M.init()
    log.i("Init new local project")
    local proj = project.new()

    project.save_to_file(proj)
end

function M.add_package()
    log.i("Add package to local project")
    local proj = project.load_from_file()

    project.add_package(proj, "debeat")

    project.save_to_file(proj)
end

function M.project_version()
    log.i("Print version of local project")
    local proj = project.load_from_file()
    print(proj.project.title, proj.project.version)
end

function M.command(cmd)
    if cmd == "-V" or cmd == "--version" then
        M.version()
    end
    
    if cmd == "init" then
        M.init()
    end

    if cmd == "install" then
        M.add_package()
    end

    if cmd == "version" then
        M.project_version()
    end
end

return M