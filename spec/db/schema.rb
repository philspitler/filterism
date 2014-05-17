ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :name
    t.string :age
    t.string :is_young_at_heart
  end
end
