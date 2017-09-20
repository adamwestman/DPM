
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
local critical = function(...) 
    log(4, "CRITIAL", ...)
    if log_level > 2 then
        error("Failed at execution.\nTo output additional information specify --debug or --info")
    else
        error("Failed at execution")
    end
end

local M = {
    debug = debug,
    d = debug,

    info = info,
    i = info,

    warn = warning,
    w = warning,

    error = critical,
    e = critical,
}

function M.set_level(level)
    log_level = level
end

return M
