require 'rails_helper'

RSpec.describe Comment, type: :model do
  #let(:comment) { FactoryGirl.build :comment }
  let(:user_1) { FactoryGirl.create :user }
  let(:user_2) { FactoryGirl.build :user }
  let(:user_3) { FactoryGirl.build :user }
  let(:question_post) { FactoryGirl.create :question_post }
  let(:anonymous_post) { FactoryGirl.create :anonymous_post }

  describe 'save comment with all redis updates' do
    before do
      user_2.email +='.uk'
      user_2.save

      user_3.email +='.au'
      user_3.save

      question_post.user = user_1
      question_post.save

      anonymous_post.user = user_2
      anonymous_post.save
    end

    it 'should save valid comments for a normal post' do
      post_hash = { id: question_post.id, post_type: Comment::POST_TYPE[:QUESTION] }
      comment_params = { comment_string: 'Sample comment' }

      # for user_1 : "user_2 commented on your post"
      Comment.save_comment(user_2, comment: comment_params, post: post_hash)

      # for user_2 : "user_1 commented on their own post"
      Comment.save_comment(user_1, comment: comment_params, post: post_hash)

      # for user_1 : "user_3 commented on your post"
      # for user_2 : "user_3 commented on user_1's post"
      Comment.save_comment(user_3, comment: comment_params, post: post_hash)
    end

    it 'should save valid comments for anonymous post' do
      post_hash = { id: anonymous_post.id, post_type: Comment::POST_TYPE[:QUESTION] }
      comment_params = { comment_string: 'Sample comment' }

      # for user_1 : "user_2 commented on your post"
      Comment.save_comment(user_2, comment: comment_params, post: post_hash)

      # for user_2 : "anonymous user commented on their own post"
      Comment.save_comment(user_1, comment: comment_params, post: post_hash)

      # for user_1 : "user_3 commented on your post"
      # for user_2 : "user_3 commented on an anonymous post"
      Comment.save_comment(user_3, comment: comment_params, post: post_hash)
    end
  end
end
