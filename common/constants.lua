screen = {
    w = 128,
    h = 128
}

colors = {
    black = 0,
    dark_blue = 1,
    dark_purple = 2,
    dark_green = 3,
    brown = 4,
    dark_gray = 5,
    light_gray = 6,
    white = 7,
    red = 8,
    orange = 9,
    yellow = 10,
    green = 11,
    blue = 12,
    indigo = 13,
    pink = 14,
    peach = 15,
}

--
stat_codes = {
    -- System
    mem_usage = 0,    -- Memory usage (0..2048)
    cpu = 1,          -- CPU used since last flip (1.0 == 100% CPU)
    clipboard = 4,    -- Clipboard contents (after user has pressed CTRL-V)
    param_string = 6, -- Parameter string
    framerate = 7,    -- Current framerate

    -- Keyboard and Mouse

    raw_keyboard = 28,       -- Raw keyboard input (stat(28, scancode) returns true if key with scan code is pressed)
    keypress_available = 30, -- True when a keypress is available
    keyboard_char = 31,      -- Character returned by keyboard
    mouse_x = 32,            -- Mouse X
    mouse_y = 33,            -- Mouse Y
    mouse_buttons = 34,      -- Mouse buttons (bitfield)
    mouse_wheel = 36,        -- Mouse wheel event
    mouse_rel_x = 38,        -- Relative x movement (host desktop pixels)
    mouse_rel_y = 39,        -- Relative y movement (host desktop pixels)

    -- Audio
    -- Audio values 16..26 are the legacy version of audio state queries 46..56.
    -- They only report on the current state of the audio mixer, which changes only
    -- ~20 times a second (depending on the host sound driver and other factors).
    -- 46..56 instead stores a history of mixer state at each tick to give a higher resolution
    -- estimate of the currently audible state.

    sfx_channels = { 46, 47, 48, 49 }, -- Index of currently playing SFX on channels 0..3
    note_channels = { 50, 51, 52, 53 }, -- Note number (0..31) on channel 0..3
    pattern_index = 54,               -- Currently playing pattern index
    total_patterns_played = 55,       -- Total patterns played
    ticks_on_pattern = 56,            -- Ticks played on current pattern
    music_playing = 57,               -- (Boolean) TRUE when music is playing

    -- Time
    utc_time = { 80, 81, 82, 83, 84, 85 }, -- UTC time: year, month, day, hour, minute, second
    local_time = { 90, 91, 92, 93, 94, 95 }, -- Local time

    --
    breadcrumb_label = 100, -- Current breadcrumb label, or nil
    frame_by_frame = 110,   -- Returns true when in frame-by-frame mode
}

keys = {
    left = 0,
    right = 1,
    up = 2,
    down = 3,
    a = 4,
    b = 5,
}