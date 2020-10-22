# Check the shift value is between 0 and 25
# If not, using ascii code becomes difficult to deal with
# Prompts user to re-enter the shift value and checks it again
def check_shift_value( check )
  if check > 25 || check < 0
    puts "Please re-enter a character shift value from 0 to 25:"
    check = gets.chomp.to_i
    check_shift_value( check )
  end
  check
end

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
  shift = check_shift_value( shift )
  character_array = string.split( '' )
  character_array.map! { |character| shift_character( character, shift ) }
  character_array.join()
end

p caeser_cipher( "Insert string here, sit back, and prepare for some gobbledigook.", -3 )