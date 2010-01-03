require "string_calculator.rb"

Spec::Matchers.define :add_to do |expected|
  match do |string|
    (@result = string.extend(StringCalculator).add) == expected
  end
  
  failure_message_for_should do |string|
    "Exptected #{string}to add up to #{expected}, but got #{@result}"
  end
end

describe StringCalculator, "#add" do
  it "should returns 0 for empty string" do
    "".should add_to(0)
  end
  
  context "single number" do
    it "should returns 0 for 0" do
      "0".should add_to(0)
    end
    it "should returns 5 dor 5" do
      "5".should add_to(5)
    end
    it "should returns 27 for 27" do
      "27".should add_to(27)
    end
  end
  
  context "2 numbers" do
    it "should retuens 5 for 2,3" do
      "2,3".should add_to(5)
    end
    it "should returns 27 for 22,5" do
      "22,5".should add_to(27)
    end
    it "should returns 1025 for 200,700,125" do
      "200,700,125".should add_to(1025)
    end
  end
  
  context "3 numebrs" do
    it "should returns 25 for 10,12,3" do
      "10,12,3".should add_to(25)
    end
    it "should supports newline as delimiter" do
      "1\n2".should add_to(3)
    end
    it "should supports mixed delimiters" do
      "1\n2,25".should add_to(28)
    end
    it "should supports aleternate delimiter" do
      "//;\n1;2;3".should add_to(6)
    end
  end
  
  context "negative numbers" do
    it "should raise an exception if it finds one" do
      lambda {"-1,25,-42".extend(StringCalculator).add}.should raise_error("Negative not allowed: -1, -42")
    end
  end
end