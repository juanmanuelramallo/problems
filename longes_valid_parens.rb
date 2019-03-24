# Given a string containing just the characters '(' and ')', find the length of the longest valid (well-formed) parentheses substring.

# Example 1:

# Input: "(()"
# Output: 2
# Explanation: The longest valid parentheses substring is "()"
# Example 2:

# Input: ")()())"
# Output: 4
# Explanation: The longest valid parentheses substring is "()()"

require "rspec/autorun"

def longest_valid_parenthesis(input)
  return 0 if input.size <= 1
  input_array = input.chars
  count = 0

  stack = []
  input_array.each do |char|
    if char == "("
      stack << char
    elsif char == ")" && stack.size > 0
      stack.pop
      count += 1
    end
  end

  count * 2
end

RSpec.describe "longest_valid_parenthesis" do
  it { expect(longest_valid_parenthesis("(()")).to eq 2 }
  it { expect(longest_valid_parenthesis(")()())")).to eq 4 }
  it { expect(longest_valid_parenthesis(")()(())()))")).to eq 8 }
  it { expect(longest_valid_parenthesis("()(()")).to eq 4 }
end
