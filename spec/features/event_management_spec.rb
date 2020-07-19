require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'Event management', type: :feature do
  before(:each) do
    visit new_user_url
    fill_in 'Email', with: 'gideon@email.com'
    fill_in 'Name', with: 'Gideon'
    fill_in 'Password', with: 'gideon'
    fill_in 'Password confirmation', with: 'gideon'
    click_on 'Create User'
  end

  scenario 'displays a successful flash message' do
    expect(page).to have_content 'User was successfully created'
  end
  scenario 'shows a list of upcoming, past and self created events' do
    visit login_url
    fill_in 'Email', with: 'gideon@email.com'
    fill_in 'Password', with: 'gideon'
    click_on 'Login'
    visit events_url
    expect(page).to have_content 'Upcoming events'
    expect(page).to have_content 'Past events'
    expect(page).to have_content 'Events'
  end
  scenario 'create a new event' do
    visit login_url
    fill_in 'Email', with: 'gideon@email.com'
    fill_in 'Password', with: 'gideon'
    click_on 'Login'
    visit events_url
    expect(page).to have_content 'Upcoming events'
    expect(page).to have_content 'Past events'
    expect(page).to have_content 'Events'

    visit new_event_url
    fill_in 'Title', with: 'Lunar Moon'
    fill_in 'Description', with: 'Big beautiful blue moon'
    click_button 'Create Event'
    expect(page).to have_content('Lunar Moon')
    expect(page).to have_content('Big beautiful blue moon')
  end

  scenario 'does not create an event with invalid inputs' do
    visit login_url
    fill_in 'Email', with: 'gideon@email.com'
    fill_in 'Password', with: 'gideon'
    click_on 'Login'
    visit events_url

    visit new_event_url
    fill_in 'Title', with: ' '
    fill_in 'Description', with: ''
    click_button 'Create Event'
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content('Title is too short (minimum is 5 characters)')
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content('Description is too short (minimum is 10 characters)')
  end
end
