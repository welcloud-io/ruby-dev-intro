// ----------------------------------
// COMMON
// ----------------------------------

var LEFT_ARROW = 37;
var RIGHT_ARROW = 39;
var DOWN_ARROW = 40;
var UP_ARROW = 38;
var SPACE = 32;
var HOME = 36;

var SYNCHRONOUS = false;
var ASYNCHRONOUS = true;

var ALT = 18
var CTRL = 17
var F5 = 116
var R = 82
var S = 83

var SEPARATOR = '\n#{SEP}#\n'

var queryAll = function(node, query) {
  nodeList = node.querySelectorAll(query);
  return Array.prototype.slice.call(nodeList, 0);
};

var postResource = function(path, params, synchronous_asynchronous) {
  var xmlhttp = new XMLHttpRequest();	
  xmlhttp.open("POST", path, synchronous_asynchronous);
  xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  xmlhttp.send(params);	
  return xmlhttp.responseText;
};

var getResource = function(path) {
  var xmlhttp = new XMLHttpRequest();
  xmlhttp.open("GET", path, false);
  xmlhttp.send();
  return xmlhttp.responseText;
};

// ----------------------------------
// SLIDE CLASS
// ----------------------------------
var Slide = function(node) {
  this._node = node;
};


Slide.prototype = {

  _update: function() {
  },
  
  _isPollResultSlide: function() {
    return false;  
  },

  _isCodingSlide: function() {
    return false;
  },   

  setState: function(state) {
    this._node.className = 'slide' + ((state != '') ? (' ' + state) : '');
  },

};

// ----------------------------------
// POLL SLIDE CLASS
// ----------------------------------
var PollSlide = function(node) {
  Slide.call(this, node);
  this._node = node;
}

PollSlide.prototype = {
  _isPollResultSlide: function() {
    return this._node.querySelectorAll('.poll_response_rate').length > 0  
  },
  savePoll: function(elementId) {
    postResource('/'+elementId, '', ASYNCHRONOUS);
  },   
  _update: function() {
    rateNodes = this._node.querySelectorAll('.poll_response_rate')
    for (var i=0; i<rateNodes.length; i++) {
      rateNodeId = '#' + rateNodes[i].id;
      rateNodeValue = "(" + getResource('/' + rateNodes[i].id) + "%)"
      this._node.querySelector(rateNodeId).innerHTML = rateNodeValue;
    }
  },
}

for(key in Slide.prototype) {
  if (! PollSlide.prototype[key]) PollSlide.prototype[key] = Slide.prototype[key];
};

// ----------------------------------
// EDITOR
// ----------------------------------
var Editor = function(node) {
  this._node = node;
}

Editor.prototype = {
  content: function() {
    return this._node.value;
  },
  updateEditor: function(code) {
    this._node.value = code;  
  },
}

// ----------------------------------
// CODE HELPER (MINI-SLIDE)
// ----------------------------------
var CodeHelper = function(node) {
  this._node = node;
}

CodeHelper.prototype = {
  setState: function(state) {
    this._node.className = 'code_helper' + ((state != '') ? (' ' + state) : '');
  },  
  codeToAdd: function() {
    code = '';
    if (this._node.querySelector('.code_to_add') ) 
      code = SEPARATOR + this._node.querySelector('.code_to_add').innerHTML;
    return code.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&amp;/g, '&');
  }, 
  codeToDisplay: function() {
    code = '';
    if (this._node.querySelector('.code_to_display') ) 
      code = this._node.querySelector('.code_to_display').innerHTML;
    return code.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&amp;/g, '&');
  },  
}

// ----------------------------------
// CODE SLIDE EXTENDS SLIDE CLASS
// ----------------------------------
var CodeSlide = function(node) {
  Slide.call(this, node);
  
  this._codeHelpers = (queryAll(node, '.code_helper')).map(function(element) {
    return new CodeHelper(element); 
  });
  
  this._codeHelper_current_index = 0;
  this._declareEvents();
  this._editor = new Editor(this._node.querySelector('#code_input'));
};

