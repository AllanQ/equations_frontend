require 'rails_helper'

feature 'show equation', js: true do
  context 'when linear' do
    scenario 'with all params' do
      visit('/')
      fill_in('a', with: '-1')
      fill_in('b', with: '-2')

      expect(page).to have_content('- x - 2 = 0')
    end
    scenario 'with -0 param' do
      visit('/')
      fill_in('a', with: '3')
      fill_in('b', with: '-0')

      expect(page).to have_content('3 * x = 0')
    end
  end
  context 'when quadratic' do
    scenario 'with all params' do
      visit('/')
      choose('quadratic')
      fill_in('a', with: '-1')
      fill_in('b', with: '-2')
      fill_in('c', with: '3')

      expect(page).to have_content('- x 2 - 2 * x + 3 = 0')
    end
    scenario 'with 0 param' do
      visit('/')
      choose('quadratic')
      fill_in('a', with: '5')
      fill_in('b', with: '0')
      fill_in('c', with: '-4')

      expect(page).to have_content('5 * x 2 - 4 = 0')
    end
  end
end
