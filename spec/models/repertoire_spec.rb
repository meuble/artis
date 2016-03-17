require 'spec_helper'

RSpec.describe Repertoire do
  describe "Attributes" do
    it "should have a title" do
      expect(Repertoire.new).to respond_to(:title)
    end

    it "should be positioned" do
      expect(Repertoire.new).to respond_to(:description)
    end
  end
end
