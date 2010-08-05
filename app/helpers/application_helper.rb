# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def yeld_error(message)
    "<div id=\"errorbox\">#{message}</div>"
  end
  
  # Only need this helper once, it will provide an interface to convert a block into a partial.
  # 1. Capture is a Rails helper which will 'capture' the output of a block into a variable
  # 2. Merge the 'body' variable into our options hash
  # 3. Render the partial with the given options hash. Just like calling the partial directly.
  def block_to_partial(partial_name, options = {}, &block)
    options.merge!(:body => capture(&block))
    @options = options
    concat(render(:partial => partial_name), block.binding)
  end


  # 1. Render 'shared/rounded_titled_box' partial with the given options and block content
  def rounded_titled_box(title, type, options = {}, &block)
    block_to_partial('shared/rounded_titled_box', options.merge(:title => title, :type => type), &block)
  end

  # 1. Render 'shared/rounded_titled_box' partial with the given options and block content
  def rounded_box(options = {}, &block)
    block_to_partial('shared/rounded_box', options, &block)
  end
  
  
end
