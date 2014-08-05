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
Editor.prototype.updateWithText = function (code) { code_editor.setValue(code, -1); };
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