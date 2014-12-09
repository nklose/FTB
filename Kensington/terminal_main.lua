--[[Kensington Network
    
--]]

local MAX_POWER = 10000000 * 4
local POWER_LENGTH = 60
local bridge = peripheral.wrap("right")
local power1 = 0
local power2 = 0
local power3 = 0
local power4 = 0
local powerPercent = 0
local line = 1
local sender = "default"
local message = "default"
local protocol = "default"
local m = peripheral.wrap("bottom")
print("Initializing...")
 
-- set up modem
local PORT1 = 47838
local PORT2 = 47839
local PORT3 = 47840
local PORT4 = 47841
local modem = peripheral.wrap("top")
modem.open(PORT1)
modem.open(PORT2)
modem.open(PORT3)
modem.open(PORT4)
print("Setting up modem...")
 
-- set up terminal glasses colors
local nCol = {}
nCol.red = 0xff0000
nCol.blue = 0x7dd2e4
nCol.yellow = 0xffff4d
nCol.green = 0x4dff4d
nCol.gray = 0xe0e0e0
nCol.grey = 0xe0e0e0
nCol.lime = 0x55ff55
nCol.black = 0x000000
nCol.white = 0xffffff
 
m.clear()
print("Initialization finished.")
 
-- main loop
while true do
    -- clear the display
    bridge.clear()
   
    -- display welcome message
    welcome = "Yardle OS Loaded"
    text = bridge.addText(5, 5, welcome, nCol.blue)
   
    -- display current time
    timeRaw = textutils.formatTime(os.time(), true)
    bridge.addText(5, 15, "IGT: ", nCol.lime)
    bridge.addText(25, 15, timeRaw, nCol.white)
    m.setTextColor(colors.lime)
    m.setCursorPos(1, 1)
    m.write("                ")
    m.setCursorPos(1, 1)
    m.write("Time: " .. timeRaw)
   
    -- display current day
    bridge.addText(55, 15, "Day: " , nCol.lime)
    bridge.addText(78, 15, tostring(os.day()), nCol.white)
    m.setTextColor(colors.blue)
    m.setCursorPos(1, 2)
    m.write("Day: " .. os.day())
   
    -- connected users
    bridge.addText(5, 55, "Connections:", nCol.white)
    local users = bridge.getUsers()
    yLoc = 65
    for key, value in pairs(users) do
        bridge.addText(5, yLoc, "- " .. value, nCol.blue)
        yLoc = yLoc + 10
    end
   
    -- print power
    powerPercent = (power1 + power2 + power3 + power4) / MAX_POWER
    bridge.addText(5, 25, "Power: ", nCol.lime)
    local barLength = POWER_LENGTH * powerPercent
    --bridge.addText(42, 26, powerPercent * 100 .. "%", nCol.white)
    bridge.addBox(42, 26, barLength, 5, nCol.yellow, .5)
    bridge.addBox(42 + barLength, 26, POWER_LENGTH - barLength, 5, nCol.black, .5)
 
    powPercent1 = tostring(math.floor(power1 / 100000))
    powPercent2 = tostring(math.floor(power2 / 100000))
    powPercent3 = tostring(math.floor(power3 / 100000))
    powPercent4 = tostring(math.floor(power4 / 100000))
    bridge.addText(5, 35, "     |     |     | ", nCol.red)
   
    barLength = powPercent1 / 100 * 20
    bridge.addBox(5, 36, barLength, 5, nCol.white, .5)
    bridge.addBox(5 + barLength, 36, 20 - barLength, 5, nCol.black, .5)
   
    barLength = powPercent2 / 100 * 20
    bridge.addBox(27, 36, barLength, 5, nCol.white, .5)
    bridge.addBox(27 + barLength, 36, 20 - barLength, 5, nCol.black, .5)
 
    barLength = powPercent3 / 100 * 20
    bridge.addBox(49, 36, barLength, 5, nCol.white, .5)
    bridge.addBox(49 + barLength, 36, 20 - barLength, 5, nCol.black, .5)
 
    barLength = powPercent4 / 100 * 20
    bridge.addBox(72, 36, barLength, 5, nCol.white, .5)
    bridge.addBox(72 + barLength, 36, 20 - barLength, 5, nCol.black, .5)
 
    --bridge.addText(38, 35, tostring(powPercent1), nCol.white)
    --bridge.addText(61, 35, tostring(powPercent2), nCol.white)
    --bridge.addText(81, 35, tostring(powPercent3), nCol.white)
    --bridge.addText(105, 35, tostring(powPercent4), nCol.white)
 
    bridge.addText(8, 42, "reactor", nCol.yellow)
    bridge.addText(55, 42, "primary", nCol.yellow)
 
    m.setCursorPos(1, 3)
    m.setTextColor(colors.yellow)
    m.write("Power: " .. powerPercent * 100 .. "%")
    m.setCursorPos(1, 4)
    m.setTextColor(colors.white)
    m.write(powPercent1 .. "%|" .. powPercent2 .. "%|" .. powPercent3 .. "%|" .. powPercent4 .. "%")
 
    -- update power from wireless modem
    local event, modemSide, senderChannel,
        replyChannel, message, senderDistance = os.pullEvent("modem_message")
    if (senderChannel == PORT1) then
        power1 = message
    elseif (senderChannel == PORT2) then
        power2 = message
    elseif (senderChannel == PORT3) then
        power3 = message
    elseif (senderChannel == PORT4) then
        power4 = message
    end
    print("Power: (" .. power1 .. ", " .. power2 .. ", " .. power3 .. ", " .. power4 .. ", " .. powerPercent * 100 .. "%)")
 
   
 
    -- timeout to prevent flooding
    os.sleep(.1)
end