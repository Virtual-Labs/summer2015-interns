$(document).ready(function(){
	/**
	Variable for flash plugins
	*/
	var hasFlash = false;
		try {
				/**
				Flash from ActiveX Object
				*/
				var fo = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
				if (fo) {
					hasFlash = true;
				}
			} catch (e) {
				/**
				Flash from Installed Plugins
				*/
				if (navigator.mimeTypes
					&& navigator.mimeTypes['application/x-shockwave-flash'] != undefined
					&& navigator.mimeTypes['application/x-shockwave-flash'].enabledPlugin) {
				hasFlash = true;
				}
			}
		/**
		If both Flash and Java are not present
		*/
		if (!hasFlash && !deployJava.versionCheck("1.6.0+")){
				alert("Java and Flash required!");
				document.getElementById("jf").style.visibility = "visible";
		}
		/**
		If Only Java is not present
		*/
		else if (!deployJava.versionCheck("1.6.0+")){
				alert("Java Required");
				document.getElementById("j").style.visibility = "visible";
		}
		/**
		If Only Flash is not present
		*/
		else if (!hasFlash){
				alert("Flash Required");
				document.getElementById("f").style.visibility = "visible";
		}
		/**
		If all the plugins are present
		*/
		else{
				/**
				If the OS is Windows, no extra plugin is required
				*/
				if (navigator.userAgent.indexOf("Windows") != -1) {
					alert("You have updated Configuration. Please proceed to the experiment site!");
					window.close();
				}
				/**
				If the OS is Linuz, icedtea plugin is required which is checked when clicked on Requirements link
				*/
				else{
					alert("If you are a linux user click on Requirements to verify your Configuration!");
				}
		}
});
