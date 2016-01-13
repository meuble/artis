require 'spec_helper'

RSpec.describe Section do
  describe "Attributes" do
    it "should have a title" do
      expect(Musician.new).to respond_to(:name)
    end

    it "should be positioned" do
      expect(Musician.new).to respond_to(:position)
    end
  end
end
