local M = {}

function M.new(title, version)
    title = title or "Example"
    version = version or "0.0.1"

    print("project.new()")
    return {
        project = {
            title = title,
            version = version,
        }
    }
end

function M.save_to_file(project, path)
    assert(project, "Requires a project")

    local file = io.open("game.project", "w+")

    for category, fields in pairs(project) do
        file:write(string.format("[%s]\n", category))
        for key, value in pairs(fields) do
            file:write(string.format("%s=%s\n", key, tostring(value)))
        end
        file:write("\n")
    end

    file.close()
end

function M.load_from_file(path)
    local project = {}

    local category = nil
    for line in io.lines("game.project") do
        if string.match(line, "^%[.+") then
            category = string.match(line, "^%[(.+)%]$")
            project[category] = {}
        elseif category and string.match(line, "^(.+)%=(.+)$") then 
            local key, value = string.match(line, "^(.+)%=(.+)$")
            project[category][key]=value
        end
    end

    return project
end

function M.add_package(project,  package_name, version_rule)
    assert(project)
    assert(package_name)
    version_rule = version_rule or "+"

    if not project.dpm then
        project.dpm = {}
    end
    project.dpm[package_name] = version_rule
end

return M