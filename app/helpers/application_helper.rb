module ApplicationHelper
  def posted_at_display(unix_time)
    start_time = Time.now
    end_time = DateTime.strptime(unix_time.to_s, '%s').to_time
    seconds_diff = (start_time - end_time).to_i.abs
    days = (seconds_diff / 3600) / 24
    hours = seconds_diff / 3600
    minutes = seconds_diff / 60
    seconds = seconds_diff

    if days.positive?
      "#{pluralize(days, 'day')} ago."
    elsif hours.positive? && days <= 0
      "#{pluralize(hours, 'hour')} ago."
    elsif hours < 1 && minutes.positive?
      "#{pluralize(minutes, 'minute')} ago."
    else
      "#{pluralize(seconds, 'seconds')} ago."
    end
  end
end
