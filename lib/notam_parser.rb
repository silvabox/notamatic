class NotamParser
  include Enumerable

  attr_reader :source, :notam
  private :source, :notam

  def initialize(source)
    @source = source
    run
  end

  def each(filter = nil, &block)
    return notams.each(&block) unless filter
    each_with_filter(filter, &block)
  end

  private

  def run
    source.each_line do |line|
      if line.chomp.empty?
        close_notam
      else
        parse_line(line)
      end
    end
    close_notam
  end

  def each_with_filter(filter, &block)
    enum = Enumerator.new do |y|
      notams.each do |notam|
        filter.apply(notam) do |result|
          y << result
        end
      end
    end
    return enum unless block
    enum.each &block
  end

  def notams
    @notams ||= []
  end

  def close_notam
    return unless current_notam?
    notams << notam
    @notam = nil
  end

  def current_notam?
    @notam
  end

  def notam
    @notam ||= Notam.new
  end

  def parse_line(line)
    regex = /^([AE])\)\s+(.*)$/
    match = regex.match(line)
    return unless match
    NotamParser.const_get(match.captures[0]).call(notam, match.captures[1])
  end

  A = ->(notam, content) { notam.code = content }
  E = ->(notam, content) { notam.message = content }
end
