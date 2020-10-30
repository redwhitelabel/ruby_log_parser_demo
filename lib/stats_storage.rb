require_relative 'stats_model'

class StatsStorage
  def initialize
    @storage = {}
  end

  def log_visit(url:, ip:)
    return if url.empty? || ip.empty?

    if storage.include?(url)
      storage[url].add_visit(ip)
    else
      storage[url] = StatsModel.new(url: url, ip: ip)
    end
  end

  def paths_by_total_views
    storage.sort_by { |url, stat| -stat.total_views }
  end

  def paths_by_unique_views
    storage.sort_by { |url, stat| -stat.unique_views }
  end

  attr_reader :storage
end
