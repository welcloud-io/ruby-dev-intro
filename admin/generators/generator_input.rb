#encoding: utf-8

STYLE =
%Q{
.slide {
background-color: #fff;
}
section {
color: #000000;
margin-left: 1%;
margin-right: 1%;
margin-bottom: 1%;
margin-top: 3%;
}
.code_result {

font-size: 0.6em;
background-color: #332;      
color: yellow;      
}
.code_helper.current {
background-color: #fff;
}
div.slide > h1 {
color: #000000;  
}
div.slide > h2 {
color: #ffffff;
background-color: orange;
}
div.code_helper > h2 {  
color: #ffffff;
background-color: orange;
}
span.help_output {
color: yellow;
background-color: black;
}
span.help_string {
color: lime;
background-color: black;
}
span.help_variable {
color: white;
background-color: black;
}
span.help_integer {
color: yellowgreen;
background-color: black;
}
}

EDITOR_CONFIG = 
%Q{
<script>
var code_editor = ace.edit(document.getElementById('code_input'));
Editor.prototype.updateEditor = function (code) { code_editor.setValue(code, -1); };
Editor.prototype.content = function () { return code_editor.getValue();  };
code_editor.setTheme('ace/theme/vibrant_ink');
code_editor.getSession().setMode('ace/mode/ruby');
code_editor.setFontSize('14px');
</script>
}

PREVENT_DEFAULT_KEYS =
%Q{
<script>
preventDefaultKeys = function(e) {
  if (e.keyCode == F5) e.preventDefault();
  // if (e.keyCode == BACK_SPACE) e.preventDefault();    
  if (e.ctrlKey && e.which == R) e.preventDefault();
}
</script>
}

MIME_TYPE_PUZZLE =
%Q{
<div style="font-size: 0.55em">
Le type MIME est utilisé dans de nombreux protocoles internet pour associer un type de média (html, image, vidéo, ...) 
avec le contenu envoyé.
<p>   
<p>   
Ce type MIME est généralement déduit de l'extension du fichier à transférer.
<p>
<p>
Vous devez écrire un programme qui permet de détecter le type MIME d'un fichier à partir de son nom.
<p>      
Une table qui associe un type MIME avec une extension de fichier vous est fournie. 
Une liste des noms de fichier est aussi fournie et vous devrez déduire pour chacun d'eux, le type MIME correspondant.
<p>
L'extension d'un fichier se définit par la partie du nom qui se trouve après le dernier point qui le compose.
<p>
Si l'extension du fichier est présente dans la table d'association (la casse ne compte pas. ex : TXT est équivalent à txt), 
alors affichez le type MIME correspondant . S'il n'est pas possible de trouver le type MIME associé à un fichier, 
ou si le fichier n'a pas d'extensions, affichez UNKNOWN.       
<p>
<p>

EXEMPLE :
<p>
<p>

<table style="display: inline">
<th>Correspondances</th>
<tr><td>html => text/html</td></tr>
<tr><td>png => image/png</td></tr>
</table>
<table style="display: inline">
<th>Liste de fichiers</th>
<tr><td>test.html</td></tr>
<tr><td>noextension</td></tr>
<tr><td>portrait.png</td></tr>
<tr><td>doc.TXT</td></tr>
</table>
<table style="display: inline">
<th>Résultat</th>
<tr><td>text/html</td></tr>
<tr><td>UNKNOWN</td></tr>
<tr><td>image/png</td></tr>
<tr><td>UNKNOWN</td></tr>
</table>

</div>
}

JAVA_CODE =
%Q{
class Solution

  def Solution.main(table, fichiers)
    types_mimes = Array.new();
    for i in 0..fichiers.size-1 do
      nomFichier = fichiers[i];
      if (nomFichier.rindex(".") == nil)
        types_mimes.push("UNKNOWN");
      else
        ext = nomFichier[nomFichier.rindex(".")+1, 
	                           nomFichier.size-1];
        ext = ext.downcase;
        if (table.has_key?(ext))
          types_mimes.push(table[ext]);
        else
          types_mimes.push("UNKNOWN");
        end
      end
      i = i + 1;
    end
    return types_mimes;
  end
	
end

def mime_types(table, fichiers)
  Solution.main(table, fichiers);
end
}

