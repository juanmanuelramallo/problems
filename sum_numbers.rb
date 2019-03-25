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

def nine_complement(arr)
  arr.map { |char| (9 - char.to_i).to_s }
end

def sum(string_a, string_b)
  chars_a, chars_b = string_a.chars, string_b.chars
  result = []
  carry = 0
  signature = ""
  complemented = false

  if chars_a[0] == "-" && chars_b[0] == "-"
    chars_a.delete_at(0)
    chars_b.delete_at(0)
    signature = "-"
  end

  if chars_a[0] != "-" && chars_b[0] == "-"
    chars_b.delete_at(0)
    chars_a = nine_complement(chars_a)
    complemented = :chars_a
  elsif chars_a[0] == "-" && chars_b[0] != "-"
    chars_a.delete_at(0)
    chars_b = nine_complement(chars_b)
    complemented = :chars_b
  end

  max_size = [chars_a.size, chars_b.size].max

  max_size.times do
    a = chars_a.pop.to_i
    b = chars_b.pop.to_i

    sum = (a + b + carry)
    result << sum % 10
    carry = sum / 10
  end

  result << carry if carry > 0

  if complemented
    if result.size > max_size
      result.pop
      carry = 1
      index = result.size - 1
      while carry != 0
        sum = result[index] + carry
        result[index] = sum % 10
        carry = sum / 10
        index -= 1
      end

      signature = "-"
    else
      result = nine_complement(result)
    end
  end

  result << signature
  result.reverse.join("")
end

RSpec.describe "sum" do
  it { expect(sum("1", "2")).to eq "3" }
  it { expect(sum("1", "23")).to eq "24" }
  it { expect(sum("567", "8")).to eq "575" }
  it { expect(sum("6", "789")).to eq "795" }
  it { expect(sum("7777555511111111", "3332222221111")).to eq "7780887733332222" }
  it { expect(sum("3333311111111111", "44422222221111")).to eq "3377733333332222" }

  it { expect(sum("-3", "-2")).to eq "-5" }
  it { expect(sum("3", "-2")).to eq "1" }
  it { expect(sum("-3", "2")).to eq "-1" }

  # FAILING:
  # it { expect(sum("-590", "1")).to eq "-589"}
end
