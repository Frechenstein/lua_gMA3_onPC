function main()
    
    local Answer = Confirm('Hey', 'Confirm me!')

    if (Answer) then
        Printf('User confirmed the pop-up.')
    elseif (Answer == false) then
        Printf('User canceled the pop-up.')
    end

end

return main