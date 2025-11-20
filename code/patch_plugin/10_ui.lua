-- 10_ui

function UI_ChooseZ300Count()
    local mb = MessageBox({
        title   = "Z300 Patch",
        message = "Wie viele Z300 patchen?",
        commands = {
            {value=1, name="1"},
            {value=2, name="2"},
            {value=4, name="4"},
            {value=6, name="6"},
            {value=8, name="8"},
            {value=-1, name="Cancel"},
        }
    })

    if not mb or mb.result == -1 then
        return nil
    end
    return mb.result
end
