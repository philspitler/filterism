require 'helper'
require 'finders/activerecord_test_connector'
ActiverecordTestConnector.setup

describe Filterism do
  extend ActiverecordTestConnector::FixtureSetup
  fixtures :users

  it "defines the COMPARATORS constant" do
    Filterism::COMPARATORS.should be
    Filterism::COMPARATORS.should be_a Hash
  end

  it "fitlers on equal_to" do
    User.filter({'name_is_equal_to' => 'David'}).first.id.should == 1
    User.filter({'name_is_equal_to' => 'Dave'}).first.id.should == 2
  end

  it "filters on not_equal_to" do
    User.filter({'name_is_not_equal_to' => 'David'}).all.count.should == 4
  end

  it "filters on greater_than" do
    User.filter({'salary_is_greater_than' => '80000'}).all.count.should == 1
  end

  it "filters on gt" do
    User.filter({'salary_is_gt' => '70000'}).all.count.should == 2
  end

  it "filters on after" do
    User.filter({'salary_is_after' => '9000'}).all.count.should == 4
  end

  it "filters on greater_than_or_equal_to" do
    User.filter({'salary_is_greater_than_or_equal_to' => '80000'}).all.count.should == 2
  end

  it "filters on gtet" do
    User.filter({'salary_is_gtet' => '80000'}).all.count.should == 2
  end

  it "filters on less_than" do
    User.filter({'salary_is_less_than' => '80000'}).all.count.should == 3
  end

  it "filters on lt" do
    User.filter({'salary_is_lt' => '70000'}).all.count.should == 3
  end

  it "filters on before" do
    User.filter({'salary_is_before' => '10000'}).all.count.should == 1
  end

  it "filters on less_than_or_equal_to" do
    User.filter({'salary_is_less_than_or_equal_to' => '80000'}).all.count.should == 4
  end

  it "filters on ltet" do
    User.filter({'salary_is_ltet' => '80000'}).all.count.should == 4
  end

  it "filters on like" do
    User.filter({'name_is_like' => 'Dav'}).all.count.should == 2
  end

  it "filters on in" do
    User.filter({'id_is_in' => '1,2,3'}).all.count.should == 3
    User.filter({'name_is_in' => 'Dave,Jamis'}).all.count.should == 2
  end

  it "doesn't filter if passed invalid expression" do
    User.filter({'name_is_garbage' => 'David'}).all.count.should == User.all.count
  end

end
