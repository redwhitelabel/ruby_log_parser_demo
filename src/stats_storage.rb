require_relative 'stats_model'

class StatsStorage
  def initialize
    @storage = {}
  end

  def log_visit(url:, ip:)
    return storage[url] = StatsModel.new(url: url, ip: ip) unless storage.include?(url)

    storage[url].add_visit(ip)
  end

  def show_total_views
    storage
      .sort_by { |url, stat| -stat.total_views }
      .each { |url, stat| puts "#{url} #{stat.total_views} views\n" }
  end

  def show_unique_views
    storage
      .sort_by { |url, stat| -stat.unique_views }
      .each { |url, stat| puts "#{url} #{stat.unique_views} unique views\n" }
  end

  attr_reader :storage
end