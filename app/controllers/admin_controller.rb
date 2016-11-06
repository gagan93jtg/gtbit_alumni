class AdminController < ApplicationController
  before_filter :allow_admins_only

  def index
  end

  private

  def allow_admins_only
    render text: 'Not for kids !', status: :unauthorized if current_user.nil? || current_user.not_an_admin?
  end
end
