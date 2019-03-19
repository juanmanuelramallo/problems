require "rspec/autorun"

# Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

# Symbol       Value
# I             1
# V             5
# X             10
# L             50
# C             100
# D             500
# M             1000
# For example, two is written as II in Roman numeral, just two one's added together. Twelve is written as, XII, which is simply X + II. The number twenty seven is written as XXVII, which is XX + V + II.

# Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

# I can be placed before V (5) and X (10) to make 4 and 9.
# X can be placed before L (50) and C (100) to make 40 and 90.
# C can be placed before D (500) and M (1000) to make 400 and 900.
# Given an integer, convert it to a roman numeral. Input is guaranteed to be within the range from 1 to 3999.

$roman_numbers = [
  [:I, 1],
  [:V, 5],
  [:X, 10],
  [:L, 50],
  [:C, 100],
  [:D, 500],
  [:M, 1000]
]

# @param {Integer} num
# @return {String}
def int_to_roman(num)
  num_string = num.to_s
  amounts = num_string.chars.map.with_index { |char, index| char.to_i * 10**(num_string.size - index - 1) }
  amounts.map do |amount|
    digits_amount = amount.to_s.size
    index_roman_numbers = (digits_amount - 1) * 2
    base_roman_number = $roman_numbers[index_roman_numbers]
    new_roman_number = []
    amount.to_s[0].to_i.times { new_roman_number << base_roman_number }
    standarize_roman_number(new_roman_number, index_roman_numbers)
  end.flatten.join
end

def standarize_roman_number(roman_numbers_array, index_roman_numbers)
  return unless roman_numbers_array.any?

  base_roman_number = roman_numbers_array[0]
  new_roman_number = []
  if base_roman_number[0] != :M
    next_roman_number = $roman_numbers[index_roman_numbers + 1]
    if roman_numbers_array.size == 9
      sub_next_roman_number = $roman_numbers[index_roman_numbers + 2]
      new_roman_number << base_roman_number
      new_roman_number << sub_next_roman_number
    elsif roman_numbers_array.size > 4
      new_roman_number << next_roman_number
      (roman_numbers_array.size - 5).times { new_roman_number << base_roman_number }
    elsif roman_numbers_array.size == 4
      new_roman_number << base_roman_number
      new_roman_number << next_roman_number
    else
      roman_numbers_array.size.times { new_roman_number << base_roman_number }
    end
  else
    new_roman_number = roman_numbers_array
  end
  new_roman_number.map { |roman_number| roman_number[0].to_s }
end


RSpec.describe "int_to_roman" do
  it { expect(int_to_roman(3)).to eq "III" }
  it { expect(int_to_roman(4)).to eq "IV" }
  it { expect(int_to_roman(9)).to eq "IX" }
  it { expect(int_to_roman(10)).to eq "X" }
  it { expect(int_to_roman(58)).to eq "LVIII" }
  it { expect(int_to_roman(1994)).to eq "MCMXCIV" }
end
