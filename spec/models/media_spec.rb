require 'spec_helper'

RSpec.describe Media do
  describe "Attributes" do
    it "should have a title" do
      expect(Concert.new).to respond_to(:title)
    end

    it "should have a media" do
      expect(Concert.new).to respond_to(:media)
    end

    it "should have a url" do
      expect(Concert.new).to respond_to(:url)
    end

    it "should have an embed" do
      expect(Media.new).to respond_to(:embed)
    end

    it "should have an kind" do
      expect(Media.new).to respond_to(:kind)
    end

    it "should have a position" do
      expect(Media.new).to respond_to(:position)
    end
  end

  describe "Validations" do
    describe "title" do
      it "should be mandatory" do
        c = Media.new
        expect(c.save).to be_falsy
        expect(c.errors).to include(:title)
      end
    end

    describe "kind" do
      it "should be mandatory" do
        c = Concert.new
        expect(c.save).to be_falsy
        expect(c.errors).to include(:kind)
      end
    end
  end
end
