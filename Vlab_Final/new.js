$(document).ready(function(){
var hasFlash = false;
		try {
				var fo = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
				if (fo) {
					hasFlash = true;
				}
			} catch (e) {
				if (navigator.mimeTypes
					&& navigator.mimeTypes['application/x-shockwave-flash'] != undefined
					&& navigator.mimeTypes['application/x-shockwave-flash'].enabledPlugin) {
				hasFlash = true;
				}
			}
		if (!hasFlash && !deployJava.versionCheck("1.6.0+")){
			if (navigator.userAgent.indexOf("WOW64") != -1 || navigator.userAgent.indexOf("Win64") != -1) {
				alert("Java+Flash+64");
				document.getElementById("jf64").style.visibility = "visible";
			}
			else {
				alert("Java+Flash+32");
				document.getElementById("jf32").style.visibility = "visible";
			}
		}
		else if (!deployJava.versionCheck("1.6.0+")){
				if (navigator.userAgent.indexOf('Chrome') == -1){
				if (navigator.userAgent.indexOf("WOW64") != -1 || navigator.userAgent.indexOf("Win64") != -1) {
					alert("Java+64");
					document.getElementById("j64").style.visibility = "visible";
				}
				else {
					alert("Java+64");
					document.getElementById("j32").style.visibility = "visible";
				}
				}
		}
		else if (!hasFlash){
			if (navigator.userAgent.indexOf("WOW64") != -1 || navigator.userAgent.indexOf("Win64") != -1) {
				alert("Flash+64");
				document.getElementById("f64").style.visibility = "visible";
			}
			else {
				alert("Flash+64");
				document.getElementById("f32").style.visibility = "visible";
			}
		}
});