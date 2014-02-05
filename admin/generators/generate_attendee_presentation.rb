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
    
    <div class="code" id="code_input">puts "CONNEXION REUSSIE, BIENVENUE"</div>
    
	<div class="code_helper">
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
<pre>
require 'test/unit'

class TestMimeType < Test::Unit::TestCase

  def test03
    extension_hash = { "html" => "text/html" }
    file_list = ["file.html"]
    
    assert_equal ["text/html"], mime_types(file_list, extension_hash)
  end  

  def test03
    extension_hash = { "html" => "text/html" }
    file_list = ["file.html"]
    
    assert_equal ["text/html"], mime_types(file_list, extension_hash)
  end  
  
  def test04
    extension_hash = { "html" => "text/html" }
    file_list = ["file.html", "file.gif"]
    
    assert_equal ["text/html", "UNKNOWN"], mime_types(file_list, extension_hash)
  end
  
  def test05
    extension_hash = { "html" => "text/html", "gif" => "image/gif" }
    file_list = ["file.html", "file.gif"]
    
    assert_equal ["text/html", "image/gif"], mime_types(file_list, extension_hash)
  end  
	
  def test11
    extension_hash = {"html" =>  "text/html", "png" => "image/png", "gif" => "image/gif" }
    file_list = ["animated.gif", "portrait.png", "index.html"]
    
    assert_equal  ["image/gif", "image/png", "text/html"], mime_types(file_list, extension_hash)
  end
  
  def test12
    extension_hash = {"txt" => "text/plain", "xml" =>  "text/xml", "flv" => "video/x-flv" }
    file_list = ["image.png", "animated.gif", "script.js", "source.cpp"]   
    
    assert_equal  ["UNKNOWN", "UNKNOWN", "UNKNOWN", "UNKNOWN"], mime_types(file_list, extension_hash)
  end
  
  def test13
    extension_hash = { "wav" => "audio/x-wav", "mp3" => "audio/mpeg", "pdf" => "application/pdf" }
    file_list = ["a", "a.wav", "b.wav.tmp", "test.vmp3", "pdf", "mp3", "report..pdf", "defaultwav", ".mp3.", "final."]   
    
    assert_equal  ["UNKNOWN", "audio/x-wav", "UNKNOWN", "UNKNOWN", "UNKNOWN", "UNKNOWN", "application/pdf", "UNKNOWN", "UNKNOWN", "UNKNOWN"], mime_types(file_list, extension_hash)
  end

  def test14
    #~ extension_hash = { "png" => "image/png", "TIFF" => "image/TIFF", "css" => "text/css", "TXT" => "text/plain"}
    extension_hash = { "png" => "image/png", "tiff" => "image/TIFF", "css" => "text/css", "txt" => "text/plain"}
    file_list = ["example.TXT", "referecnce.txt", "strangename.tiff", "resolv.CSS", "matrix.TiFF", "lanDsCape.Png", "extract.cSs"]   
    
    assert_equal  ["text/plain", "text/plain", "image/TIFF", "text/css", "image/TIFF", "image/png", "text/css"], mime_types(file_list, extension_hash)
  end
  
  def test15
    extension_hash = { }
    file_list = []   
    
    assert_equal  [], mime_types(file_list, extension_hash)
  end 
  
end
</pre>
		
	</div>	

	<div class="code_helper">
<pre>
#~ import java.util.*;
#~ import java.io.*;
#~ import java.math.*;

#~ class Solution {
class Solution

	#~ public static void main(String args[]) {
		
		# read two first lines
		#~ Scanner in = new Scanner(System.in);
		#~ int n = Integer.valueOf(in.nextLine().trim());
		#~ int q = Integer.valueOf(in.nextLine().trim());
		#~ n = Math.max(0, Math.min(n, 10000));
		#~ q = Math.max(0, Math.min(q, 10000));
		
		# put n next lines in a hash
		#~ Map<String, String> table = new HashMap<String, String>();
		#~ for (int i = 0; i < n; i++) {
		    #~ String[] assoc = in.nextLine().split(" ");
		    #~ table.put(assoc[0].toUpperCase(), assoc[1]);
		#~ }
		
		table = {}
		
		q = 0
		fichiers = ['..']
		
		# map each lines
		#~ for (int i = 0; i < q; i++) {
		for i in 0..q do
		    #~ String nomFichier = in.nextLine().trim();
		    nomFichier = fichiers[i]
		    #~ if (nomFichier.lastIndexOf(".") < 0)
		    if nomFichier.rindex(".") < 0
			#~ System.out.println("UNKNOWN");
			puts "UNKNOWN"
		    #~ else {
		    else
			#~ String ext = nomFichier.substring(nomFichier.lastIndexOf(".") + 1).toUpperCase();
			ext = nomFichier[nomFichier.rindex(".")..-1].upcase;
			#~ if (table.containsKey(ext))
			if table.has_key?(ext)
			    #~ System.out.println(table.get(ext));
			    puts table[ext]
			else
			    #~ System.out.println("UNKNOWN");
			    puts "UNKNOWN"
			#~ }
			end
		    end
		#~ }
		end
		
	#~ }
