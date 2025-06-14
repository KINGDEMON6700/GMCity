-- Resource files (materials)
local function AddMaterialFiles(folder)
    local files, dirs = file.Find(folder .. "/*", "GAME")
    for _, f in ipairs(files) do
        local ext = string.GetExtensionFromFilename(f)
        if ext == "png" or ext == "vmt" or ext == "vtf" then
            local path = folder .. "/" .. f
            resource.AddFile(path)
            print("[GMAddon] Chargement ressource : " .. path)
        end
    end
    for _, d in ipairs(dirs) do
        AddMaterialFiles(folder .. "/" .. d)
    end
end
AddMaterialFiles("materials/gmaddon")

-- Fonction de chargement sécurisé
local function LoadLuaFile(path)
    local success, err = pcall(function()
        include(path)
    end)
    if not success then
        print("    ❌ ERREUR : " .. path)
        print("       -> " .. err)
    end
    return success
end

-- Parcours récursif des fichiers Lua
local function ChargerDossier(dossier, isModuleRoot)
    if isModuleRoot then print("[GMAddon] Chargement du module : " .. dossier) end
    local fichiers, sousDossiers = file.Find(dossier .. "/*", "LUA")
    for _, fichier in ipairs(fichiers) do
        if string.GetExtensionFromFilename(fichier) == "lua" then
            local chemin = dossier .. "/" .. fichier
            local doitInclure = false
            if SERVER then
                if string.StartWith(fichier, "sh_") then
                    AddCSLuaFile(chemin)
                    doitInclure = true
                elseif string.StartWith(fichier, "sv_") then
                    doitInclure = true
                elseif string.StartWith(fichier, "cl_") then
                    AddCSLuaFile(chemin)
                end
            elseif CLIENT then
                if string.StartWith(fichier, "sh_") or string.StartWith(fichier, "cl_") then
                    doitInclure = true
                end
            end
            if doitInclure then LoadLuaFile(chemin) end
        end
    end
    for _, sousDossier in ipairs(sousDossiers) do
        ChargerDossier(dossier .. "/" .. sousDossier, false)
    end
end

-- Charger tous les modules
local _, modulesTrouves = file.Find("modules/*", "LUA")
for _, nomModule in ipairs(modulesTrouves) do
    ChargerDossier("modules/" .. nomModule, true)
end