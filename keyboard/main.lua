function _init()
  poke(0x5f2d,1)
end

function _draw()
  cls()
--   for y=0,15 do
--     for x=0,15 do
--       circfill(4+x*8,4+y*8,3,
--           stat(28,x+y*16) and 7 or 1)
--     end
--   end
    if kbtn(key.a) then
        color(colors.brown)
        rect(0, 0, 10, 10)
        
    end
end