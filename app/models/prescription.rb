class Prescription < ApplicationRecord
    belongs_to :user
    belongs_to :appointment
end
