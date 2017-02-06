module ApplicationHelper

  def nested_posts(messages)
    messages.map do |message, sub_messages|

    	render(message) + content_tag(:div, nested_posts(sub_messages), :class => "nested_posts")
    end.join.html_safe
  end 

end