password = Utils.key_generator(10)
user = User.new(first_name: 'Bandana', last_name: 'Singh', email: 'bandana9oct@gmail.com',
  password: password)
user.save
p user.errors.full_messages
UserMailer.welcome_mail(user, password).deliver_now
