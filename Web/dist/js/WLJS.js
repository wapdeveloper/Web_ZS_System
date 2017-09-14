/**
 * 时间：(2015-05-20)
 * 说明：公共库
 * 编写人：wl
 */
 
/**
 * 打印类
 */
(function () { // encapsulate

	if(!window['WLJS']) { 
		window['WLJS']= {}; 
	}
	
	/**
	 * Retrieve an array of element base on a class name
	 */
	function getElementsByClassName(className, tag, parent){
		parent = parent || document;
		if(!(parent = $(parent))) return false;
		
		// Locate all the matching tags
		var allTags = (tag == "*" && parent.all) ? parent.all : parent.getElementsByTagName(tag);
		var matchingElements = new Array();
		
		// Create a regular expression to determine if the className is correct
		className = className.replace(/\-/g, "\\-");
		var regex = new RegExp("(^|\\s)" + className + "(\\s|$)");
		
		var element;
		// Check each element
		for(var i=0; i<allTags.length; i++){
			element = allTags[i];
			if(regex.test(element.className)){
				matchingElements.push(element);
			}
		}
		
		// Return any matching elements
		return matchingElements;
	};
	
	window['WLJS']['getElementsByClassName'] = getElementsByClassName;

})();
