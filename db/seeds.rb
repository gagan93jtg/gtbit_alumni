# This file should contain all the record creation needed to seed the database with its default
# values. The data can then be loaded with the rake db:seed (or created alongside the db
# with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env == 'production'
      # create anonymous user
      User.create(email: 'anonymous_user@gtbitalumni.in', password: 'D#%$K@M@CedKC',
            first_name: 'The', last_name: 'Anonymous', gender: 'Male',
            bio: 'You found me ? That means somebody posted an anonymous question. You can also post'\
            ' an anonymous question but make sure you dont post shitty content on my name. If I find'\
            ' something like that, I will deactive your account. I hope that\'s enough intro of me !')
else
      User.create(email: 'gagan93gtbit@gmail.com', password: '123123123', first_name: 'Gogo',
            last_name: 'Singh')
      User.create(email: 'ekaspreet.singh93@gmail.com', password: '123123123', first_name: 'Ekaspreet',
            last_name: 'Singh')
      User.create(first_name: 'Gagandeep', last_name: 'Singh', email: 'gagan@gmail.com',
            password: '123123123')
      User.create(first_name: 'Gagandeep', last_name: 'Singh', email: 'gagan@yahoo.com',
            password: '123123123')

      Post.create(user_id: 1, query_string: "Portugal became the first team to reach the Euro semi-finals"\
            " without winning a single game. That's something.\r\nhttp://9gag.com/gag/amz9RXV?ref=f"\
            "bp\r\n", tags: "  1,2,3", is_anonymous: false, post_type: Comment::POST_TYPE[:QUESTION])


      Post.create(user_id: 1, query_string: "Waheguru Ji Ka Khalsa, Waheguru Ji Ki Fateh !\r\nWatch This "\
            "Extremely Beautiful Short Movie Based On Sikh Values\r\nMannan Di Saari Team Nu Bahut "\
            "Bahut Mubaraka jinha ne ehni sohni film banayi hai, Benti hai Ji Iss Movie Nu Vadh Toh"\
            " Vadh Spread Karo taaki Jo Sikh Bhatke Hoye Ne Oh Sri Guru Granth Sahib Ji Naal Vapis "\
            "Jur Ke Vapsi Kar Sakan..\r\nWritten & Directed By - Harjeet Singh Oberoi \r\n* "\
            "Inderpreet Singh, Manpreet Singh Gaba, Jasmeet Singh Kohli" ,
            tags: "  1,2,3", is_anonymous: false, post_type: Comment::POST_TYPE[:EXPERIENCE])

      Post.create(user_id: 2, query_string: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, "\
            "sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad "\
            "minim veniam,\r\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea "\
            "commodo\r\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit "\
            "esse\r\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat "\
            "non\r\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum." ,
            tags: "  1,2,3", is_anonymous: false, post_type: Comment::POST_TYPE[:QUESTION])

      Comment.create(post_id: 1, user_id: 2, comment_string: "hey ", upvotes: 0, created_at: 10.days.ago, post_type: 1)
      Comment.create(post_id: 1, user_id: 3, comment_string: "hello", upvotes: 0, created_at: 9.days.ago, post_type: 1)
      Comment.create(post_id: 1, user_id: 1, comment_string: "hey people", upvotes: 0, created_at: 8.days.ago, post_type: 1)
      Comment.create(post_id: 1, user_id: 2, comment_string: "hey", upvotes: 0, created_at: 7.days.ago, post_type: 1)
      Comment.create(post_id: 1, user_id: 3, comment_string: "heyaaa", upvotes: 0, created_at: 6.days.ago, post_type: 1)
      Comment.create(post_id: 1, user_id: 1, comment_string: "cinn", upvotes: 0, created_at: 5.days.ago, post_type: 1)
      Comment.create(post_id: 1, user_id: 1, comment_string: "test comment", upvotes: 0, created_at: 4.days.ago, post_type: 1)
      Comment.create(post_id: 1, user_id: 1, comment_string: "another commment", upvotes: 0, created_at: 3.days.ago, post_type: 1)
      Comment.create(post_id: 1, user_id: 1, comment_string: "aaa", upvotes: 0, created_at: 2.days.ago, post_type: 1)
      Comment.create(post_id: 1, user_id: 1, comment_string: "My from phone", upvotes: 0, created_at: 1.days.ago, post_type: 1)
      Comment.create(post_id: 1, user_id: 1, comment_string: "sdkjghgf", upvotes: 0, created_at: 10.hours.ago, post_type: 1)
      Comment.create(post_id: 1, user_id: 1, comment_string: "I think it would be better if blah blah ", post_type: 1, upvotes: 0, created_at: 5.hours.ago)
      Comment.create(post_id: 1, user_id: 1, comment_string: "another comment", upvotes: 0, created_at: 2.hours.ago, post_type: 1)
      Comment.create(post_id: 1, user_id: 1, comment_string: "k", upvotes: 0, created_at: 10.minutes.ago, post_type: 1)
      Comment.create(post_id: 2, user_id: 2, comment_string: "k", upvotes: 0, created_at: 10.minutes.ago, post_type: 2)

      30.times do |i|
            Faq.create(question: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed '\
               'do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad' + i.to_s,
               answer: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod'\
               'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,'\
               'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo'\
               'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse'\
               'cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat no'\
               'proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'+ i.to_s)
      end
end
