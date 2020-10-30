require_relative 'errors'
require_relative 'stats_storage'
require_relative 'stats_storage_presenter'

class Parser
  def self.call(**args)
    new(**args).call
  end

  def initialize(**kwargs)
    @file_path = kwargs.delete(:file_path)
  end

  def call
    raise Errors::MissingFileError, "File #{file_path} does not exist" unless File.exist?(file_path)

    File.foreach(file_path) do |line|
      log_entry_array = line.split(" ").compact
      stats_storage.log_visit(url: log_entry_array.first, ip: log_entry_array.last)
    end

    stats_storage_presenter.total_views
    stats_storage_presenter.unique_views
  end

  private

  attr_reader :file_path

  def stats_storage
    @stats_storage ||= StatsStorage.new
  end

  def stats_storage_presenter
    @stats_storage_presenter ||= StatsStoragePresenter.new(stats_storage: stats_storage)
  end
end