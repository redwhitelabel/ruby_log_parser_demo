# frozen_string_literal: true

require_relative "base_formatter"

class UniqueViewsFormatter < BaseFormatter
  HEADER = "Unique views"

  def initialize(views:)
    @views = views
  end

  def header
    HEADER
  end

  def data
    views.map { |url, stat| "#{url} #{stat.unique_views} unique views\n" }.join
  end
end
