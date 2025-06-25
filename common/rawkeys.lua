-- https://www.reddit.com/r/pico8/comments/1dlz5z8/change_input_keys/
-- https://www.lexaloffle.com/dl/docs/pico-8_manual.html#Mouse_and_Keyboard_Input

function rawkeys_init()
  poke(0x5f2d,1)
end

function kbtn(key)
---@diagnostic disable-next-line: redundant-parameter
    return stat(28, key)
end