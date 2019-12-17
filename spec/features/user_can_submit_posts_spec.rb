# frozen_string_literal: true

require 'rails_helper'
require_relative './login_helper'

RSpec.feature 'Timeline', type: :feature do
  scenario 'Can submit posts and view them' do
    sign_up_user
    visit '/posts'
    click_link 'New post'
    fill_in 'Message', with: 'Hello, world!'
    click_button 'Submit'
    expect(find('.card-text').text).to have_content('Hello, world!')
    expect(find('.card-subtitle').text).to match(/\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s\w{3}/)
  end

  scenario 'Can submit multiple posts and view them in reverse chronological order' do
    sign_up_user
    visit '/posts'
    click_link 'New post'
    fill_in 'Message', with: 'Hello, world!'
    click_button 'Submit'
    click_link 'New post'
    fill_in 'Message', with: 'Hello, universe!'
    click_button 'Submit'
    expect(find('.container').text).to match(/Hello, universe!.*Hello, world!/)
  end
end
