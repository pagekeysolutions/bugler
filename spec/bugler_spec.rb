require 'bugler'

describe Bugler do
  context "confirming default method" do
    it "prints something containing Hello world" do
      expect(Bugler.hi).to include("Hello world")
	end
  end
end
