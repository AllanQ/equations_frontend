require 'rails_helper'

feature 'validation', js: true do
  context 'with incorrect input error message' do
    scenario 'minus only' do
      visit('/')
      fill_in('a', with: '-')

      expect(page).to have_content('Input with error')
    end
    scenario 'minus after' do
      visit('/')
      fill_in('b', with: '3-')

      expect(page).to have_content('Input with error')
    end
    scenario 'floating point' do
      visit('/')
      choose('quadratic')
      fill_in('c', with: '10e2')

      expect(page).to have_content('Input with error')
    end
    scenario 'dot' do
      visit('/')
      fill_in('a', with: '1.7')

      expect(page).to have_content('Input with error')
    end
    scenario 'comma' do
      visit('/')
      fill_in('b', with: '1,7')

      expect(page).to have_content('Input with error')
    end
    scenario 'plus' do
      visit('/')
      choose('quadratic')
      fill_in('c', with: '+3')

      expect(page).to have_content('Input with error')
    end
  end

  context 'with correct input no error messages' do
    scenario 'integer numbers' do
      visit('/')
      choose('quadratic')
      fill_in('a', with: '1')
      fill_in('b', with: '-2')
      fill_in('c', with: '0')

      expect(page).not_to have_content('Input with error')
    end
  end
end
