require 'spec_helper'

RSpec.describe Program do
  describe "Attributes" do
    it "should have a name" do
      expect(Program.new).to respond_to(:title)
    end

    it "should have a description" do
      expect(Program.new).to respond_to(:description)
    end

    it "should be positioned" do
      expect(Program.new).to respond_to(:position)
    end

    it "should have an image" do
      expect(Program.new).to respond_to(:image)
    end

    it "should have a position" do
      expect(Program.new).to respond_to(:position)
    end
  end
end
