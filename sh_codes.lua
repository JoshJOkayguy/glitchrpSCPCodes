-- Use this table to add new code materials.
codeMaterials = {
[green] = "materials/icon16/shading.png",
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

	-- Use this table to add more commands.
	commandArgs = {
		["green"] = true,
		["yellow"] = true,
	}

	hook.Add("OnPlayerChat", "scpCodesCommand", function(ply,strText,bTeam,bDead)

		if ply != LocalPlayer() then return end

		if strText != string.find( strText, "!code" ) then
			return 
		elseif strText == "!code "..commandArgs and allowedJobs[ply:getDarkRPVar("job")] then
			if strText == "!code "..commandArgs["green"] then
				print("You called code green")
			elseif strText == "!code "..commandArgs["yellow"] then
				print("You called code yellow")
			end
		elseif strText == "!code" and allowedJobs[ply:getDarkRPVar("job")] then
			chat.AddText("Usage: !code ("table.ToString( commandArgs, "Arguments", true )')')
			chat.PlaySound()
		end		

	end )

end