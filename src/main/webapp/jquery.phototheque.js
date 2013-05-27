;(function($){
    $.Phototheque = function(el, options){
        // To avoid scope issues, use 'base' instead of 'this'
        // to reference this class from internal events and functions.
        var base = this;
        
        // Access to jQuery and DOM versions of element
        base.$el = $(el);
        base.el = el;
        
        // Add a reverse reference to the DOM object
        base.$el.data("Phototheque", base);
        
        base.init = function(){
            base.options = $.extend({},$.Phototheque.defaultOptions, options);
            
            // Put your initialization code here
        };
        
        // Sample Function, Uncomment to use
        // base.functionName = function(paramaters){
        // 
        // };
        
        // Run initializer
        base.init();
    };
    
    $.Phototheque.defaultOptions = {
    };
    
    $.fn.phototheque = function(options){
        return this.each(function(){
            (new $.Phototheque(this, options));
        });
    };
    
    // This function breaks the chain, but returns
    // the Phototheque if it has been attached to the object.
    $.fn.getPhototheque = function(){
        this.data("Phototheque");
    };
    
})(jQuery);
