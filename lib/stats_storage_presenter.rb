class StatsStoragePresenter
  def initialize(stats_storage:)
    @stats_storage = stats_storage
  end

  def total_views
    stats_storage
      .paths_by_total_views
      .each { |url, stat| puts "#{url} #{stat.total_views} views\n" }
  end

  def unique_views
    stats_storage
      .paths_by_unique_views
      .each { |url, stat| puts "#{url} #{stat.unique_views} unique views\n" }
  end

  private

  attr_reader :stats_storage
end