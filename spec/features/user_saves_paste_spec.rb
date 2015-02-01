require 'rails_helper'

feature 'User attmpts to create a paste', js: true do
  context 'with valid attributes' do
    scenario 'when clicking on the save button on the homepage' do
      ruby_code = load_fixture 'ruby.rb'

      visit root_path
      fill_in 'Try some code', with: ruby_code

      click_button(t('helpers.submit.paste.create'))

      expect(page).to have_content('Ruby')
      expect(page).to have_content(ruby_code)
    end
  end
end
