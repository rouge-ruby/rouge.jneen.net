require 'rails_helper'

describe '#home' do
  it 'routes the root path to the home page' do
    home_page_route = { controller: 'high_voltage/pages',
                        id: 'home',
                        action: 'show' }
    expect(get: root_path).to route_to(home_page_route)
  end
end
