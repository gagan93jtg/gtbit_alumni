class Query < ActiveRecord::Base
  belongs_to :user
  has_many :responses
  has_many :query_histories

  def query_time
    Time.at(created_at)
  end

  def self.save_query(user, params)
    query_params = params[:query]
    query = user.queries.build(query_string: query_params[:query_string],
                               tags: query_params[:tags],
                               is_anonymous: query_params[:is_anonymous])
    query.save
  end

  def update_query(params)
    query_params = params[:query]
    if was_query_updated?(query_params)
      query_history = query_histories.build(query_string: query_string,
                                            tags: tags, user_id: user_id)
      query_history.save
      update(query_string: query_params[:query_string], tags: query_params[:tags])
    end
  end

  private

  def was_query_updated?(query_params)
    old_tags = tags.split(',').sort
    new_tags = query_params[:tags].split(',').sort
    old_string = query_string
    new_string = query_params[:query_string]
    (old_tags == new_tags && old_string == new_string) ? false : true
  end
end
