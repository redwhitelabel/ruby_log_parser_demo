class BaseFormatter
  def initialize(views:)
    @views = views
  end

  def header
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def data
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  private

  attr_reader :views
end
