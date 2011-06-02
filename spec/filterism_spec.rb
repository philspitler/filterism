require 'helper'
require 'finders/activerecord_test_connector'
ActiverecordTestConnector.setup

describe Filterism do
  extend ActiverecordTestConnector::FixtureSetup
  fixtures :users

  it "should be a test" do
    User.find(1).id.should == 1
  end

end
