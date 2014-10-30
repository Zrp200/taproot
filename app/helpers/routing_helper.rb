module RoutingHelper

  def route(items, action)
    i = ""; s = ""; pop = false
    if items.last.is_a?(Array)
      items[-1] = items.last.flatten.first
      pop = true
    end
    items.each do |item|
      klass = item.class.method_defined?(:model) ? item.model : item.class
      t = klass.table_name.gsub(/heartwood\_/, '')
      ts = t.singularize; s += "#{ts}_"
      item == items.last ? i += "#{t}_" : i += "#{ts}_"
    end
    objs = items.reverse.drop(1).reverse
    objs = objs.collect(&:to_param).join(',')
    case action
    when :index
      objs.empty? ? send("#{i}path") : send("#{i}path", objs)
    when :new
      objs.empty? ? send("new_#{s}path") : send("new_#{s}path", objs)
    when :edit
      objs.empty? ? send("edit_#{s}path", items.last.to_param) : 
        send("edit_#{s}path", objs, items.last.to_param)
    when :show
      objs.empty? ? send("#{s}path", items.last.to_param) : 
        send("#{s}path", objs, items.last.to_param)
    end
  end

  def site_route(items, action)
    route([current_site] + items, action)
  end

  def page_type_route(items, action)
    route([current_site, current_page_type], action)
  end

end
