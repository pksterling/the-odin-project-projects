# Shifts alphabetical characters a certain number of characters
# Converts character to ascii code
# Checks it is a letter and if so, shifts it
# Checks if it is still a letter and if not, shifts it back down 26 characters
# Converts back to a letter
def shift_character( character, shift )
  character_ascii = character.ord

  if character_ascii >= 65 && character_ascii <= 90
    character_ascii += shift
    if character_ascii > 90 then character_ascii -= 26 end
  elsif character_ascii >= 97 && character_ascii <= 122
    character_ascii += shift
    if character_ascii > 122 then character_ascii -= 26 end
  end

  character = character_ascii.chr
end

# Takes a string and a shift value
# Shifts each letter by the shift value
# Returns new string
def caeser_cipher( string, shift )
  shift = shift % 26
  character_array = string.split( '' )
  character_array.map! { |character| shift_character( character, shift ) }
  character_array.join()
end

p caeser_cipher( "Insert string here, sit back, and prepare for some gobbledigook.", 3838384949 )