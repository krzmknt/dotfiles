-- default stackline config
-- TODO: Experiment with setting __index() metatable to leverage autosuggest when keys not found

c = {}
c.paths = {}
c.appearance = {}
c.features = {}
c.advanced = {}

-- Paths
local function getCommandOutput(cmd)
	local handle = io.popen(cmd) -- コマンドを実行して出力を取得
	local result = handle:read("*a") -- 全ての出力を読み込む
	handle:close() -- ハンドルを閉じる
	return result:match("^%s*(.-)%s*$") -- 前後の空白を除去して返す
end

c.paths.yabai = getCommandOutput("which yabai")

-- Appearance
c.appearance.color = { white = 0.90 } -- Indicator background color, e.g., {red = 0.5, blue = 0 }
c.appearance.alpha = 1 -- Opacity of active indicators
c.appearance.dimmer = 5 -- Higher numbers increase contrast b/n focused & unfocused state
c.appearance.iconDimmer = 3 -- Higher numbers dim inactive icons *less* than the non-icon indicators
c.appearance.showIcons = true -- Window indicator style ('lozenge'-shaped when false)
c.appearance.size = 24 -- Size of window indicators (height when icons off)
c.appearance.radius = 5 -- Indicator roundness. Higher numbers → *less* roundness… I'm sorry
c.appearance.iconPadding = 2 -- Space between icon & indicator edge. Higher numbers → smaller, more inset icons
c.appearance.pillThinness = 6 -- Aspect ratio of pill-style icons (width = size / pillThinness)

c.appearance.vertSpacing = 1.3 -- Amount of vertical space between indicators

c.appearance.offset = {} -- Offset controls position of stack indicators relative to the window
c.appearance.offset.y = 2 -- Distance from top of the window to render indicators
c.appearance.offset.x = 8 -- Distance away from the edge of the window to render indicators

c.appearance.shouldFade = true -- Enable/disable fade animations
c.appearance.fadeDuration = 0.2 -- Duration of fade animations (seconds)

-- Features
c.features.clickToFocus = true -- Click indicator to focus window. Mouse clicks are tracked when enabled
c.features.hsBugWorkaround = true -- Workaround for https://github.com/Hammerspoon/hammerspoon/issues/2400

c.features.fzyFrameDetect = {} -- Round window frame dimensions by fuzzFactor before identifying stacked windows
c.features.fzyFrameDetect.enabled = true -- Enable/disable fuzzy frame detection
c.features.fzyFrameDetect.fuzzFactor = 30 -- Window frame dimensions will be rounded to nearest fuzzFactor

c.features.winTitles = "not_implemented" -- Valid options: false, true, 'when_switching', 'not_implemented'
c.features.dynamicLuminosity = "not_implemented" -- Valid options: false, true, 'not_implemented'

c.advanced.maxRefreshRate = 0.5 -- How aggressively to refresh Stackline. Higher = slower response time + less battery drain

return c
