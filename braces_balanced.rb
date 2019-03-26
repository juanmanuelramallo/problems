# You are designing a compiler for a C++ program and need to check that braces in any given file are balanced.

# Braces in a string are considered to be balanced if the following criteria are met:
# All braces must be closed. Braces come in pairs of the form (), {} and [].
# The left brace opens the pair, and the right one closes it.
# In any set of nested braces, the braces between any pair must be closed.

# For example, [{}] is a valid grouping of braces but [}]{} is not.

# Function Description
# Complete the function braces in the editor below.
# The function must return an array of strings where the string at each index i denotes whether or not the
# braces were balanced in a valuesi.  The array should consist of strings "YES" or "NO" aligned with their indexes in values.

require "rspec/autorun"

def braces(values)
    braces_data = {
        "{": "}",
        "(": ")",
        "[": "]",
    }

    closing_braces = ["}", ")", "]"]

    values.map do |braces|
        stack = []
        is_balanced = true

        braces.each_char do |char|
            if closing_braces.include?(char) && stack.size > 0
                popped = stack.pop

                expected_closing_brace = braces_data[:"#{popped}"]

                if expected_closing_brace != char
                    is_balanced = false
                    break
                end
            else
                stack << char
            end
        end

        is_balanced && stack.empty? ? "YES": "NO"
    end
end

RSpec.describe "braces" do
    it { expect(braces(["{}()[]"])).to eq ["YES"]}
    it { expect(braces(["{}()[]", "(){}[]"])).to eq ["YES", "YES"]}
    it { expect(braces(["{}()[]", "{)}"])).to eq ["YES", "NO"]}
    it { expect(braces(["{]}(])[]]"])).to eq ["NO"]}
    it { expect(braces(["[()]{}"])).to eq ["YES"]}
    it { expect(braces(["(()()((())))()[{({[]})}]", "(){}[)"])).to eq ["YES", "NO"]}
    it { expect(braces(["])]}()"])).to eq ["NO"]}
    it { expect(braces(["("])).to eq ["NO"]}
end
