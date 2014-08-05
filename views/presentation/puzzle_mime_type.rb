#encoding: utf-8

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

$slides += [
Slide.new(
  :subtitle => "TDD", 
  :section => [
    "#{ MIME_TYPE_PUZZLE}"
  ],
  :code_to_add => TESTS
),
Slide.new(
  :subtitle => "REFACTORING",
  :section => [
    "#{ MIME_TYPE_PUZZLE}"
  ],
  :code_to_display => JAVA_CODE,
  :code_to_add => TESTS
),
]