class ActivitiesController < ApplicationController
  before_action :authenticate_user, :authenticate_friend#, :reset_activities

  def index
    if params[:user_id] && !current_user.is_friend_with?(User.find_by(id: params[:user_id])) && !current_user.admin?
      flash[:danger] = "You don't have authorization."
      redirect_back(fallback_location: activities_path)
    else
      @activities = policy_scope(Activity) #ActivityPolicy::Scope.new(pundit_user, Activity).resolve
      @boards = policy_scope(Board)
      @activity = Activity.new
      @user = User.find_by(id: params[:user_id]) if params[:user_id]
    end
  end

  def create
    user = params[:user_id].nil? ? current_user : User.find_by(id:params[:user_id])
    @activity = user.activities.build(activity_params)
    if Activity.find_by_activity_des_and_user_id(@activity.description, user.id)
      flash[:info] = "This activity already exists."
      redirect_to to_activities
      return
    end
    authorize @activity
    if @activity.save
      flash[:success] = "New activity successfully created."
      redirect_to to_activities
    else
      flash[:danger] = "Activity not created. Make sure you provide a description and a rating."
      redirect_back(fallback_location: session[:previous_url]) ### SHOULD RENDER INDEX?
    end
  end

  def edit
    @activity = Activity.find_by(id: params[:id])
    if @activity
      authorize @activity #ActivityPolicy
      @boards = policy_scope(Board)
      @user = User.find_by(id: params[:user_id]) if params[:user_id]
      store_previous_url
    else
      flash[:danger] = "Activity not found."
      redirect_to activities_path
    end
  end

  def update
    @activity = Activity.find_by(id: params[:id])
    redirect_to activities_path unless @activity
    authorize @activity
    if @activity.update(activity_params)
      flash[:success] = "Activity updated."
      go_to_previous_url
    else
      flash.now[:danger] = "Please try again."
      render :edit
    end
  end

  def import
    activity = Activity.find_by(id: params[:id])
    redirect_to to_activities unless activity
    @new_activity = current_user.activities.build(description: activity.description, rating: activity.rating)
    if Activity.find_by_activity_des_and_user_id(@new_activity.description, current_user.id)
      flash[:info] = "This activity already exists."
    end

    authorize @new_activity
    if @new_activity.save
      flash[:success] = "New activity added to your activities."
    else
      flash[:danger] = "Activity not added. Make sure you ."
    end
  end

  def destroy
    @activity = Activity.find_by(id: params[:id])
    if @activity
      authorize @activity
      @activity.destroy
      flash[:success] = "Activity deleted."
      @activity = nil
    else
      flash[:danger] = "Activity couldn't be found or deleted."
    end
    redirect_back(fallback_location: activities_path)
  end

  private

  def activity_params
    params.require(:activity).permit(:user_id, :description, :rating, :board_ids => [])
  end

  # def reset_activities
  #   @activities = current_user.activities.select {|activity| activity.id}
  # end

  def to_activities
    if params[:user_id].nil?
      activities_path
    else
      user = User.find_by(id: params[:user_id])
      user_activities_path(user)
    end
  end

end
