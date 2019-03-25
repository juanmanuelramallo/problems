# Sum of two large numbers
# Given two numbers as strings. The numbers may be very large (may not fit in long long int), the task is to find sum of these two numbers.
# Examples:
# Input  : str1 = "3333311111111111",
#          str2 =   "44422222221111"
# Output : 3377733333332222

# Input  : str1 = "7777555511111111",
#          str2 =    "3332222221111"
# Output : 7780887733332222

require "rspec/autorun"

def sum(string_a, string_b)
  return -1 if string_a[0] == "-" || string_b[0] == "-" || string_a.nil? || string_b.nil?

  chars_a, chars_b = string_a.chars, string_b.chars
  result = []
  carry = 0

  max_size = [chars_a.size, chars_b.size].max

  max_size.times do
    a = chars_a.pop.to_i
    b = chars_b.pop.to_i

    sum = (a + b + carry)
    result << sum % 10
    carry = sum / 10
  end

  result << carry if carry > 0
  result.reverse.join("")
end

RSpec.describe "sum" do
  it { expect(sum("1", "2")).to eq "3" }
  it { expect(sum("1", "23")).to eq "24" }
  it { expect(sum("567", "8")).to eq "575" }
  it { expect(sum("6", "789")).to eq "795" }
  it { expect(sum("9", "9")).to eq "18" }
  it { expect(sum("7777555511111111", "3332222221111")).to eq "7780887733332222" }
  it { expect(sum("3333311111111111", "44422222221111")).to eq "3377733333332222" }
end
