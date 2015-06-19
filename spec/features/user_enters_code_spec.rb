require 'rails_helper'

feature 'User visits homepage' do
  context 'user enters text into source field' do
    scenario 'expect text to be in source field' do
      ruby_code = load_fixture 'ruby.rb'

      visit root_path
      fill_in 'Try some code', with: ruby_code

      expect(find_field('Try some code').value).to eq(ruby_code)
    end

    scenario 'expect highlighted text to be in formatted box', js: true do
      ruby_code = load_fixture 'ruby.rb'

      visit root_path
      fill_in 'Try some code', with: ruby_code
      select 'Ruby', from: 'parse_language'

      expect(page).to have_css('pre.highlight')
      expect(find('span.nb').text).to eq('puts')
      expect(find('span.s1').text).to eq("'hello world'")
    end

    scenario 'expect source to re-highlight when language is changed', js: true do
      ruby_code = load_fixture 'ruby.rb'

      visit root_path
      fill_in 'Try some code', with: ruby_code
      select 'Ruby', from: 'parse_language'

      expect(find('span.s1').text).to eq("'hello world'")

      css = find('option[value=css]')
      css.select_option

      expect(page).to have_selector('span.nt', count: 6)
      expect(page).to have_selector('span.err', count: 2)
    end
  end
end
