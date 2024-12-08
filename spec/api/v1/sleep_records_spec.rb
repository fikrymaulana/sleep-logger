require 'rails_helper'

RSpec.describe V1::SleepRecords, type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => "Bearer #{user.api_key}" } }

  context 'when no active clocked-in record exists' do
    it 'returns success when clocking in' do
      post '/api/v1/sleep_records', headers: headers

      expect(response).to have_http_status(:created)
      res = JSON.parse(response.body)
      expect(res['id']).to be_present
    end
  end
end
