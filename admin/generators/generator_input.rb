#encoding: utf-8

STYLE =
%Q{
.slide {
background-color: #fff;
}
section {
margin-left: 1%;
margin-right: 1%;
margin-bottom: 1%;
}
.code_result {
background-color: #332;      
color: yellow;      
}
.code_helper.current {
background-color: #fff;
}
div.slide > h2 {
color: #ffffff;
background-color: orange;
}
div.code_helper > h2 {  
color: #ffffff;
background-color: orange;
}
}

MIME_TYPE_PUZZLE =
%Q{
Le type MIME est utilisé dans de nombreux protocoles internet pour associer un type de média (html, image, vidéo, ...) avec le contenu envoyé.
</br>   
Ce type MIME est généralement déduit de l'extension du fichier à transférer.
</br>
Vous devez écrire un programme qui permet de détecter le type MIME d'un fichier à partir de son nom.
</br>      
Une table qui associe un type MIME avec une extension de fichier vous est fournie. Une liste de noms de fichier à transférer vous sera aussi fournie et vous devrez déduire pour chacun d'eux, le type MIME à utiliser.
</br>
L'extension d'un fichier se définit par la partie du nom qui se trouve après le dernier point qui le compose.
</br>
Si l'extension du fichier est présente dans la table d'association (la casse ne compte pas. ex : TXT est équivalent à txt), alors affichez le type MIME correspondant . S'il n'est pas possible de trouver le type MIME associé à un fichier, ou si le fichier n'a pas d'extensions, affichez UNKNOWN.       
</br>
EXEMPLE :
Entrée
html text/html
png image/png
test.html
noextension
portrait.png
doc.TXT
Sortie
text/html
UNKNOWN
image/png
UNKNOWN
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

  def test01_should_find_an_empty_list

    extension_hash = { 
    }
    file_list = [
    ]
    assert_equal [
    ], mime_types(extension_hash, file_list)
    
  end

  def test02_should_find_one_mime_type

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

  def test03_should_find_one_UNKNOWN_mime_types

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
  
  def test04_should_find_two_mime_types

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
	
  def test10_should_find_three_mime_types
    extension_hash = {
    "html" =>  "text/html", 
    "png" => "image/png", 
    "gif" => "image/gif" 
    }
    file_list = [
    "animated.gif", 
    "portrait.png", 
    "index.html"
    ]
    assert_equal  [
    "image/gif", 
    "image/png", 
    "text/html"
    ], mime_types(extension_hash, file_list)
  end
  
  def test12_should_not_find_any_mime_type

    extension_hash = {
    "txt" => "text/plain", 
    "xml" =>  "text/xml", 
    "flv" => "video/x-flv" 
    }
    file_list = [
    "image.png", 
    "animated.gif", 
    "script.js", 
    "source.cpp"
    ]
    assert_equal  [
    "UNKNOWN", 
    "UNKNOWN", 
    "UNKNOWN", 
    "UNKNOWN"
    ], mime_types(extension_hash, file_list)

  end
  
  def test13_should_find_unknown_mime_types_if_wierd_extensions
    extension_hash = { 
    "wav" => "audio/x-wav", 
    "mp3" => "audio/mpeg", 
    "pdf" => "application/pdf" 
    }
    file_list = ["a", 
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

  def test14_should_not_care_about_case

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

CONNEXION_SLIDE = "
<h3 style='text-align:center'>INTRODUCTION A RUBY</h3>
<h3 style='color: red; text-align:center'>CONNECTEZ VOUS SUR :</h3>
<h4 style='color: blue; font-size: 1.3em; text-align:center'>http://ruby-dev-intro.herokuapp.com</h4>
"

TITLE = 'INITIATION A RUBY'    
SLIDES = [
{			:Section => [
			"<h3 style='text-align:center'>INTRODUCTION A RUBY</h3>",
			"<h3 style='color: red; text-align:center'>CONNECTEZ VOUS SUR :</h3>",
			"<h4 style='color: blue; font-size: 1.3em; text-align:center'>http://ruby-dev-intro.herokuapp.com</h4>",
			'<div class="code_to_display"> puts "Connexion ok, Bienvenue"</div>',
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
			"</br>",			
			"Affichez sur la sortie standard", 
			"</br></br>",
			"<font color='blue'>BIENVENUE A L'INITIATION RUBY</font>"
			] 
},
{ :Subtitle => "LES CHAINES DE CARACTERES", 
			:Section => [
			"</br>",				
			"Affichez sur la sortie standard",
			"</br></br>",			
			"<font color='red'>la 1ère lettre de la phrase</font>", 
			"</br></br>",			
			"<font color='blue'>\"BIENVENUE A L'INITIATION RUBY\"</font>"
			] 
},
{ :Subtitle => "LES CHAINES DE CARACTERES", 
			:Section => [
			"</br>",	
			"Affichez sur la sortie standard", 
			"</br></br>",				
			"<font color='red'>la 5ème lettre de la phrase</font>", 
			"</br></br>",				
			"<font color='blue'>\"BIENVENUE A L'INITIATION RUBY\"</font>"
			] 
},
{ :Subtitle => "LES CHAINES DE CARACTERES", 
			:Section => [
			"</br>",	
			"Affichez sur la sortie standard",
			"</br></br>",				
			"<font color='red'>la dernière lettre de la phrase</font>", 
			"</br></br>",				
			"<font color='blue'>\"BIENVENUE A L'INITIATION RUBY\"</font>"
			] 
},
{ :Subtitle => "LES CHAINES DE CARACTERES", 
			:Section => [
			"</br>",	
			"Affichez sur la sortie standard",
			"</br></br>",	
			"<font color='red'>les 4 premières lettres de la phrase</font>",
			"</br></br>",				
			"<font color='blue'>\"BIENVENUE A L'INITIATION RUBY\"</font>"
			] 
},
{ :Subtitle => "LES CHAINES DE CARACTERES", 
			:Section => [
			"</br>",	
			"Affichez sur la sortie standard", 
			"</br></br>",				
			"<font color='red'>La taille en de nombre de caractères de la phrase</font>",
			"</br></br>",				
			"<font color='blue'>\"BIENVENUE A L'INITIATION RUBY\"</font>"
			] 
},
{ :Subtitle => "LES VARIABLES", 
			:Section => [
			"</br>",				
			"<font color='red'>Déclarez une variable</font>", 
			"</br></br>",				
			"<font color='green'>chaine_de_caracteres</font>",
			"</br></br>",				
			"<font color='red'>initialisez la avec le mot", 
			"</br></br>",				
			"<font color='brown'>\"RUBY\"</font>",
			"</br></br>",				
			"affichez la sur la sortie standard"
			] 
},
{ :Subtitle => "LES VARIABLES", 
			:Section => [
			"</br>",				
			"Affichez sur la sortie standard",
			"</br></br>",				
			"<font color='red'>la classe de la variable</font>", 
			"</br></br>",			
			"<font color='green'>chaine_de_caracteres</font>",
			] 
},
{ :Subtitle => "LES VARIABLES", 
			:Section => [
			"</br>",				
			"Affichez sur la sortie standard",
			"</br></br>",				
			"<font color='red'>les méthodes de la variable</font>",
			"</br></br>", 			
			"<font color='green'>chaine_de_caracteres</font>",
			] 
},
{ :Subtitle => "LES ENTIERS", 
			:Section => [
			"</br>",				
			"<font color='red'>Déclarez la variable</font>",
			"</br></br>",				
			"<font color='green'>un_entier</font>",
			"</br></br>",			
			"<font color='red'>initialisez la avec valeur -12</font>",
			"affichez la sur la sortie standard"
			] 
},
{ :Subtitle => "LES ENTIERS", 
			:Section => [
			"</br>",				
			"Affichez sur la sortie standard", 
			"</br></br>",				
			"<font color='red'>la classe de la variable</font>",
			"</br></br>", 			
			"<font color='green'>un_entier</font>",
			"</br></br>",
			"Affichez sur la sur la sortie standard",
			] 
},
{ :Subtitle => "LES ENTIERS", 
			:Section => [
			"</br>",
			"Affichez sur la sur la sortie standard",
			"</br></br>",			
			"<font color='red'>la valeur absolue de la variable</font>",
			"</br></br>",			
			"<font color='green'>un_entier</font>"
			] 
},
{ :Subtitle => "LES ENTIERS", 
			:Section => [
			"</br>",				
			"Affichez sur la sur la sortie standard",
			"</br></br>",				
			"<font color='red'>le nombre de secondes dans une année de 365 jours</font>"
			] 
},
{ :Subtitle => "COMPOSITION ENTIER et CHAINES DE CARACTERES", 
			:Section => [
			"</br>",				
			"Affichez sur la sur la sortie standard, la phrase ",
			"</br></br>",				
			"<font color='blue'>En 2014 il y aura ** secondes</font>",
			"</br></br>",			
			"<font color='red'>** représente le nombre de secondes en chiffres</font>"
			] 
},
{ :Subtitle => "COMPOSITION ENTIER et CHAINES DE CARACTERES", 
			:Section => [
			"</br>",				
			"Affichez sur la sur la sortie standard",
			"</br></br>",				
			"<font color='red'>15 fois de suite la chaine de caractère</font>", 
			"</br></br>",			
			"<font color='blue'>'Ruby !'</font>"
			] 
},
{ :Subtitle => "LES LISTES", 
			:Section => [
			"</br>",				
			"Déclarez une variable",
			"</br></br>",				
			"<font color='green'>cinq_chiffres_romains</font>",
			"</br></br>",			
			"<font color='red'>Intialisez là avec 'I', 'II', 'III', 'IV', 'V'</font>",
			"</br></br>",				
			"Affichez la sur le sortie standard",
			] 
},
{ :Subtitle => "LES LISTES", 
			:Section => [
			"</br>",				
			"Affichez sur le sortie standard",
			"</br></br>",				
			"<font color='red'>Le chiffre romain correspondant au chiffre décimal 3</font>"
			] 
},
{ :Subtitle => "LES LISTES", 
			:Section => [
			"</br>",				
			"Affichez sur le sortie standard",
			"</br></br>",				
			"<font color='red'>le chiffre romain correspondant à l'addition 3 + 2</font>"
			] 
},
{ :Subtitle => "LES LISTES", 
			:Section => [
			"</br>",				
			"Affichez sur le sortie standard",
			"</br></br>",				
			"<font color='red'>le chiffre décimal correspondant au chiffre romain 'IV'</font>"
			] 
},
{ :Subtitle => "LES DICTIONNAIRES", 
			:Section => [
			"</br>",				
			"Déclarez une variable",
			"</br></br>",	
			"<font color='green'>types_de_contenu_par_type_de_fichier</font>",
			"</br></br>",			
			"<font color='red'>Initialisez la avec (mp3: 'audio', ...)</font>",
			"</br></br>",			
			"Affichez là sur la sortie standard"
			] 
},
{ :Subtitle => "LES CONDITIONS", 
			:Section => [
			"</br>",				
			"Déclarez une variable", 
			"</br></br>",			
			"<font color='green'>age</font>",
			"</br></br>",				
			"<font color='red'>initialisez la à</font>",
			"</br></br>",	
			"<font color='brown'>5</font>",
			"</br></br>",				
			"<font color='red'>Affichez 'MINEUR' si  age inférieur à 18 et 'MAJEUR' sinon</font>",
			"</br></br>",				
			"<font color='red'>Modifier la variable et donnez lui la valeur 34</font>",
			"</br></br>",				
			"Affichez là sur la sortie standard"
			] 
},
{ :Subtitle => "LES CONDITIONS", 
			:Section => [
			"</br>",				
			"Déclarez une variable",
			"</br></br>",					
			"<font color='green'>age</font>",			
			"</br></br>",				
			"<font color='red'>initialisez la à</font>",
			"</br></br>",	
			"<font color='brown'>5</font>",			
			"</br></br>",				
			"<font color='red'>Affichez 'MINEUR' si age inférieur à 18 sinon ne rien afficher</font>",
			] 
},
{ :Subtitle => "LES CONDITIONS", 
			:Section => [
			"</br>",				
			"Déclarez une variable",
			"</br></br>",					
			"<font color='green'>age</font>",			
			"</br></br>",					
			"<font color='red'>initialisez la à</font>",
			"</br></br>",	
			"<font color='brown'>5</font>",
			"</br></br>",			
			"<font color='red'>Affichez 'MINEUR' sauf si age supérieur égal à 18</font>",
			"</br></br>",					
			"<font color='red'>Affichez là sur la sortie standard</font>",
			] 
},
{ :Subtitle => "LES CONDITIONS", 
			:Section => [
			"</br>",				
			"Déclarez une variable", 
			"</br></br>",				
			"<font color='green'>ages</font>",
			"</br></br>",				
			"<font color='red'>initialisez la à </font>",
			"</br></br>",			
			"<font color='brown'>1, 2, 3, 4, 5</font>",
			"</br></br>",			
			"<font color='red'>Déclarez une variable</font>", 
			"</br></br>",				
			"<font color='green'>index</font>",
			"</br></br>",				
			"<font color='red'>Intialisez la à</font>",
			"</br></br>",			
			"<font color='brown'>0</font>",
			"</br></br>",			
			"<font color='red'>Affichez 'OK' si ages[index] existe, 'KO' sinon</font>",
			] 
},
{ :Subtitle => "LES BOUCLES", 
			:Section => [
			"</br>",				
			"Déclarez une variable",
			"</br></br>",	
			"<font color='green'>chiffres</font>",
			"</br></br>",			
			"<font color='red'>Initialisez la à</font>",
			"</br></br>",		
			"<font color='brown'>0, 1, 2, 3, 4, 5, 6, 7, 8, 9</font>",
			"</br></br>",			
			"<font color='red'>Affichez les nombres impairs en utilisant l'index</font>",
			] 
},
{ :Subtitle => "LES BOUCLES", 
			:Section => [
			"</br>",				
			"Déclarez une variable",
			"</br></br>",	
			"<font color='green'>chiffres</font>",
			"</br></br>",			
			"<font color='red'>Initialisez la à</font>",
			"</br></br>",		
			"<font color='brown'>0, 1, 2, 3, 4, 5, 6, 7, 8, 9</font>",
			"</br></br>",			
			"<font color='red'>Affichez les nombres impairs sans utiliser d'index</font>",
			] 
},
{ :Subtitle => "LES BOUCLES", 
			:Section => [
			"</br>",				
			"Déclarez une variable",
			"</br></br>",	
			"<font color='green'>chiffres</font>",
			"</br></br>",				
			"<font color='red'>Initialisez la à</font>",
			"</br></br>",		
			"<font color='brown'>0, 1, 2, 3, 4, 5, 6, 7, 8, 9</font>",
			"</br></br>",				
			"<font color='red'>Affichez les nombres impairs sans utiliser d'index, ni l'instruction for</font>",
			] 
},
{ :Subtitle => "LES BOUCLES", 
			:Section => [
			"</br>",				
			"Déclarez une variable",
			"</br></br>",				
			"<font color='green'>chiffres</font>",
			"</br></br>",				
			"<font color='red'>Initialisez la à</font>",
			"</br></br>",		
			"<font color='brown'>0, 1, 2, 3, 4, 5, 6, 7, 8, 9</font>",
			"</br></br>",			
			"<font color='red'>Afficher les chiffres impairs sans utiliser 'each'</font>",
			] 
},
{ :Subtitle => "LES BOUCLES", 
			:Section => [
			"</br>",				
			"Déclarez une variable",
			"</br></br>",				
			"<font color='green'>chiffres</font>",
			"</br></br>",				
			"<font color='red'>Initialisez la à</font>",
			"</br></br>",		
			"<font color='brown'>0, 1, 2, 3, 4, 5, 6, 7, 8, 9</font>",
			"</br></br>",			
			"<font color='red'>Affichez le carré de chaque chiffre sans utiliser 'each'</font>",
			] 
},
{ :Subtitle => "LES BOUCLES", 
			:Section => [
			"</br>",				
			"Déclarez une variable",  
			"</br></br>",				
			"<font color='green'>chiffres</font>",
			"</br></br>",				
			"<font color='red'>Initialisez la à</font>",
			"</br></br>",		
			"<font color='brown'>0, 1, 2, 3, 4, 5, 6, 7, 8, 9</font>",
			"</br></br>",			
			"<font color='red'>Définissez la methode carre_de(x)</font>",
			"</br></br>",				
			"<font color='red'>Afficher le carre de chaque chiffre</font>",
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

