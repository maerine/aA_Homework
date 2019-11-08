def bubble_sort(array)
    len = array.length - 1
    sorted = false

    until sorted
      sorted = true
      (0...len).each do |idx|
        if array[idx].length > array[idx + 1].length
          array[idx], array[idx + 1] = array[idx + 1], array[idx]
          sorted = false
        end
      end
    end

    array[-1]
end

p bubble_sort(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])

def merge_sort(array)
    return array if array.length <= 1

    mid_idx = array.length / 2
    merge(
      merge_sort(array.take(mid_idx)),
      merge_sort(array.drop(mid_idx))
    )
  end

  def merge(left, right)
    merged_array = []
    prc = Proc.new { |fish1, fish2| fish1.length <=> fish2.length } 
    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged_array << left.shift
      when 0
        merged_array << left.shift
      when 1
        merged_array << right.shift
      end
    end

    merged_array + left + right
  end

  p merge_sort(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])