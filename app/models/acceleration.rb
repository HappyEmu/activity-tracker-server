class Acceleration < ActiveRecord::Base
  scope :in_time_frame, ->(time_frame) { where('timestamp > ?', Time.now - time_frame).order(timestamp: :asc) }
end
