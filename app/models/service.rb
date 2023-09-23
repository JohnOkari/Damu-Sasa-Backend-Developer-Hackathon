class Service < ApplicationRecord
    has_many :appointments

    validates :specialist, presence: true
    validates :option, presence: true
    validates :duration, presence: true, numericality: { greater_than: 0 }

    # validate :valid_duration_for_service

    private

  def valid_duration_for_service
    unless service && (start_time + service.duration.minutes) <= Time.zone.today + WORKING_HOURS_END.hours
      errors.add(:service, "duration is not valid for the selected time")
    end
  end
end