CodeSlide.prototype = {
  _codeHelpers: [],
	
  _isCodingSlide: function() {
    return this._node.querySelector('#execute') != null;
  },
  
  _keyHandling: function(e) {
    if ( e.altKey ) { 
      if (e.which == R) { if ( ! this._node.querySelector('#execute').disabled == true ) { this.executeCode(); } }
      if (e.which == S) { this.executeAndSendCode(); }
    } else {
      e.stopPropagation()
    }    
  },
  
  _declareEvents: function() {  
    var _t = this;	  
    this._node.querySelector('#code_input').addEventListener('keydown',
      function(e) { _t._keyHandling(e) }, false
    );
    this._node.querySelector('#execute').addEventListener('click',
      function(e) { _t.executeCode(); }, false
    );     
    this._node.querySelector('#send_code').addEventListener('click',
      function(e) { _t.executeAndSendCode(); }, false
    );       
  },  

  _update: function(slide_index) {
    this.showCurrentCodeHelper(slide_index);
    this.updateEditorAndExecuteCode();
  },
  
  _clearCodeHelpers: function() {
    for (var i=0; i<this._codeHelpers.length; i++) {
      this._codeHelpers[i].setState('');
    }
  }, 

  _currentCodeHelper: function() {
    return this._codeHelpers[this._codeHelper_current_index]
  },   
  
  showCurrentCodeHelper: function(slide_index) {
    if (this._codeHelpers.length == 0) return;
    this._clearCodeHelpers();
    this._codeHelpers[slide_index].setState('current');
    this._codeHelper_current_index = slide_index;    	  
  },  
  
  codeToExecute: function() {
    return this._editor.content() + this._currentCodeHelper().codeToAdd();
  },	  

  executeCode: function() {
    run_url = "/code_run_result" + "/" + this._codeHelper_current_index;
    this._node.querySelector('#code_output').value = postResource(run_url , this.codeToExecute(), SYNCHRONOUS);
  },
  
  executeAndSendCode: function() {
    send_url = "/code_send_result" + "/" + this._codeHelper_current_index;
    this._node.querySelector('#code_output').value = postResource(send_url, this.codeToExecute(), SYNCHRONOUS);
  }, 
  
  lastSend: function() {
    return getResource('/code_last_send' + '/' + this._codeHelper_current_index);
  },
  
  lastSendOrCodeToDisplay: function() {
    lastSend = this.lastSend().split(SEPARATOR)[0];
    if (lastSend != '') { return lastSend }
    return this._currentCodeHelper().codeToDisplay();
  },
  
  updateEditorAndExecuteCode: function() {
    lastSendOrCodeToDisplay = this.lastSendOrCodeToDisplay();
    if (lastSendOrCodeToDisplay == '' && this._currentCodeHelper().codeToAdd() == '') return;
    this._editor.updateEditor(lastSendOrCodeToDisplay);
    this.executeCode();	  
  }, 
  
};

for(key in Slide.prototype) {
  if (! CodeSlide.prototype[key]) CodeSlide.prototype[key] = Slide.prototype[key];
};


// ----------------------------------
// SLIDESHOW CLASS
// ----------------------------------  
var SlideShow = function(slides) {
  this._slides = (slides).map(function(element) { 
	  if (element.querySelector('#execute') != null) { return new CodeSlide(element); };
	  if (element.querySelector('.poll_response_rate') != null) { return new PollSlide(element); };
    return new Slide(element); 
  });
  this._numberOfSlides = this._slides.length;
  this._currentSlide = this._slides[this._currentIndex];

  var _t = this;
  document.addEventListener('keydown', function(e) { _t.handleKeys(e); }, false );   

  this._getCurrentIndexOnServer();
  this._refresh();  
};



SlideShow.prototype = {
  _slides : [],
  _currentIndex : 0,
  _currentSlide : undefined, 
  _currentServerIndex : 0,
  _numberOfSlides : 0,
  _showIDE : false,


  _clear: function() {
    for(var slideIndex in this._slides) { this._slides[slideIndex].setState('') }
  },
  
  _show_current_slide: function() {
    if (this._slides[this._currentIndex]) this._currentSlide = this._slides[this._currentIndex];
    this._clear();	    
    this._currentSlide.setState('current');
  },

  _last_slide:function() {
    return this._slides[this._numberOfSlides-1]
  },  
  
  _show_teacher_coding_slide: function() {
    this._clear();
    this._currentSlide = this._last_slide();	  
    this._currentSlide.setState('current');
  },

  _is_a_number: function(index) {
    return  !( isNaN(index) );
  },
  
  _getCurrentIndexOnServer: function() {
    serverIndex = parseInt(getResource('/teacher_current_slide'));
    if ( this._is_a_number(serverIndex) ) this._currentIndex = serverIndex;	  
  },    

  _postCurrentIndexOnServer: function() {
    postResource('/teacher_current_slide', 'index=' + this._currentIndex, ASYNCHRONOUS);  
  },
  
  _refresh: function() {
    if (this._slides.length == 0) return
    if (this._showIDE) 
      this._show_teacher_coding_slide();
    else
      this._show_current_slide();
    this._currentSlide._update(this._currentIndex);
    window.console && window.console.log("Refreshed with this._currentIndex = " + this._currentIndex);
  }, 

  prev: function() {
    if (this._currentIndex <= 0) return;
    this._currentIndex -= 1;
    this._refresh();	  
    this._postCurrentIndexOnServer();
  },

  next: function() {
    if (this._currentIndex >= (this._numberOfSlides - 1) ) return;
    if (this._slides[this._currentIndex+1] && this._slides[this._currentIndex+1]._isCodingSlide()) return;
    this._currentIndex += 1;		  
    this._refresh();
    this._postCurrentIndexOnServer();
  },
  
  down: function() {
    if (! this._last_slide()._isCodingSlide()) return;    
    this._showIDE = true;
    this._refresh();  
  },
  
  up: function() {
    this._showIDE = false;	  
    this._refresh();
  },
  
  synchronise: function() {
    previous_index = this._currentIndex
    this._getCurrentIndexOnServer();
    if (this._currentIndex != previous_index) this._refresh();  
   },
  
};
