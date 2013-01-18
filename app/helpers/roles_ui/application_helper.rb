module RolesUi
  include UrlHelper

  module ApplicationHelper
    def alert_block(msg, alert_type)
      content_tag :div, :class => "alert alert-block alert-#{alert_type}" do
        link_to('x', '#', :class => 'close', :"data-dismiss" => 'alert') +
        msg
      end
    end

    def link_to_remove_fields(name, f)
      content_tag :div, :class => 'control-group' do
        content_tag :label
        content_tag :div, :class => 'controls' do
          f.hidden_field(:_destroy) + '  ' +
          link_to_function(name, "remove_fields(this)", :class => 'btn btn-mini btn-danger')
        end
      end
    end

    def link_to_add_fields(name, f, association, options={})
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", :f => builder)
      end
      link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", options)
    end

    # def method_missing method, *args, &block
    #      if method.to_s.end_with?('_path', '_url') and main_app.respond_to?(method)
    #        main_app.send(method, *args)
    #      else
    #        super
    #      end
    #    end
    #
    #    def respond_to?(method)
    #      if method.to_s.end_with?('_path', '_url')
    #        if main_app.respond_to?(method)
    #          true
    #        else
    #          super
    #        end
    #      else
    #        super
    #      end
    #    end
  end
end
