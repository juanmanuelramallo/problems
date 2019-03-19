require 'rspec/autorun'

class Greeter
  attr_reader :name

  def initialize(**params)
    @name = params[:name]
  end

  def hi
    "Hi #{name}"
  end
end

RSpec.describe Greeter do
  describe "#hi" do
    subject { Greeter.new(name: "Olivia").hi }
    it "expects greeter to say hi" do
      expect(subject).to eq "Hi Olivia"
    end
  end
end