#~ }
end

require 'test/unit'

class TestMimeType < Test::Unit::TestCase

  def test03
    extension_hash = { "html" => "text/html" }
    file_list = ["file.html"]
    
    assert_equal ["text/html"], mime_types(file_list, extension_hash)
  end  

  def test03
    extension_hash = { "html" => "text/html" }
    file_list = ["file.html"]
    
    assert_equal ["text/html"], mime_types(file_list, extension_hash)
  end  
  
  def test04
    extension_hash = { "html" => "text/html" }
    file_list = ["file.html", "file.gif"]
    
    assert_equal ["text/html", "UNKNOWN"], mime_types(file_list, extension_hash)
  end
  
  def test05
    extension_hash = { "html" => "text/html", "gif" => "image/gif" }
    file_list = ["file.html", "file.gif"]
    
    assert_equal ["text/html", "image/gif"], mime_types(file_list, extension_hash)
  end  
	
  def test11
    extension_hash = {"html" =>  "text/html", "png" => "image/png", "gif" => "image/gif" }
    file_list = ["animated.gif", "portrait.png", "index.html"]
    
    assert_equal  ["image/gif", "image/png", "text/html"], mime_types(file_list, extension_hash)
  end
  
  def test12
    extension_hash = {"txt" => "text/plain", "xml" =>  "text/xml", "flv" => "video/x-flv" }
    file_list = ["image.png", "animated.gif", "script.js", "source.cpp"]   
    
    assert_equal  ["UNKNOWN", "UNKNOWN", "UNKNOWN", "UNKNOWN"], mime_types(file_list, extension_hash)
  end
  
  def test13
    extension_hash = { "wav" => "audio/x-wav", "mp3" => "audio/mpeg", "pdf" => "application/pdf" }
    file_list = ["a", "a.wav", "b.wav.tmp", "test.vmp3", "pdf", "mp3", "report..pdf", "defaultwav", ".mp3.", "final."]   
    
    assert_equal  ["UNKNOWN", "audio/x-wav", "UNKNOWN", "UNKNOWN", "UNKNOWN", "UNKNOWN", "application/pdf", "UNKNOWN", "UNKNOWN", "UNKNOWN"], mime_types(file_list, extension_hash)
  end

  def test14
    #~ extension_hash = { "png" => "image/png", "TIFF" => "image/TIFF", "css" => "text/css", "TXT" => "text/plain"}
    extension_hash = { "png" => "image/png", "tiff" => "image/TIFF", "css" => "text/css", "txt" => "text/plain"}
    file_list = ["example.TXT", "referecnce.txt", "strangename.tiff", "resolv.CSS", "matrix.TiFF", "lanDsCape.Png", "extract.cSs"]   
    
    assert_equal  ["text/plain", "text/plain", "image/TIFF", "text/css", "image/TIFF", "image/png", "text/css"], mime_types(file_list, extension_hash)
  end
  
  def test15
    extension_hash = { }
    file_list = []   
    
    assert_equal  [], mime_types(file_list, extension_hash)
  end 
  
end
</pre>
		
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
teacherSlideshow._slides[teacherSlideshow._numberOfSlides-1].code_editor.setTheme("ace/theme/vibrant_ink");
teacherSlideshow._slides[teacherSlideshow._numberOfSlides-1].code_editor.getSession().setMode("ace/mode/ruby");
document.getElementById('code_input').style.fontSize='14px';    
</script>    

</body>
</html>
}

puts ERB.new(template).result()
