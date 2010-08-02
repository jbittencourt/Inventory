# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def yeld_error(message)
    "<div id=\"errorbox\">#{message}</div>"
  end
  
end
