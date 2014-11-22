module FormsHelper

  def site_forms
    @site_forms ||= current_site.forms
  end

  def current_form
    @current_form ||= begin
      p = params[:form_slug] || params[:slug]
      current_site.forms.find_by_slug(p)
    end
  end

  def form_field_options
    [
      ['String', 'string'],
      ['Textarea', 'text'],
      ['Dropdown', 'select'],
      ['Date', 'date'],
      ['Checkbox', 'boolean'],
      ['Checkboxes', 'check_boxes'],
      ['Radio Buttons', 'radio_buttons'],
      # ['Date & Time', 'datetime'],
      # ['File Upload', 'file']
    ].sort
  end

  def form_view(form)
    simple_form_for(
      FormSubmission.new, 
      :url => api_v1_forms_path(:key => form.key)
    ) do |f|  
      f.simple_fields_for :field_data do |field_data|
        o = ''
        form.fields.each do |field|
          o += form_field_view(field, field_data)
        end
        o.html_safe
      end
    end
  end

  def form_field_view(field, form)
    case field.data_type
    when 'select', 'check_boxes', 'radio_buttons'
      form.input(
        field.slug.to_sym,
        :as => field.data_type,
        :label => field.show_label ? field.label || field.title : false,
        :collection => field.option_values,
        :required => field.required,
        :selected => field.default_value
      )
    when 'boolean'
      form.input(
        field.slug.to_sym,
        :as => field.data_type,
        :label => field.show_label ? field.label || field.title : false,
        :collection => field.option_values,
        :required => field.required,
        :input_html => {
          :checked => field.default_value.to_bool
        }
      )
    else
      form.input(
        field.slug.to_sym,
        :as => field.data_type,
        :label => field.show_label ? field.label || field.title : false,
        :required => field.required,
        :placeholder => field.placeholder,
        :input_html => {
          :value => field.default_value
        }
      )
    end
  end

end
