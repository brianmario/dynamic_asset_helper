module DynamicAssetHelper
  def dynamic_javascript_include_tag
    output = []
    output << controller_javascript_include_tag
    output << action_javascript_include_tag
    output.join("\n")
  end
  
  def controller_javascript_include_tag
    if defined?(RAILS_ROOT) && File.exists?("#{RAILS_ROOT}/public/javascripts/"+params[:controller]+'.js')
      javascript_include_tag(params[:controller]+'.js')
    end
  end
  
  def action_javascript_include_tag
    if defined?(RAILS_ROOT) && File.exists?("#{RAILS_ROOT}/public/javascripts/"+params[:controller]+'/'+params[:action]+'.js')
      javascript_include_tag(params[:controller]+'/'+params[:action]+'.js')
    end
  end
  
  def dynamic_stylesheet_link_tag
    output = []
    output << controller_stylesheet_link_tag
    output << action_stylesheet_link_tag
    output.join("\n")
  end
  
  def controller_stylesheet_link_tag
    if defined?(RAILS_ROOT) && File.exists?("#{RAILS_ROOT}/public/stylesheets/"+params[:controller]+'.css')
      stylesheet_link_tag(params[:controller]+'.css')
    end
  end

  def action_stylesheet_link_tag
    if defined?(RAILS_ROOT) && File.exists?("#{RAILS_ROOT}/public/stylesheets/"+params[:controller]+'/'+params[:action]+'.css')
      stylesheet_link_tag(params[:controller]+'/'+params[:action]+'.css')
    end
  end
end