require 'rails_helper'

RSpec.describe GroupEvent, type: :model do
  
  context 'When Group Event is draft' do

    let!(:valid_draft_event)  { create :group_event }
  
    it 'are valid with one or more attributes' do
      expect(valid_draft_event).to be_valid
      expect(valid_draft_event.name).to eq 'Example draft event'
    end

    it 'should have at least one attribute' do
      valid_draft_event.name = ''
      expect(valid_draft_event).to_not be_valid
    end

    it 'should be marked as published when have all fields' do
      valid_draft_event.location    = 'Colombia'
      valid_draft_event.start_date  = '09-09-2017'
      valid_draft_event.end_date    = '15-09-2017'
      valid_draft_event.description = 'Now is plublished!'
      valid_draft_event.save!

      expect(valid_draft_event.published?).to be true
      expect(valid_draft_event.status).to eq 'published'
    end
  end

  context 'When Group Event is plublished' do
    let!(:invalid_published_event) { build :group_event, :invalid_published }
    let!(:valid_pusblished_event)  { build :group_event, :valid_published }

    it { valid_pusblished_event.should validate_presence_of(:name) }
    it { valid_pusblished_event.should validate_presence_of(:description) }
    it { valid_pusblished_event.should validate_presence_of(:location) }
    it { valid_pusblished_event.should validate_presence_of(:start_date) }

    it 'not saved with all the attributes' do
      expect(invalid_published_event).to_not be_valid
    end

    it 'saved with all filled fields' do
      expect(valid_pusblished_event).to be_valid
      expect { valid_pusblished_event.save }.to change { GroupEvent.count }.by(1)
    end

    it 'not saved when end_date is behind start_date' do
      valid_pusblished_event.end_date = "01-01-2015"
      expect(valid_pusblished_event).to_not be_valid
    end
  end

  context 'When is published or draft' do
    let!(:event)  { create :group_event }
    let!(:start_date) { event.start_date }

    it 'calculate end_date with duration' do 
      event.duration = 5
      end_date = start_date + 5

      event.save
      expect(event.end_date).to eq end_date
    end

    it 'calculate duration with end_date' do 
      event.end_date = '15-09-2017'
      duration = event.end_date.mjd - start_date.mjd

      event.save
      expect(event.duration).to eq duration
    end
  end
end
