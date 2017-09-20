local log = require "util.log"

local package = require "dpm.package"

local M = {}

M.VERSION = "0.0.3"

function M.init()
    log.i("Init new local project")
    package.init()
end

function M.install(params)
    if params and #params > 0 then
        log.i("Install package to local dpm.package", unpack(params))
        package.install(unpack(params))
        -- TODO: add support for : sparation
    else
        print("Install expects additional instructions")
    end
end

function M.command(cmd, params)    
    if cmd == "init" then
        M.init()
    end

    if cmd == "install" then
        M.install(params)
    end
end

return M