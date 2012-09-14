module ApplicationHelper
  def logo
    logo = image_tag("rails.png", :alt => "Sample App", :class => "round") 
  end

  def title
    base_title = "This title"
	if @title.nil?
	  base_title
	else
	 "#{base_title} | #{@title}"
	end
  end
end
