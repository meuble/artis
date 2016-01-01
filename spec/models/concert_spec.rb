require 'spec_helper'

RSpec.describe Concert do
  describe "Attributes" do
    it "should have a title" do
      expect(Concert.new).to respond_to(:title)
    end

    it "should have a description" do
      expect(Concert.new).to respond_to(:description)
    end

    it "should have a date" do
      expect(Concert.new).to respond_to(:date)
    end

    it "should have an image" do
      expect(Concert.new).to respond_to(:image)
    end

    it "should have a musician id list" do
      expect(Concert.new).to respond_to(:musician_ids)
    end
  end

  describe "Validations" do
    describe "title" do
      it "should be mandatory" do
        c = Concert.new
        expect(c.save).to be_falsy
        expect(c.errors).to include(:title)
      end
    end

    describe "description" do
      it "should be mandatory" do
        c = Concert.new
        expect(c.save).to be_falsy
        expect(c.errors).to include(:description)
      end
    end

    describe "date" do
      it "should be mandatory" do
        c = Concert.new
        expect(c.save).to be_falsy
        expect(c.errors).to include(:date)
      end
    end
  end
end
