# TODO

# require "byebug"
require "rspec/autorun"

# def is_match(s, p)
#   # puts " ---------------------------- #{s}, #{p} ------------------------------ "
#   index = 0
#   pattern_index = 0
#   matches = true
#   until pattern_index >= p.size
#     pattern_char = p[pattern_index]
#     next_pattern_char = p[pattern_index + 1]

#     puts " P: #{pattern_char} -> #{next_pattern_char} | S: #{s[index]} -> #{s[index + 1]} | I: #{index}"

#     if next_pattern_char == "*"
#       index = pattern_char == "." ? s.size : handle_asterisk(s, index, p, pattern_index)
#     else
#       matches = [".", "*"].include?(pattern_char) ? matches : pattern_char == s[index]
#       # puts " pattern_char = #{pattern_char} == s[index] #{s[index]}"
#       index += 1 unless pattern_char == "*"
#     end

#     puts " P: #{pattern_char} -> #{next_pattern_char} | S: #{s[index]} -> #{s[index + 1]} | I: #{index} | M: #{matches}"

#     pattern_index += 1
#   end

#   all_input = index == s.size
#   # puts "all input #{all_input}"
#   matches && all_input
# end

# def handle_asterisk(s, index, p, pattern_index)
#   pattern_char = p[pattern_index]
#   # puts " HANDLE ASTERISK #{pattern_char} "
#   prev_char = s[index]
#   return index unless prev_char == pattern_char
#   char = s[index + 1]
#   until char != prev_char do
#     index += 1
#     char = s[index]
#   end
#   index = s.size if prev_char == "."
#   index -= p[(pattern_index + 2)..(p.size - 1)].size if index == s.size - 1
#   index
# end

# def is_match(s, p)
#   return false if !p.include?("*") && !p.include?(".") && s.size != p.size

#   index = 0
#   s = s.reverse
#   p = p.reverse
#   puts " ---------------------------- #{s}, #{p} ------------------------------ "
#   matches = true

#   p.each_char.with_index do |pattern_char, pattern_index|
#     next_pattern_char = p[pattern_index + 1]
#     # puts " === #{pattern_char} === "
#     # puts " P: #{pattern_char} -> #{next_pattern_char} | S: #{s[index]} -> #{s[index + 1]} | I: #{index} | M: #{matches}"
#     case pattern_char
#     when "."
#       byebug
#       index = index + 1 unless p[pattern_index - 1] == "*"
#     when "*"
#       char = s[index]
#       byebug
#       if next_pattern_char == "."
#         # byebug
#         until char == p[pattern_index + 2] do
#           index += 1
#           char = s[index]
#         end
#       else
#         byebug
#         until char != next_pattern_char do
#           index += 1
#           char = s[index]
#         end
#       end
#     else
#       byebug
#       unless pattern_index > 0 && p[pattern_index - 1] == "*"
#         matches = matches && (s[index] == pattern_char)
#         index += 1
#       end
#     end

#     # puts " P: #{pattern_char} -> #{next_pattern_char} | S: #{s[index]} -> #{s[index + 1]} | I: #{index} | M: #{matches}"
#   end

#   # puts " ----- #{index}, #{s.size}, #{index == s.size} ---------- "
#   matches && index == s.size
# end

def is_match(s, p)
  pattern = parse_pattern(p)
  pattern_index = 0

  match_sum = 0
  s.chars.each.with_index do |char, index|
    prev_pattern = p[pattern_index - 1]
    prev_pattern_char = prev_pattern[0]
    current_pattern = p[pattern_index]
    pattern_char = current_pattern[0]

    if current_pattern.include?("*")
      if pattern_char == char
        match_sum += 1
      else
        pattern_index += 1
      end
    elsif current_pattern.include?(".")

    else
      if prev_pattern.include?("*") && prev_pattern_char == current_pattern_char
        pattern_index += 1
      else

      end
    end

    # pattern_index += 1
  end

  if pattern_index < pattern.size
    pattern_index += 1 if pattern[pattern_index + 1] == s.chars.last
  end

  match_sum == s.size && pattern_index == pattern.size
end

def parse_pattern(p)
  p.scan(/[a-z.]\**/).flatten
end

RSpec.describe "is_match" do
  # it { expect(is_match("aa", "a*")).to eq true }
  # it { expect(is_match("ab", ".*")).to eq true }
  # it { expect(is_match("aab", "c*a*b")).to eq true }
  # it { expect(is_match("aaa", "a*a")).to eq true }
  # it { expect(is_match("baaa", "ba*a")).to eq true }
  # it { expect(is_match("asdfga", ".*a")).to eq true }
  # it { expect(is_match("baaa", "b.*")).to eq true }
  it { expect(is_match("aaa", "ab*a*c*a")).to eq true }

  # it { expect(is_match("aa", "a")).to eq false }
  # it { expect(is_match("mississippi", "mis*is*p*.")).to eq false }
  # it { expect(is_match("abcd", "d*")).to eq false }
end
