# Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.

# Note:

# The solution set must not contain duplicate triplets.

# Example:

# Given array nums = [-1, 0, 1, 2, -1, -4],

# A solution set is:
# [
#   [-1, 0, 1],
#   [-1, -1, 2]
# ]

require "rspec/autorun"

# @param {Integer[]} nums
# @return {Integer[][]}
def three_sum(nums)
  nums.combination(3).to_a.select { |ary| ary.sum.zero? }.map(&:sort).uniq
end

RSpec.describe "three_sum" do
  it { expect(three_sum([-1, 0, 1, 2, -1, -4])).to eq ([[-1, 0, 1], [-1, -1, 2]]) }
  # it { expect(three_sum([-1, 0, 1, 2, -1, -4])).to eq ([[-1, 0, 1], [-1, -1, 2]]) }
end

# three_sum([13,-14,-10,-4,4,4,0,-14,5,-9,-3,-10,14,7,-3,-4,-3,12,-14,2,-11,-6,0,-7,13,-2,-7,-11,-14,-13,5,14,-12,11,-13,-1,-8,2,0,4,1,4,10,-8,-11,-8,3,1,11,4,-12,8,5,-4,-14,-4,9,-13,-8,2,-11,12,-7,14,0,-5,-2,7,5,5,-3,13,-6,-8,-10,-10,-9,0,6,-12,11,2,11,1,13,4,12,-1,6,-11,-14,2,9,-6,1,-6,-4,14,-13,8,4,-1,6,6,-2,11,11,4,-4,-5,-1,-8,12,-13,1,10,7,-10,-14,-10,-5,-13,0,11])
