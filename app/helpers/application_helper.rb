module ApplicationHelper

  def nested_posts(messages)
    messages.map do |message, sub_messages|

    	render(message) + content_tag(:div, nested_posts(sub_messages), :class => "nested_posts")
    end.join.html_safe
  end 

  def footer_position(controller_name, action_name, flash=nil)
     
  	if['registrations'].include?(controller_name)
  		if['show', 'edit'].include?(action_name)
  			return 'footer-absolute'
  		else
  			return 'footer-relative'
  		end
  	elsif['posts', 'charges'].include?(controller_name)
  		return 'footer-relative'
  	elsif['confirmations', 'passwords', 'sessions', 'static_pages'].include?(controller_name)
  		return 'footer-absolute'
  	elsif(controller_name=='photos')
  		if(controller_name.classify.constantize.count < 3 )
  			return 'footer-absolute'
  		else
  			return 'footer-relative'
  		end
  	else
  		return 'footer-absolute'
  	end

  end

end