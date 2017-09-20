local properties = require "util.io.properties"
local input = require "util.io.input"
local log = require "util.log"

local M = {}

local DPM_PACKAGE = "dpm.package"
local DEFOLD_PROJECT = "game.project"


--- Call init DPM on the location.
-- Creates a dpm.package if not already setup, based on the local game.project if that exists.
function M.init(commands)
    
    if properties.exists(DPM_PACKAGE) then
        log.i("DPM is already initialized")
        return
    end

    local title, version
    if properties.exists(DEFOLD_PROJECT) then
        log.i("Init DPM based on local game.project")
        local proj = properties.load(DEFOLD_PROJECT)

        title = proj.project and proj.project.title or "Example"
        version = proj.project and proj.project.version or "0.0.1"
    else
        log.i("Init DPM based on input")
        print([[
This utility will walk you through creating a dpm.package file.
It only covers the most common items, and tries to guess sensible defaults.

See `dpm help package` for definitive documentation on these fields
and exactly what they do.

Use `dpm install <pkg>` afterwards to install a package and
save it as a dependency in the dpm.package file.

Press ^C at any time to quit.]])

        name = input.request("package name: ")
        version = input.optional("version:", "1.0.0")

        -- ask for description:
        -- ask for entry point: (index.js)
        -- ask for test command:
        -- ask for git repository:
        -- ask for keywords:
        -- ask for author:
        -- ask for license: (ISC):
        --[[
            About to write to /Users/adamwestman/experimental/DPM/application/build/package.json:

            {
            "name": "build",
            "version": "1.0.0",
            "description": "blah blah",
            "main": "index.js",
            "scripts": {
                "test": "echo \"Error: no test specified\" && exit 1"
            },
            "author": "awf",
            "license": "ISC"
            }


            Is this ok? (yes)
        --]]
    end
    
    properties.save({
        package = {
            name = name,
            version = version,
        }
    }, DPM_PACKAGE)
end

--- Add DPM package dependency.
function M.install(package_name, version_rule)
    assert(properties.exists(DPM_PACKAGE), "DPM is not setup")

    assert(package_name, "Package name is required")
    version_rule = version_rule or "+"

    local package = properties.load(DPM_PACKAGE)

    if not package.dependencies then
        package.dependencies = {}
    end
    package.dependencies[package_name] = version_rule

    properties.save(package, DPM_PACKAGE)

    M.resolve()
end

--- Resolve DPM dependencies.
-- Updates the game.project dependencies based on local dpm package.
function M.resolve()
    assert(properties.exists(DPM_PACKAGE), "DPM is not setup")

    local proj
    if properties.exists(DEFOLD_PROJECT) then
        log.i("load local game.project")

        proj = properties.load(DEFOLD_PROJECT)

    else
        log.i("game.project missing, generating")

        local package = properties.load(DPM_PACKAGE)
        if not package.package then
            log.e("dpm.package is not setup correctly")
        end

        proj = {
            project = {
                title = package.package.name,
                version = package.package.version,
            }
        }
    end

    --TODO: resolve the dependencies

    properties.save(proj, DEFOLD_PROJECT)
end

return M
