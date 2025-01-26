hs.ipc.cliInstall()

local hs = hs
POINTER = nil
POINTER_LIFETIME = nil

local function mouseHighlight()
  -- Delete an existing highlight if it exists
  if POINTER then
    POINTER:delete()
    if POINTER_LIFETIME then
      POINTER_LIFETIME:stop()
    end
  end

  -- Get the current co-ordinates of the mouse pointer
  local mousepoint = hs.mouse.absolutePosition()

  -- Prepare a big red circle around the mouse pointer
  local radius = 20
  POINTER = hs.drawing.circle(hs.geometry.rect(
    mousepoint.x - radius, mousepoint.y - radius, radius * 2, radius * 2))
  POINTER:setStrokeColor({ ["red"] = 255, ["blue"] = 40, ["green"] = 0, ["alpha"] = 0.9 })
  POINTER:setFill(false)
  POINTER:setStrokeWidth(5)
  POINTER:show()

  -- Set a timer to delete the circle after 3 seconds
  POINTER_LIFETIME = hs.timer.doAfter(3, function()
    POINTER:delete()
    POINTER = nil
  end)
end

hs.hotkey.bind({ "alt" }, "q", mouseHighlight)


-- ========================
-- Stackline

local stackline = require "stackline"
stackline:init()




-- ========================
-- CheetSheet


local function createTextElement(frame, text)
  return {
    type = "text",
    text = text,
    textColor = { white = 1.0 }, -- 文字色を白に設定
    textFont = "Menlo",          -- 等幅フォントを使用
    textSize = 15.0,
    textAlignment = "left",      -- 左揃え
    frame = frame,
    padding = 10.0,              -- パディングを追加
    lineBreak = "charWrap",      -- 改行を有効にする
  }
end

local function getFileText(filePath)
  local text = hs.execute(string.format("cat %s", filePath))
  return text
end

local function splitTextIntoColumns(text, maxWidth, maxHeight, charPerLine)
  local lines = {}
  for line in text:gmatch("(.-)\n") do
    table.insert(lines, line)
  end

  local columns = {}
  local linesPerColumn = math.floor(maxHeight / 20) -- 1行の高さを20px程度と仮定
  local currentColumn = {}

  for i, line in ipairs(lines) do
    if #line > charPerLine then
      line = line:sub(1, charPerLine - 3) .. "..." -- 長い行を切り詰め
    end
    table.insert(currentColumn, line)
    if #currentColumn >= linesPerColumn then
      table.insert(columns, table.concat(currentColumn, "\n"))
      currentColumn = {}
    end
  end

  if #currentColumn > 0 then
    table.insert(columns, table.concat(currentColumn, "\n"))
  end

  return columns
end

local function showCheatSheet()
  local canvas = require("hs.canvas")

  -- 画面サイズを取得
  local screen = hs.screen.mainScreen()
  local screenFrame = screen:frame()
  local width = screenFrame.w * 0.75
  local height = screenFrame.h * 0.75
  local x = (screenFrame.w - width) / 2
  local y = (screenFrame.h - height) / 2

  -- canvas 作成
  local sheet = canvas.new { x = x, y = y, h = height, w = width }

  -- 背景設定
  sheet[1] = {
    type = "rectangle",
    action = "fill",
    fillColor = { black = 0.0, alpha = 0.6 },              -- 背景色を黒に設定
    roundedRectRadii = { xRadius = 20.0, yRadius = 20.0 }, -- 角を丸くする
  }

  -- ファイル内容を取得
  local fileText = getFileText("~/ghq/github.com/krzmknt/dotfiles/cheetsheet.txt")

  -- テキストを列に分割
  local charPerLine = 100 -- 1行あたりの文字数
  local columns = splitTextIntoColumns(fileText, width, height, charPerLine)

  -- 列ごとにテキストを配置
  local columnWidth = width / #columns
  local padding = 20 -- ウィンドウ縁のパディングを大きく設定
  for i, columnText in ipairs(columns) do
    sheet[i + 1] = createTextElement(
      { x = (i - 1) * columnWidth + padding, y = padding, w = columnWidth - (2 * padding), h = height - (2 * padding) }, -- パディングを考慮した配置
      columnText
    )
  end

  -- シート表示
  sheet:show()

  return sheet
end

local function deleteCheatSheet(sheet)
  if sheet then
    sheet:delete()
  end
end

-- ショートカットキーを alt + w に設定
hs.hotkey.bind({ 'alt' }, 'w', function()
  cheatSheet = showCheatSheet()
end, function()
  deleteCheatSheet(cheatSheet)
end)
