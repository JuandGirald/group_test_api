require 'spec_helper'

RSpec.describe Api::V1::GroupEventsController , :type => :api do  
  context 'Get Event Groups' do
    let!(:draft_event)  { create :group_event }
    let!(:published_event)  { create :group_event, :valid_published }

    it 'should list all published events' do
      get '/group_events'
      
      expect(json['group_events'].count).to eq 1
      expect(json['group_events'].first['status']).to eq "published"
    end

    it 'should list draft events' do
      get '/group_events', params = { query: 'draft' }

      expect(json['group_events'].count).to eq 1
      expect(json['group_events'].first['status']).to eq "draft"
    end

    it 'shoul list deleted events' do
      draft_event.destroy
      get '/group_events', params = { query: 'deleted' }

      expect(json['group_events'].count).to eq 1
      expect(json['group_events'].first['deleted_at']).to_not be nil
    end

    it 'should show an specific event' do
      id = draft_event.id
      get "/group_events/#{id}"

      expect(json['group_event']).to_not be nil
      expect(json['group_event']['id']).to eq draft_event.id
      expect(json['group_event']['name']).to eq draft_event.name
    end
  end

  context 'Create, update and delete Events' do
    let!(:event)  { create :group_event, :valid_published }

    it 'creates a draft event when only one field' do
      post "/group_events/", :group_event => { name: 'New Event'} 

      expect(json['group_event']).to_not be nil
      expect(json['group_event']['status']).to eq "draft"
      expect(json['group_event']['name']).to eq 'New Event'
    end

    it 'creates a published event when all field are present' do
      post "/group_events/", :group_event => event_params 

      expect(json['group_event']).to_not be nil
      expect(json['group_event']['status']).to eq "published"
      expect(json['group_event']['name']).to eq event_params[:name]
    end

    it 'update an existing event' do
      put "/group_events/#{event.id}", :group_event => { name: 'New Event name!' }

      expect(json['group_event']['id']).to eq event.id
      expect(json['group_event']['name']).to eq 'New Event name!'
    end

    it 'delete an existing event and market as deleted' do 
      delete "/group_events/#{event.id}"

      expect(GroupEvent.count).to eq 0
      expect(GroupEvent.deleted.last).to eq event
    end
  end

  def event_params
    { name: 'Event Text', start_date: '09-10-2017', 
      end_date: '20-10-2017', location: 'colombia',
      description: 'Best event ever'
    }
  end
end  