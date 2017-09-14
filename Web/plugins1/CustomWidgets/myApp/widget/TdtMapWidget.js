define("myApp/widget/TdtMapWidget", [
	"dojo/_base/declare",
	"dijit/_WidgetBase",
	"dijit/_TemplatedMixin",
	"dojo/text!./templates/TdtMapWidget.html",
	"dojo/dom",
	"dojo/dom-style",
	"dojo/_base/fx",
	"dojo/_base/lang",
	"dojo/on",
	"dojo/mouse",
	"require" // context-sensitive require to get URLs to resources from relative paths
], function(declare, _WidgetBase, _TemplatedMixin, template, dom, domStyle, baseFx, lang, on, mouse, require){
        var _TdtMapWidget = declare("myApp/widget/TdtMapWidget", [_WidgetBase, _TemplatedMixin], {
            // Some default values for our author
			// These typically map to whatever you're handing into the constructor
			title: "地图",
			
			name: "defaultType", 
			
			// Using require.toUrl, we can get a URL to our default avatar image
			thumbs: require.toUrl("./images/defaultMapType.png"),

			// Our template - important!
			templateString: template,

			// A class to be applied to the root node in our template
			baseClass: "mapType",
			
			options:{
				map:null,
				extent:null,
				visible: true,
				name: 'asdasd'
			},
			
			visible: true,
			
			constructor:function(args, divContainer){
				
				var options = lang.mixin(this.options, args);
				//lang.mixin(this, args);
				
				//alert(options.name)
				
				this.domNode = divContainer;
				
				this.watch("visible",this._visible);
				
			},
			
			_css: {
				'basemapContainer' : 'basemapContainer',
				'toggleButton' : 'toggleButton',
				'basemapImage' : 'basemapImage',
				'basemapTitle' : 'basemapTitle'
			},
			
			_333333333currentType: null,
			
			_mapTypes: {
				'vector': {
					"name": "vectorType",
					"title": "地图",
					"thumbs": "./images/vectorType.png"
				},
				'image': {
					"name": "imageType",
					"title": "影像",
					"thumbs": "./images/imageType.png"
				}
			},
			
			// A reference to our background animation
			mouseAnim: null,

			// Colors for our background animation
			baseBackgroundColor: "#fff",
			mouseBackgroundColor: "#def",
			imageBasePath: './images',

			// postCreate is called once our widget's DOM is ready,
			// but BEFORE it's been inserted into the page!
			// This is far and away the best point to put in any special work.
			postCreate: function(){
				// Get a DOM node reference for the root of our widget
				var domNode = this.domNode;
					
				// Run any parent postCreate processes - can be done at any point
				this.inherited(arguments);
				
				// Set our DOM node's background color to white -
				// smoothes out the mouseenter/leave event animations
				domStyle.set(domNode, "backgroundColor", this.baseBackgroundColor);
				// Set up our mouseenter/leave events
				// Using dijit/Destroyable's "own" method ensures that event handlers are unregistered when the widget is destroyed
				// Using dojo/mouse normalizes the non-standard mouseenter/leave events across browsers
				// Passing a third parameter to lang.hitch allows us to specify not only the context,
				// but also the first parameter passed to _changeBackground
				this.own(
					on(domNode, mouse.enter, lang.hitch(this, "_changeBackground", this.mouseBackgroundColor)),
					on(domNode, mouse.leave, lang.hitch(this, "_changeBackground", this.baseBackgroundColor)),
					on(domNode, "click", lang.hitch(this, "_changeMapType", ""))
				);
				
				//this.basemapImgNode.src = this.thumbs;
				//this.basemapImgNode.alt = this.name;
			},

			// This method is automatically invoked anytime anyone calls
			// myWidget.set('avatar', someValue)
			_setThumbsAttr: function(imagePath) {
				// We only want to set it if it's a non-empty string
				if (imagePath) {
					// Save it on our widget instance - note that
					// we're using _set, to support anyone using
					// our widget's Watch functionality, to watch values change
					this._set("thumbs", imagePath);

					imgUrl =  require.toUrl(imagePath);
					
					// Using our avatarNode attach point, set its src value
					this.basemapImgNode.src = imgUrl;
					this.basemapImgNode.alt = this.name;
				}
			},
			
			_changeBackground: function(newColor) {
				// If we have an animation, stop it
				if (this.mouseAnim) {
					this.mouseAnim.stop();
				}

				// Set up the new animation
				this.mouseAnim = baseFx.animateProperty({
					node: this.domNode,
					properties: {
						backgroundColor: newColor
					},
					onEnd: lang.hitch(this, function() {
						// Clean up our mouseAnim property
						this.mouseAnim = null;
					})
				}).play();
			},
			
			_changeMapType: function() {
				// If we have an animation, stop it
				var maptype = this.basemapImgNode.alt;
				if (maptype) {
					//this.basemapImgNode.src = this.thumbs;
					//this.basemapImgNode.alt = this.name;
					
					//this.set("visible", false);
					alert(this.options.name);
				}
			},
			
			_visible:function(){
				//this.get("visible") ? dom.set(this.domNode,"display","block") : dom.set(this.domNode,"display","none");
				if(this.get("visible")){
					 domStyle.set(this.domNode,"display","block");

						console.log("this node is visible");
				}
				else{
					domStyle.set(this.domNode,"display","none");

						console.log("this node is not visible");
				}
			}
			
			});
		
		return _TdtMapWidget;
    });