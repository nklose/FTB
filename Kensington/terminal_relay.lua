--[[Kensington Network
    If range becomes an issue, add relays to increase it.
--]]

local PORT1 = 47838
local PORT2 = 47839
local PORT3 = 47840
local PORT4 = 47841
 
local modem = peripheral.wrap("top")
modem.open(PORT1)
modem.open(PORT2)
modem.open(PORT3)
modem.open(PORT4)
 
while true do
        local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
        modem.transmit(senderChannel, replyChannel, message)
        print("Transmitting on " .. senderChannel .. ": " .. message)
end