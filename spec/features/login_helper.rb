def sign_up_user
  visit "/users/sign_up"
  fill_in "Email", with: test_users(0)[:email]
  fill_in "Password", with: test_users(0)[:password]
  fill_in "Password confirmation", with: test_users(0)[:password]
  click_button "Sign up"
end

def log_in_user
  visit "/users/sign_in"
  fill_in "Email", with: test_users(0)[:email]
  fill_in "Password", with: test_users(0)[:password]
  click_button "Log in"
end

def log_in_alt_user
  visit "/users/sign_in"
  fill_in "Email", with: test_users(1)[:email]
  fill_in "Password", with: test_users(1)[:password]
  click_button "Log in"
end