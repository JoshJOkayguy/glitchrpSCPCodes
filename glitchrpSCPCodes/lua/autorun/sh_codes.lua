-- Use this table to allow jobs to use the command.
allowedJobs = {
["Citizen"] = true,

}

-- (DON'T EDIT THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING) Use this table to add new code materials.
codeMaterials = {
["defcon5"] = "materials/icon16/shading.png",
} 

if SERVER then

	for k,v in ipairs(codeMaterials) do
		
		resource.AddFile(v)

	end

end

if CLIENT then

	local currentCode = 0
	
	hook.Add("OnPlayerChat", "scpCodesCommand", function(ply,strText,bTeam,bDead)

		if ply != LocalPlayer() then return end
		
		local playerInput = string.Explode( " ", strText ) 
		
		if playerInput[1] != "!code" or bDead then
			return
		else
			return true
				
			if allowedJobs[getDarkRPVar("job")] then
				if playerInput[2] == "defcon5" or ( playerInput[2] == "defcon" and playerInput[3] == "5" ) then
					currentCode = 1
					print(strText)
				elseif playerInput[2] == "defcon4" or ( playerInput[2] == "defcon" and playerInput[3] == "4" ) then
					currentCode = 2
					print(strText)	
				elseif playerInput[2] == "defcon3" or ( playerInput[2] == "defcon" and playerInput[3] == "3" ) then
					currentCode = 3 
					print(strText)	
				elseif playerInput[2] == "defcon2" or ( playerInput[2] == "defcon" and playerInput[3] == "2" ) then
					currentCode = 4
					print(strText)	
				elseif playerInput[2] == "defcon1" or ( playerInput[2] == "defcon" and playerInput[3] == "1" ) then
					currentCode = 5
					print(strText)
				elseif playerInput[2] == "white" then
					currentCode = 6
					print(strText)	
				elseif playerInput[2] == "silver" then
					currentCode = 7
					print(strText)	
				elseif playerInput[2] == "purple" then
					currentCode = 8
					print(strText)
				else
					chat.AddText("Arguments: defcon5, defcon4, defcon3, defcon2, defcon1, white, purple, silver")
					chat.PlaySound()
				end
			else
				chat.AddText("You don't have permission to use this command!")
				chat.PlaySound()
			end
		end

	end )
	
	hook.Add("HUDPaint", "DrawSCPCode", function()
		surface.drawTexturedRect( 200, 200, 300, 100)
		for i, ply in ipairs( player.GetAll() ) do
			if currentCode == 1 then
				surface.SetMaterial( codeMaterials["defcon5"] )
			else
				print("The current code is not set.")
			end
		end
		
	end )

end
