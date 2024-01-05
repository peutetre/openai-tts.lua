local M = {}

function M.echo(message)
  vim.cmd('echom "[TTS] ' .. tostring(message):gsub('"', '\\"') .. '"')
end

function M.api(sk, data)
  return 'curl -s https://api.openai.com/v1/audio/speech' ..
    ' -H "Content-Type: application/json" -H "Authorization: Bearer ' .. sk ..
    '" -d \'' ..
    string.gsub(vim.json.encode(data), "'", "'\\''") ..
    '\' ' ..
    '--output ' .. tostring(os.time()) .. '.mp3'
end

function M.find_config_path()
  local config = vim.fn.expand("$XDG_CONFIG_HOME")
  if config and vim.fn.isdirectory(config) > 0 then
    return config
  elseif vim.fn.has("win32") > 0 then
    config = vim.fn.expand("~/AppData/Local")
    if vim.fn.isdirectory(config) > 0 then
      return config
    end
  else
    config = vim.fn.expand("~/.config")
    if vim.fn.isdirectory(config) > 0 then
      return config
    else
      print("Error: could not find config path")
    end
  end
end


M.userdata = function()

  local conf = M.find_config_path() .. "/openai-tts/config.json"

  if(vim.fn.filereadable(conf) == 0) then
    local userdata = { voice = 'alloy', model = 'tts-1', token = 'changeme' }
    local j = vim.json.encode(userdata)
    vim.fn.mkdir(M.find_config_path() .. "/openai-tts", 'p')
    vim.api.nvim_eval( "writefile(['" ..  j  .. "'], '" .. M.find_config_path() .. "/openai-tts/config.json')")
  end

  local userdata = vim.json.decode(
    vim.api.nvim_eval("readfile('" .. conf .. "')")[1]
  )
  return userdata
end

return M
