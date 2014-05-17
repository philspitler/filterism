require 'spec_helper'
require 'support/active_record'

describe Filterism do
  describe "#filter" do
    ActiveRecord::Base.include(Filterism)

    class User < ActiveRecord::Base
    end

    it "filters for equals" do
      user = User.where("name = 'Phil Spitler'").first
      expect(User.filter([
        {key: 'name', comparator: '=', value: 'Phil Spitler'},
      ]).first).
      to eq(user)
    end

    it "filters for LIKE" do
      user = User.where("name LIKE '%Billy%'").first
      expect(User.filter([
        {key: 'name', comparator: 'LIKE', value: 'Billy'},
      ]).first).
      to eq(user)
    end

    it "filters for IN" do
      user = User.where("name IN ('Phil Spitler','Joe Stuffypants')")
      expect(User.filter([
        {key: 'name', comparator: 'IN', value: 'Phil Spitler,Joe Stuffypants'},
      ]).to_a).
      to eq(user.to_a)
    end

    it "filters for booleans" do
      user = User.where(is_young_at_heart: true)
      expect(User.filter([
        {key: 'is_young_at_heart', comparator: '=', value: 'true'},
      ]).to_a).
      to eq(user.to_a)
    end

    context "with filterable fields" do
      it "filters only on filterable fields" do
        class User < ActiveRecord::Base
          filterable_fields :age, :is_young_at_heart
        end

        user = User.all.to_a
        expect(User.filter([
          {key: 'name', comparator: '=', value: 'Phil Spitler'},
        ]).to_a).
        to eq(user)

        user = User.where(is_young_at_heart: true)
        expect(User.filter([
          {key: 'is_young_at_heart', comparator: '=', value: "true"}
        ]).to_a).
        to eq(user)
      end
    end

    context "with unfilterable fields" do
      it "filters only on unfilterable fields" do
        class User < ActiveRecord::Base
          unfilterable_fields :name
        end

        user = User.all.to_a
        expect(User.filter([
          {key: 'name', comparator: '=', value: 'Phil Spitler'},
        ]).to_a).
        to eq(user)

        user = User.where(is_young_at_heart: true)
        expect(User.filter([
          {key: 'is_young_at_heart', comparator: '=', value: "true"}
        ]).to_a).
        to eq(user)
      end
    end

  end
end
