require 'spec_helper'

describe Filterism::ConditionParser do
  before(:all) do
    @condition_parser = Filterism::ConditionParser.new
  end

  describe "#parse" do
    it "has the parse method" do
      expect(@condition_parser).to respond_to(:parse)
    end
    subject { -> (params) { return @condition_parser.parse(params) }}

    it "returns a hash" do
      expect(subject.call({ name_is_equal_to: 'David' })).to be_an(Array)
    end

    it "has the keys 'key, comparator, value'" do
      expect(subject.call({ name_is_equal_to: 'David' })[0].keys.sort).
        to eq([:comparator, :key, :value])
    end

    specify "the returned hashes are derived from the hash which was passed in" do
      conditions = subject.call({ name_is_equal_to: 'John' }).first
      expect(conditions[:key]).to eq "name"
      expect(conditions[:comparator]).to eq "="
      expect(conditions[:value]).to eq "John"
    end
  end

  describe "#add_comparator" do
    it "has the add_comparator method" do
      expect(@condition_parser).to respond_to(:add_comparator).with(1).argument
    end

    it "adds the new comparator to the comparators Hash" do
      expect(@condition_parser.add_comparator({"equals_to" => "="})).to include("equals_to" => "=")
    end
  end

  describe "#delete_comparator" do
    it "has the delete_comparator method" do
      expect(@condition_parser).to respond_to(:delete_comparator).with(1).argument
    end

    it "deletes the comparator from the comparators Hash" do
      @condition_parser.add_comparator({"equals_to" => "="})
      expect(@condition_parser.delete_comparator("equals_to")).not_to include("equals_to")
    end
  end
end

