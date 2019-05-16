# Given an array of non-negative integers, you are initially positioned at the first index of the array.

# Each element in the array represents your maximum jump length at that position.

# Your goal is to reach the last index in the minimum number of jumps.

# Example:

# Input: [2,3,1,1,4]
# Output: 2
# Explanation: The minimum number of jumps to reach the last index is 2.
#     Jump 1 step from index 0 to 1, then 3 steps to the last index.
# Note:

# You can assume that you can always reach the last index.

require "rspec/autorun"

def jumps(nums)
  return 0 if nums.empty? || nums.size == 1

  i = 0
  jumps = []

  # puts nums.join " "

  while i < nums.size
    # puts " ****** #{i}"
    if i >= nums.size - 1 # If we are standing in the end of the array or beyond
      # puts "THE END"
      break
    end

    num = nums[i]
    potential_next_value, potential_next_index = nums[(i + 1)..(i + num)].each_with_index.max
    # puts " P: #{num} - #{potential_next_value} - #{potential_next_index}"
    potential_next_index += (i + 1)
    # puts " New index: #{potential_next_index}"

    if num >= (nums.size - 1) - i
      jumps << (nums.size - 1)
      i = nums.size
    elsif potential_next_value >= num ||
        (nums[potential_next_index].to_i > nums[i + num].to_i && (nums[potential_next_index].to_i + i) > (i + num)) ||
        nums[i + num]&.zero?
      i = potential_next_index
      jumps << potential_next_index
    else # Else if num is our best jump
      i = i + num
      jumps << i
    end
  end

  jumps.size
end

RSpec.describe "jumps" do
  it { expect(jumps([])).to eq 0 }
  it { expect(jumps([1])).to eq 0 }
  it { expect(jumps([1,1])).to eq 1 }
  it { expect(jumps([3,1,2,3])).to eq 1 }
  it { expect(jumps([1,1,1])).to eq 2 }
  it { expect(jumps([1,2,3,4,5,6,7,8,9])).to eq 4 }
  it { expect(jumps([2,3,1,1,4])).to eq 2 }
  it { expect(jumps([2,3,1,1,4,3,7,2,1,1,1,1])).to eq 4 }
  it { expect(jumps([2,2,0,1])).to eq 2 }
  it { expect(jumps([3,0,2,0,3])).to eq 2 }
  it { expect(jumps([2,1])).to eq 1 }
  it { expect(jumps([4,1,1,3,1,1,1])).to eq 2 }
  it { expect(jumps([3,2,1])).to eq 1 }
  it { expect(jumps([10,9,8,7,6,5,4,3,2,1,1,0])).to eq 2 }
end


# 2: 3 1
# 3: 1 1 4
#
