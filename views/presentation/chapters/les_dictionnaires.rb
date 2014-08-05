#encoding: utf-8

SCRABBLE = "
points_au_scrabble = {
'a'=>1,'b'=>3,'c'=>3,'d'=>2,'e'=>1,'f'=>4,'g'=>2,'h'=>4,
'i'=>1,'j'=>8,'k'=>5,'l'=>1,'m'=>3,'n'=>1,'o'=>1,'p'=>3,
'q'=>10,'r'=>1,'s'=>1,'t'=>1,'u'=>1,'v'=>4,'w'=>4,'x'=>8,
'y'=>4,'z'=>10
}
"
subtitle = "LES DICTIONNAIRES (HASHES)"

hash_initial_value = "
  <div>
    <span class='help_string'>\"a\" <span class='help_variable'>=></span> <span class='help_integer'>1,</span>
  </div>
  <div>
    <span class='help_string'>\"b\" <span class='help_variable'>=></span> <span class='help_integer'>3,</span>
  </div>
  <div>
    <span class='help_string'>\"c\" <span class='help_variable'>=></span> <span class='help_integer'>3,</span>
  </div>
  <div>
    <span class='help_string'>\"d\" <span class='help_variable'>=></span> <span class='help_integer'>2,</span>
  </div>
  <div>  
    <span class='help_string'>\"e\" <span class='help_variable'>=></span> <span class='help_integer'>1,</span>
  </div>
"

$slides += [
Slide.new( 
  :subtitle => subtitle, 
  :section_p => [
  "Déclarez une variable",
  "<span class='help_variable'>points_au_scrabble</span>",		
  "Initialisez la avec",
  hash_initial_value,
  "Affichez là sur la sortie standard",      
  ] 
),
Slide.new(
  :subtitle => subtitle, 
  :section_p => [
  "Afficher sur la sortie standard",				
  "<font color='red'>les <b>clés</b> du dictionnaire</font>",
  "<span class='help_variable'>points_au_scrabble</span>",
  ] 
),
Slide.new(
  :subtitle => subtitle, 
  :section_p => [
  "Afficher sur la sortie standard",			
  "<font color='red'>les <b>valeurs</b> contenues dans le dictionnaire</font>",
  "<span class='help_variable'>points_au_scrabble</span>",
  ] 
),
Slide.new(
  :subtitle => subtitle, 
  :section_p => [
  "Afficher sur la sortie standard",
  "<font color='red'>le nombre de points de la lettre</font>",
  "<span class='help_string'>\"d\"</span>",
  ] 
),
Slide.new(
  :subtitle => subtitle, 
  :section_p => [	
  "Afficher sur la sortie standard",
  "<font color='red'>le nombre de points du mot</font>",
  "<span class='help_string'>\"ruby\"</span>",
  ],
  :code_to_display => SCRABBLE
),
Slide.new(
  :subtitle => subtitle, 
  :section_p => [	
  "Afficher sur la sortie standard",
  "<font color='red'>le nombre de points du symbol</font>",
  "<span class='help_string'>\"@\"</span>",
  ],
),
]