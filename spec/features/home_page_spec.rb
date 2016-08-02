require 'rails_helper'

feature 'home page' do
  scenario 'head of the page' do
    visit('/')

    expect(page).to have_content('System for solving mathematical equations')
  end

  scenario 'form' do
    visit('/')

    expect(page).to have_content('Select the type of equation')
    expect(page).to have_content('Input the parameters of the solution')
    expect(page).to have_content('Result')
  end
end
