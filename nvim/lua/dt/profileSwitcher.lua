function switchProfile(ID)
  if ID == 0 then
    -- require('dt.profile')
  elseif ID == 1 then
    require('dt.profile2')
  end
end

switchProfile(0)
