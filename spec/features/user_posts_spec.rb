# frozen_string_literal: true

require 'rails_helper'
require_relative './login_helper'

RSpec.feature 'Post timeline feature', type: :feature do
  before(:each) do
    log_in_user
    visit '/posts'
  end

  scenario 'Can submit posts and view them' do
    find('.button-new-post').click
    fill_in 'Message', with: 'Hello, universe!'
    click_button 'Submit'
    click_link 'Log Out'
    log_in_alt_user
    find('.button-new-post').click
    fill_in 'Message', with: 'Hello, world!'
    click_button 'Submit'
    click_link 'My Posts'
    expect(page).not_to have_content(test_users(0)[:email].split('@').first)
    expect(find_all('.card-title').first.text).to have_content(test_users(1)[:email].split('@').first)
  end
end
