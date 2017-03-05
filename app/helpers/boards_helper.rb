module BoardsHelper

  def errors_messages(object)
    if object.errors.any?
       content_tag(:div, nil, :id=>"error_explanation") do
        content_tag(:div, class:"alert alert-danger") do
          content_tag(:ul) do
            object.errors.full_messages.each do |msg|
              concat content_tag(:li, "#{msg}")
            end.join.html_safe
          end
        end
      end
    end
  end

end
