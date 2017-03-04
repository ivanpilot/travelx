module ActivitiesHelper

  def display_form(object)
    if policy(:display).show? #DisplayPolicy.new(pundit_user, object).show?
      concat content_tag(:h2,"Create a new #{object.wordify.capitalize}")
      form_for object do |f|
        concat render :partial => "#{object.wordify}", :locals => {object.wordify.to_sym => f}
        concat f.submit "Create #{object.wordify.capitalize}", class:"btn btn-primary"
      end
    end
  end

  def show_edit_link(activity, user_visited)
    link_to("| Edit", edit_link(activity, user_visited)) if policy(activity).edit?
  end

  def show_delete_link(activity)
    link_to("| Delete", activity_path(activity),method: :delete, data: {confirm: 'Are you sure?'}) if policy(activity).destroy?
  end

  def edit_link(activity, user_visited)
    user_visited.nil? ? edit_activity_path(activity) : edit_user_activity_path(user_visited, activity)
  end

end
