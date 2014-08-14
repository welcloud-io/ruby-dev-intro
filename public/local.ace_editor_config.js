var code_editor = ace.edit(document.getElementById('code_input'));
Editor.prototype.updateWithText = function (code) { code_editor.setValue(code, -1); };
Editor.prototype.content = function () { return code_editor.getValue();  };
code_editor.setTheme('ace/theme/vibrant_ink');
code_editor.getSession().setMode('ace/mode/ruby');
code_editor.setFontSize('14px');
code_editor.getSession().setTabSize(2);
code_editor.getSession().setUseSoftTabs(true);