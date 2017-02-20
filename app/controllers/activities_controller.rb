class ActivitiesController < ApplicationController
  before_action :authenticate_user, :reset_activities

  def index
    @activities = current_user.activities
    @activity = Activity.new
    # if params[:user_id] && correct_user?(params[:user_id])
    #   @activities = current_user.activities
    #   @activity = Activity.new
    # else
    #   redirect_to boards_path
    # end
  end

  def create
    @activity = current_user.activities.build(activity_params)
    if @activity.save
      flash[:success] = "New activity successfully created."
      redirect_to activities_path
    else
      flash[:danger] = "Activity not created. Make sure you provide a description and a rating."
      redirect_back(fallback_location: session[:previous_url])
    end

    # if params[:user_id] && correct_user?(params[:user_id])
    #   @activity = current_user.activities.build(activity_params)
    #
    #   if @activity.save
    #     flash[:success] = "New activity successfully created."
    #     redirect_to user_activities_path(current_user)
    #   else
    #     flash[:danger] = "Activity not created. Make sure you provide a description and a rating."
    #     redirect_back(fallback_location: session[:previous_url])
    #     # raise params.inspect
    #     # redirect_to user_activities_path(current_user)
    #     # redirect_to user_boards_path(current_user) #### MUST REDIRECT TO RIGHT URL
    #   end
    # else
    #   redirect_to user_boards_path(current_user)
    # end
  end

  def edit
    @activity = current_user.activities.find_by(id: params[:id])
    if @activity.nil?
      flash[:danger] = "Activity not found."
      redirect_to boards_path(current_user)
    end
    store_previous_url
    #
    # if params[:user_id] && correct_user?(params[:user_id])
    #   @activity = current_user.activities.find_by(id: params[:id])
    #
    #   if @activity.nil?
    #     flash[:danger] = "Activity not found."
    #     redirect_to user_boards_path(current_user)
    #   end
    # else
    #   redirect_to user_boards_path(current_user)
    # end
  end

  def update
    @activity = current_user.activities.find_by(id: params[:id])
    redirect_to activities_path unless @activity
    if @activity.update(activity_params)
      flash[:success] = "Activity updated."
      go_to_previous_url
    else
      flash.now[:danger] = "Activity couldn't be found or updated."
      render :edit
    end


    # if params[:user_id] && correct_user?(params[:user_id])
    #   @activity = current_user.activities.find_by(id: params[:id])
    #
    #   if !@activity.nil? && @activity.update(activity_params)
    #     flash[:success] = "Activity updated."
    #     go_to_previous_url
    #   else
    #     flash[:danger] = "Activity couldn't be found or updated."
    #     redirect_to user_boards_path(current_user)
    #   end
    # else
    #   redirect_to user_boards_path(current_user)
    # end
  end

  def destroy
    @activity = current_user.activities.find_by(id: params[:id])
    if !@activity.nil?
      @activity.destroy
      flash[:success] = "Activity deleted."
      @activity = nil
    else
      flash[:danger] = "Activity couldn't be found or updated."
    end
    redirect_to activities_path

    # if params[:user_id] && correct_user?(params[:user_id])
    #   @activity = current_user.activities.find_by(id: params[:id])
    #
    #   if !@activity.nil?
    #     @activity.destroy
    #     flash[:success] = "Activity deleted."
    #     redirect_to user_activities_path(current_user)
    #     @activity = nil
    #   else
    #     flash[:danger] = "Activity couldn't be found or updated."
    #     redirect_to user_activities_path(current_user)
    #   end
    # else
    #   redirect_to user_boards_path(current_user)
    # end
  end

  private

  def activity_params
    params.require(:activity).permit(:description, :rating, :board_ids => [])
  end

  def reset_activities
    @activities = current_user.boards.select {|activity| activity.id}
  end


end
