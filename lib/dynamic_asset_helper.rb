# DynamicAssetHelper
#
# @version    1.0
#
# @license    MIT-style license
# @author     Brian Lopez <brianmario [at] me.com>
# @copyright  Author
module DynamicAssetHelper
  def dynamic_javascript_include_tag(options={})
    output = []
    if options[:extras]
      extras = options[:extras]
      options.reject! {|k, v| k == :extras}
    end
    output << controller_javascript_include_tag(options) unless controller_javascript_include_tag(options).nil?
    output << action_javascript_include_tag(options) unless action_javascript_include_tag(options).nil?
    output << other_javascript_include_tags(options, extras) unless extras.nil?
    output.join("\n")
  end
  
  def dynamic_stylesheet_link_tag(options={})
    output = []
    if options[:extras]
      extras = options[:extras]
      options.reject! {|k, v| k == :extras}
    end
    output << controller_stylesheet_link_tag(options) unless controller_stylesheet_link_tag(options).nil?
    output << action_stylesheet_link_tag(options) unless action_stylesheet_link_tag(options).nil?
    output << other_stylesheet_link_tags(options, extras) unless extras.nil?
    output.join("\n")
  end
  
  protected
  
  def controller_javascript_include_tag(options)
    if File.exists?(File.join(Rails.root, 'public', 'javascripts', params[:controller]+'.js'))
      path = "#{params[:controller]}"
      path << "_#{options[:media]}" unless options[:media].nil?
      javascript_include_tag("#{path}.js", options)
    end
  end
  
  def action_javascript_include_tag(options)
    if File.exists?(File.join(Rails.root, 'public', 'javascripts', params[:controller], params[:action]+'.js'))
      path = "#{params[:controller]}/#{params[:action]}"
      path << "_#{options[:media]}" unless options[:media].nil?
      javascript_include_tag("#{path}.js", options)
    end
  end
  
  def other_javascript_include_tags(options, extras)
    unless extras.nil?
      output = []
      extras.each do |extra|
        
        fs_path = File.join(Rails.root, 'public', 'javascripts', params[:controller], params[:action], extra.to_s.pluralize+'.js')
        if File.exists?(fs_path)
          path = "#{params[:controller]}/#{params[:action]}/#{extra.to_s.pluralize}"
          path << "_#{options[:media]}" unless options[:media].nil?
          output << javascript_include_tag("#{path}.js", options)
        end
        
        if params[extra]
          fs_path = File.join(Rails.root, 'public', 'javascripts', params[:controller], params[:action], extra.to_s.pluralize, params[extra]+'.js')
          if File.exists?(fs_path)
            path = "#{params[:controller]}/#{params[:action]}/#{extra.to_s.pluralize}/#{params[extra]}"
            path << "_#{options[:media]}" unless options[:media].nil?
            output << javascript_include_tag("#{path}.js", options)
          end
        end
      end
      output.join("\n")
    end
  end
  
  def controller_stylesheet_link_tag(options)
    if File.exists?(File.join(Rails.root, 'public', 'stylesheets', params[:controller]+'.css'))
      path = "#{params[:controller]}"
      path << "_#{options[:media]}" unless options[:media].nil?
      stylesheet_link_tag("#{path}.css", options)
    end
  end

  def action_stylesheet_link_tag(options)
    if File.exists?(File.join(Rails.root, 'public', 'stylesheets', params[:controller], params[:action]+'.css'))
      path = "#{params[:controller]}/#{params[:action]}"
      path << "_#{options[:media]}" unless options[:media].nil?
      stylesheet_link_tag("#{path}.css", options)
    end
  end
  
  def other_stylesheet_link_tags(options, extras)
    unless extras.nil?
      output = []
      extras.each do |extra|
        
        fs_path = File.join(Rails.root, 'public', 'stylesheets', params[:controller], params[:action], extra.to_s.pluralize+'.css')
        if File.exists?(fs_path)
          path = "#{params[:controller]}/#{params[:action]}/#{extra.to_s.pluralize}"
          path << "_#{options[:media]}" unless options[:media].nil?
          output << stylesheet_link_tag("#{path}.css", options)
        end
        
        if params[extra]
          fs_path = File.join(Rails.root, 'public', 'stylesheets', params[:controller], params[:action], extra.to_s.pluralize, params[extra]+'.css')
          if File.exists?(fs_path)
            path = "#{params[:controller]}/#{params[:action]}/#{extra.to_s.pluralize}/#{params[extra]}"
            path << "_#{options[:media]}" unless options[:media].nil?
            output << stylesheet_link_tag("#{path}.css", options)
          end
        end
      end
      output.join("\n")
    end
  end
end