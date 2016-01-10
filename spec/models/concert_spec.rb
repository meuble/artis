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

  describe "musicians=" do
    describe "with params" do
      describe "and corresponding musicians" do
        it "should fill musician_ids" do
          m1 = FactoryGirl.create(:musician)
          m2 = FactoryGirl.create(:musician)
          c = Concert.new
          c.musicians = {m1.id => 1, m2.id => 1}
          expect(c.musician_ids).to eq("#{m1.id},#{m2.id}")
        end
      end

      describe "and no matching musicians" do
        it "should fill musician_ids with no ids" do
          c = Concert.new
          c.musicians = {3 => 1, 4 => 1}
          expect(c.musician_ids).to eq("")
        end
      end
    end

    describe "with no params" do
      it "should not raise errors" do
        c = Concert.new
        expect do
          c.musicians = {}
        end.not_to raise_error
      end

      it "should fill musician_ids with no ids" do
        c = Concert.new
        c.musicians = {}
        expect(c.musician_ids).to eq("")
      end
    end

    describe "with bad params" do
      it "should not raise errors" do
        c = Concert.new
        expect do
          c.musicians = 32
          c.musicians = {"toto" => 1}
        end.not_to raise_error
      end

      it "should fill musician_ids with no ids" do
        c = Concert.new
        c.musicians = 32
        expect(c.musician_ids).to eq("")

        c.musicians = {"toto" => 1}
        expect(c.musician_ids).to eq("")
      end
    end
  end

  describe "#musicians" do
    describe "with musicians" do
      before(:each) do
        @m1 = FactoryGirl.create(:musician)
        @m2 = FactoryGirl.create(:musician)
        @concert = FactoryGirl.create(:concert, :musician_ids => "#{@m1.id},#{@m2.id}")
      end

      it "should be an active record query" do
        expect(@concert.musicians.class).to be(Musician::ActiveRecord_Relation)
      end

      it "should scope musician to this concert" do
        expect(@concert.musicians.all).to eq([@m1, @m2])
      end
    end

    describe "without musicians" do
      before(:each) do
        @m1 = FactoryGirl.create(:musician)
        @m2 = FactoryGirl.create(:musician)
        @concert = FactoryGirl.create(:concert)
      end

      it "should be an active record query" do
        expect(@concert.musicians.class).to be(Musician::ActiveRecord_Relation)
      end

      it "should scope no musician to this concert" do
        expect(@concert.musicians.all).to eq([])
      end
    end
  end
end
