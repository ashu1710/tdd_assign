PREFACE      = ('A'..'Z').to_a << ?_
SUFFIX       = ('0'..'9').to_a
PREFACE_SIZE = 2
SUFFIX_SIZE  = 3

def gen_name
	PREFACE.sample(PREFACE_SIZE).join << SUFFIX.sample(SUFFIX_SIZE).join
end

(0..10).each do |num|
	order = Order.new(order_date: (Time.now-num.days), customer_name: gen_name)
	(0..4).each do |num1|
		order_detail = order.order_details.new(price: rand(100..999),quantity: rand(1..10))
		order_detail.save
	end
end

