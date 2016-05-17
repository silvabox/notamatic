require 'notam/message_filter'

describe Notam::MessageFilter do
  let(:notam1) { double(:notam, message: 'SELECT THIS NOTAM FOR THE WIN') }
  let(:notam2) { double(:notam, message: 'NOT THIS ONE') }

  subject(:filter) { Notam::MessageFilter.new(/SELECT THIS/) }

  it 'yields for notams with matching message' do
    expect(notam1).to receive(:hit)
    filter.apply(notam1) { |notam| notam.hit }
  end

  it 'does not yield notams with unmatching messages' do
    expect(notam2).not_to receive(:hit)
    filter.apply(notam2) { |notam| notam.hit }
  end
end
