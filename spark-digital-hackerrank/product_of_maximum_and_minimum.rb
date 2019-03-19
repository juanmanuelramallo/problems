require "rspec/autorun"

# First version
def maxMin(operations, x)
  elements = []
  operations.map.with_index do |operation, i|
    operation = operation == "push" ? :push : :delete
    elements.send(operation, x[i])
    elements.min * elements.max
  end
end

# # Second version
# def maxMin(operations, x)
#   elements = []
#   min, max = nil, nil
#   operations.map.with_index do |operation, i|
#     min = x[i] if min.nil?
#     max = x[i] if max.nil?

#     operation = operation == "push" ? :push : :delete
#     result = elements.send(operation, x[i])

#     if operation == :push
#       if x[i] < min
#         min = x[i]
#       elsif x[i] > max
#         max = x[i]
#       end
#     else operation == :delete
#       if result == min
#         min = elements.min
#       elsif result == max
#         max = elements.max
#       end
#     end

#     min * max
#   end
# end

RSpec.describe "maxMin" do
  it { expect(maxMin(["push","push","push","pop"], [1,2,3,1])).to eq [1,2,3,6] }
  it { expect(maxMin(["push","push"], [3,2])).to eq [9,6] }
end
