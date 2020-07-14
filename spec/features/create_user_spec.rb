require 'rails_helper'
require 'capybara/rails'

feature 'The signup process:' do
  scenario 'has a new user page' do
    visit(new_user_url)
    expect(page).to have_content('New User')
  end

  feature 'sign up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'Email', with: 'tam@gmail.com'
      fill_in 'Name', with: 'Tammy'
      fill_in 'Password', with: 'Tamara'
      fill_in 'Password confirmation', with: 'Tamara'
      click_on 'Create User'
    end

    scenario 'redirects to show page after signup' do
      expect(page).to have_content 'User was successfully created.'
    end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content 'Tammy'
    end
  end
end

feature 'The signin process:' do
  scenario 'has a login user page' do
    visit(login_url)
    expect(page).to have_content('Email')
  end

  feature 'signing in a user' do
    before(:each) do
      visit login_url
      fill_in 'Password', with: 'Tammy'
      fill_in 'Email', with: 'tam@gmail.com'
      click_button 'Login'
    end

    scenario 'redirects to events home page after signin' do
      expect(page).to have_content 'Events'
    end

    scenario 'shows events on the homepage after signing in' do
      expect(page).to have_content 'Events'
    end
  end
end