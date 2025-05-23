local logger = {}

-- ログレベルの定義
logger.levels = {
  DEBUG = 1,
  INFO  = 2,
  WARN  = 3,
  ERROR = 4,
}

-- 最大ラベル長の計算
local max_level_length = 0
for level, _ in pairs(logger.levels) do
  max_level_length = math.max(max_level_length, #level)
end

logger.current_level = logger.levels.DEBUG

function logger.set_level(level)
  local lvl = logger.levels[level:upper()]
  if lvl then
    logger.current_level = lvl
  else
    error("Invalid log level: " .. tostring(level))
  end
end

-- 内部でのログ出力関数
local function log(level_name, fmt, ...)
  local level_val = logger.levels[level_name]
  if level_val >= logger.current_level then
    local time = os.date("%Y-%m-%d %H:%M:%S")
    local message = string.format(fmt, ...)
    local padded_level = level_name .. string.rep(" ", max_level_length - #level_name)

    -- 呼び出し元の情報を取得する
    local info = debug.getinfo(3, "nSl")
    local func_name = (info and info.name) or "anonymous"
    local line = (info and info.currentline) or 0

    print(string.format("[%s][%s][%s:%d] %s", time, padded_level, func_name, line, message))
  end
end

-- 各ログレベル用の関数
function logger.debug(fmt, ...)
  log("DEBUG", fmt, ...)
end

function logger.info(fmt, ...)
  log("INFO", fmt, ...)
end

function logger.warn(fmt, ...)
  log("WARN", fmt, ...)
end

function logger.error(fmt, ...)
  log("ERROR", fmt, ...)
end

return logger
