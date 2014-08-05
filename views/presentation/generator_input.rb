#encoding: utf-8

require_relative 'generator_input_constants'

TITLE = 'INITIATION A RUBY'

$slides = []

require_relative 'slide_class'

require_relative 'connexion'
require_relative 'introduction'
require_relative 'les_chaines_de_caracteres'
require_relative 'les_variables'
require_relative 'les_entiers'
require_relative 'les_entiers_et_les_chaines_de_caracteres'
require_relative 'les_listes'
require_relative 'les_dictionnaires'
require_relative 'les_conditions'
require_relative 'les_boucles'
require_relative 'les_blocs'
require_relative 'les_methodes'
require_relative 'puzzle_mime_type'

SLIDES = $slides

