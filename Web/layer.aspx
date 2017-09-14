<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no">
   <title>Reorder layers in map service</title>
   <link rel="stylesheet" href="https://js.arcgis.com/3.21/dijit/themes/tundra/tundra.css">
   <link rel="stylesheet" href="https://js.arcgis.com/3.21/esri/css/esri.css">
   <style>
      html,
      body,
      #map {
         height: 100%;
         width: 100%;
         margin: 0;
         padding: 0;
      }
      h3 {
         margin: 0 0 5px 0;
         border-bottom: 1px solid #444;
      }
      .shadow {
         box-shadow: 0 0 5px #888;
      }
      #map {
         margin: 0;
         padding: 0;
      }
      #feedback {
         background: #fff;
         color: #444;
         position: absolute;
         font-family: arial;
         height: 300px;
         left: 30px;
         margin: 5px;
         padding: 10px;
         top: 30px;
         width: 300px;
         z-index: 40;
      }
      #note,
      #hint {
         font-size: 80%;
      }
      #note {
         font-weight: 700;
         padding: 0 0 10px 0;
      }
      #layerList {
         width: 200px;
      }
      .dojoDndItemOver {
         background: #ccc;
      }
   </style>

   <script src="https://js.arcgis.com/3.21/"></script>
   <script>
      // the infos object is used to track layer visibility and position
      var map, usaLayer, infos = {};
       var layers = []; 
      require([
      "esri/map", "esri/layers/ArcGISDynamicMapServiceLayer",
      "esri/layers/DynamicLayerInfo", "esri/layers/LayerDataSource",
      "esri/layers/LayerDrawingOptions", "esri/layers/TableDataSource",
      "esri/Color", "esri/renderers/SimpleRenderer",
      "esri/symbols/SimpleFillSymbol", "esri/symbols/SimpleLineSymbol",
      "dojo/dom", "dojo/dom-construct", "dojo/dom-style",
      "dojo/query", "dojo/on",
          "dojo/parser", "dojo/_base/array", "dojo/dnd/Source", "dijit/registry", "esri/geometry/Extent", "esri/layers/TileInfo", "esri/SpatialReference",
          "esri/layers/WebTiledLayer",
          "esri/layers/WMTSLayer",
          "esri/layers/WMTSLayerInfo",
          "esri/layers/GraphicsLayer",

      "dijit/form/Button", "dojo/domReady!"
    ], function (
         Map, ArcGISDynamicMapServiceLayer,
         DynamicLayerInfo, LayerDataSource,
         LayerDrawingOptions, TableDataSource,
         Color, SimpleRenderer,
         SimpleFillSymbol, SimpleLineSymbol,
         dom, domConstruct, domStyle,
         query, on,
         parser, arrayUtils, Source, registry, Extent, TileInfo, SpatialReference, WebTiledLayer, WMTSLayer, WMTSLayerInfo, GraphicsLayer


      ) {
         parser.parse();




         var bounds = new Extent({
             "xmin": -180.0, "ymin": -90.0, "xmax": 180, "ymax": 90.0,
             //"xmin": -128.816, "ymin": 25.076, "xmax": -72.855, "ymax": 51.385,  
             "spatialReference": { "wkid": 4326 }
         });
         map = new Map("map", {
             logo: false,
             center: [113.27, 23.13],  //中心
             zoom: 9,   //缩放等级
             extent: bounds
         });

         var tileInfo1 = new TileInfo({
             "dpi": 96,
             "format": "tiles",
             "compressionQuality": 0,
             "spatialReference": new SpatialReference({
                 "wkid": 4326
             }),
             "rows": 256,
             "cols": 256,
             "origin": {
                 "x": -180,
                 "y": 90
             },
             "lods": [{
                 "level": "1",
                 "scale": 295829355.455,
                 "resolution": 0.703914402554
             }, {
                 "level": "2",
                 "scale": 147914677.727,
                 "resolution": 0.351957201277
             }, {
                 "level": "3",
                 "scale": 73957338.8636,
                 "resolution": 0.175978600638
             }, {
                 "level": "4",
                 "scale": 36978669.4318,
                 "resolution": 0.0879893003192
             }, {
                 "level": "5",
                 "scale": 18489334.7159,
                 "resolution": 0.0439946501596
             }, {
                 "level": "6",
                 "scale": 9244667.35796,
                 "resolution": 0.0219973250798
             }, {
                 "level": "7",
                 "scale": 4622333.67898,
                 "resolution": 0.0109986625399
             }, {
                 "level": "8",
                 "scale": 2311166.83949,
                 "resolution": 0.00549933126995
             }, {
                 "level": "9",
                 "scale": 1155583.41974,
                 "resolution": 0.00274966563497
             }, {
                 "level": "10",
                 "scale": 577791.709872,
                 "resolution": 0.00137483281749
             }]

         });
         var tileExtent1 = new Extent(-180, -90, 180, 90, new SpatialReference({
             wkid: 4326
         }));  



         //影像
         layerInfo1 = new WMTSLayerInfo({
             tileInfo: tileInfo1,
             fullExtent: tileExtent1,
             initialExtent: tileExtent1,
             identifier: "img",
             tileMatrixSet: "c",
             format: "tiles",
             style: "default"

         });


         var resourceInfo = {
             version: "1.0.0",
             layerInfos: [layerInfo1],
             copyright: "天地图"
         };


         options = {
             serviceMode: "KVP",
             resourceInfo: resourceInfo,
             layerInfo: layerInfo1

         };
         wmtsLayerImg = new WMTSLayer("http://t0.tianditu.com/img_c/wmts", options);
         wmtsLayerImg.className = "影像";
         map.addLayer(wmtsLayerImg);
         layers.push(wmtsLayerImg);




         //影像注记
         layerInfo1 = new WMTSLayerInfo({
             tileInfo: tileInfo1,
             fullExtent: tileExtent1,
             initialExtent: tileExtent1,
             identifier: "cia",
             tileMatrixSet: "c",
             format: "tiles",
             style: "default"
         });


         var resourceInfo = {
             version: "1.0.0",
             layerInfos: [layerInfo1],
             copyright: "天地图"
         };


         options = {
             serviceMode: "KVP",
             resourceInfo: resourceInfo,
             layerInfo: layerInfo1
         };
         wmtsLayerImganno = new WMTSLayer("http://t0.tianditu.com/cia_c/wmts", options);
         map.addLayer(wmtsLayerImganno);
         layers.push(wmtsLayerImganno);

         //layers[0].id = "影像";
         //layers[1].id = "影像注记";



















      //   var dynamicLayerInfos;

      //   map = new Map("map", {
      //      basemap: "topo",
      //      center: [-93.636, 46.882],
      //      zoom: 7,
      //      slider: false
      //   });

      //   var dndSource = new Source("layerList");
      //   dndSource.on("DndDrop", reorderLayers);

      //   usaLayer = new ArcGISDynamicMapServiceLayer("https://sampleserver6.arcgisonline.com/arcgis/rest/services/USA/MapServer", {
      //      "id": "usa"
      //   });
      //   usaLayer.on("load", function (e) {
      //      dynamicLayerInfos = e.target.createDynamicLayerInfosFromLayerInfos();
      //      arrayUtils.forEach(dynamicLayerInfos, function (info) {
      //         var i = {
      //            id: info.id,
      //            name: info.name,
      //            position: info.id
      //         };
      //         if (arrayUtils.indexOf(usaLayer.visibleLayers, info.id) > -1) {
      //            i.visible = true;
      //         } else {
      //            i.visible = false;
      //         }
      //         infos[info.id] = i;
      //      });
      //      infos.total = dynamicLayerInfos.length;
      //      e.target.setDynamicLayerInfos(dynamicLayerInfos, true);
      //   });





      //   // only create the layer list the first time update-end fires
      //   on.once(layers, "update-end", buildLayerList);
      //   map.addLayer(layers);

      //   // add the lakes layer to the existing map service
      //   registry.byId("lakes").on("click", addLakes);

      //   function buildLayerList() {
      //      dndSource.clearItems();
      //      domConstruct.empty(dom.byId("layerList"));

      //      var layerNames = [];
      //      for (var info in infos) {
      //         if (!infos[info].hasOwnProperty("id")) {
      //            continue;
      //         }
      //         // only want the layer's name, don't need the db name and owner name
      //         var nameParts = infos[info].name.split(".");
      //         var layerName = nameParts[nameParts.length - 1];
      //         var layerDiv = createToggle(layerName, infos[info].visible);
      //         layerNames[infos[info].position] = layerDiv;
      //      }

      //      dndSource.insertNodes(false, layerNames);
      //   }

      //   function toggleLayer(e) {
      //      for (var info in infos) {
      //         var i = infos[info];
      //         if (i.name === e.target.name) {
      //            i.visible = !i.visible;
      //         }
      //      }
      //      var visible = getVisibleLayers();
      //      if (visible.length === 0) {
      //          layers.setVisibleLayers([-1]);
      //      } else {
      //          layers.setDynamicLayerInfos(visible);
      //      }
      //   }

      //   function reorderLayers() {
      //      var newOrder = getVisibleLayers();
      //      layers.setDynamicLayerInfos(newOrder);
      //   }



      //   function getVisibleLayers() {
      //      // get layer name nodes, build an array corresponding to new layer order
      //      var layerOrder = [];
      //      query("#layerList .dojoDndItem label").forEach(function (n, idx) {
      //         for (var info in infos) {
      //            var i = infos[info];
      //            if (i.name === n.innerHTML) {
      //               layerOrder[idx] = i.id;
      //               // keep track of a layer's position in the layer list
      //               i.position = idx;
      //               break;
      //            }
      //         }
      //      });
      //      // find the layer IDs for visible layer
      //      var ids = arrayUtils.filter(layerOrder, function (l) {
      //         return infos[l].visible;
      //      });
      //      // get the dynamicLayerInfos for visible layers
      //      var visible = arrayUtils.map(ids, function (id) {
      //         return dynamicLayerInfos[id];
      //      });
      //      return visible;
      //   }

      //   function createToggle(name, visible) {
      //      var div = domConstruct.create("div");
      //      var layerVis = domConstruct.create("input", {
      //         checked: visible,
      //         id: name,
      //         name: name,
      //         type: "checkbox"
      //      }, div);
      //      on(layerVis, "click", toggleLayer);
      //      var layerSpan = domConstruct.create("label", {
      //         for: name,
      //         innerHTML: name
      //      }, div);
      //      return div;
      //   }
      //});


   </script>
</head>

<body class="tundra">
   <div style="width: 100%; height: 100%; margin: 0;">
      <div id="map">

         <div id="feedback" class="shadow">
            <h3>Add and Re-order Layers</h3>
            <div id="info">
               <div id="note">
                  Note: This sample requires an ArcGIS Server version 10.1 or later map service.
               </div>

               <div id="hint">
                  Click and drag a map layer name below to re-order layers. The first layer in the list will be drawn on top.
               </div>

               <div><strong>Map Layers</strong></div>
               
               <div id="layerList"></div>

               <button id="lakes" data-dojo-type="dijit/form/Button">
                  Add Lakes
               </button>

            </div>
         </div>
      </div>
   </div>
</body>

</html>