define("myApp/widget/TdtMapToggle", [
	"dojo/_base/declare",
	"dijit/_WidgetBase",
	"dijit/_TemplatedMixin",
	"dojo/text!./templates/TdtMapToggle.html",
	"dojo/dom",
	"dojo/dom-style",
	"dojo/_base/fx",
	"dojo/_base/lang",
	"dojo/on",
	"dojo/mouse",
	"dojo/query",
	"require" // context-sensitive require to get URLs to resources from relative paths
], function(declare, _WidgetBase, _TemplatedMixin, template, dom, domStyle, baseFx, lang, on, mouse, query, require){
        var _TdtMapWidget = declare("myApp/widget/TdtMapToggle", [_WidgetBase, _TemplatedMixin], {
            // Some default values for our author
			// These typically map to whatever you're handing into the constructor

			title: "切换地图",
			
			// Our template - important!
			templateString: template,

			// A class to be applied to the root node in our template
			baseClass: "mapType",
			
			basemap: "tdtImageMap",
			
			defaultBasemap:"tdtVectorMap",
			
			options:{
				map: null,
				visible: true,
				name: 'asdasd',
				basemap: "tdtImageMap"
			},
			
			visible: true,
			
			constructor:function(args, divContainer){
				
				var options = lang.mixin(this.options, args);
				//lang.mixin(this, args);			
					
				//alert(this.options.map.layers);
				this.set("map",options.map);
				this.set("visible",options.visible);
				this.set("name",options.name);
				this.set("basemap",options.basemap);
				
				this.domNode = divContainer;
									
				this.watch("visible",this._visible);		
			},
			
			_css: {
				'basemapContainer' : 'basemapContainer',
				'toggleButton' : 'toggleButton',
				'basemapImage' : 'basemapImage',
				'basemapTitle' : 'basemapTitle'
			},
			
			
			tdtMaps: {
				'tdtVectorMap': {
					"name": "tdtVectorMap",
					"next": "tdtImageMap",
					"title": "地图",
					"thumbs": require.toUrl("./images/vectorType.png")
				},
				'tdtImageMap': {
					"name": "tdtImageMap",
					"next": "tdtVectorMap",
					"title": "影像",
					"thumbs": require.toUrl("./images/imageType.png")
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
					
				var vectorToggleNode = this._vectorToggleNode;
				
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
					on(vectorToggleNode, mouse.enter, lang.hitch(this, "_changeBackground", this.mouseBackgroundColor, vectorToggleNode)),
					on(vectorToggleNode, mouse.leave, lang.hitch(this, "_changeBackground", this.baseBackgroundColor, vectorToggleNode)),
				
					on(vectorToggleNode, "click", lang.hitch(this, "toggle", vectorToggleNode))
				);
				
			},

			startup: function(){
						
				if(!this.map){
					this.destroy();
					console.log("BasemapToggle::map required");
					return;
				};
				
				if(this.map.loaded){
					this._init();					
				}
				else {
					on.once(this.map,"load",lang.hitch(this,function(){this._init()}))				
				}			
			},
			
			destroy: function(){
				this.inherited(arguments)
			},
			
			toggle: function(vectorToggleNode) {
				
				var maptype = this.get("defaultBasemap"), 
					basemap =  this.get("basemap"),
					mapStatus =  {'previousBasemap': maptype, 'currentBasemap': basemap};
					
				//alert(maptype +" " +basemap);
				if(maptype !== basemap){
					//this.map.setBasemap(basemap);
					//this.set("basemap",maptype);
					//this._basemapChange();
					
					
					this.set("defaultBasemap", basemap);//basemap为当前地图类型
					this.set("basemap",maptype); //地图切换，图标对应下一地图
					
					this._tdtmapChange(basemap, maptype);
					
					//alert(this.get("defaultBasemap"));				
				}else{
					mapStatus.error=Error("BasemapToggle::Current basemap is same as new basemap");
				}
				
				this.emit("toggle",mapStatus);
			},
			
			_init: function(){
				this._visible();
				alert(defaultBasemap);
				this._tdtmapChange(defaultBasemap, basemap);
				//on(this.map, "basemap-change",f.hitch(this,function(){this._basemapChange()}));
				//this.set("loaded",true);
				//this.emit("load",{})
			},
			
			_updateImage:function(){
				var basemap =  this.get("basemap"),
					tdtmap = this.tdtMaps[basemap];
					
				this.basemapImgNode.src = tdtmap.thumbs;
				this.basemapImgNode.alt = tdtmap.name;
				this.basemapTitleNode.innerHTML = tdtmap.title;
			},
			
			_tdtmapChange: function(showlayer, hidelayer){						
				//alert("地图切换为:"+ showlayer +"，隐藏： " + hidelayer);
				
				this._findLayers(showlayer, hidelayer);
				this._updateImage();
			},
			
			_findLayers: function (showlayer, hidelayer) {
				var map = this.map;
				var ids = map.layerIds;
				if(ids){
					for (var i = 0, len = ids.length; i < len; i++) {
						var id = ids[i];
						var layer = map.getLayer(id);

						if (layer.id.indexOf(hidelayer) != -1) {
							layer.hide();
						}
						
						if (layer.id.indexOf(showlayer) != -1) {
							layer.show();
						}		
					}
				}
			},
			
			// This method is automatically invoked anytime anyone calls
			// myWidget.set('avatar', someValue)
			/*
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
			*/
			_changeBackground: function(newColor, dnode) {
				// If we have an animation, stop it
				if (this.mouseAnim) {
					this.mouseAnim.stop();
				}

				// Set up the new animation
				this.mouseAnim = baseFx.animateProperty({
					node: dnode,
					properties: {
						backgroundColor: newColor
					},
					onEnd: lang.hitch(this, function() {
						// Clean up our mouseAnim property
						this.mouseAnim = null;
					})
				}).play();
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