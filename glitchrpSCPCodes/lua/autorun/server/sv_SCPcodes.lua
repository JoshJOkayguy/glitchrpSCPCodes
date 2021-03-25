include("autorun/sh_SCPcodes.lua")

resource.AddSingleFile("materials/glitchSCPCodes/Defcon5.png")
resource.AddSingleFile("materials/glitchSCPCodes/Defcon4.png")
resource.AddSingleFile("materials/glitchSCPCodes/Defcon3.png")
resource.AddSingleFile("materials/glitchSCPCodes/Defcon2.png")
resource.AddSingleFile("materials/glitchSCPCodes/Defcon1.png")
resource.AddSingleFile("materials/glitchSCPCodes/CodeSilver.png")
resource.AddSingleFile("materials/glitchSCPCodes/CodeWhite.png")
resource.AddSingleFile("materials/glitchSCPCodes/CodePurple.png")
resource.AddSingleFile("materials/glitchSCPCodes/codebrown.png")

resource.AddWorkshop("2398310299")

util.AddNetworkString("sendVars")
util.AddNetworkString("receiveInts")
util.AddNetworkString("writeData")

util.AddNetworkString("executeSendCodeToJoiningPly")
util.AddNetworkString("codeToJoiningPly")


net.Receive("sendVars", function(len, ply)
local teamName = team.GetName(ply:Team())
if !allowedJobs[teamName] then return end
local	cText = net.ReadString()
for i, ply in ipairs(player.GetAll()) do
    ply:ChatPrint(cText)
end

end )

local currentCodeSV
net.Receive("receiveInts", function(len, ply)
local teamName = team.GetName(ply:Team())
if !allowedJobs[teamName] then return end
    currentCodeSV = net.ReadInt( 5 )
    net.Start("writeData")
        net.WriteInt( currentCodeSV, 5 )
    net.Broadcast()
end )

net.Receive("executeSendCodeToJoiningPly", function(len, ply)
    net.Start("codeToJoiningPly")
        net.WriteInt( currentCodeSV, 5 )
    net.Send(ply)
    print(currentCodeSV)
end )