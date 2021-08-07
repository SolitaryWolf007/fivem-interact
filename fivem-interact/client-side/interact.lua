--==================================================================================
-- OpenGL Mathematics
--==================================================================================
local glm = require("glm")
--==================================================================================
-- VARS
--==================================================================================
local entities = {}
local running = false
local isMouseEnabled = false
--==================================================================================
-- SCRIPT
--==================================================================================
exports("addInteraction",function(entity,cb_click)
    if (type(entity) ~= "number") then error("Invalid Entity"); end;
    if (type(cb_click) ~= "function") then error("Invalid Callback Function"); end;
    entities[entity] = cb_click
end)

exports("removeInteraction",function(entity)
    if (type(entity) ~= "number") then error("Invalid Entity"); end;
    entities[entity] = nil
end)

function ScreenPositionToCameraRay(screenX, screenY)
    local pos = GetFinalRenderedCamCoord()
    local rot = glm.rad(GetFinalRenderedCamRot(2))
    local q = glm.quatEulerAngleZYX(rot.z, rot.y, rot.x)
    return pos,glm.rayPicking(
        q * glm.forward(),
        q * glm.up(),
        glm.rad(GetFinalRenderedCamFov()),
        GetAspectRatio(true),
        0.10000, -- GetFinalRenderedCamNearClip(),
        10000.0, -- GetFinalRenderedCamFarClip(),
        screenX * 2 - 1, -- scale mouse coordinates from [0, 1] to [-1, 1]
        screenY * 2 - 1
    )
end

RegisterNUICallback("interact",function(data,cb)
    if isMouseEnabled and (not running) then
        running = true
        local ped = PlayerPedId()
        local w, h = GetActiveScreenResolution()
        local mx = data.mouseX / w
        local my = data.mouseY / h
        local r_pos, r_dir = ScreenPositionToCameraRay(mx, my)
        local b = r_pos + 10000 * r_dir

        local handle = StartExpensiveSynchronousShapeTestLosProbe(r_pos.x, r_pos.y, r_pos.z, b.x, b.y, b.z,(1 | 2 | 4 | 8 | 16 | 32 | 64 | 128 | 256), ped, 7)
        local _, hit, pos, surface, entity = GetShapeTestResult(handle)
        if (entity ~= 0) then
            if entities[entity] then
                local dist = #( GetEntityCoords(ped) - pos )
                entities[entity](dist) 
                return
            end
        end
            
        running = false
    end
end)

RegisterCommand('+interactact',function()    
    SetNuiFocusKeepInput(true)
    if (not isMouseEnabled) then
        isMouseEnabled = true
        SetNuiFocus(true,true)
        while isMouseEnabled do
            DisableControlAction(0, 24, true)
            DisablePlayerFiring(PlayerId(), true)
            Wait(1)
        end
    else
        isMouseEnabled = false
        SetNuiFocus(false,false)
    end
end, false)
RegisterKeyMapping('+interactact','[INTERACT] Toggle Mouse', 'KEYBOARD', 'Z')
