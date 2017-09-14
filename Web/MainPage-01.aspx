<!DOCTYPE html>
<html lang="zh-CN">
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=7,IE=9" />	

    <title>布局 - Bootstrap Admin Theme</title>

    <!-- Bootstrap Core CSS -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

	<!-- Arcgis CSS -->


<%--	<link rel="stylesheet" type="text/css" href="http://localhost:8094/3.14/dijit/themes/claro/claro.css"/>
    <link rel="stylesheet" type="text/css" href="http://localhost:8094/3.14/esri/css/esri.css" />--%>

    <link rel="stylesheet" href="https://js.arcgis.com/3.14/dijit/themes/claro/claro.css">
    <link rel="stylesheet" href="https://js.arcgis.com/3.14/esri/css/esri.css">





    <!-- Custom CSS -->
    <link href="dist/css/main.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

	<script src="http://js.arcgis.com/3.14/"></script>
	
	<script type="text/javascript">
		
		var dojoConfig = {
			parseOnLoad: true,
			packages: [{
					name: "agsjs",
					location: location.pathname.replace(/\/[^/]+$/, '') + '/agsjs'
				},{
					name: "tdtlib",
					location: location.pathname.replace(/\/[^/]+$/, '') + '/plugins/tdtlib'
				}
			],
			async: true
		};
		
	</script>





        <script>



            var map, wmtsLayer;
            var baseMap, baseMapanno, imgMap, imgMapanno;

            require([

                "esri/map", "esri/layers/WebTiledLayer", "esri/layers/WMTSLayer", "esri/layers/WMTSLayerInfo", "esri/dijit/Measurement", 
                "esri/geometry/Extent", "esri/layers/TileInfo", "esri/SpatialReference",
                "dojo/parser", "esri/geometry/Point",

                "dijit/layout/BorderContainer", "dijit/layout/ContentPane", "dijit/TitlePane","dojo/domReady!"
            ], function (

                Map, WebTiledLayer, WMTSLayer, WMTSLayerInfo, Measurement, 
                Extent, TileInfo, SpatialReference,
                parser, Point
            ) {
                    parser.parse();

                    //四至
                    var bounds = new Extent({
                        "xmin": -180.0, "ymin": -90.0, "xmax": 180, "ymax": 90.0,
                        "spatialReference": { "wkid": 4326 } //坐标系
                    });
                    map = new Map("mapDiv", {
                        extent: bounds,
                        center: [113.27, 23.13],  //中心
                        zoom: 9   //缩放等级
                    });

                    var tileInfo1 = new TileInfo({
                        "dpi": 96,
                        "format": "tile",
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
                        "lods": [
                            { "level": 1, "resolution": 0.703125, "scale": 295497593.058752 },
                            { "level": 2, "resolution": 0.3515625, "scale": 147748796.529376 },
                            { "level": 3, "resolution": 0.17578125, "scale": 73874398.264688 },
                            { "level": 4, "resolution": 0.087890625, "scale": 36937199.132344 },
                            { "level": 5, "resolution": 0.0439453125, "scale": 18468599.566172 },
                            { "level": 6, "resolution": 0.02197265625, "scale": 9234299.783086 },
                            { "level": 7, "resolution": 0.010986328125, "scale": 4617149.891543 },
                            { "level": 8, "resolution": 0.0054931640625, "scale": 2308574.945771 },
                            { "level": 9, "resolution": 0.00274658203125, "scale": 1154287.472886 },
                            { "level": 10, "resolution": 0.001373291015625, "scale": 577143.736443 },
                            { "level": 11, "resolution": 0.0006866455078125, "scale": 288571.86822143558 },
                            { "level": 12, "resolution": 0.00034332275390625, "scale": 144285.93411071779 },
                            { "level": 13, "resolution": 0.000171661376953125, "scale": 72142.967055358895 },
                            { "level": 14, "resolution": 0.0000858306884765625, "scale": 36071.4835276794475 },
                            { "level": 15, "resolution": 0.00004291534423828125, "scale": 18035.741763839724 },
                            { "level": 16, "resolution": 0.000021457672119140625, "scale": 9017.870881919861875 },
                            { "level": 17, "resolution": 0.0000107288360595703125, "scale": 4508.9354409599309375 },
                            { "level": 18, "resolution": 0.00000536441802978515625, "scale": 2254.46772047996546875 }
                        ]
                    });


                    baseMap = new WebTiledLayer("http://t1.tianditu.com/vec_c/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=vec&STYLE=default&TILEMATRIXSET=c&TILEMATRIX=${level}&TILECOL=${col}&TILEROW=${row}&FORMAT=tiles", {
                        "copyright": "广东省地图院",
                        "id": "baseMap",
                        "tileInfo": tileInfo1
                    });

                    baseMapanno = new WebTiledLayer("http://t0.tianditu.com/cva_c/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=cva&STYLE=default&TILEMATRIXSET=c&TILEMATRIX=${level}&TILECOL=${col}&TILEROW=${row}&FORMAT=tiles", {
                        "copyright": "广东省地图院",
                        "id": "baseMapanno",
                        "tileInfo": tileInfo1
                    });

                    imgMap = new WebTiledLayer("http://t0.tianditu.com/img_c/wmts?service=wmts&request=GetTile&version=1.0.0&LAYER=img&tileMatrixSet=c&TileMatrix=${level}&TileRow=${row}&TileCol=${col}&style=default&format=tiles", {
                        "copyright": "广东省地图院",
                        "id": "imgMap",
                        "tileInfo": tileInfo1
                    });



                    imgMapanno = new WebTiledLayer("http://t0.tianditu.com/cia_c/wmts?service=wmts&request=GetTile&version=1.0.0&LAYER=cia&tileMatrixSet=c&TileMatrix=${level}&TileRow=${row}&TileCol=${col}&style=default&format=tiles", {
                        "copyright": "广东省地图院",
                        "id": "imgMapanno",
                        "tileInfo": tileInfo1
                    });



                    map.addLayers([baseMap]);
                    map.addLayers([baseMapanno]);















                    //map.addLayers([imgMap]);
                    //map.addLayers([imgMapanno]);     

                    //http://services.tianditugd.com/gdimg201311/wmts?SERVICE=WMTS&REQUEST=GetCapabilities
                    // anno.visible=false;
                    //map.centerAndZoom(new Point({ "x": 115.317880, "y": 22.970000, "spatialReference": { "wkid": 4326} }), 9);
                });

            function printpage() {
                window.print()
            }


            function addimage() {

                map.removeLayer(baseMap);
                map.removeLayer(baseMapanno);
                map.addLayers([imgMap]);
                map.addLayers([imgMapanno]);

            }

            function removeimage() {

                map.removeLayer(imgMap);
                map.removeLayer(imgMapanno);
                map.addLayers([baseMap]);
                map.addLayers([baseMapanno]);
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




            function measurement()
            {
                document.getElementById("meaDiv").style.display = "block";

                var measurement = new esri.dijit.Measurement({    // 测量工具  
                    map: map
                }, dojo.byId('measurementDiv'));
                measurement.startup();    // 开启  

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
                        <i class="fa fa-user fa-fw"></i> 资料管理  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i> 附件管理</a></li>
						<li class="divider"></li>
                        <li>
							<a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-gear fa-fw"></i> 成果图管理</a>
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
                        <i class="fa fa-user fa-fw"></i> 用户  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i> 个人信息</a>
                        </li>
                        <li><a href="#"><i class="fa fa-gear fa-fw"></i> 配置</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="pages/login.html"><i class="fa fa-sign-out fa-fw"></i> 登出</a>
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
								<i class="fa fa-arrows-alt fa-fw"></i> 全屏
							</a>
							<!-- /.dropdown-messages -->
						</li>
						<!-- /.dropdown -->
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">
								<i class="fa fa-tasks fa-fw"></i> 清除
							</a>
							<!-- /.dropdown-tasks -->
						</li>
						<!-- /.dropdown -->
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">
								<i class="fa fa-gear fa-fw"></i> 工具  <i class="fa fa-caret-down"></i>
							</a>
							<ul class="dropdown-menu dropdown-user">
								<li onclick="measurement()"><a href="#"><i class="fa fa-user fa-fw"></i> 测量</a></li>
								<li class="divider"></li>
								<li><a href="#"><i class="fa fa-gear fa-fw"></i> 标注</a></li>	
								<li class="divider"></li>
								<li><a href="#"><i class="fa fa-gear fa-fw"></i> 统计</a></li>
								<li class="divider"></li>
								<li><a href="#" id = "print"><i class="fa fa-gear fa-fw"></i> 打印</a></li>
<%--								<li><a href="#"  onclick="printpage()"><i class="fa fa-gear fa-fw"></i> 打印</a></li>--%>
							</ul>
							<!-- /.dropdown-messages -->
							<!-- /.dropdown-alerts -->
						</li>
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">
								<i class="fa fa-user fa-fw"></i> 对比  <i class="fa fa-caret-down"></i>
							</a>
							<ul class="dropdown-menu dropdown-user">
							    <li><a href="#" id= "swipeOn" ><i class="fa fa-user fa-fw"></i> 对比浏览</a>
								</li>
								<li><a href="#"><i class="fa fa-gear fa-fw"></i> 取消对比</a>
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

						<div id="mapDiv" >

                            <div id="meaDiv" style="position:absolute; right:20px; top:10px; z-Index:999; display:none">
                              <div id="titlePane" data-dojo-type="dijit/TitlePane" data-dojo-props="title:'测量工具', closable:'false', open:'false'">
                                <div id="measurementDiv"></div>
                                <span style="font-size:smaller;padding:5px 5px;">Press <b>CTRL</b> to enable snapping.</span>
                              </div>
                            </div>

					<div id="swipeDiv"></div> 
							 <!-- /.layerswipe -->
							<div id="mapTypeDiv" class ="mapType">
								<div class="basemapContainer">
									<div title="切换底图" role="button" class="toggleButton topo">
										<div class="basemapImage"><img alt="地形图" src="dist/images/basemaps/vectorType.png" onclick="removeimage()"></div>
										<div class="basemapTitle">地形图</div>
									</div>
								</div>
								<div class="basemapContainer">
									<div title="切换底图" role="button" class="toggleButton topo">
										<div class="basemapImage"><img alt="影像图" src="dist/images/basemaps/imageType.png" onclick="addimage()"></div>
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

    </div>
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
