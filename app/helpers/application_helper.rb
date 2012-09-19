# encoding: utf-8
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

  def rus_date(data)
    d = data.split(%r{\D})
    month = { 
        "01" => "Янв", "02" => "Фев", "03" => "Мар", "04" => "Апр", "05" => "Май", "06" => "Июн",
        "07" => "Июл", "08" => "Авг", "09" => "Сен", "10" => "Окт", "11" => "Ноя", "12" => "Дек" 
    }
    
    return "#{d[2]+' '+month[d[1]]+' '+d[3]+':'+d[4]}"
  end
end
