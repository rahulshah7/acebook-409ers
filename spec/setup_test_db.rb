# frozen_string_literal: true

def setup_test_db
  ActiveRecord::Base.connection.execute('TRUNCATE posts RESTART IDENTITY CASCADE;')
  ActiveRecord::Base.connection.execute('TRUNCATE users RESTART IDENTITY CASCADE;')
  user0 = User.create(email: test_users(0)[:email], password: test_users(0)[:password])
  Post.create(message: 'Hello, world!', user_id: user0.id)
  
  user1 = User.create(email: test_users(1)[:email], password: test_users(1)[:password])
  Post.create(message: 'I love food!', user_id: user1.id)
end
