require 'rails_helper'

feature 'User visits homepage' do
  scenario 'enters text into source field' do
    code = <<-END
def method
  puts "Hello world"
end
    END

    visit root_path
    fill_in 'Try some code', with: code

    expect(find_field('Try some code').value).to eq(code)
  end
end
