class ActivityLogsController < ApplicationController
  def index
    @activity_logs = ActivityLog.order(created_at: :desc)
  end
end
