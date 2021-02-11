-- Use this table to allow jobs to use the command.
allowedJobs = {
["Citizen"] = true,
}
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local defcon5 = Material("materials/Defcon5.png")
local defcon4 = Material("materials/Defcon4.png")
local defcon3 = Material("materials/Defcon3.png")
local defcon2 = Material("materials/Defcon2.png")
local defcon1 = Material("materials/Defcon1.png")
local codesilver = Material("materials/CodeSilver.png")
local codewhite = Material("materials/CodeWhite.png")
local codepurple = Material("materials/CodePurple.png")

if SERVER then	
		resource.AddFile("materials/Defcon5.png")
		resource.AddFile("materials/Defcon4.png")
		resource.AddFile("materials/Defcon3.png")
		resource.AddFile("materials/Defcon2.png")
		resource.AddFile("materials/Defcon1.png")
		resource.AddFile("materials/CodeSilver.png")
		resource.AddFile("materials/CodeWhite.png")
		resource.AddFile("materials/CodePurple.png")

	util.AddNetworkString("sendVars")
	util.AddNetworkString("codeChat")

	net.Receive("sendVars", function(len, ply)
		local	cText = net.ReadString()
		for i, ply in ipairs(player.GetAll()) do
			ply:ChatPrint(cText)
		end

	end )
end

if CLIENT then

	local function codeChat( chatColor, chatText) -- Colors are unused for now. Will probably be used in the future.

		net.Start("sendVars")
			net.WriteString(chatText)
		net.SendToServer()

	end


	local currentCode = 1
	
	hook.Add("OnPlayerChat", "scpCodesCommand", function(ply,strText,bTeam,bDead)
		
		local loweredChat = string.lower( strText )
		local playerInput = string.Explode( " ", loweredChat, false ) 

		if playerInput[1] != "!code" or bDead then
			return
		elseif playerInput[1] == "!code" and not allowedJobs[LocalPlayer():getDarkRPVar("job")] then
			chat.AddText("You don't have permissions to use that command!")
			return true
		elseif allowedJobs[LocalPlayer():getDarkRPVar("job")] and playerInput[1] == "!code" and playerInput[2] == nil then
			chat.AddText("To use this command add one of the following arguments: defcon 5, defcon 4, defcon 3, defcon 2, defcon 1, silver, white, or purple")
			return true
		elseif playerInput[1] == "!code" and allowedJobs[LocalPlayer():getDarkRPVar("job")] then
			if playerInput[2] == "defcon5" or (playerInput[2] == "defcon" and playerInput[3] == "5") then
				codeChat(Color(34,235,16),"The site is now in Defcon 5, perform normal duties.")
				currentCode = 1
				return true
			elseif playerInput[2] == "defcon4" or (playerInput[2] == "defcon" and playerInput[3] == "4") then
				codeChat( Color(224,207,47), "The site is now in Defcon 4, exercise caution.")
				currentCode = 2
				return true
			elseif playerInput[2] == "defcon3" or (playerInput[2] == "defcon" and playerInput[3] == "3") then
				codeChat( Color(221,126,18), "The site is now in Defcon 3, exercise combat readiness.")
				currentCode = 3
				return true
			elseif playerInput[2] == "defcon2" or (playerInput[2] == "defcon" and playerInput[3] == "2") then
				codeChat( Color(221,18,18), "The site is now in Defcon 2, prepare to enter combat.")
				currentCode = 4
				return true
			elseif playerInput[2] == "defcon1" or (playerInput[2] == "defcon" and playerInput[3] == "1") then
				codeChat( Color(0,0,0), "The site is now in Defcon 1, please evacuate the site.")
				currentCode = 5
				return true
			elseif playerInput[2] == "white" then
				codeChat( Color(255,255,255), "The site is now in code white, D-Block is under lockdown.")
				currentCode = 6
				return true
			elseif playerInput[2] == "silver" then
				codeChat( Color(122,120,116), "The site is now in code silver, Gate A has been breached and there is a raid on the facility.")
				currentCode = 7
				return true
			elseif playerInput[2] == "purple" then
				codeChat( Color(116,35,141), "The site is now in code purple, retrieving the captured personnel is our top priority.")
				currentCode = 8
				return true
			end
		end

	end )
	
	local codePosY = 0
	hook.Add("HUDPaint", "PaintCode", function()
		surface.SetDrawColor(Color(255,255,255))
		if currentCode == 1 then
			surface.SetMaterial(defcon5)
			codePosY = ScrH() * -.07
		elseif currentCode == 2 then
			surface.SetMaterial(defcon4)
			codePosY = ScrH() * -.08
		elseif currentCode == 3 then
			surface.SetMaterial(defcon3)
			codePosY = ScrH() * -.08
		elseif currentCode == 4 then
			surface.SetMaterial(defcon2)
			codePosY = ScrH() * -.085
		elseif currentCode == 5 then
			surface.SetMaterial(defcon1)
			codePosY = ScrH() * -.075
		elseif currentCode == 6 then
			surface.SetMaterial(codewhite)
			codePosY = ScrH() * -.065
		elseif currentCode == 7 then
			surface.SetMaterial(codesilver)
			codePosY = ScrH() * -.065
		elseif currentCode == 8 then
			surface.SetMaterial(codepurple)
			codePosY = ScrH() * -.07
		end
		surface.DrawTexturedRect(ScrW() * .76, codePosY, 471, 244)
	end )
end
