require 'bugler'
require 'bugler/config'
require 'fileutils'

describe Bugler do
  context "confirming default method" do
    it "returns something containing Hello world" do
      expect(Bugler.hi).to include("Hello world")
	  end
  end
end

describe Bugler::CLI do
  describe ".exec" do
    context "when user provides no arguments" do
      it "prints the help dialog" do
        expect{ Bugler::CLI.exec([]) }.to output(Bugler::Config::HELP_TEXT).to_stdout
      end
    end
    context "when user calls init" do
      it "invokes .init" do
        expect(Bugler::CLI).to receive(:init).with([]) # .with (arg)
        Bugler::CLI.exec(['init'])
      end
      it "passes array to init" do
        expect(Bugler::CLI).to receive(:init).with(["app_name"]) # .with (arg)
        Bugler::CLI.exec(['init', 'app_name'])
      end
    end
  end
  context ".init" do
    before(:context) do
      SAMPLE_NAME = "sample_app"
    end
    it "fails when no name is provided" do
      argv = []
      expect{ Bugler::CLI.init(argv) }.to raise_error(Bugler::Config::ERROR_INIT_NO_NAME)
    end
    it "fails when a string argument is provided" do
      argv = "init"
      expect{ Bugler::CLI.init(argv) }.to raise_error(Bugler::Config::ERROR_INIT_ARGV)
    end
    it "creates directory structure for blank app" do
      argv = [SAMPLE_NAME]
      Bugler::CLI.init(argv)
      expect(File).to exist(SAMPLE_NAME)
      expect(File).to exist(File.join(SAMPLE_NAME, ".bugler"))
      expect(File).to exist(File.join(SAMPLE_NAME, Bugler::Config::SOURCE_DIRNAME))
    end
    after(:context) do
      FileUtils.rm_r(SAMPLE_NAME) if File.exists?(SAMPLE_NAME)
    end
  end
end
