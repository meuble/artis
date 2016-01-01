require 'spec_helper'

RSpec.describe Musician do
  describe "Attributes" do
    it "should have a name" do
      expect(Musician.new).to respond_to(:name)
    end

    it "should have a description" do
      expect(Musician.new).to respond_to(:description)
    end

    it "should be positioned" do
      expect(Musician.new).to respond_to(:position)
    end

    it "should be flagged as core_member" do
      expect(Musician.new).to respond_to(:is_core_member)
    end

    it "should have an image" do
      expect(Musician.new).to respond_to(:image)
    end
  end

  describe "Validations" do
    describe "#name" do
      it "should be mandatory" do
        m = Musician.new
        expect(m.save).to be_falsy
        expect(m.errors).to include(:name)
      end
    end

    describe "#description" do
      it "should be mandatory" do
        m = Musician.new
        expect(m.save).to be_falsy
        expect(m.errors).to include(:description)
      end
    end

    describe "#position" do
      it "should be mandatory" do
        m = Musician.new
        expect(m.save).to be_falsy
        expect(m.errors).to include(:position)
      end
    end

    describe "#is_core_member" do
      it "should be mandatory" do
        m = Musician.new
        expect(m.save).to be_falsy
        expect(m.errors).to include(:is_core_member)
      end
    end
  end
end
