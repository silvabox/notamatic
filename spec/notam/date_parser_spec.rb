require 'notam/date_parser'

describe Notam::DateParser do
  let(:message) { 'AERODROME CONTROL TOWER (TWR) HOURS OF OPS/SERVICE ' \
                'MON 0445-1845 ' \
                'TUE 0445-2030, 2230-2359 ' \
                'WED-FRI 0445-2030 ' \
                'SAT CLSD ' \
                'SUN 0600-0700, 1215-1930' }

  subject(:parser) { Notam::DateParser.new(message) }

  it 'handles singular dates and times' do
    expect(parser[:mon]).to eq ['0445-1845']
  end

  it 'handles ranges of days' do
    [:wed, :thu, :fri].each do |day|
      expect(parser[day]).to eq ['0445-2030']
    end
  end

  it 'parses ranges of times' do
    ['0445-2030', '2230-2359']. each do |time|
      expect(parser[:tue]).to include time
    end
  end

  it 'fails if the message format is invalid' do
    expect{Notam::DateParser.new('Invalid message')}.to raise_error 'Invalid message format'
  end

  it 'handles closed days' do
    expect(parser[:sat]).to eq ['CLOSED']
  end
end
