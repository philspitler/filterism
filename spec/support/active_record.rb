require 'active_record'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

load "spec/db/schema.rb"

FactoryGirl.find_definitions

class User < ActiveRecord::Base
end

FactoryGirl.create(:user)

FactoryGirl.create(:user, {
  name: 'Billy Bob',
  age: 18,
  is_young_at_heart: true
})

FactoryGirl.create(:user, {
  name: 'Joe Stuffypants',
  age: 27,
  is_young_at_heart: false
})
