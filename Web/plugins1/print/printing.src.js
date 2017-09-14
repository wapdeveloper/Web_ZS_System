/**
 * 时间：(2015-5-20)
 * 说明：浏览器打印模块
 * 编写人：wl
 */


(function () { // encapsulate

	function screenPrinter(){

	}
	
	screenPrinter.prototype = {
		isPrinting: false,
		print: function (myContainer) {

			var container = $('#' + myContainer),
				origParent = container.parent(),
				origDisplay = [],
				body = $('body'),
				childNodes = body.children();

			$.each(childNodes, function (i, node) {
				if (node.nodeType === 1) {
					origDisplay[i] = node.style.display;
					node.style.display = NONE;
				}
			});
			
			body.append(container);

			win.focus(); // #1510
			win.print();

			// allow the browser to prepare before reverting
			setTimeout(function () {

				// 判断地图对象容器的位置
				origParent.append(container);

				// restore all body content
				$.each(childNodes, function (i, node) {
					if (node.nodeType === 1) {
						node.style.display = origDisplay[i];
					}
				});

			}, 1000);
		}
	};

	if(!window.Webprint) { window['Webprint']= {}; }
	
	window['Webprint'].['print'] = new screenPrinter();
	
}());
