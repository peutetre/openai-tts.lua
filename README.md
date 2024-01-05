# Openai-tts

Neovim plugin to call [Openai text to speech API](https://platform.openai.com/docs/guides/text-to-speech)

# Install

with lazy.nvim

``` lua
return {
    "peutetre/openai-tts.lua"
}
```

# Token and config

Save token: `:TTS token set yourtoken`

Remove token: `:TTS token remove`

Set voice: `:TTS voice set alloy` (available voice: allow (default), echo. fable, onyx, nova and shimmer)

Set model: `:TTS model set tts-1` (available model: tts-1 (default) and tts-1-hd)

# Create speech

Select the text to speech and then run 

`:TTS`

to create mp3 in the current directory
