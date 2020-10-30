require "faker"
require "lib/stats_storage_presenter"

RSpec.describe StatsStoragePresenter do
  describe "#total_views" do
    context "with initial visit only" do
      let(:url) { Faker::Internet.url }
      let(:ip) { Faker::Internet.ip_v4_address }
      subject(:stats_storage_presenter) { described_class.new(stats_storage: stats_storage) }

      it "presents total views registered", :aggregate_failures do
      end
    end
  end
end