class Appointment < ApplicationRecord
    belongs_to :user
    has_one :prescription

    
    # enum status: { pending: 0, fulfilled: 1, missed: 2 }

    validate :within_working_hours

    def within_working_hours
        unless start_time.between?(Time.zone.today + WORKING_HOURS_START.hours, Time.zone.today + WORKING_HOURS_END.hours)
          errors.add(:start_time, "must be within working hours (8 am to 5 pm)")
        end
    end
end
