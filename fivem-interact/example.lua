-- You can delete this file.
local pedlist = {
	{ ['x'] = 40.66, ['y'] = -882.6, ['z'] = 30.28, ['h'] = 181.03, ['hash'] = "a_m_m_hillbilly_01" },
}

Citizen.CreateThread(function()
	for k,v in pairs(pedlist) do
		RequestModel(v.hash)
		while not HasModelLoaded(v.hash) do
			Citizen.Wait(10)
		end
		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)

        exports["fivem-interact"]:addInteration(ped,function(dist)
            print("Hey! I am "..v.hash.."! Dist is: "..dist)
        end)
	end
end)