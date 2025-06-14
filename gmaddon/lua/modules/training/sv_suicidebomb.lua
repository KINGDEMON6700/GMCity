print("sv_test.lua > OK")

hook.Add("PlayerSay", "SuicideBomb", function(ply, text)
    if string.lower(text) == "!suicidebomb" then
        PrintMessage(HUD_PRINTTALK, "Attention, " .. ply:Nick() .. " va exploser dans 5 secondes !")
        timer.Simple(5, function()
            if not IsValid(ply) then return end

            local explosion = ents.Create("env_explosion")
            explosion:SetPos(ply:GetPos())
            explosion:SetOwner(ply)
            explosion:Spawn()
            explosion:SetKeyValue("iMagnitude", "300")
            explosion:Fire("Explode", 0, 0)

            PrintMessage(HUD_PRINTTALK, ply:Nick() .. " vient d'exploser !")
        end)

        return ""
    end
end)