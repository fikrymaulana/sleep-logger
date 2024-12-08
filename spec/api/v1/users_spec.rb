require 'rails_helper'

RSpec.describe V1::Users, type: :request do
  let(:user) { create(:user) }
  let(:followed_user) { create(:user) }
  let(:unfollowed_user) { create(:user) }
  let(:headers) { { 'Authorization' => "Bearer #{user.api_key}" } }

  describe 'POST /api/v1/users/:id/follow' do
    it 'allows a user to follow another user' do
      post "/api/v1/users/#{followed_user.id}/follow", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq("You are now following #{followed_user.name}")
      expect(user.followees).to include(followed_user)
    end

    it 'does not allow duplicate follows' do
      user.followees << followed_user
      post "/api/v1/users/#{followed_user.id}/follow", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq("You are already following #{followed_user.name}")
      expect(user.followees.where(id: followed_user.id).count).to eq(1)
    end

    it 'returns an error if the user does not exist' do
      post "/api/v1/users/999999999/follow", headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /api/v1/users/:id/unfollow' do
    before { user.followees << followed_user }

    it 'allows a user to unfollow another user' do
      delete "/api/v1/users/#{followed_user.id}/unfollow", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq("You unfollowed #{followed_user.name}")
      expect(user.followees).not_to include(followed_user)
    end

    it 'returns success even if the user is not followed' do
      delete "/api/v1/users/#{unfollowed_user.id}/unfollow", headers: headers

      expect(response).to have_http_status(:ok)
      expect(user.followees).not_to include(unfollowed_user)
    end

    it 'returns an error if the user does not exist' do
      post "/api/v1/users/999999999/follow", headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end
end