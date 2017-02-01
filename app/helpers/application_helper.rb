module ApplicationHelper

  def home(user)
    is_logged_in?(user) ? user_path(user) : root_path
  end


  def generate_table(collection:, headers:, fields:)
    thead = content_tag(:thead) do
      headers.collect do |head|
        concat content_tag(:th, head)
      end
    end

    body = content_tag(:body) do
      collection.collect do |element|
        content_tag(:tr) do
          fields.collect do |field|
            concat content_tag(:td, element.send("#{field}"))
          end
        end
      end.join.html_safe
    end

    content_tag :table, thead.concat(body), :class =>"table table-striped"
  end

end
