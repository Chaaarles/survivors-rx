--- Utility function to play a sound with specified parameters.
--- @param sound love.Source The sound to play.
--- @param seek number The time in seconds to seek to before playing the sound.
--- @param volume number The volume level to set for the sound.
--- @param pitch_variance number The variance in pitch to apply to the sound.
return function(sound, seek, volume, pitch_variance)
  seek = seek or 0
  if sound:isPlaying() then
    sound = sound:clone()
  end

  sound:setVolume(volume)
  sound:setPitch(1 + math.random() * pitch_variance - pitch_variance / 2) -- Random pitch variation
  sound:stop()
  sound:seek(seek)
  sound:play()
end
