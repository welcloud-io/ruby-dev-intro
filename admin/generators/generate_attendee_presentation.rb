#encoding: utf-8

require 'erb'

require_relative 'generator_input'

template = 
%Q{<html>
<head>
<link href="slideshow.css" rel="stylesheet" media="screen"/>
<style>
.slide {
left: 1%;
top: 1%;
width: 98%;
height: 98%;
background-color: #fff;
border-radius: 5px;
}
section {
margin-left: 1%;
margin-right: 1%;
margin-bottom: 1%;
} 
.code {
width:60%; 
height:60%;
}
.code_helper {
width:39%; 
height:60%;
}      
.code_result {
height:25%;
background-color: #332;      
color: yellow;      
}     
.code_helper.current {
background-color: #fff;
}
input[type=button]#execute {
margin: 1%;
}   
</style>   
</head>
<body>

<div class="presentation">

<div class="slide" id="coding">
    
    <section>
    
    <div class="code" id="code_input"></div>
    
	<div class="code_helper">
	<div class="code_to_display">puts "CONNEXION REUSSIE, BIENVENUE"</div>
	<section class='centered' >
	  INTRODUCTION A RUBY
	  </br>
	  </br>
	  CONNECTEZ VOUS SUR :
	  </br>
	  </br>
	  http://ruby-dev-intro.herokuapp.com
	</section>
	</div>

	<!--   LES CHAINES DE CARACTERES   -->

	<div class="code_helper">
	    <h3>- C'est un langage qui vient du Japon.</h3>
	    <h3>- Créé par Yukihiro Matsumoto (actuellement employé chez Heroku).</h3>
	    <h3>- Première version officielle (0.95) en 1995.</h3>
	    <h3>- A ce jour (janvier 2014) la dernière version est la 2.1.0.</h3>		    
	</div>

	<div class="code_helper">
	    <h3>- Ruby est conçu pour la productivité et le plaisir du programmeur.</h3>
	    <h3>- Il se focalise sur les besoins humains plutôt que sur les besoins de la machine.</h3>
	    <h3>- Il est influencé par différents langages, en particulier Smalltalk, Lisp et Perl.</h3>  
	</div>

	<% SLIDES.each do |slide| %>
	<div class="code_helper">
	
	    <center><%= slide[:Subtitle] %><center>

	    <% slide[:Section].each do |text| %>
		</br>
		</br>
		<center><%= text %></center>	
		<% end %>
		
	</div>
	<%end %>
	
	<div class="code_helper">
	
	<pre><%= TESTS %></pre>
		
	</div>	

	<div class="code_helper">
	
    <div class="code_to_display"><%= JAVA_CODE %></div>
    <pre><%= TESTS %></pre>
    
	</div>
    
    <input type="button" id="execute" value="EXECUTE (ALT-R)">
    <textarea class="code_result" id="code_output"></textarea>
    
    </section>

</div>  



</div> <!--presentation-->

<script src="ace-builds/src-min-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>
<script src="slideshow.js"></script>
<script src="slideshow-attendee.js"></script>
<script>
attendeeSlideshow._slides[attendeeSlideshow._numberOfSlides-1].code_editor.setTheme("ace/theme/vibrant_ink");
attendeeSlideshow._slides[attendeeSlideshow._numberOfSlides-1].code_editor.getSession().setMode("ace/mode/ruby");
document.getElementById('code_input').style.fontSize='14px';    
</script>    

</body>
</html>
}

puts ERB.new(template).result()
