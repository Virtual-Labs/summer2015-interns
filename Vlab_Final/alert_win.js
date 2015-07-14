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
				alert("Java and Flash required!");
				document.getElementById("jf").style.visibility = "visible";
		}
		else if (!deployJava.versionCheck("1.6.0+")){
				alert("Java Required");
				document.getElementById("j").style.visibility = "visible";
		}
		else if (!hasFlash){
				alert("Flash Required");
				document.getElementById("f").style.visibility = "visible";
		}
});
