define("tdtlib/TianDiTuLayer", ["dojo/_base/declare", "esri/SpatialReference", "esri/layers/TiledMapServiceLayer", "esri/layers/TileInfo", "esri/geometry/Extent"], function (declare, SpatialReference, TiledMapServiceLayer, TileInfo, Extent){

    var _TianDiTuLayer = declare("tdtlib.TianDiTuLayer", [TiledMapServiceLayer], {
		constructor: function (id, tdtType) {
            this.tdtType = tdtType;
            this.spatialReference = new esri.SpatialReference({ wkid: 4490 });
            this.initialExtent = (this.fullExtent =
		            new esri.geometry.Extent(-180.0, -90.0, 180.0, 90.0, this.spatialReference));
            this.id = id;
            this.tileInfo = new esri.layers.TileInfo({
                "rows": 256,
                "cols": 256,
                "compressionQuality": 0,
                "origin": { "x": -180, "y": 90 },
                "spatialReference": { "wkid": 4490 },
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
            this.loaded = true;
            this.onLoad(this);
        },
        getTileUrl: function (level, row, col) {
            var url = "";
            var tdt = this.tdtType;
            switch (tdt) {
                case 1:
                    url = "vec_c";
                    break;
                case 2:
                    url = "cva_c";
                    break;
                case 3:
                    url = "img_c";
                    break;
                case 4:
                    url = "cia_c";
                    break;
                default:
                    url = "vec_c";
                    break;
            }

            return "http://t1.tianditu.cn/DataServer?T=" + url + "&X=" + col + "&" + "Y=" + row + "&" + "L=" + level;
        }
	});
	return _TianDiTuLayer;
});

