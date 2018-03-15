require 'bugler'
require 'bugler/cli'
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
        expect(Bugler::CLI).to receive(:init) # .with (arg)
        Bugler::CLI.exec(['init'])
      end
    end
  end
  context ".init" do
    it "fails when no name is provided" do
      argv = []
      expect{ Bugler::CLI.init(argv) }.to raise_error(Bugler::Config::ERROR_INIT_NO_NAME)
    end
    it "creates directory structure for blank app" do
      argv = %w(sample)
      Bugler::CLI.init(argv)
      expect(File).to exist("sample")
      Dir.rmdir "sample"
    end
  end
end
