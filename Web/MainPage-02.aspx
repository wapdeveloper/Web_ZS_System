<!DOCTYPE html>
<html lang="zh-CN">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=7,IE=9" />


    <title>布局 - Bootstrap Admin Theme</title>

    <!-- Bootstrap Core CSS -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Arcgis CSS -->



    <link rel="stylesheet" href="https://js.arcgis.com/3.21/esri/themes/calcite/dijit/calcite.css">
    <link rel="stylesheet" href="https://js.arcgis.com/3.21/esri/themes/calcite/esri/esri.css">



    <!-- Custom CSS -->
    <link href="dist/css/main.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">


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



        var map, wmtsLayer, wmtsLayeranno, wmtsLayerImg, wmtsLayerImganno, measure;

        require([

            "esri/map", "esri/layers/WebTiledLayer", "esri/layers/WMTSLayer", "esri/layers/WMTSLayerInfo", "esri/dijit/Measurement",
            "esri/geometry/Extent", "esri/layers/TileInfo", "esri/SpatialReference",
            "dojo/parser", "esri/geometry/Point", "esri/units",

            "dijit/layout/BorderContainer", "dijit/layout/ContentPane", "dijit/TitlePane", "dojo/domReady!"
        ], function (

            Map, WebTiledLayer, WMTSLayer, WMTSLayerInfo, Measurement,
            Extent, TileInfo, SpatialReference,
            parser, Point, Units
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


                document.getElementById("meaDiv").style.display = "none";

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

 



            //document.getElementById("meaDiv").style.display = "none";

            document.getElementById("meaDiv").style.display = "block";



        }


        function hidemea()
        {
            measure.clearResult();
            document.getElementById("meaDiv").style.display = "none";
        }





    </script>








</head>

<body class="claro">


    <div class="mainheader" id="header">
        <h1>Header</h1>
    </div>


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
                <a class="navbar-brand" href="#">自定义首页模板</a>
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
                        <li class="dropdown">
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
                                <li><a href="#"><i class="fa fa-gear fa-fw"></i>标注</a></li>
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

                        <div id="mapDiv" class="calcite" data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'center'">


                            <div id="meaDiv" ondblclick="hidemea()" style="position: absolute; right: 20px; top: 10px; z-index: 999;">
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
