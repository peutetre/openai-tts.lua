local util = require('openai-tts.util')
local M = {}

function M.set(params)
  if #params ~= 3 then
    util.echo("1 token needed")
    return
  end

  local userdata = util.userdata()
  userdata.token= params[3]
  local j = vim.json.encode(userdata)
  vim.api.nvim_eval( "writefile(['" ..  j  .. "'], '" .. util.find_config_path() .. "/openai-tts/config.json')")
  util.echo("token saved")
end

M.get = function()
  util.echo('token: ' .. util.userdata().token)
end

function M.remove()
  local userdata = util.userdata()
  userdata.token= ''
  local j = vim.json.encode(userdata)
  vim.api.nvim_eval( "writefile(['" ..  j  .. "'], '" .. util.find_config_path() .. "/openai-tts/config.json')")
  util.echo("token removed")
end

return M
