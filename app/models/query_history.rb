class QueryHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :query
end
