class Admin::ActivitiesController < ApplicationController

  def index
    @activities = Activity.all
  end

  def create
  end

  def destroy
  end
end
