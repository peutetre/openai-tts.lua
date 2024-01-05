local util = require('openai-tts.util')
local M = {}

function M.set(params)
  if params[3] ~= 'alloy' and params[3] ~= 'echo' and params[3] ~= 'fable' and params[3] ~= 'onyz' and params[4] ~= 'nova' and params[3] ~= 'shimmer' then
    util.echo("allowed values: alloy, fable, onyz, nova or shimmer")
    return
  end

  local userdata = util.userdata()
  userdata.voice = params[3]
  local j = vim.json.encode(userdata)
  vim.api.nvim_eval( "writefile(['" ..  j  .. "'], '" .. util.find_config_path() .. "/openai-tts/config.json')")
  util.echo("voice saved")
end

M.get = function()
  util.echo('voice: ' .. util.userdata().voice)
end

return M
