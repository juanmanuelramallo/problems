# require "byebug"
# You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

# You may assume the two numbers do not contain any leading zero, except the number 0 itself.

# Example:

# Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
# Output: 7 -> 0 -> 8
# Explanation: 342 + 465 = 807.

# Definition for singly-linked list.
class ListNode
    attr_accessor :val, :next
    def initialize(val)
        @val = val
        @next = nil
    end
end

# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
    reminders = []

    val = l1.val + l2.val
    if val / 10 > 0
        reminders << val / 10
    end
    list = ListNode.new(val % 10)
    main_list = list
    l1 = l1.next
    l2 = l2.next

    until l1.nil? && l2.nil?
        val = [l1&.val, l2&.val].compact.sum
        val += reminders.pop.to_i
        if val / 10 > 0
            reminders << val / 10
        end
        list.next = ListNode.new(val % 10)
        list = list.next
        l1 = l1&.next
        l2 = l2&.next
    end

    if reminders.any?
        list.next = ListNode.new(reminders.pop)
    end

    main_list
end

# def add_two_numbers(l1, l2)
#     reminders = []

#     val = [l1&.val, l2&.val].compact.sum
#     reminders << val / 10 if (val / 10 > 0)
#     list = ListNode.new(val % 10)
#     l1 = l1&.next
#     l2 = l2&.next

#     until l1.nil? && l2.nil?
#         val = [l1&.val, l2&.val].compact.sum
#         val += reminders.pop.to_i
#         if (val / 10) > 0
#             reminders << (val / 10)
#         end
#         list.next = ListNode.new(val % 10)
#         l1 = l1&.next
#         l2 = l2&.next
#     end

#     until reminders.empty?
#        list.next = ListNode.new(reminders.pop)
#     end

#     list
# end

# Testcases
def generate_list(array = [])
    list = ListNode.new(array[0])
    array.drop(1).each do |n|
        list.next = ListNode.new(n)
    end
    list
end

def print_list(list)
    until list.nil?
        print "#{list.val} "
        list = list.next
    end
    puts ""
end

l1_nums = [4,6]
l2_nums = [1,4]
l1 = generate_list(l1_nums)
l2 = generate_list(l2_nums)

puts l1_nums.join(" ")
puts l2_nums.join(" ")
print_list(add_two_numbers(l1, l2))
