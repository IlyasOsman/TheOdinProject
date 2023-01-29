fibs

def fibs(n)
    array = []
    0.upto(n) do |i|
      if i == 0
        array << 0
      elsif i == 1
        array << 1
      else 
        fib = array[i - 1] + array[i - 2]
        array << fib
      end
    end
    array
end
  
  # def fibs(n)
  #   (2..n).reduce([0, 1]) do |array, i|
  #     array.push(array[i - 1] + array[i - 2])
  #   end
  # end
  
  def fibs_rec(n)
    # base cases 0 and 1
    return [0] if n == 0
    return [0, 1] if n == 1
  
    array = fibs_rec(n - 1)
    # add the last two to form new elements
    array << array[-2] + array[-1]
  end
  
  p fibs(10)
  p fibs_rec(10)


#   merge

def merge_sort(array)
    # base case
    return array if array.length < 2
  
    middle = array.length / 2
    # sort left
    left_half = merge_sort(array[0...middle])
    # sort right
    right_half = merge_sort(array[middle..array.length])
    # merge two halves(sort)
  
    sorted = []
    # compare until one half is empty
    until left_half.empty? || right_half.empty?
      # one pointer in each half comparing their current values
      # smaller values pushed to the sorted array
      left_half.first <= right_half.first ? sorted << left_half.shift : sorted << right_half.shift
    end
  
    sorted + left_half + right_half
end
  
  p merge_sort([3, 4, 2, 1, 5, 0, 10, 9, 7, 8, 6])