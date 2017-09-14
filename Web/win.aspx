<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
  
<html xmlns="http://www.w3.org/1999/xhtml">  
  
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
        <meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no" />  
        <%--<script src="config.js" type="text/javascript"></script>--%>  
        <script src="https://js.arcgis.com/3.16/init.js" type="text/javascript"></script>  
        <link type="text/css" href="https://js.arcgis.com/3.16/esri/css/esri.css" rel="stylesheet" />  
        <link type="text/css" href="https://js.arcgis.com/3.16/dijit/themes/tundra/tundra.css" rel="stylesheet" />  
        <title>Map hello world</title>  
        <style>  
            html,  
            body,  
            #map {  
                height: 100%;  
                margin: 0;  
                padding: 0;  
                overflow: hidden;  
            }  
        </style>  

        <script>  
            var map;
            require(["esri/map",
                "esri/SpatialReference",
                "esri/geometry/Point",
                "esri/geometry/Polygon",
                "esri/geometry/Polyline",
                "esri/geometry/Extent",
                "esri/geometry/ScreenPoint",
                "esri/layers/GraphicsLayer",
                "esri/symbols/SimpleLineSymbol",
                "esri/symbols/SimpleFillSymbol",
                "esri/symbols/TextSymbol",
                "esri/renderers/ClassBreaksRenderer",
                "esri/graphic",
                "esri/Color",
                "esri/toolbars/draw",
                "dojo/_base/connect",
                "dojo/domReady!"
            ],
                function (Map, SpatialReference, Point, Polygon, Polyline, Extent, ScreenPoint, GraphicsLayer, SimpleLineSymbol, SimpleFillSymbol, TextSymbol, ClassBreaksRenderer, Graphic, Color, DrawTool, connect) {
                    map = new Map("map", {
                        zoom: 10,
                        force3DTransforms: true,
                        basemap: "national-geographic"

                    });
                    //设置地图坐标系类型  
                    var spatialReference = new SpatialReference(102100);
                    map.spatialReference = spatialReference;
                    //中心基于地图位置  
                    map.centerAt(new Point(13366465, 3705414, new SpatialReference(102100)));
                    //创建图层  
                    graphicLayer = new GraphicsLayer();
                    //把图层添加到地图上  
                    map.addLayer(graphicLayer);
                    addMarker(13366465, 3705414);
                    map.on("click", function (e) {
                        addMarker(e.mapPoint.x, e.mapPoint.y);
                    });
                    map.showZoomSlider();
                });

            function addMarker(xx, yy) {

                //设置标注的经纬度  
                var pt = new esri.geometry.Point(xx, yy, map.spatialReference);
                var symbol1 = new esri.symbol.PictureMarkerSymbol("images/site.png", 25, 25);

                //要在模版中显示的参数  
                var attr = {
                    "address": "山东省淄博市张店区"
                };

                //创建模版  
                var infoTemplate = new esri.InfoTemplate("标题", "地址:${address}");
                //创建图像  
                var graphic = new esri.Graphic(pt, symbol1, attr, infoTemplate);
                //把图像添加到刚才创建的图层上  
                graphicLayer.add(graphic);
                setMapCenter(xx, yy, map.getLevel());
            }

            function setMapCenter(xx, yy, level) {
                var point = new esri.geometry.Point(xx, yy, map.spatialReference);
                map.centerAndZoom(point, level);
            }
        </script>  
    </head>  
  
    <body>  
        <div id="map" style="z-index:0;">  
  
        </div>  
    </body>  
  
</html>  