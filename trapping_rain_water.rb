# Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.
# The above elevation map is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped. Thanks Marcos for contributing this image!
# Example:
# Input: [0,1,0,2,1,0,1,3,2,1,2,1]
# Output: 6

# require "rspec/autorun"

# @param {Integer[]} heights
# @return {Integer}
# def trap_count(heights)
#   return 0 if heights.empty?
#   max = second_max heights.dup
#   water = 0

#   max.times do
#     heights = clean_first_zeros(heights)
#     heights = clean_first_zeros(heights.reverse)

#     heights.each do |height|
#       water += 1 if height == 0
#     end

#     heights.map! { |height| height.zero? ? 0 : height - 1 }
#   end

#   water
# end

# def second_max(heights)
#   heights.delete_at(heights.index(heights.max)) if heights.size > 1
#   heights.max
# end

# def clean_first_zeros(heights)
#   wall_found = false
#   index = 0
#   while index < heights.size && !wall_found
#     if heights[index] > 0
#       wall_found = true
#     end

#     if !wall_found && heights[index] == 0
#       heights[index] = nil
#     end

#     index += 1
#   end

#   heights.compact
# end


RSpec.describe "trap" do
  it { expect(trap_count([])).to eq 0 }
  it { expect(trap_count([0])).to eq 0 }
  it { expect(trap_count([1])).to eq 0 }
  it { expect(trap_count([2,0,0])).to eq 0 }
  it { expect(trap_count([1,0,1])).to eq 1 }
  it { expect(trap_count([0,1,0,1])).to eq 1 }
  it { expect(trap_count([2,0,1])).to eq 1 }
  it { expect(trap_count([1,0,2])).to eq 1 }
  it { expect(trap_count([2,0,2])).to eq 2 }
  it { expect(trap_count([0,1,0,2,1,0,1,3,2,1,2,1])).to eq 6 }
end
