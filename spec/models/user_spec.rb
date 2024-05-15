require 'rails_helper'

RSpec.describe User, type: :model do
	context "Validate Input and output" do
		it "should return valid output because we pass valid input" do
			output = User.add("1\n2,3")
			expect(output).to eq(6)

			output = User.add("1,2")
			expect(output).to eq(3)

			output = User.add("")
			expect(output).to eq(0)

			output = User.add("//;\n1;2")
			expect(output).to eq(3)

			output = User.add("//[*][%]\n1*2%3")
			expect(output).to eq(6)
		end

		it "should return error because we pass invalid input" do
			output = User.add("1,\n")
			expect(output).to eq("invalid input")
		end

		it "should return error because we passed single/multiple negative value" do
			output = User.add("1,2,-3")
			expect(output).to eq("negative numbers not allowed: -3")

			output = User.add("1,2,-3,-4")
			expect(output).to eq("negative numbers not allowed: -3, -4")
		end
	end
end