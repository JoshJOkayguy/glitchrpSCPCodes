-- Use this table to allow jobs to use the command.
allowedJobs = {
["Citizen"] = true,
}

-- (DO NOT EDIT THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING)
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
end

if CLIENT then

	local function codeChat( chatColor, chatText)
		for i, ply in ipairs(player.GetAll()) do
			chat.AddText( chatColor, chatText)
		end
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
			elseif playerInput[2] == "defcon4" then
				codeChat( Color(224,207,47), "The site is blah blah")
				currentCode = 8
				return true
			end
		end

	end )
	
	hook.Add("HUDPaint", "PaintCode", function()
	
		surface.SetDrawColor(0,0,0,0)

		if currentCode == 1 then
			surface.SetMaterial(defcon5)
		elseif currentCode == 2 then
			surface.SetMaterial(defcon4)
		elseif currentCode == 3 then
			surface.SetMaterial(defcon3)
		elseif currentCode == 4 then
			surface.SetMaterial(defcon2)
		elseif currentCode == 5 then
			surface.SetMaterial(defcon1)
		elseif currentCode == 6 then
			surface.SetMaterial(codewhite)
		elseif currentCode == 7 then
			surface.SetMaterial(codesilver)
		elseif currentCode == 8 then
			surface.SetMaterial(codepurple)
		end


		surface.DrawTexturedRect(ScrW() * .74, ScrH() * -.14, ScrW() * 512/1920, ScrH() * 440/1080)


	end )

end
