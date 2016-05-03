class DashboardController < ApplicationController
  def index
    @default_columns = [
      {
        strategySlug: 'student_name',
        strategyInputs: {}
      }
    ]
  end
end
