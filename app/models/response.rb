class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :query

  def self.save_response(user, params)
    response_params = params[:response]
    response = user.responses.build(response_string: response_params[:response_string],
                                    query_id: params[:query][:id])
    response.save
  end
end
