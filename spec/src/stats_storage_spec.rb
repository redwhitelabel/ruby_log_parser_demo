require "faker"
require "spec/spec_helper"
require "src/stats_storage"
require "src/stats_model"

RSpec.describe StatsStorage do
  describe "#log_visit" do
    context "with empty storage" do
      let(:ip) { Faker::Internet.ip_v4_address }
      let(:url) { Faker::Internet.url }
      subject(:stats_storage) { described_class.new }

      it "logs new visit", :aggregate_failures do
        stats_storage.log_visit(url: url, ip: ip)

        expect(stats_storage.storage.length).to eq 1
        expect(stats_storage.storage[url]).to be_a StatsModel
        expect(stats_storage.storage[url].unique_views).to eq 1
        expect(stats_storage.storage[url].url).to eq url
      end
    end

    context "with unique visit already registered", :aggregate_failures do
      let(:ip) { Faker::Internet.ip_v4_address }
      let(:url) { Faker::Internet.url }
      subject(:stats_storage) do
        storage = described_class.new
        storage.log_visit(url: url, ip: ip)
        storage
      end

      context "with returning client" do
        it "skips same client visit", :aggregate_failures do
          stats_storage.log_visit(url: url, ip: ip)

          expect(stats_storage.storage.length).to eq 1
          expect(stats_storage.storage[url]).to be_a StatsModel
          expect(stats_storage.storage[url].unique_views).to eq 1
          expect(stats_storage.storage[url].url).to eq url
        end
      end

      context "with another client visiting the same url" do
        let(:another_ip) { Faker::Internet.ip_v4_address }

        it "skips same client visit", :aggregate_failures do
          stats_storage.log_visit(url: url, ip: another_ip)

          expect(stats_storage.storage.length).to eq 1
          expect(stats_storage.storage[url]).to be_a StatsModel
          expect(stats_storage.storage[url].unique_views).to eq 2
          expect(stats_storage.storage[url].url).to eq url
        end
      end

      context "with another client visiting different url" do
        let(:another_url) { Faker::Internet.url }
        let(:another_ip) { Faker::Internet.ip_v4_address }

        it "skips same client visit", :aggregate_failures do
          stats_storage.log_visit(url: another_url, ip: another_ip)

          expect(stats_storage.storage.length).to eq 2
          expect(stats_storage.storage[url]).to be_a StatsModel
          expect(stats_storage.storage[url].unique_views).to eq 1
          expect(stats_storage.storage[url].url).to eq url
          expect(stats_storage.storage[another_url]).to be_a StatsModel
          expect(stats_storage.storage[another_url].unique_views).to eq 1
          expect(stats_storage.storage[another_url].url).to eq another_url
        end
      end
    end
  end
end
