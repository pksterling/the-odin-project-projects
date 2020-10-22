def add_to_result( substring )
  @result[substring] += 1
end

def check_potential_match( potential_match, substring )
  if potential_match.upcase == substring.upcase
    add_to_result( substring )
  end
end

def find_potential_matches( string, substring )
  potential_match_index = string.index( substring[0] )
  
  if potential_match_index
    potential_match = string.slice( potential_match_index, substring.length )
    check_potential_match( potential_match, substring )

    updated_string = string[potential_match_index + 1..]
    find_potential_matches( updated_string, substring )
  end
end

def substrings( string, substrings )
  @result = Hash.new(0)
  for word in substrings do
    find_potential_matches( string, word)
  end
  @result
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("Howdy partner, sit down! How's it going?", dictionary)