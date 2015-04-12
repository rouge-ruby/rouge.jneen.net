require 'rails_helper'

describe '/pastes' do
  it 'routes the /pastes path to the homepage' do
    get '/pastes'

    expect(response).to redirect_to(root_path)
  end
end
