require_relative './lib/oystercard.rb'

oystercard = Oystercard.new
p oystercard.balance

oystercard.top_up(50)
p oystercard.balance
# expect £10

# oystercard.top_up(100)
# expect runtime error

oystercard.deduct(1.90)
p oystercard.balance
