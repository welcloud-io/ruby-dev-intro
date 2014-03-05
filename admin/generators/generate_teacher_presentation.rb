#encoding: utf-8

require 'erb'

require_relative 'generator_input'

template = 
%Q{<html>
<head>
<link href="slideshow.css" rel="stylesheet" media="screen"/>
<style>
<%= STYLE %>   
</style>   
</head>
<body>

<div class="presentation">

<% SLIDES.each do |slide| %>
<div class="slide">
  <% if slide[:Subtitle] then %><h1><%= TITLE %></h1><% end %>
  <% if slide[:Subtitle] then %><h2><%= slide[:Subtitle] %></h2><% end %>
  <section style="font-size:2em;">
    <% slide[:Section].each do |text| %>	    
    <%= text %>
    <% end %>
  </section>		    
</div>
<% end %>

<!--   #####  LAST SLIDE : CODING SLIDE   ##### -->

<div class="slide" id="coding">
    
<section>

<div class="code" id="code_input"></div>

<% SLIDES.each do |slide| %>
  <div class="code_helper">
  <% if slide[:Subtitle] then %><h2><center><%= slide[:Subtitle] %></center></h2><% end %>
  <% slide_text = slide[:Helper] || slide[:Section] %>
  <% slide_text.each do |text| %>
    <%= text %>	
  <% end %>
  </div>
<%end %>

<input type="button" id="execute" value="EXECUTE (ALT-R)">
<input type="button" id="send_code" value="SEND (ALT-S)">

<textarea class="code_result" id="code_output" readonly></textarea>

</section>

</div>  

</div> <!--presentation-->

<script src="ace-builds/src-min-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>
<script src="slideshow.js"></script>
<script src="slideshow-teacher.js"></script>
<script>
teacherSlideshow._slides[teacherSlideshow._numberOfSlides-1].code_editor.setTheme("ace/theme/vibrant_ink");
teacherSlideshow._slides[teacherSlideshow._numberOfSlides-1].code_editor.getSession().setMode("ace/mode/ruby");
document.getElementById('code_input').style.fontSize='14px';    
</script>    

</body>
</html>
}

puts ERB.new(template).result()
