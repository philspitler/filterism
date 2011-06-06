ActiveRecord::Schema.define do
  create_table "users", :force => true do |t|
    t.column "name", :text
    t.column "salary", :integer, :default => 70000
    t.column "bonus", :boolean, :default => false
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end
  
  create_table "posts", :force => true do |t|
    t.column "title", :string
    t.column "body", :text
    t.column "published_at", :datetime
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end
end
