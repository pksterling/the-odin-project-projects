def sort_pair(pair)
  new_pair = pair

  # If second number is higher than first, swap them around
  if pair[1] < pair[0] then new_pair = pair.reverse end

  new_pair
end

def bubble_sort(array)
  sorted_array = array
  sorted = false

  # Iterate through array
  sorted_array.each.with_index { |value, index|
    # Stop continuing if you're past the last pair
    if index < sorted_array.length - 1
      pair = sorted_array[index.. index + 1]
      new_pair = sort_pair(pair)

      # Stop continuing if the pair was correct to begin with
      next if pair == new_pair

      # Replace unsorted pair with sorted pair
      sorted_array[index.. index + 1] = new_pair

      # Log that, during this iteration, a sort took place
      sorted = true
    end
  }

  # Reaching the end of the array, if a sort took place, run the method again
  if sorted then bubble_sort(sorted_array) end

  sorted_array
end

p bubble_sort([1, 2, 4, 5, 17, 30, 1, 5, 3, 2, 6, 1])
