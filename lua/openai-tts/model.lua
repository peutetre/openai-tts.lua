local util = require('openai-tts.util')
local M = {}

function M.set(params)
  if params[3] ~= 'tts-1' and params[3] ~= 'tts-1-hd' then
    util.echo("allowed values: tts-1 and tts-1-hd")
    return
  end

  local userdata = util.userdata()
  userdata.model = params[3]
  local j = vim.json.encode(userdata)
  vim.api.nvim_eval( "writefile(['" ..  j  .. "'], '" .. util.find_config_path() .. "/openai-tts/config.json')")
  util.echo("model saved")
end

M.get = function()
  util.echo('model: ' .. util.userdata().model)
end

return M
