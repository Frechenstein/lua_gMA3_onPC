function main() 

    Cmd("Fixture 101 Thru 103")
    Cmd("Go Executor 101")
    Cmd("Store Preset 4.1 /merge")
    Cmd("Delete Sequence 5")
    Cmd("Group 1")
    Cmd("At 50")
    Cmd("ClearAll")
    
end

return main