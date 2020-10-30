require_relative 'stats_storage'
require_relative 'errors'

class Parser
  def self.call(**args)
    new(**args).call
  end

  def initialize(**kwargs)
    @file_path = kwargs.delete(:file_path)
  end

  def call
    file.each_line do |line|
      log_entry_array = line.split(" ").compact
      stats_storage.log_visit(url: log_entry_array.first, ip: log_entry_array.last) if log_entry_array.length == 2
    end

    stats_storage.show_total_views
    stats_storage.show_unique_views
  end

  private

  attr_reader :file_path

  def file
    raise Errors::MissingFileError, "File #{file_path} does not exist" unless File.exist?(file_path)

    File.open(file_path).read
  end

  def stats_storage
    @storage ||= StatsStorage.new
  end
end