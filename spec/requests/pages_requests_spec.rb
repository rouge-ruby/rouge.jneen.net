require 'rails_helper'

describe '/pages' do
  it 'routes the /pages path to the homepage' do
    get '/pastes'

    expect(response).to redirect_to(root_path)
  end
end