TESTS=
%Q{
require 'test/unit'

class TestMimeType < Test::Unit::TestCase

  def test01_empty_list

    extension_hash = { 
    }
    file_list = [
    ]
    assert_equal [
    ], mime_types(extension_hash, file_list)
    
  end

  def test02_one_file_list_with_one_known_mime_type

    extension_hash = { 
    "html" => "text/html" 
    }
    file_list = [
    "file.html"
    ]
    assert_equal [
    "text/html"
    ], mime_types(extension_hash, file_list)
    
  end  

  def test03_two_files_list_with_two_known_mime_types

    extension_hash = { 
    "html" => "text/html", 
    "gif" => "image/gif" 
    }
    file_list = [
    "file.html", 
    "file.gif"
    ]
    assert_equal [
    "text/html", 
    "image/gif"
    ], mime_types(extension_hash, file_list)
    
  end

  def test04_two_files_list_with_one_UNKNOWN_mime_type

    extension_hash = { 
    "html" => "text/html" 
    }
    file_list = [
    "file.html", 
    "file.gif"
    ]
    assert_equal [
    "text/html", 
    "UNKNOWN"
    ], mime_types(extension_hash, file_list)
    
  end
  
  def test05_file_list_with_particular_extensions
    extension_hash = { 
    "wav" => "audio/x-wav", 
    "mp3" => "audio/mpeg", 
    "pdf" => "application/pdf" 
    }
    file_list = [
    "a", 
    "a.wav", 
    "b.wav.tmp", 
    "test.vmp3", 
    "pdf", "mp3", 
    "report..pdf", 
    "defaultwav", 
    ".mp3.", "final."
    ]
    assert_equal  [
    "UNKNOWN", 
    "audio/x-wav", 
    "UNKNOWN", 
    "UNKNOWN", 
    "UNKNOWN", 
    "UNKNOWN", 
    "application/pdf", 
    "UNKNOWN", 
    "UNKNOWN", 
    "UNKNOWN"
    ], mime_types(extension_hash, file_list)

  end

  def test06_file_list_with_upper_or_lower_case_extensions

    extension_hash = { 
    "png" => "image/png", 
    "tiff" => "image/TIFF", 
    "css" => "text/css", 
    "txt" => "text/plain"
    }
    file_list = [
    "example.TXT", 
    "referecnce.txt", 
    "strangename.tiff", 
    "resolv.CSS", 
    "matrix.TiFF", 
    "lanDsCape.Png", 
    "extract.cSs"
    ]
    assert_equal  [
    "text/plain", 
    "text/plain", 
    "image/TIFF", 
    "text/css", 
    "image/TIFF", 
    "image/png", 
    "text/css"
    ], mime_types(extension_hash, file_list)
    
  end
  
end
}

SCRABBLE = "
points_au_scrabble = {
'a'=>1,'b'=>3,'c'=>3,'d'=>2,'e'=>1,'f'=>4,'g'=>2,'h'=>4,
'i'=>1,'j'=>8,'k'=>5,'l'=>1,'m'=>3,'n'=>1,'o'=>1,'p'=>3,
'q'=>10,'r'=>1,'s'=>1,'t'=>1,'u'=>1,'v'=>4,'w'=>4,'x'=>8,
'y'=>4,'z'=>10
}
"

CONNEXION_SLIDE = "
<h3 style='text-align:center'>INTRODUCTION A RUBY</h3>
<h3 style='color: red; text-align:center'>CONNECTEZ VOUS SUR :</h3>
<h4 style='color: blue; font-size: 1.3em; text-align:center'>http://ruby-dev-intro.herokuapp.com</h4>
"

