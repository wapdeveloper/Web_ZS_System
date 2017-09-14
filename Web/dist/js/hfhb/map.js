//加载系统的arcgis地图脚本,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size


$(function() {


    $("#print").click(function () {
        
		HF.print('mapDiv');
	});
	 
	 
	$("#swipeOn").click(function() {
		HF.log('swipeOn click');
			
		if(HF.map.loaded)
			HF.log('swipeOn begin');
	});
	
	require([
	"dojo/domReady!", "esri/map",
	"esri/geometry/Extent",
	"esri/layers/ArcGISDynamicMapServiceLayer", "esri/layers/ArcGISTiledMapServiceLayer",
	"esri/geometry/Point",	
	"esri/dijit/HomeButton", "esri/dijit/Scalebar", "esri/dijit/BasemapToggle", "esri/dijit/Basemap", 
	"tdtlib/TianDiTuLayer", "myApp/widget/TdtMapToggle"], function (
	ready, Map, Extent, 
	ArcGISDynamicMapServiceLayer, ArcGISTiledMapServiceLayer, 
	Point, HomeButton, Scalebar, BasemapToggle, Basemap,
	TianDiTuLayer, TdtMapToggle) {
		
		
		var tdtVectorLayer = new TianDiTuLayer('tdtVectorMapGroup_layer', 1);
		var tdtVectorAnnoLayer = new TianDiTuLayer('tdtVectorMapGroup_anno', 2);
		
		var tdtImageLayer = new TianDiTuLayer('tdtImageMapGroup_layer', 3);
		var tdtImageAnnoLayer = new TianDiTuLayer('tdtImageMapGroup_anno', 4);
			  
		HF.map = new Map("mapDiv", { 
			 center: [113.19, 23.00],        
			 zoom: 10,
			 sliderStyle: "large",
			 logo: false
		});
		
		HF.map.setExtent( new Extent({ xmin: 113.09, ymin: 23.04,
						xmax: 113.43, ymax: 23.20, spatialReference: { wkid: 4490 }})
		); //默认范围:广州 
		

		var scalebar = new Scalebar({
			map: HF.map,
			scalebarUnit: "dual"
		});	
				
		
		var widget = new TdtMapToggle({
			name: "testTitle", 
			map: HF.map},
		'mapTypeDiv');
		//widget.startup();
		
		HF.map.addLayers([tdtVectorLayer,tdtVectorAnnoLayer]);
		HF.map.addLayers([tdtImageLayer,tdtImageAnnoLayer]);
		
		//HF.map.centerAndZoom(new Point({ "x": 115.317880, "y": 22.970000, "spatialReference": { "wkid": 4490} }), 9);//定位到海丰
		tdtImageLayer.hide();
		tdtImageAnnoLayer.hide();
		
		HF.map.on("load", initMapOnload);
		HF.map.on("mouse-move", initCoordBar);
		
	});
	
	function initMapOnload(){
	   HF.log('Map loaded');
		
	   
	   //var vectoranno = TianDiTuLayer("TdtVectorAnno", 2);
	}
	
	function initCoordBar(evt) {
        var x = evt.mapPoint.x.toFixed(6);
        var y = evt.mapPoint.y.toFixed(6);
        //dojo.byId("coordBar").innerHTML = "经度：" + x + "，纬度：" + y;
    }
});
