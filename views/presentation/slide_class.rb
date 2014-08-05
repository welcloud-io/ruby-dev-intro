class Slide
  
  def initialize(params)
    @subtitle = params[:subtitle]
    if params[:section] then @section = params[:section] end
    if params[:section_p] then @section = section_p(params[:section_p]) end
    @code_to_add = params[:code_to_add]
    @code_to_display = params[:code_to_display]
  end
  
  def section_p(section)
    section.map { |element|  '<p>' + element + '</p>'}
  end
  
  def html_title
    "<h1>#{TITLE}</h1>" if @subtitle
  end
  
  def html_subtitle
    "<h2>#{@subtitle}</h2>" if @subtitle
  end
  
  def html_section
    html = ""
    @section.each do |text|   
      html << text
    end  
    html
  end
  
  def html_helper
    return if @code_to_add
    html_section
  end
  
  def html_code_to_add
    "<div class='code_to_add'>#{ @code_to_add }</div>"
  end  
  
  def html_code_to_display
    "<div class='code_to_display'>#{ @code_to_display }</div>"
  end    
  
end