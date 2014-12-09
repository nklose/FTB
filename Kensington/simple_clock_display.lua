--[[Kensington Network
    Displays a simple clock for the in-game time on a monitor attached to the left of the computer.
--]]

m = peripheral.wrap("left")
print("Running display script; CTRL+T to terminate.")
 
m.setTextScale(3)
while true do
  m.clear()
  m.setCursorPos(2,2)
  m.setTextColor(colors.yellow)
  m.write(textutils.formatTime(os.time(), true))
  m.setCursorPos(2,3)
  sleep(0.5)
end