require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:redis_conn) { RedisConnection.initialize_redices[0] }
  let(:comment1)  { FactoryGirl.build(:comment) }
  let(:comment2)  { FactoryGirl.build(:comment) }
  let(:question_post) { FactoryGirl.build(:question_post) }
  let(:experience_post) { FactoryGirl.build(:experience_post) }

  it 'saves and updates a post of each type ' do

    # create post question post
    params = { query_string: 'Sample string', tags: 'a, b, c', is_anonymous: false,
      post_type: Comment::POST_TYPE[:QUESTION] }

    q_post = Post.save_post(user, post: params)
    expect(q_post.id).to eq(QuestionPost.last.id)

    # create post experience post
    params[:post_type] = Comment::POST_TYPE[:EXPERIENCE]

    e_post = Post.save_post(user, post: params)
    expect(e_post.id).to eq(ExperiencePost.last.id)


    # update post question post
    params[:query_string] = 'Sample string 2'
    params[:tags] = 'updated, tags'
    params[:is_anonymous] = true # this should not get set

    q_post.update_post(post: params)

    expect(q_post.query_string).to eq(params[:query_string])
    expect(q_post.tags).to eq(params[:tags])
    expect(q_post.is_anonymous).to eq(false)
    expect(PostHistory.count).to eq(1)
    expect(PostHistory.first.query_string).to eq('Sample string')

    # update post experience post

    e_post.update_post(post:params)
    expect(q_post.query_string).to eq(params[:query_string])
    expect(q_post.tags).to eq(params[:tags])
    expect(q_post.is_anonymous).to eq(false)
    expect(redis_conn.hget('EXPERIENCE_POSTS', "ORIGINAL_#{e_post.id}").include?('Sample string')).to eq(true)
  end

  it 'retrieves comments of a post' do
    # question post
    question_post.user = user
    question_post.save

    expect(question_post.comments).to eq([])

    comment1.post_type = Comment::POST_TYPE[:QUESTION]
    comment1.post_id = question_post.id
    comment1.user = user
    comment1.save

    expect(question_post.comments).to eq([comment1])

    # experience post
    experience_post.user = user
    experience_post.save

    expect(experience_post.comments).to eq([])

    comment2.post_type = Comment::POST_TYPE[:EXPERIENCE]
    comment2.post_id = experience_post.id
    comment2.user = user
    comment2.save

    expect(experience_post.comments).to eq([comment2])
  end
end
