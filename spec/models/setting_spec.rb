require 'spec_helper'

RSpec.describe Setting do
  describe "Attributes" do
    it "should have a key" do
      expect(Setting.new).to respond_to(:key)
    end

    it "should have a value" do
      expect(Setting.new).to respond_to(:value)
    end
  end
end
