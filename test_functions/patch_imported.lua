return function()

    --------------------------------------------------------------------
    -- 1) In den Patch wechseln
    --------------------------------------------------------------------
    Cmd("ChangeDestination Root")
    Cmd("ChangeDestination 'ShowData'.'Patch'")

    local patch = Patch()
    if patch == nil or patch.FixtureTypes == nil then
        Printf("Patch oder FixtureTypes nicht gefunden – ist ein Showfile geladen?")
        Cmd("ChangeDestination Root")
        return
    end

    --------------------------------------------------------------------
    -- 2) Cameo-FixtureType finden
    --------------------------------------------------------------------
    local ftPool = patch.FixtureTypes
    local ft = nil

    for i = 1, #ftPool do
        local fType = ftPool[i]
        if fType
           and fType.Manufacturer
           and fType.Manufacturer:match("Cameo")
        then
            ft = fType
            break
        end
    end

    if ft == nil then
        Printf("Kein FixtureType mit Manufacturer 'Cameo' im Showfile.")
        Printf("Bitte Auro Spot CLASZ300 einmal im Patch → Fixture Types importieren.")
        Cmd("ChangeDestination Root")
        return
    end

    local mode = ft.DMXModes["20 channel"]
    if mode == nil then
        Printf("Mode '20 channel' im gefundenen Cameo-FixtureType nicht vorhanden.")
        Cmd("ChangeDestination Root")
        return
    end

    --------------------------------------------------------------------
    -- 3) In Stage 1 → Fixtures wechseln (für AddFixtures)
    --------------------------------------------------------------------
    Cmd("ChangeDestination Stages")
    Cmd("ChangeDestination 1")
    Cmd("ChangeDestination Fixtures")

    --------------------------------------------------------------------
    -- 4) Deine 4 Z300 definieren
    --------------------------------------------------------------------
    local universe = 1
    local addresses = {1, 21, 41, 61}            -- ergibt 1.001, 1.021, 1.041, 1.061
    local fids      = {101, 102, 103, 104}
    local names     = {"Z300 1", "Z300 2", "Z300 3", "Z300 4"}

    --------------------------------------------------------------------
    -- 5) Patchen
    --------------------------------------------------------------------
    for i = 1, 4 do
        local t = {}
        t.mode   = mode
        t.amount = 1
        t.fid    = tostring(fids[i])
        t.idtype = "Fixture"
        t.name   = names[i]
        t.patch  = { string.format("%d.%03d", universe, addresses[i]) }
        t.undo   = "Lua Patch Z300 " .. i

        local ok = AddFixtures(t)

        if ok ~= nil then
            Printf(string.format(
                "OK: %s  FID %d  @ %d.%03d",
                names[i], fids[i], universe, addresses[i]
            ))
        else
            Printf("FEHLER beim Patchen von " .. names[i])
        end
    end

    Cmd("ChangeDestination Root")
end
