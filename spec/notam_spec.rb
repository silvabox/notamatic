require 'notam'

describe Notam do
  subject(:notam) { Notam.new('ABCD', 'TEST NOTAM MON-SUN 0800-1700') }

  it 'has a code' do
    expect(notam.code).to eq 'ABCD'
  end

  it 'has a message' do
    expect(notam.message).to eq 'TEST NOTAM MON-SUN 0800-1700'
  end
end
