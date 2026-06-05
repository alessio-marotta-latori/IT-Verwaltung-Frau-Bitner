class ActivityLogsController < ApplicationController
  def index
    @pagy, @activity_logs = pagy(ActivityLog.order(created_at: :desc), limit: 25)
  end
end
