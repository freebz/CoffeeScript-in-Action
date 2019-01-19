// Listing 5.6  CoffeeScript class and compliation to JavaScript

// JavaScript

var Simple = (function() {
  function Simple() {
    this.name = 'simple';
  }
  return Simple;
})();

simple = new Simple();
