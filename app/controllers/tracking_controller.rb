class TrackingController < ApplicationController

  skip_before_filter  :verify_authenticity_token

  def test
    render :charts
  end

  def accelerations
    @accelerations = Acceleration.in_time_frame(30.seconds)

    chart_data = [
        { name: 'ax', data: @accelerations.pluck(:timestamp, :ax) },
        { name: 'ay', data: @accelerations.pluck(:timestamp, :ay) },
        { name: 'az', data: @accelerations.pluck(:timestamp, :az) }
    ]
    render json: chart_data.chart_json
  end

  def activities
    render json: Activity.to_timeline
  end

  def incoming
    data = JSON.parse params[:data]

    ActiveRecord::Base.transaction do
      data.each do |v|
        #v['timestamp'] = Time.at(v['timestamp'] / 1000).to_datetime
        case v['type']
          when 'acceleration'
            Acceleration.create(v.except 'type')
          when 'activity'
            Activity.create(timestamp: v['timestamp'], type_string: v['text'])
          else
        end
      end
    end

    render text: "Incoming data received: #{data}"
  end
end
