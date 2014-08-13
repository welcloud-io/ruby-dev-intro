preventDefaultKeys = function(e) {
  if (e.keyCode == F5) e.preventDefault();
  //~ if (e.keyCode == BACK_SPACE) e.preventDefault();    
  if (e.ctrlKey && e.which == R) e.preventDefault();
}