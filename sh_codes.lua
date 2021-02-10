-- Use this table to add new code materials.
codeMaterials = {
["defcon5"] = "materials/icon16/shading.png",
} 

-- Use this table to allow jobs to use the command.
allowedJobs = {
["Citizen"] = true,

}

if SERVER then

	for k,v in ipairs(codeMaterials) do
		if codeMaterials then

			resource.AddFile(k)
	
		end
	end

end

if CLIENT then


	hook.Add("OnPlayerChat", "scpCodesCommand", function(ply,strText,bTeam,bDead)

		if ply != LocalPlayer() then return end
		
		local playerInput = string.Explode( " ", strText ) 
		
		if playerInput[1] != "!code" then
			return
		else
			return true
				
			if allowedJobs[getDarkRPVar("job")] then
				if playerInput[2] == "defcon5" or ( playerInput[2] == "defcon" and playerInput[3] == "5" ) then
					print(strText)
				elseif playerInput[2] == "defcon4" or ( playerInput[2] == "defcon" and playerInput[3] == "4" ) then
					print(strText)	
				elseif playerInput[2] == "defcon3" or ( playerInput[2] == "defcon" and playerInput[3] == "3" ) then
					print(strText)	
				elseif playerInput[2] == "defcon2" or ( playerInput[2] == "defcon" and playerInput[3] == "2" ) then
					print(strText)	
				elseif playerInput[2] == "defcon1" or ( playerInput[2] == "defcon" and playerInput[3] == "1" ) then
					print(strText)
				elseif playerInput[2] == "white" then
					print(strText)	
				elseif playerInput[2] == "silver" then
					print(strText)	
				elseif playerInput[2] == "purple" then
					print(strText)
			else
				chat.AddText("You don't have permission to use this command!")
				chat.PlaySound()
			end
		end

	end )

end
