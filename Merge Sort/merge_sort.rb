def merge_sort array
  return array if array.is_a?(Integer) || array.length < 2

  left = merge_sort(array[0..((array.length - 2) / 2).floor])
  right = merge_sort(array[((array.length / 2).ceil)..])

  array = []

  loop do
    if left[0]
      if right[0] == nil || left[0] <= right[0] 
        array << left.shift
      else
        array << right.shift
      end
    elsif right[0]
      array << right.shift
    else
      break
    end
  end

  return array
end

arr = []
rand(200).times do
  arr << rand(200)
end

p merge_sort(arr)