require 'notam_parser'

describe NotamParser do
  let(:file) { File.open('./spec/fixtures/notam_data.txt') }
  subject(:parser) { NotamParser.new(file) }

  it 'creates a notam for each entry' do
    expect(parser.count).to eq 12
  end

  it 'supports enumeration with a filter' do
    filter = double(:filter)
    expect(filter).to receive(:apply).exactly(12).times
    parser.each(filter).to_a
  end

  describe 'each with filter' do
    it 'returns only yielded objects' do
      filter = double(:filter)
      obj = nil
      allow(filter).to receive(:apply) do |notam, &block|
        unless obj
          obj = Object.new
          block.call obj
        end
      end
      expect(parser.each(filter).to_a).to eq [obj]
    end
  end
end
