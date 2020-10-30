require "spec/spec_helper"
require "src/parser"
require "src/errors"

RSpec.describe Parser do
  describe "#call" do
    context "with existing file" do
      let(:file_path) { File.dirname(__FILE__) + '/../resources/sample.log'}
      let(:expected_output) do
        ["/help_page/1 5 views",
         "/contact 2 views",
         "/home 2 views",
         "/about/2 1 views",
         "/index 1 views",
         "/about 1 views",
         "/help_page/1 5 unique views",
         "/home 2 unique views",
         "/contact 1 unique views",
         "/about/2 1 unique views",
         "/index 1 unique views",
         "/about 1 unique views\n"].join("\n")
      end
      subject(:app) { described_class.new(file_path: file_path) }

      it "prints request log stats", :aggregate_failures do
        expect { app.call }.to output(expected_output).to_stdout
      end
    end

    context "when file is missing" do
      let(:file_path) { File.dirname(__FILE__) + '/../resources/missing_file.log' }
      subject(:app) { described_class.new(file_path: file_path) }

      it "throws MissingFileError", :aggregate_failures do
        expect { app.call }.to raise_error(Errors::MissingFileError)
      end
    end
  end
end
