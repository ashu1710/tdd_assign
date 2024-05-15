class User < ApplicationRecord
	def self.add(numbers)
		return "invalid input" if numbers.match?(/,(\n|$)/)

		negatives = numbers.scan(/-\d+/)
		return "negative numbers not allowed: #{negatives.join(', ')}" if negatives.present?
		numbers.scan(/[-]?\d+/).map(&:to_i).select { |num| num <= 1000 }.sum
	end
end
