print("sv_test.lua > OK")

hook.Add("PlayerSay", "GiveItem", function(ply, text)
    local args = string.Explode(" ", text)

    if string.lower(args[1]) == "/giveitem" then
        if not ply:IsAdmin() then
            ply:ChatPrint("Commande réservée aux admins.")
            return ""
        end

        local target = args[2]

        if not target then
            ply:ChatPrint("Utilisation: /giveitem <Joueur>")
            return ""
        end

        local foundPlayer = nil
        for _, v in ipairs(player.GetAll()) do
            if string.find(string.lower(v:Nick()), string.lower(target), 1, true) then
                foundPlayer = v
                break
            end
        end

        if not foundPlayer then
            ply:ChatPrint("Joueur introuvable.")
            return ""
        end

        ply:ChatPrint("Joueur: " .. foundPlayer:Nick())
        return ""
    end
end)