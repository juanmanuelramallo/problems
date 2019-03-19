require "rspec/autorun"
# Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.
# Note: You may not slant the container and n is at least 2.
# Input: [1,8,6,2,5,4,8,3,7]
# Output: 49

# @param {Integer[]} height
# @return {Integer}

Height = Struct.new(:index, :value)

def max_area(height)
  height_with_index = height.map.with_index { |h, i| Height.new(i, h) }
  max = 0
  height_with_index.combination(2).to_a.each do |start_height, end_height|
    area = [start_height.value, end_height.value].min * (end_height.index - start_height.index).abs
    if area > max
      max = area
    end
  end
  max
end

RSpec.describe "max_area" do
  it { expect(max_area([1,8,6,2,5,4,8,3,7])).to eq 49 }
  it { expect(max_area([1,2])).to eq 1 }
  it { expect(max_area([9,6,14,11,2,2,4,9,3,8])).to eq 72 }
  it { expect(max_area([8,10,14,0,13,10,9,9,11,11])).to eq 80 }
end
