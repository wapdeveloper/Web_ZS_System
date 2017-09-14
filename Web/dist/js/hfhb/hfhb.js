
/*本项目的类*/
(function(){
	
	if(!window.HF) { window['HF']= {}; }
	
	window['HF'].map = null;
	
    function print(container) {
       // alert("d");
		WLJS.printer.print(container);
	};
	
	function log(message){
		WLJS.log.write(message);
	};
	

	WLJS.log.setHeader('HFHB_log : ');
	
	//WLJS.log.clearHeader();
	
	window['HF']['print'] = print;
	window['HF']['log'] = log;
	
})();
