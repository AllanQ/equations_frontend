require 'rails_helper'

feature 'next field', js: true do
  context 'when press enter' do
    scenario 'select next input field' do
      visit('/')
      find('#a').send_keys '1', :enter

      expect(page).to have_selector('#b:focus')
    end
  end
end
