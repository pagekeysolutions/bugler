require 'bugler'
require 'bugler/config'

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
    it "fails when no name is provided" do
      argv = []
      expect{ Bugler::CLI.init(argv) }.to raise_error(Bugler::Config::ERROR_INIT_NO_NAME)
    end
    it "fails when a string argument is provided" do
      argv = "init"
      expect{ Bugler::CLI.init(argv) }.to raise_error(Bugler::Config::ERROR_INIT_ARGV)
    end
    it "creates directory structure for blank app" do
      argv = %w(sample)
      Bugler::CLI.init(argv)
      expect(File).to exist("sample")
      Dir.rmdir "sample"
    end
  end
end
