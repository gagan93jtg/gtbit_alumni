class Query < ActiveRecord::Base
  belongs_to :user
  has_many :responses
  def query_time
    Time.at(self.created_at)
  end

  def self.save_query(user, params)
    query_params = params[:query]
    query = user.queries.build(:query_string => query_params[:query_string],
                               :tags => query_params[:tags],
                               :is_anonymous => query_params[:is_anonymous])
    query.save
  end

  def update_query(params)
    query_params = params[:query]
    update(:query_string => query_params[:query_string],
                               :tags => query_params[:tags],
                               :is_anonymous => query_params[:is_anonymous])
  end
end
