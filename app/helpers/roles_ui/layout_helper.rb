module RolesUi
  module LayoutHelper
    def title(page_title, show_title = true)
      content_for(:title) { h(page_title.to_s) }
      @show_title = show_title
    end

    def show_title?
      @show_title
    end

    def alert_type(name)
      case name
      when :notice
        'success'
      when :alert
        'error'
      else
        'info'
      end
    end
  end
end
