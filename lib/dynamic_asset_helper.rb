# DynamicAssetHelper
#
# @version    1.0
#
# @license    MIT-style license
# @author     Brian Lopez <brianmario [at] me.com>
# @copyright  Author
module DynamicAssetHelper
  DYNAMIC_DIR = "dynamic"
  
  def dynamic_javascript_include_tag
    dynamic_asset_tag do |file|
      dynamic_include_js_file(file)
    end
  end
  
  def dynamic_stylesheet_link_tag
    dynamic_asset_tag do |file|
      dynamic_include_css_files(file)
    end
  end
  
  def dynamic_asset_tag
    layout = @controller.active_layout
    
    file_includes = [ File.join(DYNAMIC_DIR, layout),
                      File.join(DYNAMIC_DIR, params[:controller]),
                      File.join(DYNAMIC_DIR, params[:controller], params[:action]) ]
    file_includes.map! {|x| yield(x)}
    file_includes.flatten!
    file_includes.join("\n")
  end
  
  def dynamic_include_js_file(file)
    return_files = []
    file_with_type = file + ".js"
    if File.exists?(File.join(ActionView::Helpers::AssetTagHelper::JAVASCRIPTS_DIR, file_with_type))
      return_files << javascript_include_tag(file_with_type)
    end
    return_files
  end

  def dynamic_include_css_files(file)
    return_files = []
    media_types = [["", "all"], ["_screen", "screen"], ["_print", "print"]]
    media_types.each do |m|
      file_with_type = file + m[0] + ".css"
      if File.exists?(File.join(ActionView::Helpers::AssetTagHelper::STYLESHEETS_DIR, file_with_type))
        return_files << stylesheet_link_tag(file_with_type, :media => m[1])
      end
    end
    return_files
  end
end