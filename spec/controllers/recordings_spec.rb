require 'rails_helper'

RSpec.describe RecordingsController do
  # Test Get Recordings
  let(:recordings) { Recording.all }

  describe 'GET index' do
    it "assigns all recordings to @recordings" do
      get :index
      expect(assigns(:recordings)).to eq(recordings)
    end
  end

  # Test Create Meeting
  describe 'POST create' do
    it "creates a new meeting with participant data" do
      post(:create, :params => { :name => 'Test Subject' })
      expect(response).to have_http_status(:found) # found response is http 302 as shown in output
    end
  end

  # Test Delete Recordings
  ## Add a recording to database
  ## Delete it
  ## Make sure it is not in database
  describe 'DELETE destroy' do
    let!(:meeting) { Recording.create(:id => 1, :meetingID => "ThisIsATestMeeting") }
    it 'deletes a recording with a specific meeting ID' do
      expect { delete :destroy, :params => { :id => 1 } }.to change { Recording.count }.by(-1)
    end
  end
end
