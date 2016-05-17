require_relative '../notam'

class Notam::MessageFilter
  def initialize(pattern)
    @pattern = pattern
  end

  def apply(notam)
    yield notam if @pattern.match(notam.message)
  end
end
