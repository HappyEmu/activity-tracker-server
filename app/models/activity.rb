class Activity < ActiveRecord::Base

  def self.to_timeline(time_frame = 1.day)
    activities = Activity.where('timestamp > ?', DateTime.now - time_frame).order(timestamp: :asc).to_a

    return [] if activities.count == 0

    strings = activities.map(&:type_string)
    changes = strings.zip(strings[1..-1]).map { |x,y| x != y }

    end_idx = changes.each_with_index.map { |c, idx| idx if changes[idx] }.compact
    begin_idx = (end_idx.map { |idx| idx + 1 }.unshift 0)[0..-2]

    end_activities = activities.values_at(*end_idx)
    begin_activities = activities.values_at(*begin_idx)

    end_activities.zip(begin_activities).map { |e, b| [e.type_string, b.timestamp, e.timestamp]}
  end

  def to_s
    "#{timestamp}: #{type_string}"
  end
end
