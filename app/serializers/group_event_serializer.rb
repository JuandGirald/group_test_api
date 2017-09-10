class GroupEventSerializer < ActiveModel::Serializer
  attributes :id, :status, :name, :description, :start_date,
             :end_date, :duration, :location, :deleted_at

  def duration
    if object.duration
      object.duration == 1 ? "#{object.duration} day" : "#{object.duration} days"
    else
      object.duration
    end
  end

  def start_date
    object.start_date.to_formatted_s(:long) if object.start_date
  end

  def end_date
    object.end_date.to_formatted_s(:long) if object.end_date
  end
end