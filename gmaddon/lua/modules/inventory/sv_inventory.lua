AddCSLuaFile()
include("modules/inventory/sh_inventory.lua")

-- Droppable item entity creation
local ITEM_MODEL = "models/props_junk/wood_crate001a.mdl"

local function spawnItem(pos, class)
    local ent = ents.Create("prop_physics")
    if not IsValid(ent) then return end
    ent:SetModel(ITEM_MODEL)
    ent:SetPos(pos)
    ent:Spawn()
    ent.IsDroppableItem = true
    ent.ItemClass = class
end

hook.Add("PlayerInitialSpawn", "InventoryInit", function(ply)
    ply.Inventory = {}
    timer.Simple(1, function()
        if IsValid(ply) then
            ply:SendInventory()
        end
    end)
end)

hook.Add("PlayerUse", "InventoryPickup", function(ply, ent)
    if ent.IsDroppableItem and ply:KeyDown(IN_WALK) then -- Alt + E
        ply:AddItem(ent.ItemClass or "crate")
        ent:Remove()
        return false
    end
end)

concommand.Add("gm_dropitem", function(ply, cmd, args)
    local index = tonumber(args[1] or 1)
    local class = ply:RemoveItem(index)
    if class then
        local pos = ply:GetPos() + ply:GetForward() * 50 + Vector(0, 0, 10)
        spawnItem(pos, class)
    end
end)
