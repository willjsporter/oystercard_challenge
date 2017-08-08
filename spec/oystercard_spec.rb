require 'oystercard'

describe Oystercard do
  let(:oystercard) { described_class.new }

  it 'initializes with a zero balance' do
    expect(oystercard.balance).to eq 0
  end

  it 'allows a topup' do
    expect(oystercard).to respond_to(:top_up).with(1).argument
  end

  it 'registers a ten pound topup in the balance' do
    oystercard.top_up(10)
    expect(oystercard.balance).to eq 10
  end

  it 'limits the amount of balance on the card to £90' do
    expect { oystercard.top_up(90) }.not_to raise_error
  end

  it 'limits the amount of balance on the card to £91' do
    expect { oystercard.top_up(91) }.to raise_error "Balance cannot exceed £90"
  end

  it 'deducts fare amount from balance' do
    oystercard.top_up(50)
    old_bal = oystercard.balance
    oystercard.deduct
    expect(oystercard.balance).to eq(old_bal - 2)
  end

  it 'returns Beep when touching in' do
    oystercard.top_up(10)
    expect(oystercard.touch_in).to eq "Beep"
  end

  it 'recognises when it is in the midst of a voyage' do
    oystercard.top_up(10)
    oystercard.touch_in
    expect(oystercard.in_journey?).to eq true
  end

  it "won't letcha touch in again if you're in journey" do
    oystercard.top_up(10)
    oystercard.touch_in
    expect { oystercard.touch_in }.to raise_error "Fuck"
  end

  it "will let you touch out if you have touched in and runs deduct" do
    oystercard.top_up(50)
    old_bal = oystercard.balance
    oystercard.touch_out
    expect(oystercard.balance).to eq(old_bal - 2)
  end

  it "returns 'boop' when touching out" do
    expect(oystercard.touch_out).to eq "Boop"
  end

  it 'returns error if balance < £1' do
    expect { oystercard.touch_in }.to raise_error "FUCK OFF"
  end

end
