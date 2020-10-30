# frozen_string_literal: true

require_relative "base_formatter"

class TotalViewsFormatter < BaseFormatter
  HEADER = "Total views"

  def header
    HEADER
  end

  def data
    views.map { |url, stat| "#{url} #{stat.total_views} views\n" }
  end
end
