local M = {}

-- @param instruction [string] eg, "continue with this operation (y/n)? "
-- @output "instruction (fallback) "
-- @return user input or fallback
function M.optional(instruction, fallback)
    assert(instruction, "Requires an instruction message")

    if fallback then
        io.write(string.format("%s (%s) ",instruction, fallback))
    else
        io.write(string.format("%s ",instruction))
    end

    io.flush()
    local answer=io.read()

    return answer == "" and fallback or answer
end

-- @param instruction [string] eg, "continue with this operation (y/n)? "
-- @output "instruction "
-- @return user input
function M.request(instruction, pattern)
    assert(instruction, "Requires an instruction message")

    pattern = pattern or ".+"

    local answer
    repeat
        io.write(instruction)
        io.flush()
        answer=io.read()
    until string.match(answer, pattern)

    return answer
end

function M.cwd(file)
    local chr = os.tmpname():sub(1,1)
    if chr == "/" then
      -- linux
      chr = "/[^/]*$"
    else
      -- windows
      chr = "\\[^\\]*$"
    end
    return arg[0]:sub(1, arg[0]:find(chr))..(file or '')
end

return M