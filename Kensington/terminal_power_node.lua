--[[Kensington Network
    To be run on a computer attached to an MSFU.
--]]

--[[
repeat
    print("Set up tracker 1, 2, 3, or 4?")
    input = io.read()
    if (input == "1") then
        PORT = 47838
    elseif (input == "2") then
        PORT = 47839
    elseif (input == "3") then
        PORT = 47840
    elseif (input == "4") then
        PORT = 47841
    end
until (input == "1" or input == "2" or input == "3" or input == "4")
 
repeat
    print("Which side is the energy cell attached to?")
    input = io.read()
until (input == "right" or input == "left" or input == "top" or input == "bottom" or input == "front" or input == "back")
local side = input
 --]]
 
local input
local PORT = 0
local energy = 0
local side = "bottom" -- TODO: check this value
local port = 47838 -- TODO: check this value
 
print("Port " .. PORT .. " selected.")
 
-- wrap the modem
local modem = peripheral.wrap("top")
modem.open(PORT)
 
-- wrap the cell
local cell = peripheral.wrap(side)
 
-- transmit messages
while true do
    term.clear()
    term.setCursorPos(1,1)
    energy = tostring(cell.getStored())
    print("Sending value: " .. energy)
    if (modem.isOpen(PORT)) then
        modem.transmit(PORT, PORT, energy)
    else
        term.write("ERROR Connection closed")
    end
    sleep(5)
end