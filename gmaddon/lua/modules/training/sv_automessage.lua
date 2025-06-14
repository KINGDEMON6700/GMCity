local messages = {
    "Vous êtes connecté sur GMCity !",
    "Le créateur de cet addon est KING#6700",
}

timer.Create("AutoMessage", 10, 0, function()
    local index = math.random(1, #messages)
    local message = messages[index]
    PrintMessage(HUD_PRINTTALK, message)
end)