include("modules/inventory/sh_inventory.lua")

local inventory = {}

local function openInventory()
    if IsValid(inventory.Frame) then
        inventory.Frame:Remove()
    end

    local frame = vgui.Create("DFrame")
    frame:SetSize(300, 400)
    frame:Center()
    frame:SetTitle("Inventaire")
    frame:MakePopup()
    inventory.Frame = frame

    local model = vgui.Create("DModelPanel", frame)
    model:SetSize(200, 200)
    model:SetPos(50, 30)
    model:SetModel(LocalPlayer():GetModel())
    model:SetLookAt(Vector(0, 0, 60))
    model:SetCamPos(Vector(80, 0, 60))

    local list = vgui.Create("DListView", frame)
    list:SetPos(10, 240)
    list:SetSize(280, 150)
    list:AddColumn("Items")
    for _, c in ipairs(LocalPlayer():GetInventory()) do
        list:AddLine(c)
    end

    function frame:OnRemove()
        inventory.Frame = nil
    end
end

net.Receive("Inventory_Update", function()
    local count = net.ReadUInt(8)
    LocalPlayer().Inventory = {}
    for i = 1, count do
        table.insert(LocalPlayer().Inventory, net.ReadString())
    end
end)

hook.Add("PlayerButtonDown", "InventoryToggle", function(ply, key)
    if key == KEY_I and ply == LocalPlayer() then
        if inventory.Frame then
            inventory.Frame:Close()
        else
            openInventory()
        end
    end
end)
