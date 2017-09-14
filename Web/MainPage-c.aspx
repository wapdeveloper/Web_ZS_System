<!DOCTYPE html>
<html lang="zh-CN">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=7,IE=9" />


    <title>布局 - Bootstrap Admin Theme</title>

    <!-- Bootstrap Core CSS -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Arcgis CSS -->

    <link rel="stylesheet" href="https://js.arcgis.com/3.21/dijit/themes/nihilo/nihilo.css">
    <link rel="stylesheet" href="https://js.arcgis.com/3.21/esri/themes/calcite/dijit/calcite.css">
    <link rel="stylesheet" href="https://js.arcgis.com/3.21/esri/themes/calcite/esri/esri.css">

    <!-- Custom CSS -->
    <link href="dist/css/main.css" rel="stylesheet">
    <link rel="stylesheet" href="dist/css/tabs-vertical.css">
    <%--<link rel="stylesheet" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">--%>




    <!-- Custom Fonts -->
    <link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="StyleSheet.css" rel="stylesheet" />






    <script type="text/javascript" src="https://js.arcgis.com/3.21/"></script>
    <script type="text/javascript" src="WMTSLayer.js"></script>

    <script src="dist/js/jquery-1.11.1.min.js"></script>
    <script src="dist/js/jquery.ui.core.js"></script>
    <script src="dist/js/jquery.ui.widget.js"></script>
    <script src="dist/js/jquery.ui.mouse.js"></script>
    <script src="dist/js/jquery.ui.accordion.js"></script>
    <script src="dist/js/jquery.ui.draggable.js"></script>
    <script src="dist/js/jquery.ui.slider.js"></script>



    <script type="text/javascript">


        var pageData1 = [];
        var pageData2 = [];
        var pageData3 = [];



        $(function () {
            $.post("Handler/ResultsDirectoryHandler.ashx",
                {
                    operation: 'searchall',
                    condition: 'a'
                },
                function (data) {
                    if (data === null || data === "") {
                        alert(data);
                        return;
                    }
                    else {
                       
                        var m_Json = jQuery.parseJSON(data);

                        var type1 = [];
                        var type2 = [];
                        var type3 = [];

                        for (var i = 0; i < m_Json.length; i++) {
                            if (m_Json[i].type == "a") {
                                type1.push(m_Json[i]);
                            }
                            if (m_Json[i].type == "b") {
                                type2.push(m_Json[i]);
                            }
                            if (m_Json[i].type == "c") {
                                type3.push(m_Json[i]);
                            }
                        }


                        for (var i = 0; i < type1.length; i+=3)
                        {
                            if (i < type1.length - 2)
                            {
                                var data1 = '<tr>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type1[i].pp + '</li></ul></td>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type1[i + 1].pp + '</li></ul></td>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type1[i + 2].pp + '</li></ul></td>' +
                                    '</tr>';
                                pageData1.push(data1);
                            }
                            else if (i < type1.length - 1) {
                                var data1 = '<tr>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type1[i].pp + '</li></ul></td>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type1[i + 1].pp + '</li></ul></td>' + '</tr>';
                                pageData1.push(data1);
                            }
                            else if (i == type1.length-1 ) {
                                var data1 = '<tr>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type1[i].pp + '</li></ul></td>' + '</tr>';
                                pageData1.push(data1);
                            }
                        }

                        for (var i = 0; i < type2.length; i += 3) {
                            if (i < type2.length - 2) {
                                var data2 = '<tr>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type2[i].pp + '</li></ul></td>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type2[i + 1].pp + '</li></ul></td>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type2[i + 2].pp + '</li></ul></td>' +
                                    '</tr>';
                                pageData2.push(data2);
                            }
                            else if (i < type2.length - 1) {
                                var data2 = '<tr>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type2[i].pp + '</li></ul></td>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type2[i + 1].pp + '</li></ul></td>' + '</tr>';
                                pageData2.push(data2);
                            }
                            else if (i == type2.length - 1) {
                                var data2 = '<tr>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type2[i].pp + '</li></ul></td>' + '</tr>';
                                pageData2.push(data2);
                            }
                        }

                        for (var i = 0; i < type3.length; i += 3)
                        {
                            if (i < type3.length - 2) {
                                var data3 = '<tr>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type3[i].pp + '</li></ul></td>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type3[i + 1].pp + '</li></ul></td>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type3[i + 2].pp + '</li></ul></td>' +
                                    '</tr>';
                                pageData3.push(data3);
                            }
                            else if (i < type3.length - 1) {
                                var data3 = '<tr>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type3[i].pp + '</li></ul></td>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type3[i + 1].pp + '</li></ul></td>' + '</tr>';
                                pageData3.push(data3);
                            }
                            else if (i == type3.length - 1) {
                                var data3 = '<tr>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + type3[i].pp + '</li></ul></td>' + '</tr>';
                                pageData3.push(data3);
                            }
                        }

                        pageData.push(pageData1);
                        pageData.push(pageData2);
                        pageData.push(pageData3);

                    }
                }
            );
        });


        function AppendToHtml(m_Json) {

        }


        var searchData ;
        function tc_search()
        {
            $.post("Handler/ResultsDirectoryHandler.ashx",
                {
                    operation: 'search',
                    condition: '区'
                },
                function (data) {
                    if (data === null || data === "") {
                        alert(data);
                        return;
                    }
                    else {

                        var m_Json = jQuery.parseJSON(data);
                        searchData = [];
                        var searchData1 = [];
                        for (var i = 0; i < m_Json.length; i += 3)
                        {
                            if (i < m_Json.length - 2) {
                                var data1 = '<tr>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + m_Json[i].pp + '</li></ul></td>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + m_Json[i + 1].pp + '</li></ul></td>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + m_Json[i + 2].pp + '</li></ul></td>' +
                                    '</tr>';
                                searchData1.push(data1);
                            }
                            else if (i < m_Json.length - 1) {
                                var data1 = '<tr>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + m_Json[i].pp + '</li></ul></td>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + m_Json[i + 1].pp + '</li></ul></td>' + '</tr>';
                                searchData1.push(data1);
                            }
                            else if (i == m_Json.length - 1) {
                                var data1 = '<tr>' +
                                    '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/1.jpg" +
                                    '"/></li> <li>' + m_Json[i].pp + '</li></ul></td>' + '</tr>';
                                searchData1.push(data1);
                            }
                        }
                        $('#page').html('');
                        searchData.push(searchData1);
                        B(0);
                    }
                }
            );
        }

        $(function () {
            $("#tcDiv").draggable({ containment: "body" });
        });


        var pageN;
        var last = 1;


        $(function () {


            var widget = $('.tabs-vertical');

            var tabs = widget.find('ul a'),
                content = widget.find('.tabs-content-placeholder > div');

            tabs.on('click', function (e) {

                e.preventDefault();

                // Get the data-index attribute, and show the matching content div

                var index = $(this).data('index');

                tabs.removeClass('tab-active');
                content.removeClass('tab-content-active');

                //$('#table' + last).empty();
                //$('#table' + last).html('');
                $('#page').html('');

                $(this).addClass('tab-active');
                content.eq(index).addClass('tab-content-active');
                A(index);
                //last = index + 1;

            });

        });

        var pageData = [];


        //一个pageData有100条data
        //一个data有5条记录
        //pageData3.push(data31);


        var data32 = '<tr>' +

            '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/7.png" +
            '"/></li> <li>' + "3:500DLG数据" + '</li></ul></td>' +
            '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/8.png" +
            '"/></li> <li>' + "3:500DLG数据" + '</li></ul></td>' +
            '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist/images/9.png" +
            '"/></li> <li>' + "3:500DLG数据" + '</li></ul></td>' +
            '</tr>';
        //pageData3.push(data32);

        //pageData.push(pageData3);



        function B(index) {

            var table = "#table" + (index + 1);

            var Count = searchData[index].length;//记录条数
            var PageSize = 6;//设置每页示数目
            var PageCount = Math.ceil(Count * 3 / PageSize);//计算总页数
            var currentPage = 1;//当前页，默认为1。


            //造个简单的分页按钮，添加所需要的页数               
            for (var i = 1; i <= PageCount; i++) {
                pageN = '<a href="#" selectPage="' + i + '" >第' + i + '页    </a>';
                $('#page').append(pageN);
            }

            $(table).html('');
            //显示默认页（第一页）
            for (i = (currentPage - 1) * 2; i < 2 * currentPage; i++) {
                if (searchData[index][i] != null) {
                    $(table).append(searchData[index][i]);
                }
            }



            //显示选择页的内容
            $('a').click(function () {
                var selectPage = $(this).attr('selectPage');
                if (selectPage != null) {
                    $(table).html('');
                    for (i = (selectPage - 1) * 2; i < selectPage * 2; i++) {
                        if (searchData[index][i] != null) {
                            $(table).append(searchData[index][i]);
                        }

                    }
                }

            });

        }


        function A(index) {

            var table = "#table" + (index + 1);

            var Count = pageData[index].length;//记录条数
            var PageSize = 6;//设置每页示数目
            var PageCount = Math.ceil(Count * 3 / PageSize);//计算总页数
            var currentPage = 1;//当前页，默认为1。


            //造个简单的分页按钮，添加所需要的页数               
            for (var i = 1; i <= PageCount; i++) {
                pageN = '<a href="#" selectPage="' + i + '" >第' + i + '页    </a>';
                $('#page').append(pageN);
            }

            $(table).html('');
            //显示默认页（第一页）
            for (i = (currentPage - 1) * 2; i < 2 * currentPage; i++) {
                if (pageData[index][i] != null) {
                    $(table).append(pageData[index][i]);
                }
            }



            //显示选择页的内容
            $('a').click(function () {
                var selectPage = $(this).attr('selectPage');
                if (selectPage != null)
                {
                    $(table).html('');
                    for (i = (selectPage - 1) * 2; i < selectPage * 2; i++) {
                        if (pageData[index][i] != null) {
                            $(table).append(pageData[index][i]);
                        }

                    }
                }

            });

        }





        var dojoConfig = {
            parseOnLoad: true,
            packages: [{
                name: "agsjs",
                location: location.pathname.replace(/\/[^/]+$/, '') + '/agsjs'
            }, {
                name: "tdtlib",
                location: location.pathname.replace(/\/[^/]+$/, '') + '/plugins/tdtlib'
            }
            ],
            async: true
        };




    </script>




    <script>

        var map, wmtsLayer, wmtsLayeranno, wmtsLayerImg, wmtsLayerImganno, measure, graphicsLayer;

        require([

            "esri/map",
            "esri/layers/WebTiledLayer",
            "esri/layers/WMTSLayer",
            "esri/layers/WMTSLayerInfo",
            "esri/layers/GraphicsLayer",

            "esri/dijit/Measurement",
            "esri/geometry/Extent",
            "esri/layers/TileInfo",
            "esri/SpatialReference",
            "esri/geometry/Point",
            "esri/units",
            "esri/toolbars/draw",
            "esri/graphic",
            "esri/symbols/SimpleMarkerSymbol",
            "esri/symbols/SimpleLineSymbol",
            "esri/symbols/SimpleFillSymbol",



            "dojo/parser", "dijit/registry",

            "dijit/layout/BorderContainer",
            "dijit/layout/ContentPane",
            "dijit/TitlePane",
            "dojo/domReady!"
        ], function (

            Map, WebTiledLayer, WMTSLayer, WMTSLayerInfo, GraphicsLayer,
            Measurement,
            Extent, TileInfo, SpatialReference, Point, Units,
            Draw, Graphic,
            SimpleMarkerSymbol, SimpleLineSymbol, SimpleFillSymbol,
            parser, registry

        ) {
                parser.parse();

                var bounds = new Extent({
                    "xmin": -180.0, "ymin": -90.0, "xmax": 180, "ymax": 90.0,
                    //"xmin": -128.816, "ymin": 25.076, "xmax": -72.855, "ymax": 51.385,  
                    "spatialReference": { "wkid": 4326 }
                });
                map = new Map("mapDiv", {
                    logo: false,
                    center: [113.27, 23.13],  //中心
                    zoom: 9,   //缩放等级
                    extent: bounds
                });

                map.on("load", createToolbar);

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

                //底图
                var layerInfo1 = new WMTSLayerInfo({
                    tileInfo: tileInfo1,
                    fullExtent: tileExtent1,
                    initialExtent: tileExtent1,
                    identifier: "vec",
                    tileMatrixSet: "c",
                    format: "tiles",
                    style: "default"
                });

                var resourceInfo = {
                    version: "1.0.0",
                    layerInfos: [layerInfo1],
                    copyright: "天地图"
                };

                var options = {
                    serviceMode: "KVP",
                    resourceInfo: resourceInfo,
                    layerInfo: layerInfo1
                };

                wmtsLayer = new WMTSLayer("http://t0.tianditu.com/vec_c/wmts", options);
                map.addLayer(wmtsLayer);



                //底图注记
                layerInfo1 = new WMTSLayerInfo({
                    tileInfo: tileInfo1,
                    fullExtent: tileExtent1,
                    initialExtent: tileExtent1,
                    identifier: "cva",
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
                wmtsLayeranno = new WMTSLayer("http://t0.tianditu.com/cva_c/wmts", options);
                map.addLayer(wmtsLayeranno);

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
                //map.addLayer(wmtsLayerImg);

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
                //map.addLayer(wmtsLayerImganno);

                measure = new esri.dijit.Measurement({
                    map: map,
                    defaultLengthUnit: Units.METERS,
                    defaultAreaUnit: Units.SQUARE_METERS
                }, dojo.byId('measurementDiv'));
                measure.startup();


                graphicsLayer = new GraphicsLayer();



                // loop through all dijits, connect onClick event
                // listeners for buttons to activate drawing tools
                registry.forEach(function (d) {
                    // d is a reference to a dijit
                    // could be a layout container or a button
                    if (d.declaredClass === "dijit.form.Button") {
                        d.on("click", activateTool);
                    }

                });


                function activateTool() {

                    var tools = this.value;
                    // var tools = p;
                    var tool = "";

                    switch (tools) {
                        case "点":
                            //case "点":
                            tool = "POINT";
                            break;
                        case "线":
                            tool = "POLYLINE";
                            break;
                        case "面":
                            tool = "POLYGON";
                            break;
                        case "手绘线":
                            tool = "FREEHAND_POLYLINE";
                            break;
                        case "手绘面":
                            tool = "FREEHAND_POLYGON";
                            break;
                        default:
                            break;
                    }
                    toolbar.activate(Draw[tool]);
                    map.hideZoomSlider();
                }

                function createToolbar(themap) {
                    toolbar = new Draw(map);
                    toolbar.on("draw-end", addToMap);
                }

                function addToMap(evt) {
                    var symbol;
                    toolbar.deactivate();
                    map.showZoomSlider();
                    switch (evt.geometry.type) {
                        case "point":
                        case "multipoint":
                            symbol = new SimpleMarkerSymbol();
                            break;
                        case "polyline":
                            symbol = new SimpleLineSymbol();
                            break;
                        default:
                            symbol = new SimpleFillSymbol();
                            break;
                    }

                    //要在模版中显示的参数  
                    var attr = {
                        "address": "<input type='text'/>"
                    };

                    //创建模版  
                    var infoTemplate = new esri.InfoTemplate("标题", "地址:${address}");

                    //var infoTemplate = new esri.InfoTemplate("标题", "<div><span>地址：</span>  <input type='text'/></div>");
                    var graphic = new Graphic(evt.geometry, symbol, attr, infoTemplate);



                    graphicsLayer.add(graphic);
                    map.addLayer(graphicsLayer);


                    //map.graphics.add(graphic);

                    //$("#ddd").css("display", "block");

                    //document.getElementById("ddd").display = "block";
                }




                //http://services.tianditugd.com/gdimg201311/wmts?SERVICE=WMTS&REQUEST=GetCapabilities
            });

        function printpage() {
            window.print()
        }

        function addimage() {

            map.removeLayer(wmtsLayer);
            map.removeLayer(wmtsLayeranno);
            map.addLayer(wmtsLayerImg);
            map.addLayer(wmtsLayerImganno);

        }

        function removeimage() {

            map.removeLayer(wmtsLayerImg);
            map.removeLayer(wmtsLayerImganno);
            map.addLayer(wmtsLayer);
            map.addLayer(wmtsLayeranno);

        }
        var t = true;

        function fullscreen() {
            if (t) {
                //document.getElementById("header").style.display = "none";
                document.getElementById("navid").style.display = "none";
                document.getElementById("footer").style.display = "none";

                document.getElementById("wrapper").style.top = "0px";
                document.getElementById("wrapper").style.bottom = "0px";

                document.getElementById("page-wrapper").style.margin = "0px 0px 0px 0px";

                document.getElementById("mapDiv_root").style.height = "600px";

                t = false;
            }
            else {

                //document.getElementById("header").style.display = "block";
                document.getElementById("navid").style.display = "block";
                document.getElementById("footer").style.display = "block";

                document.getElementById("wrapper").style.top = "80px";
                document.getElementById("wrapper").style.bottom = "30px";

                //document.getElementById("page-wrapper").style.position = "inherit";
                document.getElementById("page-wrapper").style.margin = "0px 0px 0px 300px";
                document.getElementById("page-wrapper").style.padding = "0px 15x";

                document.getElementById("mapDiv_root").style.height = "480px";

                t = true;
            }

        }

        function measurement() {

            document.getElementById("meaDiv").style.display = "block";

        }

        function hidemea() {
            measure.clearResult();
            document.getElementById("meaDiv").style.display = "none";
        }

        function hidedraw() {
            measure.clearResult();
            document.getElementById("drawDiv").style.display = "none";
        }


        function activedrawtool() {
            document.getElementById("drawDiv").style.display = "block";
        }


        function clean() {
            graphicsLayer.clear();
        }



        function thematicCatalog() {
            $('#page').html('');
            document.getElementById("tcDiv").style.display = "block";
            A(0);

        }

        function tc_close() {
            document.getElementById("tcDiv").style.display = "none";
        }











        //var pageData = [];
        //for (var i = 1; i <= 9; i++) {
        //    var data = '<tr>' +

        //        '<td><ul style="width: 100%; text-align: center;"> <li><img style="padding: 2px; border: groove; width: 96px; height: 96px" src="' + "dist / images / 1.jpg" +
        //        '"/></li> <li>' + "1:500DLG数据" + '</li></ul></td>' +

        //        '</tr>';
        //    //一个pageData有100条data
        //    //一个data有5条记录
        //    pageData.push(data);
        //    $('#table1').append(data);





    </script>

</head>

<body class="claro">


    <%--    <div class="mainheader" id="header">
        <h1>Header</h1>
    </div>--%>
    <div id="ddd" style="display: none; z-index: 9999;">ddd </div>

    <div id="wrapper" class="maincontainer">

        <!-- Navigation -->
        <nav id="navid" class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">招商服务系统</a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">

                <li><a href="#ios" data-toggle="buttons" onclick="thematicCatalog()">专题目录</a></li>


                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>资料管理  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i>附件管理</a></li>
                        <li class="divider"></li>
                        <li>
                            <a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-gear fa-fw"></i>成果图管理</a>
                            <!-- Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                       
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->
                        </li>
                    </ul>
                    <!-- /.dropdown-tasks -->
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>用户  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i>个人信息</a>
                        </li>
                        <li><a href="#"><i class="fa fa-gear fa-fw"></i>配置</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="pages/login.html"><i class="fa fa-sign-out fa-fw"></i>登出</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->


            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                                <input type="text" class="form-control" placeholder="查找...">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </span>
                            </div>
                        </li>
                    </ul>
                    <!-- /.sidebar-search -->
                    <div class="panel-body">
                        <ul id="myTab" class="nav nav-tabs ">
                            <li class="active"><a href="#home" data-toggle="tab">标签页一</a></li>
                            <li><a href="#ios" data-toggle="tab">专题目录</a></li>
                            <li><a href="#jmeter" data-toggle="tab">标签页三</a></li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <!-- /.nav-tabs -->
                            <div class="tab-pane fade in active" id="home">
                                <a href="#" class="btn"><span class="glyphicon glyphicon-asterisk" aria-hidden="true"></span>分类查询1</a>
                                <a href="#" class="btn"><span class="glyphicon glyphicon-asterisk" aria-hidden="true"></span>分类查询1</a>
                                <a href="#" class="btn"><span class="glyphicon glyphicon-asterisk" aria-hidden="true"></span>分类查询1</a>
                                <a href="#" class="btn"><span class="glyphicon glyphicon-asterisk" aria-hidden="true"></span>分类查询1</a>
                            </div>
                            <div class="tab-pane fade" id="ios">
                                <div class="panel panel-info">
                                    <div class="panel-heading" style="float: left; width: 150px;">基础地理信息数据</div>
                                    <div class="panel-body" style="float: right">
                                        <%--<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt est vitae ultrices accumsan. Aliquam ornare lacus adipiscing, posuere lectus et, fringilla augue.</p>--%>
                                        <p>ppppppp</p>
                                    </div>
                                    <div class="panel-heading" style="float: left; width: 150px;">电子地图瓦片数据</div>
                                    <div class="panel-body" style="float: right">
                                        <%--<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt est vitae ultrices accumsan. Aliquam ornare lacus adipiscing, posuere lectus et, fringilla augue.</p>--%>
                                        <p>aaaaaaaa</p>
                                    </div>
                                    <div class="panel-heading" style="float: left; width: 150px;">地名地址数据</div>
                                    <div class="panel-body" style="float: right">
                                        <%--<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt est vitae ultrices accumsan. Aliquam ornare lacus adipiscing, posuere lectus et, fringilla augue.</p>--%>
                                        <p>bbbbbbb</p>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="jmeter">
                                <p>jMeter 是一款开源的测试软件。它是 100% 纯 Java 应用程序，用于负载和性能测试。</p>
                            </div>
                        </div>
                        <!-- /.nav-tabs -->
                    </div>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <ul class="nav navbar-top-links navbar-right">
                        <li class="dropdown" onclick="fullscreen()">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-arrows-alt fa-fw"></i>全屏
                            </a>
                            <!-- /.dropdown-messages -->
                        </li>
                        <!-- /.dropdown -->
                        <li class="dropdown" onclick="clean()">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-tasks fa-fw"></i>清除
                            </a>
                            <!-- /.dropdown-tasks -->
                        </li>
                        <!-- /.dropdown -->
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-gear fa-fw"></i>工具  <i class="fa fa-caret-down"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li onclick="measurement()"><a href="#"><i class="fa fa-user fa-fw"></i>测量</a></li>
                                <li class="divider"></li>
                                <li onclick="activedrawtool()"><a href="#"><i class="fa fa-gear fa-fw"></i>标注</a></li>
                                <li class="divider"></li>
                                <li><a href="#"><i class="fa fa-gear fa-fw"></i>统计</a></li>
                                <li class="divider"></li>
                                <li><a href="#" id="print"><i class="fa fa-gear fa-fw"></i>打印</a></li>
                                <%--								<li><a href="#"  onclick="printpage()"><i class="fa fa-gear fa-fw"></i> 打印</a></li>--%>
                            </ul>
                            <!-- /.dropdown-messages -->
                            <!-- /.dropdown-alerts -->
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-user fa-fw"></i>对比  <i class="fa fa-caret-down"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#" id="swipeOn"><i class="fa fa-user fa-fw"></i>对比浏览</a>
                                </li>
                                <li><a href="#"><i class="fa fa-gear fa-fw"></i>取消对比</a>
                                </li>
                            </ul>
                            <!-- /.dropdown-user -->
                        </li>
                        <!-- /.dropdown -->
                    </ul>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="btn-block">

                        <div id="drawDiv" ondblclick="hidedraw()" style="position: absolute; right: 20px; top: 10px; z-index: 999; background-color: ghostwhite; display: none; padding: 10px;">
                            <span>标绘工具：<br />
                            </span>
                            <button class="btn1" data-dojo-type="dijit/form/Button" type="button" value="点" style="border: none;">
                                <img style="height: 16px; width: 16px;" src="dist/images/point.png" alt="点" />
                                <span id="point" style="font-size: 16px">点</span>
                            </button>

                            <button data-dojo-type="dijit/form/Button" type="button" value="线" style="border: none;">
                                <img style="height: 16px; width: 16px;" src="dist/images/line.png" alt="线" />
                                <span id="line" style="font-size: 16px">线</span>
                            </button>

                            <button data-dojo-type="dijit/form/Button" type="button" value="面">
                                <img style="height: 16px; width: 16px;" src="dist/images/polygon.png" alt="面" />
                                <span id="polygon" style="font-size: 16px">面</span>
                            </button>

                            <button data-dojo-type="dijit/form/Button" type="button" value="手绘线">
                                <img style="height: 16px; width: 16px;" src="dist/images/handline.png" alt="手绘线" />
                                <span id="handline" style="font-size: 16px">手绘线</span>
                            </button>

                            <button data-dojo-type="dijit/form/Button" type="button" value="手绘面">
                                <img style="height: 16px; width: 16px;" src="dist/images/handpolygon.png" alt="手绘面" />
                                <span id="handpolygon" style="font-size: 16px">手绘面</span>
                            </button>
                        </div>



                        <div id="mapDiv" class="calcite" data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'center'">


                            <div id="meaDiv" ondblclick="hidemea()" style="position: absolute; right: 20px; top: 10px; z-index: 999; display: none">
                                <div id="titlePane" data-dojo-type="dijit/TitlePane" data-dojo-props="title:'测量工具', closable:false">
                                    <div id="measurementDiv"></div>
                                </div>
                            </div>


                        </div>



                        <div id="swipeDiv"></div>
                        <!-- /.layerswipe -->
                        <div id="mapTypeDiv" class="mapType">
                            <div class="basemapContainer">
                                <div title="切换底图" role="button" class="toggleButton topo">
                                    <div class="basemapImage">
                                        <img alt="矢量图" src="dist/images/basemaps/vectorType.png" onclick="removeimage()">
                                    </div>
                                    <div class="basemapTitle">矢量图</div>
                                </div>
                            </div>

                            <div class="basemapContainer">
                                <div title="切换底图" role="button" class="toggleButton topo">
                                    <div class="basemapImage">
                                        <img alt="影像图" src="dist/images/basemaps/imageType.png" onclick="addimage()">
                                    </div>
                                    <div class="basemapTitle">影像图</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.row -->
    </div>
    <!-- /#page-wrapper -->


    <!-- /#wrapper -->



    <div class="mainfooter" id="footer">
        Bottom
    </div>



    <div id="tcDiv" style="position: absolute; width: 800px; height: 400px; left: 380px; top: 100px; z-index: 2000; padding: 20px; display: none" class="tabs-vertical">

        <div class="input-group custom-search-form" style="width: 200px; float: left">
            <input type="text" class="form-control" placeholder="查找...">
            <span class="input-group-btn">
                <button class="btn btn-default" type="button" onclick="tc_search()">
                    <i class="fa fa-search"></i>
                </button>
            </span>
        </div>


        <div style="float: right;">
            <button type="button" class="btn btn-default btn-sm" id="tc_close" onclick="tc_close()">
                <span class="glyphicon glyphicon-remove"></span>
            </button>
        </div>

        <div style="clear: both"></div>


        <ul style="margin-top: 20px">
            <li>
                <a class="first-tab tab-active" data-index="0" href="#">
                    <img style="height: 12px; width: 12px;" src="dist/images/active.png" />
                    基础地理信息数据</a>
            </li>
            <li>
                <a class="second-tab" data-index="1" href="#">
                    <img style="height: 12px; width: 12px;" src="dist/images/active.png" />
                    电子地图瓦片数据</a>
            </li>
            <li>
                <a class="third-tab" data-index="2" href="#">
                    <img style="height: 12px; width: 12px;" src="dist/images/active.png" />
                    地名地址数据</a>
            </li>
        </ul>

        <div class="tabs-content-placeholder" style="margin-top: 20px; height: 300px;">

            <div class="tab-content-active" style="width: 100%; height: 100%">
                <table id="table1" style="width: 100%; height: 100%; border-collapse: separate; border-spacing: 10px"></table>
                <%--                <table id="table1" style="width: 100%; height: 100%; border-collapse: separate; border-spacing: 10px">



                    <tr>
                        <td style="">
                            <ul style="width: 100%; text-align: center;">
                                <li style="">
                                    <img style="padding: 2px; border: groove; width: 96px; height: 96px" src="dist/images/1.jpg" /></li>
                                <li>1:500DLG数据</li>
                            </ul>
                        </td>
                        <td style="">
                            <ul style="width: 100%; text-align: center">
                                <li style="">
                                    <img style="padding: 2px; border: groove; width: 96px; height: 96px" src="dist/images/2.png" /></li>
                                <li>1:1000正射影像数据</li>
                            </ul>
                        </td>
                        <td style="">
                            <ul style="width: 100%; text-align: center">
                                <li style="">
                                    <img style="padding: 2px; border: groove; width: 96px; height: 96px" src="dist/images/3.png" /></li>
                                <li>1:5000正射影像数据</li>
                            </ul>
                        </td>
                    </tr>



                    <tr>
                        <td style="">
                            <ul style="width: 100%; text-align: center">
                                <li style="">
                                    <img style="padding: 2px; border: groove; width: 96px; height: 96px" src="dist/images/4.png" /></li>
                                <li>1:2000正射影像数据</li>
                            </ul>
                        </td>
                        <td style="">
                            <ul style="width: 100%; text-align: center">
                                <li style="">
                                    <img style="padding: 2px; border: groove; width: 96px; height: 96px" src="dist/images/5.jpg" /></li>
                                <li>1:10000 地理实体数据</li>
                            </ul>
                        </td>

                        <td style="">
                            <ul style="width: 100%; text-align: center">
                                <li style="">
                                    <img style="padding: 2px; border: groove; width: 96px; height: 96px" src="dist/images/6.png" /></li>
                                <li>1:10000 地理实体数据</li>
                            </ul>
                        </td>
                    </tr>--%>

                <%--                    <tr>
                        <td style="">
                            <ul style="width: 100%; text-align: center">
                                <li style="">
                                    <img style="padding: 2px; border: groove; width: 96px; height: 96px" src="dist/images/7.png" /></li>
                                <li>1:2000正射影像数据</li>
                            </ul>
                        </td>
                        <td style="">
                            <ul style="width: 100%; text-align: center">
                                <li style="">
                                    <img style="padding: 2px; border: groove; width: 96px; height: 96px" src="dist/images/8.png" /></li>
                                <li>1:10000 地理实体数据</li>
                            </ul>
                        </td>

                        <td style="">
                            <ul style="width: 100%; text-align: center">
                                <li style="">
                                    <img style="padding: 2px; border: groove; width: 96px; height: 96px" src="dist/images/9.png" /></li>
                                <li>1:10000 地理实体数据</li>
                            </ul>
                        </td>
                    </tr>--%>




                <%--        </table>--%>



                <%--       <div id="case_right_id">--%>
                <%--                <div>
                    <img src="dist/images/ff434c82-e39e-4e17-ac00-e847028189c1.jpg" alt="">
                    <a>1:500DLG数据</a>
                </div>--%>
                <%--                   <div class="product_dl">
                        <dt><a>
                            <img src="dist/images/cfbd59d1-7db3-4fcf-84d2-ee7c09cd4068.png" alt=""></a></dt>
                        <dd><a>1:1000正射影像数据</a></dd>
                    </div>
                    <div class="product_dl">
                        <dt><a>
                            <img src="dist/images/f4a01cb6-e423-4a3a-89c2-092bdfeccaf3.png" alt=""></a></dt>
                        <dd><a>1:5000正射影像数据</a></dd>
                    </div>
                    <div class="product_dl">
                        <dt><a>
                            <img src="dist/images/a21be031-45b6-4785-8a8c-589521728a19.png" alt=""></a></dt>
                        <dd><a>1:2000正射影像数据</a></dd>
                    </div>
                    <div class="product_dl">
                        <dt><a>
                            <img src="dist/images/1054a614-8646-4657-9a28-9cdf0d038f68.jpg" alt=""></a></dt>
                        <dd><a>1:10000 地理实体数据</a></dd>
                    </div>--%>
                <%--                    <div class="clear"></div>
                </div>--%>
                <%--<p>123</p>--%>
            </div>







            <div>
                <table id="table2" style="width: 100%; height: 100%; border-collapse: separate; border-spacing: 10px"></table>

            </div>

            <div>
                <table id="table3" style="width: 100%; height: 100%; border-collapse: separate; border-spacing: 10px"></table>

            </div>



        </div>

        <div id="page" style="width: 100%; bottom: -25px; text-align: center; display: block; margin-left: 80px;"></div>



    </div>


    <!-- jQuery -->
    <%--<script src="plugins/jquery/jquery.min.js"></script>--%>

    <!-- Bootstrap Core JavaScript -->
    <script src="bootstrap/js/bootstrap.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="dist/js/main.js"></script>

    <!-- Custom map JavaScript -->
    <script src="dist/js/WLJS.js"></script>
    <script src="dist/js/hfhb/custom.js"></script>
    <script src="dist/js/hfhb/hfhb.js"></script>
    <script src="dist/js/hfhb/map.js"></script>
</body>

</html>
