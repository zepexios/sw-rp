include('shared.lua')


function ViewPoint( ply, origin, angles, fov )
local dev=LocalPlayer():GetNetworkedEntity("F302",LocalPlayer())
local dist= -600
local add=Vector(0,0,0)
	if dev:GetNetworkedBool("FirstPerson") then
		dist = 20
		add = Vector(0,0,-100)
	else
		dist = -600
		add = Vector(0,0,100)
	end
	if LocalPlayer():GetNetworkedBool("isDriveF302",false) and dev~=LocalPlayer() and dev:IsValid() then
		local view = {}
			view.origin = dev:GetPos()+add+ply:GetAimVector():GetNormal()*dist
			view.angles = angles
		return view
	end
end
hook.Add("CalcView", "F302View", ViewPoint)
