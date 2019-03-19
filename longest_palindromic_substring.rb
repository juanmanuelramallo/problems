# require "byebug"
require "rspec/autorun"
# Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

# Example 1:

# Input: "babad"
# Output: "bab"
# Note: "aba" is also a valid answer.
# Example 2:

# Input: "cbbd"
# Output: "bb"

# @param {String} s
# @return {String}
def longest_palindrome(s)
  return "" if s.size.zero?

  palindromes = []

  s.each_char.with_index do |current_char, current_index|
    s.chars.drop(current_index).size.times do |i|
      substring = s.chars[current_index..(current_index + i)].join("")
      if is_palindrome(substring)
        palindromes << substring
        puts substring
      end
    end
  end

  puts palindromes.join(" ")
  palindromes.max_by(&:size)
end

def is_palindrome(s)
  return true if s.chars.uniq.count == 1

  stack = []
  reminders = []

  i = 1
  mid = s.size.even? ? s.size/2 : s.size/2 + 1
  puts mid
  until i > s.size do
    prev_char = s.chars[i - 1]
    current_char = s.chars[i]
    if i < mid
      stack << prev_char
    else
      if stack.last == current_char
        stack.pop
      else
        reminders << current_char
      end
    end
    i += 1
  end

  stack.empty? && reminders.empty?
end

# Testcases
RSpec.describe "is_palindrome" do
  context "is true" do
    it "tests reconocer" do
      expect(is_palindrome("reconocer")).to eq true
    end

    it "tests arera" do
      expect(is_palindrome("arera")).to eq true
    end

    it "tests tattarrattat" do
      expect(is_palindrome("tattarrattat")).to eq true
    end
  end

  context "is false" do
    it "tests abaca" do
      expect(is_palindrome("abaca")).to eq false
    end

    it "tests dadoperepodads" do
      expect(is_palindrome("dadoperepodads")).to eq false
    end
  end
end
