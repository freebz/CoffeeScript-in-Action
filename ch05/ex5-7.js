// Listing 5.7  CoffeeScript class, constructor, and method compilation

// JavaScript

var SteamShovel = (function() {
    function SteamShovel(name) {
	this.name = name;
    }
    SteamShovel.prototype.speak =
	function() {
	    return "Hurry up!"
	};
    return SteamShovel;
})();

gus = new SteamShovel();
gus.speak();
