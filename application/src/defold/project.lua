local M = {}

function M.new()
    print("project.new()")
    return {}
end

function M.save_to_file(project, path)
    local file = io.open("game.project", "w+")
    file:write("[project]\n")
    file:write("title=example\n")
    io.close(file)
end

function M.read_from_file(path)

end

function M.add_dependency(project_name, version_rule)

end

return M