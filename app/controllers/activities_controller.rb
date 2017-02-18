class ActivitiesController < ApplicationController
  before_action :authenticate_user, :reset_activities
  after_action :verify_authorized, except: :index


  def index ### WILL NEED TO MODIFY!!!!!!!!
    if params[:user_id] && correct_user?(params[:user_id])
      @activities = current_user.activities
      @activity = Activity.new
    else
      # redirect_to user_boards_path(current_user)
      @activities = User.find_by(id: params[:user_id]).activities
    end
  end

  def create
    @activity = current_user.activities.build(activity_params)
    authorize @activity
    if @activity.save
      flash[:success] = "New activity successfully created."
      redirect_to user_activities_path(current_user)
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
    #   end
    # else
    #   redirect_to user_boards_path(current_user)
    # end
  end

  def edit
    if params[:user_id] && correct_user?(params[:user_id])
      @activity = current_user.activities.find_by(id: params[:id])
      store_previous_url
      if @activity.nil?
        flash[:danger] = "Activity not found."
        redirect_to user_boards_path(current_user)
      end
    else
      redirect_to user_boards_path(current_user)
    end
  end

  def update
    if params[:user_id] && correct_user?(params[:user_id])
      @activity = current_user.activities.find_by(id: params[:id])

      if !@activity.nil? && @activity.update(activity_params)
        flash[:success] = "Activity updated."
        go_to_previous_url
      else
        flash[:danger] = "Activity couldn't be found or updated."
        redirect_to user_boards_path(current_user)
      end
    else
      redirect_to user_boards_path(current_user)
    end
  end

  def destroy
    if params[:user_id] && correct_user?(params[:user_id])
      @activity = current_user.activities.find_by(id: params[:id])

      if !@activity.nil?
        @activity.destroy
        flash[:success] = "Activity deleted."
        redirect_to user_activities_path(current_user)
        @activity = nil
      else
        flash[:danger] = "Activity couldn't be found or updated."
        redirect_to user_activities_path(current_user)
      end
    else
      redirect_to user_boards_path(current_user)
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:description, :rating, :board_ids => [])
  end

  def reset_activities
    @activities = current_user.boards.select {|activity| activity.id}
  end

end
