class Post < ActiveRecord::Base
  filterable_fields :title, :published_at
end
