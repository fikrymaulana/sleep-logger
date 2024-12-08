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

    it 'returns an error when trying to clock out without a clock in record' do
      put '/api/v1/sleep_records/clock_out', headers: headers

      expect(response).to have_http_status(:not_found)
      body = JSON.parse(response.body)
      expect(body['error']).to eq('No active sleep record found to clock out')
    end
  end

  context 'when an active clocked-in record exists' do
    it 'returns success when clocking out' do
      post '/api/v1/sleep_records', headers: headers

      put "/api/v1/sleep_records/clock_out", headers: headers

      expect(response).to have_http_status(:ok)
      res = JSON.parse(response.body)
      expect(res['id']).to be_present
      expect(res['clock_out']).to be_present
    end
  end
end
