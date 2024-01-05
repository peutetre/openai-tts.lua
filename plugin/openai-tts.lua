local completion_store = {
  [""] = { "token", "voice", "model" },
  token = { "set", "get", "remove" },
  voice = { "set", "get" },
  model = { "set", "get"}
}

vim.api.nvim_create_user_command("TTS", function (opts)
  local params = vim.split(opts.args, "%s+", { trimempty = true })

  local mod, action = params[1], params[2]

  -- default module
  if not mod then
    mod = "tts"
  end

  -- load module
  local ok, module = pcall(require, "openai-tts." .. mod)

  if not ok then
    print("[TTS] Unable to load module: " .. mod .. " " .. module)
    return
  end

  -- default actions
  if not action then
    if mod == "tts" then
      action = "run"
    elseif mod == "token" then
      action = "get"
    elseif mod == "voice" then
      action = "get"
    elseif mod == "model" then
      action = "get"
    end
  end


  if not module[action] then
    print("[TTS] Unknown params: " .. opts.args)
    return
  end

  module[action](params)

end, {
  bang = true,
  nargs = "*",
  complete = function(_, cmd_line)
    local has_space = string.match(cmd_line, "%s$")
    local params = vim.split(cmd_line, "%s+", { trimempty = true })

    if #params == 1 then
      return completion_store[""]
    elseif #params == 2 and not has_space then
      return vim.tbl_filter(function(cmd)
        return not not string.find(cmd, "^" .. params[2])
      end, completion_store[""])
    end

    if #params >= 2 and completion_store[params[2]] then
      if #params == 2 then
        return completion_store[params[2]]
      elseif #params == 3 and not has_space then
        return vim.tbl_filter(function(cmd)
          return not not string.find(cmd, "^" .. params[3])
        end, completion_store[params[2]])
      end
    end
  end,
})
