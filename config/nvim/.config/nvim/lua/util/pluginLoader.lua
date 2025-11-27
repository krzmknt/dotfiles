local logger = require("util.logger")
local M = {}

--- プラグイン読み込み用の reuiqre のラッパー関数
--
-- pcall(require,packageName) の結果の 1 つ目が false の場合はログ出力して nil を返します。
-- したがって、次のように nil チェックをして読み込み失敗時のハンドリングを行ってください。
--
-- ```
-- local avante = plugin.load("avante")
-- if avante == nil then return end
-- ```
--
-- @param pluginName string: require するプラグインの名前
-- @param enable boolean: 読み込みが有効がどうか。false の場合は読み込まない
-- @return table: require の結果
function M.load(props)
	props = props or {}
	props.pluginName = props.pluginName or nil
	if props.enable == nil then
		props.enable = true
	end

	if props.pluginName == nil then
		logger.error('The argument "pluginName" must be specified.')
		return nil
	end

	if not props.enable then
		logger.info(string.format('Skip loading "%s".', props.pluginName))
		return nil
	end

	local ok, package = pcall(require, props.pluginName)

	if ok then
		logger.info(string.format('Loaded "%s".', props.pluginName))
		return package
	end

	logger.error(package)
	return nil
end

return M