TITLE = 'INITIATION A RUBY'    
SLIDES = [
{		:Section => [
			"<h3 style='text-align:center'>INTRODUCTION A RUBY</h3>",
			"<h3 style='color: red; text-align:center'>CONNECTEZ VOUS SUR :</h3>",
			"<h4 style='color: blue; font-size: 1.3em; text-align:center'>http://ruby-dev-intro.herokuapp.com</h4>",
      "<h3 style='text-align:center'>ET</h3>",
      "<h3 style='text-align:center'>Entrez Votre Nom</h3>",
      "<div style='text-align: center'><input id='attendee_name' type='text'></input></div>",
			'<div class="code_to_display"> puts "CONNEXION REUSSIE, BIENVENUE"</div>',
			],			
},
{ :Subtitle => "HISTOIRE", 
			:Section => [
			"<h3>- C'est un langage qui vient du Japon.</h3>", 
			"<h3>- Créé par Yukihiro Matsumoto (actuellement employé chez Heroku).</h3>",
			"<h3>- Première version officielle (0.95) en 1995.</h3>",
			"<h3>- A ce jour (janvier 2014) la dernière version est la 2.1.0.</h3>"
			],			
},
{ :Subtitle => "PHILOSOPHIE", 
			:Section => [
			"<h3>- Ruby est conçu pour la productivité et le plaisir du programmeur.</h3>", 
			"<h3>- Il se focalise sur les besoins humains plutôt que sur les besoins de la machine.</h3>",
			"<h3>- Il est influencé par différents langages, en particulier Smalltalk, Lisp et Perl.</h3>",
			] 
},
{ :Subtitle => "LES CHAINES DE CARACTERES", 
			:Section => [
			"<p>",
			"Affichez sur la sortie standard", 
      "</p>",
      "<p>",
			"la chaine de caractères", 			
      "</p>",
      "<p>",
			"<span class='help_string'>\"BIENVENUE A L'INITIATION RUBY\"</span>",
      "</p>"
			] 
},
{ :Subtitle => "LES CHAINES DE CARACTERES", 
			:Section => [
			"<p>",				
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",			
			"<font color='red'>la 1ère lettre</font>",
			"</p>",
			"<p>",			
			"de la chaine de caractères", 
			"</p>",
			"<p>",			
			"<span class='help_string'>\"BIENVENUE A L'INITIATION RUBY\"</span>",
			"</p>"
			] 
},
{ :Subtitle => "LES CHAINES DE CARACTERES", 
			:Section => [
			"<p>",	
			"Affichez sur la sortie standard", 
			"</p>",
			"<p>",				
			"<font color='red'>la 5ème lettre</font>", 
			"</p>",
			"<p>",			
			"de la chaine de caractères", 			
			"</p>",
			"<p>",				
			"<span class='help_string'>\"BIENVENUE A L'INITIATION RUBY\"</span>",
			"</p>"
			] 
},
{ :Subtitle => "LES CHAINES DE CARACTERES", 
			:Section => [
			"<p>",	
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>la dernière lettre</font>", 
			"</p>",
			"<p>",			
			"de la chaine de caractères", 			
			"</p>",
			"<p>",				
			"<span class='help_string'>\"BIENVENUE A L'INITIATION RUBY\"</span>",
			"</p>"
			] 
},
{ :Subtitle => "LES CHAINES DE CARACTERES", 
			:Section => [
			"<p>",	
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",	
			"<font color='red'>LES 4 premières lettres</font>",
			"</p>",
			"<p>",			
			"de la chaine de caractères", 				
			"</p>",
			"<p>",				
			"<span class='help_string'>\"BIENVENUE A L'INITIATION RUBY\"</span>",
			"</p>"
			] 
},
{ :Subtitle => "LES CHAINES DE CARACTERES", 
			:Section => [
			"<p>",	
			"Affichez sur la sortie standard", 
			"</p>",
			"<p>",				
			"<font color='red'>la taille en nombre de caractères</font>",
			"</p>",
			"<p>",			
			"de la chaine de caractères", 			
			"</p>",
			"<p>",				
			"<span class='help_string'>\"BIENVENUE A L'INITIATION RUBY\"</span>",
			"</p>"
			] 
},
{ :Subtitle => "LES VARIABLES", 
			:Section => [
			"<p>",				
			"Déclarez une variable", 
			"</p>",
			"<p>",				
			"<span class='help_variable'>chaine_de_caracteres</span>",
			"</p>",
			"<p>",				
			"Initialisez la avec le mot", 
			"</p>",
			"<p>",				
			"<span class='help_string'>\"RUBY\"</span>",
			"</p>",
			"<p>",				
			"Affichez la sur la sortie standard",
			"</p>"
			] 
},
{ :Subtitle => "LES VARIABLES", 
			:Section => [
			"<p>",				
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>la classe de la variable</font>", 
			"</p>",
			"<p>",			
			"<span class='help_variable'>chaine_de_caracteres</span>",
			"</p>"
			] 
},
{ :Subtitle => "LES VARIABLES", 
			:Section => [
			"<p>",				
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>les méthodes de la variable</font>",
			"</p>",
			"<p>", 			
			"<span class='help_variable'>chaine_de_caracteres</span>",
			"</p>"
			] 
},
{ :Subtitle => "LES ENTIERS", 
			:Section => [
			"<p>",				
			"Déclarez la variable",
			"</p>",
			"<p>",				
			"<span class='help_variable'>un_entier_relatif</span>",
			"</p>",
			"<p>",			
			"Initialisez la avec valeur",
			"</p>",
			"<p>",			
			"<span class='help_integer'>-12</span>",		
			"</p>",
			"<p>",	
			"Affichez la sur la sortie standard",
			"</p>"      
			] 
},
{ :Subtitle => "LES ENTIERS", 
			:Section => [
			"<p>",				
			"Affichez sur la sortie standard", 
			"</p>",
			"<p>",				
			"<font color='red'>la classe de la variable</font>",
			"</p>",
			"<p>", 			
			"<span class='help_variable'>un_entier_relatif</span>",
			"</p>",
			"<p>",
			"Affichez sur la sur la sortie standard",
			"</p>"      
			] 
},
{ :Subtitle => "LES ENTIERS", 
			:Section => [
			"<p>",				
			"Affichez sur la sortie standard", 
			"</p>",
			"<p>",				
			"<font color='red'>les méthodes de la variable</font>",
			"</p>",
			"<p>", 			
			"<span class='help_variable'>un_entier_relatif</span>",
			"</p>",
			"<p>",
			"Affichez sur la sur la sortie standard",
			"</p>"      
			] 
},
{ :Subtitle => "LES ENTIERS", 
			:Section => [
			"<p>",
			"Affichez sur la sur la sortie standard",
			"</p>",
			"<p>",			
			"<font color='red'>la valeur absolue de la variable</font>",
			"</p>",
			"<p>",			
			"<span class='help_variable'>un_entier_relatif</span>",
			"</p>"
			] 
},
{ :Subtitle => "LES ENTIERS", 
			:Section => [
			"<p>",				
			"Affichez sur la sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>le nombre de secondes dans une année de 365 jours</font>",
			"</p>"      
			] 
},
{ :Subtitle => "ENTIERS et CHAINES DE CARACTERES", 
			:Section => [
			"<p>",				
			"Affichez sur la sur la sortie standard",
			"</p>",
			"<p>",				
			"<span class='help_string'>\"En 2014 il y aura ** secondes\"</span>",
			"</p>",
			"<p>",			
			"<font color='red'>** représente le nombre de secondes en chiffres</font>",
			"</p>"      
			] 
},
{ :Subtitle => "ENTIERS et CHAINES DE CARACTERES", 
			:Section => [
			"<p>",				
			"Affichez sur la sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>15 fois de suite la chaine de caractères</font>", 
			"</p>",
			"<p>",			
			"<span class='help_string'>\"Ruby !\"</span>",
			"</p>"
			] 
},
{ :Subtitle => "LES LISTES (ARRAYS)", 
			:Section => [
			"<p>",				
			"Déclarez une variable",
			"</p>",
			"<p>",				
			"<span class='help_variable'>cinq_chiffres_romains</span>",
			"</p>",
			"<p>",			
			"Intialisez là avec",
			"</p>",
			"<p>",			
			"<span class='help_string'>\"I\", \"II\", \"III\", \"IV\", \"V\"</span>",
			"</p>",
			"<p>",				
			"Affichez la sur la sortie standard",
			"</p>"      
			] 
},
{ :Subtitle => "LES LISTES (ARRAYS)", 
			:Section => [
			"<p>",				
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>Le chiffre Romain</font>",
			"</p>",
			"<p>",			
			"<font color='red'>correspondant</font>",
			"</p>",
			"<p>",			
			"<font color='red'>au chiffre Arabe</font>",
			"</p>",
			"<p>",			
			"<span class='help_integer'>3</span>",
			"</p>"
			] 
},
{ :Subtitle => "LES LISTES (ARRAYS)", 
			:Section => [
			"<p>",				
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>Le chiffre Arabe</font>",
			"</p>",
			"<p>",			
			"<font color='red'>correspondant</font>",
			"</p>",
			"<p>",			
			"<font color='red'>au chiffre Romain</font>",
			"</p>",
			"<p>",				
			"<span class='help_string'>\"IV\"</span>",
			"</p>"
			] 
},
{ :Subtitle => "LES LISTES (ARRAYS)", 
			:Section => [
			"<p>",				
			"<font color='red'>Ajoutez le chiffre romain</font>",
			"</p>",
			"<p>",			
			"<span class='help_string'>\"VI\"</span>",
			"</p>",
			"<p>",				
			"<font color='red'>à la variale</font>",
			"</p>",
			"<p>",			
			"<span class='help_variable'>cinq_chiffres_romains</span>",
			"</p>",
			"<p>",
			"Affichez la sur la sortie standard",
			"</p>"      
			] 
},
{ :Subtitle => "LES DICTIONNAIRES (HASHES)", 
			:Section => [
			"<p>",				
			"Déclarez une variable",
			"</p>",
			"<p>",	
			"<span class='help_variable'>points_au_scrabble</span>",
			"</p>",
			"<p>",			
			"Initialisez la avec",
			"</p>",
			"<p>",
      "<div>",
			"<span class='help_string'>\"a\" <span class='help_variable'>=></span> <span class='help_integer'>1,</span>",
      "</div>",
      "<div>",
			"<span class='help_string'>\"b\" <span class='help_variable'>=></span> <span class='help_integer'>3,</span>",
      "</div>",
      "<div>",
			"<span class='help_string'>\"c\" <span class='help_variable'>=></span> <span class='help_integer'>3,</span>",
      "</div>",
      "<div>",
			"<span class='help_string'>\"d\" <span class='help_variable'>=></span> <span class='help_integer'>2,</span>",
      "</div>",
      "<div>",  
			"<span class='help_string'>\"e\" <span class='help_variable'>=></span> <span class='help_integer'>1,</span>",
      "</div>",
      "<p>",
			"Affichez là sur la sortie standard",
			"</p>"      
			] 
},
{ :Subtitle => "LES DICTIONNAIRES (HASHES)", 
			:Section => [
			"<p>",				
			"Afficher sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>les <b>clés</b> du dictionnaire</font>",
			"</p>",
			"<p>",	
			"<span class='help_variable'>points_au_scrabble</span>",
			"</p>",
			] 
},
{ :Subtitle => "LES DICTIONNAIRES (HASHES)", 
			:Section => [
			"<p>",				
			"Afficher sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>les <b>valeurs</b> contenues dans le dictionnaire</font>",
			"</p>",
			"<p>",	
			"<span class='help_variable'>points_au_scrabble</span>",
			"</p>",
			] 
},
{ :Subtitle => "LES DICTIONNAIRES (HASHES)", 
			:Section => [
			"<p>",				
			"Afficher sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>le nombre de points de la lettre</font>",
			"</p>",
			"<p>",	
			"<span class='help_string'>\"d\"</span>",
			"</p>",
			] 
},
{ :Subtitle => "LES DICTIONNAIRES (HASHES)", 
			:Section => [
			"<p>",				
			"Afficher sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>le nombre de points du mot</font>",
			"</p>",
			"<p>",	
			"<span class='help_string'>\"ruby\"</span>",
			"</p>",
			],
			:Helper => [
			"<p>",				
			"Afficher sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>le nombre de points du mot</font>",
			"</p>",
			"<p>",	
			"<span class='help_string'>\"ruby\"</span>",
			"</p>",
			"<p>",		
			"<div class='code_to_display'> #{SCRABBLE} </div>",
			"</p>"      
			],
},
{ :Subtitle => "LES DICTIONNAIRES (HASHES)", 
			:Section => [
			"<p>",				
			"Afficher sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>le nombre de points du symbol</font>",
			"</p>",
			"<p>",	
			"<span class='help_string'>\"@\"</span>",
			"</p>",
			],
			:Helper => [
			"<p>",				
			"Afficher sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>le nombre de points du symbol</font>",
			"</p>",
			"<p>",	
			"<span class='help_string'>\"@\"</span>",
			"</p>",
			],
},
{ :Subtitle => "LES CONDITIONS", 
			:Section => [
			"<p>",				
			"Déclarez une variable",
			"</p>",
			"<p>",	
			"<span class='help_variable'>lettre</span>",
			"</p>",
			"<p>",			
			"Initialisez la avec la valeur",	
			"</p>",
			"<p>",	
			"<span class='help_string'>\"a\"</span>",
			"</p>",			
			] 
},
{ :Subtitle => "LES CONDITIONS", 
			:Section => [
			"<p>",				
			"Sur la sortie standard",
			"</p>",
			"<p>",			
			"<font color='red'>si la variable</font>", 
			"<span class='help_variable'>points_au_scrabble</span>",
			"</p>",
			"<p>",			
			"<font color='red'>possède la clé</font>",
			"<span class='help_variable'>lettre</span>",
			"</p>",
			"<p>",			
			"<font color='red'>alors</font>", 
			"</p>",
			"<p>",			
			"Affichez",
			"<span class='help_variable'>le nombre de points</span>",
			"</p>",
			"<p>",			
			"<font color='red'>sinon</font>", 
			"</p>",
			"<p>",			
			"Affichez",
			"<span class='help_string'>\"LETTRE INCONNUE\"</span>",
			"</p>",			
			] 
},
{ :Subtitle => "LES CONDITIONS", 
			:Section => [
			"<p>",				
			"Faites le test avec la variable",
			"</p>",
			"<p>",	
			"<span class='help_variable'>lettre</span>",
			"</p>",
			"<p>",			
			"Initialisée avec la valeur",	
			"</p>",
			"<p>",	
			"<span class='help_string'>\"@\"</span>",
			"</p>",
			"<p>",						
			] 
},
{ :Subtitle => "LES CONDITIONS", 
			:Section => [
			"<p>",				
			"Affichez sur la sortie standard", 
			"</p>",
			"<p>",		
			"<font color='red'>le même résultat</font>",
			"</p>",
			"<p>",	
			"<font color='red'>en réduisant au maximum</font>",
			"</p>",
			"<p>",				
			"<font color='red'>le nombre de lignes de code</font>",
			"</p>"      
			] 
},
{ :Subtitle => "LES BOUCLES", 
			:Section => [
			"<p>",				
			"Déclarez une liste",
			"</p>",
			"<p>",	
			"<span class='help_variable'>nombres</span>",
			"</p>",
			"<p>",			
			"<font color='red'>Initialisez la à</font>",
			"</p>",
			"<p>",		
			"<span class='help_integer'>10, 11, 12, 13, 14, 15, 16, 17, 18, 19</span>",
			"</p>",
			"<p>",			
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>les nombres impairs</font>",
			"</p>",
			"<p>",				
			"<font color='red'>en utilisant l'index</font>",
			"</p>"      
			] 
},
{ :Subtitle => "LES BOUCLES", 
			:Section => [
			"<p>",						
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>les nombres impairs</font>",
			"</p>",
			"<p>",			
			"de la liste",
			"</p>",
			"<p>",			
			"<span class='help_variable'>nombres</span>",
			"</p>",			
			"<p>",				
			"<font color='red'>en N'utilisant PAS l'index</font>",
			"</p>"      
			] 
},
{ :Subtitle => "LES BLOCS", 
			:Section => [
			"<p>",						
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>les nombres impairs</font>",
			"</p>",
			"<p>",			
			"de la liste",
			"</p>",
			"<p>",			
			"<span class='help_variable'>nombres</span>",
			"</p>",			
			"<p>",				
			"<font color='red'>en utilisant NI l'index, NI l'instruction FOR</font>",
			"</p>"      
			]
},
{ :Subtitle => "LES BLOCS", 
			:Section => [
			"<p>",						
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>les nombres impairs</font>",
			"</p>",
			"<p>",			
			"de la liste",
			"</p>",
			"<p>",			
			"<span class='help_variable'>nombres</span>",
			"</p>",			
			"<p>",				
			"<font color='red'>en utilisant NI l'index, NI l'instruction FOR, NI EACH</font>",
			"</p>"      
			]
},
{ :Subtitle => "LES BLOCS", 
			:Section => [
			"<p>",						
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>le carré de chaque nombre</font>",
			"</p>",
			"<p>",			
			"de la liste",
			"</p>",
			"<p>",			
			"<span class='help_variable'>nombres</span>",
			"</p>",			
			"<p>",				
			"<font color='red'>en utilisant NI l'index, NI l'instruction FOR, NI EACH</font>",
			"</p>"      
			]
},
{ :Subtitle => "LES METHODES", 
			:Section => [
			"<p>",						
			"Affichez sur la sortie standard",
			"</p>",
			"<p>",				
			"<font color='red'>le carré de chaque nombre</font>",
			"</p>",
			"<p>",			
			"de la liste",
			"</p>",
			"<p>",			
			"<span class='help_variable'>nombres</span>",
			"</p>",
			"<p>",				
			"<font color='red'>en remplaçant le calcul du carré par une procédure</font>",
			"</p>",
			"<p>",	
			"<span class='help_variable'>carre_de(nombre)</span>",
			"</p>",
			] 
},
{ :Subtitle => "TDD", 
			:Section => [
			"#{ MIME_TYPE_PUZZLE}"
			],
			:Helper => [
			"<div class='code_to_add'> #{ TESTS } </div>",
			] 
},
{ :Subtitle => "REFACTORING",
			:Section => [
			"#{ MIME_TYPE_PUZZLE}"
			],
			:Helper => [
			"<div class='code_to_display'> #{ JAVA_CODE } </div>",
			"<div class='code_to_add'> #{ TESTS } </div>",
			] 
},
]

