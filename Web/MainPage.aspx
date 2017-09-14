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

    <!-- Custom Fonts -->
    <link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="StyleSheet.css" rel="stylesheet" />

    <script type="text/javascript" src="https://js.arcgis.com/3.21/"></script>
    <script type="text/javascript" src="WMTSLayer.js"></script>
    <script type="text/javascript">

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

        var map, wmtsLayer, wmtsLayeranno, wmtsLayerImg, wmtsLayerImganno, measure,  graphicsLayer;

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


                //document.getElementById("meaDiv").style.display = "none";
                //document.getElementById("drawDiv").style.display = "none";



                // loop through all dijits, connect onClick event
                // listeners for buttons to activate drawing tools
                registry.forEach(function (d) {
                    // d is a reference to a dijit
                    // could be a layout container or a button
                    if (d.declaredClass === "dijit.form.Button") {
                        d.on("click", activateTool);
                    }

                });

                //function addEventHandler(target, type, func) {
                //    if (target.addEventListener) {
                //        //监听IE9，谷歌和火狐 
                //        target.addEventListener(type, func, false);
                //    } else if (target.attachEvent) {
                //        target.attachEvent("on" + type, func);
                //    } else {
                //        target["on" + type] = func;
                //    }
                //}
                //function removeEventHandler(target, type, func) {
                //    if (target.removeEventListener) {
                //        //监听IE9，谷歌和火狐 
                //        target.removeEventListener(type, func, false);
                //    } else if (target.detachEvent) {
                //        target.detachEvent("on" + type, func);
                //    } else {
                //        delete target["on" + type];
                //    }
                //}
                //var eventOne = function () {
                //    activateTool('点');
                //}


                //function eventTwo() {
                //    activateTool('线');
                //}

                //var eventThree = function () {
                //    activateTool('面');
                //}


                //function eventFour() {
                //    activateTool('手绘线');
                //}

                //var eventFive = function () {
                //    activateTool('手绘面');
                //}

                //window.onload = function () {

                //    var bindEventBtn = document.getElementById("point");
                //    //监听eventOne事件 
                //    addEventHandler(bindEventBtn, "click", eventOne);

                //    //var bindEventBtn2 = document.getElementById("line");
                //    ////监听eventTwo事件 
                //    //addEventHandler(bindEventBtn2, "click", eventTwo);

                //    //var bindEventBtn3 = document.getElementById("polygon");
                //    ////监听eventOne事件 
                //    //addEventHandler(bindEventBtn3, "click", eventThree);

                //    //var bindEventBtn4 = document.getElementById("handline");
                //    ////监听eventTwo事件 
                //    //addEventHandler(bindEventBtn4, "click", eventFour);

                //    //var bindEventBtn5 = document.getElementById("handpolygon");
                //    ////监听eventTwo事件 
                //    //addEventHandler(bindEventBtn5, "click", eventFive);
                //    ////监听本身的事件 
                //    //addEventHandler(bindEventBtn, "click", function () {
                //    //    alert("第三个监听事件");
                //    //});


                //    ////取消第一个监听事件 
                //    //removeEventHandler(bindEventBtn, "click", eventOne);
                //    ////取消第二个监听事件 
                //    //removeEventHandler(bindEventBtn, "click", eventTwo);
                //}



                //function btnfun()
                //{
                //           alert("");
                //      //var btn = document.getElementById('point');      
                //      //btn.onclick = activateTool('点');

                //}

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
                document.getElementById("header").style.display = "none";
                document.getElementById("navid").style.display = "none";
                document.getElementById("footer").style.display = "none";

                document.getElementById("wrapper").style.top = "0px";
                document.getElementById("wrapper").style.bottom = "0px";

                document.getElementById("page-wrapper").style.margin = "0px 0px 0px 0px";

                document.getElementById("mapDiv_root").style.height = "650px";

                t = false;
            }
            else {

                document.getElementById("header").style.display = "block";
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


        function activedrawtool()
        {
            document.getElementById("drawDiv").style.display = "block";
        }


        function clean()
        {
            graphicsLayer.clear();
        }

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
                                <input type="text" class="form-control" placeholder="Search...">
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
                            <li><a href="#ios" data-toggle="tab">标签页二</a></li>
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
                                    <div class="panel-heading">组1</div>
                                    <div class="panel-body">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt est vitae ultrices accumsan. Aliquam ornare lacus adipiscing, posuere lectus et, fringilla augue.</p>
                                    </div>
                                    <div class="panel-heading">组2</div>
                                    <div class="panel-body">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt est vitae ultrices accumsan. Aliquam ornare lacus adipiscing, posuere lectus et, fringilla augue.</p>
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
                                <i  class="fa fa-tasks fa-fw"></i>清除
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

                        <div id="drawDiv" ondblclick="hidedraw()"  style="position: absolute; right: 20px; top: 10px; z-index: 999; background-color:ghostwhite;display:none;padding: 10px;">
                            <span>标绘工具：<br />
                            </span>
                            <button class="btn1" data-dojo-type="dijit/form/Button" type="button" value="点" style="border:none;">
                                <img style="height: 16px; width: 16px;  " src="dist/images/point.png" alt="点" />
                                <span  id="point"  style="font-size:16px">点</span>
                            </button>

                            <button data-dojo-type="dijit/form/Button" type="button"  value="线" style="border:none;">
                                <img style="height: 16px; width: 16px;  " src="dist/images/line.png" alt="线" />
                                <span  id="line"  style="font-size:16px">线</span>
                            </button>

                            <button  data-dojo-type="dijit/form/Button"  type="button" value="面" >
                                <img style="height: 16px; width: 16px; " src="dist/images/polygon.png" alt="面" />
                                <span  id="polygon"  style="font-size:16px">面</span>
                            </button>

                            <button data-dojo-type="dijit/form/Button"  type="button" value="手绘线" >
                                <img style="height: 16px; width: 16px; " src="dist/images/handline.png" alt="手绘线" />
                                <span  id="handline"  style="font-size:16px">手绘线</span>
                            </button>

                            <button data-dojo-type="dijit/form/Button"  type="button" value="手绘面" >
                                <img style="height: 16px; width: 16px; " src="dist/images/handpolygon.png" alt="手绘面" />
                                <span id="handpolygon" style="font-size:16px">手绘面</span>
                            </button>
                        </div>



                        <div id="mapDiv" class="calcite" data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'center'">


                            <div id="meaDiv" ondblclick="hidemea()" style="position: absolute; right: 20px; top: 10px; z-index: 999;display:none">
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
                                        <img alt="地形图" src="dist/images/basemaps/vectorType.png" onclick="removeimage()">
                                    </div>
                                    <div class="basemapTitle">地形图</div>
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





    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>

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
