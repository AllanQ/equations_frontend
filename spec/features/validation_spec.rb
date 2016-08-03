require 'rails_helper'

xfeature 'validation' do
  context 'incorrect input' do
    scenario 'test' do
      visit('/')
      fill_in('a', with: '12345')

      expect(page).to have_content('12345')
    end

    scenario 'minus only' do
      visit('/')
      fill_in('a', with: '-')

      expect(page).to have_content('Input with error')
    end
    scenario 'minus after' do
      visit('/')
      fill_in('a', with: '3-')

      expect(page).to have_content('Input with error')
    end
    scenario 'floating point' do
      visit('/')
      fill_in('b', with: '10e2')

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
  end

  scenario 'correct input' do
    visit('/')
    fill_in('a', with: '1')
    fill_in('b', with: '2')

    expect(page).not_to have_content('Input with error')
  end
end
