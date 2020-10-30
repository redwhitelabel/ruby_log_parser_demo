require 'set'

class StatsModel
  def initialize(url:, ip:)
    @clients = Set[ip]
    @url = url
    @unique_views = 1
    @total_views = 1
  end

  def add_visit(ip)
    @total_views += 1

    return if clients.member?(ip)

    clients.add(ip)
    @unique_views += 1
  end

  attr_reader :clients, :total_views, :url, :unique_views
end
