class ActivitiesController < ApplicationController
  before_action :authenticate_user, :reset_activities, :authenticate_friend

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

  def create ### TBC WITH ADMIN NAMESPACE ### MUST BE MODIFIED !!!!
    authorize Activity
    @activity = current_user.activities.build(activity_params)
    if @activity.save
      flash[:success] = "New activity successfully created."
      redirect_to activities_path
    else
      flash[:danger] = "Activity not created. Make sure you provide a description and a rating."
      redirect_back(fallback_location: session[:previous_url])
    end
  end

  def edit
    @activity = Activity.find_by(id: params[:id])
    if @activity
      authorize @activity #ActivityPolicy
      @boards = policy_scope(Board) ###not working as must used the url with params
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
    @activity = Activity.find_by(id: params[:id])
    if @activity
      authorize @activity
      @activity.destroy
      flash[:success] = "Activity deleted."
      @activity = nil
    else
      flash[:danger] = "Activity couldn't be found or updated."
    end
    # redirect_to activities_path
    redirect_back(fallback_location: activities_path)

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
    params.require(:activity).permit(:user_id, :description, :rating, :board_ids => [])
  end

  def reset_activities
    @activities = current_user.activities.select {|activity| activity.id}
  end

  def authenticate_friend
    if params[:user_id] && !User.exists?(params[:user_id])
      redirect_back(fallback_location: session[:previous_url])
    end
  end

end
