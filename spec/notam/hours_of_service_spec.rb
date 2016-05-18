require 'notam'
require 'notam/hours_of_service'

describe Notam::HoursOfService do
  let(:message) { 'AERODROME CONTROL TOWER (TWR) HOURS OF OPS/SERVICE ' \
                'MON 0445-1845 ' \
                'TUE 0445-2030 2230-2359 ' \
                'WED-FRI 0445-2030 ' \
                'SAT CLSD ' \
                'SUN 0600-0700 1215-1930' }
  let(:notam) { double :notam, code: 'ABCD', message: message }

  subject { Notam::HoursOfService.new(notam) }

  it 'has a code' do
    expect(subject.code).to eq 'ABCD'
  end

  it 'has a message' do
    expect(subject.message).to eq message
  end

  it 'has hours of service' do
    expect(subject[:mon]).to eq ['0445-1845']
  end
end
