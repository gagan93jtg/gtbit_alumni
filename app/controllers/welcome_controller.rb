class WelcomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @your_activity = current_user.posts
    @public_activity = Post.public_activity(current_user.id)
  end
end
