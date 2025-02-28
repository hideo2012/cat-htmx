class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

=begin
  def rendaring_range
    case
    when htmx_target_main?
        render layout: false
        # veiws/cats/index.html.erb
    when htmx_target_list?
        render partial: "list"
    else
      # veiws/xxx/index.html.erb (with layout)
    end
  end

  def htmx_target_main?
    if request.headers["HTTP_HX_REQUEST"] && 
        request.headers['HTTP_HX_TARGET'] == 'side-main'
      true
    else
      false
    end
  end

  def htmx_target_list?
    if request.headers["HTTP_HX_REQUEST"] && 
        request.headers['HTTP_HX_TARGET'] == 'cats-list'
      true
    else
      false
    end
  end

=end
end
