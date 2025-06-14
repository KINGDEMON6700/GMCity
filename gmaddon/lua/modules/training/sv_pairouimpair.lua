concommand.Add("pairouimpair", function(ply, cmd, args)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if not args[1] or not tonumber(args[1]) then
        ply:PrintMessage(HUD_PRINTCONSOLE,"Vous devez mettre un numéro valide !")
        return
    end
    local number = tonumber(args[1])
    if number % 2 == 0 then
        ply:PrintMessage(HUD_PRINTCONSOLE, "Pair: " .. number)
    else
        ply:PrintMessage(HUD_PRINTCONSOLE, "Impair: " .. number)
    end
end)