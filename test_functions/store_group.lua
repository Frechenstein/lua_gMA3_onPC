return function()

    -- Programmer leeren, damit nur unsere Fixtures in der Auswahl sind
    Cmd("ClearAll")

    -- Deine 4 Z300 auswählen (FID 101–104)
    Cmd("Fixture 101 Thru 104")

    -- Gruppe 1 speichern, /o = overwrite, damit kein Popup entsteht
    Cmd("Store Group 1 /o")

    -- Gruppe benennen
    Cmd('Label Group 1 "Z300 All"')

    -- Programmer wieder leeren
    Cmd("ClearAll")

    Printf("Gruppe 'Z300 All' mit Fixtures 101–104 wurde gespeichert.")

end
