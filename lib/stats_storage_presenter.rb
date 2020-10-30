require_relative "formatters/total_views_formatter"
require_relative "formatters/unique_views_formatter"

class StatsStoragePresenter
  def initialize(stats_storage:, output: $stdout)
    @stats_storage = stats_storage
    @output = output
  end

  def present
    formatters.each do |formatter|
      output.puts(formatter.header)
      output.puts(formatter.data)
    end
  end

  private

  attr_reader :stats_storage, :output

  def formatters
    @formatters ||= [
      TotalViewsFormatter.new(views: total_views),
      UniqueViewsFormatter.new(views: unique_views)
    ]
  end

  def total_views
    stats_storage.paths_by_total_views
  end

  def unique_views
    stats_storage.paths_by_unique_views
  end
end
