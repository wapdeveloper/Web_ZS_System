/**
 * 时间：(2015-05-20)
 * 说明：公共库
 * 编写人：wl
 */
 
/**
 * 打印类
 */
(function () { // encapsulate

	if(!window['WLJS']) { 
		window['WLJS']= {}; 
	}

	function ScreenPrinter(){
		//var myOwner = this;
	}
	
	ScreenPrinter.prototype = {
		isPrinting: false,
		print: function (myContainer) {
	
			var container = document.getElementById(myContainer),
				origParent = container.parentNode,
				origDisplay = [],
				body = document.body,
				childNodes = body.childNodes;

			$.each(childNodes, function (i, node) {
				if (node.nodeType === 1) {
					origDisplay[i] = node.style.display;
					node.style.display = 'none';
				}
			});
			
/* 			if (myOwner.isPrinting) { // block the button while in printing mode
				return;
			}

			myOwner.isPrinting = true; */
			
			body.appendChild(container);
			window.focus(); // #1510
			window.print();

			// allow the browser to prepare before reverting
			setTimeout(function () {

				// 判断地图对象容器的位置
				origParent.appendChild(container);

				// restore all body content
				$.each(childNodes, function (i, node) {
					if (node.nodeType === 1) {
						node.style.display = origDisplay[i];
					}
				});

			}, 1000);
		}
	};

	window['WLJS']['printer'] = new ScreenPrinter();
	
	function WlLogger(){
	
		this.logHead = '';
	
		this.writeRaw = function (message) {
			
			if(!console) return ;		
			
			// Add the message to the log node
			if(typeof message == 'undefined') {
				console.log('Message was undefined');
			} else {
				console.log(this.logHead + message);		
			}
			
			return this;
		};
	}
	
	WlLogger.prototype = {

		/** 
		 * Writes a write a partially encoded version of the message to the log window.
		 * If the message is not a String, the toString method will be 
		 * called on the object. If no toString() method exists, the typof
		 * will be logged.
		 * @param {Object} message
		 */
		write: function (message) {
			// warn about null messages
			if(typeof message == 'string' && message.length==0) {
				return this.writeRaw('WLJS.log: null message');
			}

			// if the message isn't a string try to call the toString() method,
			// if it doesn't exist simply log the type of object
			if (typeof message != 'string') {
				if(message.toString) return this.writeRaw(message.toString());
				else return this.writeRaw(typeof message);
			}

			// transform < and > so that .innerHTML doesn't parse the message as HTML
			message = message.replace(/</g,"&lt;").replace(/>/g,"&gt;");

			return this.writeRaw(message);
		},
		setHeader:function (head){
			if(typeof head == 'string' && head.length==0) {
				return this.writeRaw('WLJS.log: null head');
			}

			if (typeof head != 'string') {
				if(head.toString) return this.writeRaw(head.toString());
				else return this.writeRaw(typeof head);
			}
			
			return this.logHead = head;
		},
		clearHeader: function (){
			return this.logHead = '';
		}
	};

	
	window['WLJS']['log'] = new WlLogger();	
})();
