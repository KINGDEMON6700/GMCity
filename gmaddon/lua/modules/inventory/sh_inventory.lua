-- Shared inventory code
if SERVER then
    util.AddNetworkString("Inventory_Update")
end

local PLAYER = FindMetaTable("Player")

function PLAYER:GetInventory()
    self.Inventory = self.Inventory or {}
    return self.Inventory
end

function PLAYER:AddItem(class)
    local inv = self:GetInventory()
    table.insert(inv, class)
    self:SendInventory()
end

function PLAYER:RemoveItem(index)
    local inv = self:GetInventory()
    local class = inv[index]
    if class then
        table.remove(inv, index)
        self:SendInventory()
    end
    return class
end

function PLAYER:SendInventory()
    if SERVER then
        net.Start("Inventory_Update")
        net.WriteUInt(#self:GetInventory(), 8)
        for _, c in ipairs(self.Inventory) do
            net.WriteString(c)
        end
        net.Send(self)
    end
end
