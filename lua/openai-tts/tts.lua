local util = require('openai-tts.util')
local M = {}

function M.run()
  local userdata = util.userdata()
  local vstart = vim.fn.getpos("'<")
  local vend = vim.fn.getpos("'>")
  local line_start = vstart[2]
  local line_end = vend[2]
  local lines = vim.fn.getline(line_start,line_end)

  local data = {
    model = userdata.model,
    voice = userdata.voice,
    input = table.concat(lines, ' ')
  }

  local cmd = util.api(userdata.token, data)
  local t = vim.fn.system(cmd)
  util.echo(t)
end

return M
