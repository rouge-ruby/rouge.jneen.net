require 'rails_helper'

describe '#show' do
  it 'routes the root path to the home page' do
    home_page_route = { controller: 'home_pages',
                        action: 'show' }
    expect(get: root_path).to route_to(home_page_route)
  end
end
