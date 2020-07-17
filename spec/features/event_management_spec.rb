require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Events Management:', type: :feature do
  before(:each) do
    visit new_user_url
    fill_in 'Email', with: 'tam@gmail.com'
    fill_in 'Name', with: 'Tammy'
    fill_in 'Password', with: 'Tamara'
    fill_in 'Password confirmation', with: 'Tamara'
    click_on 'Create User'
    visit new_event_url
  end

  scenario 'create an event' do
    fill_in 'Title', with: 'Moon'
    fill_in 'Description', with: 'Dancing in the moon light'
    click_button 'Create Event'
    visit root_path
    expect(page).to have_content('Moon')
    expect(page).to have_content('Dancing in the moon light')
  end

  scenario 'create an event' do
    fill_in 'Title', with: ''
    fill_in 'Description', with: ''
    click_button 'Create Event'
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Title is too short (minimum is 5 characters")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Description is too short(minimun is 10 characters")
  end

  scenario 'edit an event' do
    event = Event.create!(title: 'Title', description: 'Mama are mere, Tata are pere', creator_id: 1)
    visit edit_event_path(id: event.id)
    fill_in 'Title', with: 'Title'
    click_on 'Update Event'
    visit events_path
    expect(page).to have_content('Title')
    expect(page).to have_content('Mama are mere, Tata are pere')
  end

  scenario 'delete an event' do
    fill_in 'Title', with: 'Title'
    fill_in 'Description', with: 'Mama are mere, Tata are pere'
    click_on 'Create'
    visit root_path
    expect(page).to have_content('Title')
    expect(page).to have_content('Mama are mere, Tata are pere')
    expect { click_on('Delete') }.to change(Event, :count).by(-1)
  end

  scenario 'show an event' do
    fill_in 'Title', with: 'Minneapolis'
    fill_in 'Description', with: 'Mama are mere, Tata are pere'
    click_button 'Create'
    visit root_path
    click_on('Minneapolis')
    expect(page).to have_content('Minneapolis')
    expect(page).to have_content('Mama are mere, Tata are pere')
  end

  scenario 'attending an event --> valid' do
    fill_in 'Title', with: 'Minneapolis'
    fill_in 'Description', with: 'Madonna is already gone, bye bye mama'
    click_button 'Create'
    visit root_path
    click_on('Minneapolis')
    click_button 'Attending'
    expect(page).to have_content('Thanks for following')
  end

  scenario 'attending an event --> invalid' do
    fill_in 'Title', with: 'Minneapolis'
    fill_in 'Description', with: 'Madonna is already gone, bye bye mama'
    click_button 'Create'
    visit root_path
    click_on('Minneapolis')
    click_button 'Attending'
    expect(page).to have_content('Thanks for following')
    click_on('Minneapolis')
    click_button 'Attending'
    expect(page).to have_content('You can only attend once (Matrix! Perhaps!?)')
  end
end