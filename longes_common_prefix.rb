# Write a function to find the longest common prefix string amongst an array of strings.

# If there is no common prefix, return an empty string "".

# Example 1:

# Input: ["flower","flow","flight"]
# Output: "fl"
# Example 2:

# Input: ["dog","racecar","car"]
# Output: ""
# Explanation: There is no common prefix among the input strings.
# Note:

# All given inputs are in lowercase letters a-z.

require "rspec/autorun"

# @param {String[]} strs
# @return {String}
def longest_common_prefix(strs)
  return "" if strs.empty? || strs.min.size == 0
  return strs[0] if strs.size == 1

  index = 0
  any_different = nil
  max_string_size = strs.max.size

  until any_different || index == max_string_size do
    any_different = strs.detect { |str| str[index] != strs[0][index] }
    index += 1 if !any_different
  end

  if index == max_string_size
    strs[0][0..index]
  elsif index > 1
    strs[0][0..(index - 1)]
  elsif index == 1
    strs[0][0]
  else
    ""
  end
end

RSpec.describe "longest_common_prefix" do
  it { expect(longest_common_prefix(["flower","flow","flight"])).to eq "fl" }
  it { expect(longest_common_prefix(["dog","racecar","car"])).to eq "" }
  it { expect(longest_common_prefix([])).to eq "" }
  it { expect(longest_common_prefix([""])).to eq "" }
  it { expect(longest_common_prefix(["", ""])).to eq "" }
  it { expect(longest_common_prefix(["c", "c"])).to eq "c" }
  it { expect(longest_common_prefix(["aa", "ab"])).to eq "a" }
end
