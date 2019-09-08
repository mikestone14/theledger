class ActivateSeasonController < ApplicationController
  def update
    if current_user.admin?
      season = Season.find(params[:id])

      season.activate!
    end

    redirect_to seasons_path
  end
end
