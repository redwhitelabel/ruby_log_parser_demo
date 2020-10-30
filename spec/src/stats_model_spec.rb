require "faker"
require "spec/spec_helper"
require "src/stats_model"

RSpec.describe StatsModel do
  describe "#add_visit" do
    context "with initial visit only" do
      let(:url) { Faker::Internet.url }
      let(:ip) { Faker::Internet.ip_v4_address }
      subject(:stats_model) { described_class.new(url: url, ip: ip) }

      it "adds visit from already registered registered IP address", :aggregate_failures do
        stats_model.add_visit(ip)

        expect(stats_model.clients.length).to eq(1)
        expect(stats_model.total_views).to eq(2)
        expect(stats_model.unique_views).to eq(1)
      end

      it "adds new visit from unknown IP address", :aggregate_failures do
        stats_model.add_visit(Faker::Internet.ip_v4_address)

        expect(stats_model.clients.length).to eq(2)
        expect(stats_model.total_views).to eq(2)
        expect(stats_model.unique_views).to eq(2)
      end
    end
  end
end