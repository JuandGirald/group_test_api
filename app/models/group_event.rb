class GroupEvent < ApplicationRecord
  acts_as_paranoid
  before_validation :published_with_all_fields, on: [:create, :update]

  validates :start_date, :name, :location,
            :description, presence: true, if: -> { published? } 
  
  validate  :event_duration
  validate  :any_present?, if: -> { draft? }

  enum status: { draft: '1', published: '2' }

  scope :deleted, -> { only_deleted }
  scope :all_events, -> { with_deleted }

  def event_duration
    # end_date and duration validations
    if published? && end_date.blank? && duration.blank?
      errors.add(:duration, I18n.t('event.field_missings'))
    end

    if start_date
      errors.add(:end_date, I18n.t('event.invalid_date')) if end_date && end_date < start_date

      calculate_duration
    end
  end

  private 
  # calculate duration of the event when
  # end_date is present or only duration.
  # ensure a valid duration when end_date present.
  def calculate_duration
    if end_date
      self.duration = end_date.mjd - start_date.mjd
    elsif duration
      self.end_date = start_date + duration
    end
  end

  # Check if all fields are setted and marked as
  # published if true
  def published_with_all_fields
    if start_date? && (end_date? || duration?) && location? && description? && name?
      self.status = :published
    end
  end

  # Check if any field is present in order to save it as a draft
  def any_present?
    if %w(start_date end_date duration location,
          description name).all?{ |attr| self[attr].blank? }
      errors.add :group_event, I18n.t('event.none_fields')
    end
  end
end
