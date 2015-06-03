/**
 * Created by NIKHIL PUNNAM on 6/3/2015.
 */
function LoadFile() {


    //Reading and displaying the Plugins Required
    var oFrame = document.getElementById("frmFile");
    var strRawContents = oFrame.contentWindow.document.body.childNodes[0].innerHTML;
    while (strRawContents.indexOf("\r") >= 0)
        strRawContents = strRawContents.replace("\r", "");
    var arrLines = strRawContents.split("\n");
    document.writeln("File " + oFrame.src + " has " + arrLines.length + " line(s)<br/>");

    for (var i = 0; i < arrLines.length; i++) {
        var temp = false;
        var curLine = arrLines[i];
        document.write("Line #" + (i + 1) + " is: '" + curLine + "'<br/>");
        for( var j=0; j<navigator.plugins.length; j++){
            var plugin = navigator.plugins[j];
            var plugin_name = plugin.name;
            var n = plugin_name.search(curLine);
            if(n!=-1) {
                document.write("Plugin Present<br/>");
                temp=true;
                break;
            }

        }
        if(temp==false) document.write("Plugin is not present");
    }


    var unknown = 'Unknown';

    // screen
    var screenSize = '';
    var width, height;
    if (screen.width) {
        width = (screen.width) ? screen.width : '';
        height = (screen.height) ? screen.height : '';
        screenSize += '' + width + " x " + height;
    }


    //browser
    var nVer = navigator.appVersion;
    var nAgt = navigator.userAgent;
    var browser = navigator.appName;
    var version = '' + parseFloat(navigator.appVersion);
    var majorVersion = parseInt(navigator.appVersion, 10);
    var nameOffset, verOffset, ix;

    // Opera
    if ((verOffset = nAgt.indexOf('Opera')) != -1) {
        browser = 'Opera';
        version = nAgt.substring(verOffset + 6);
        if ((verOffset = nAgt.indexOf('Version')) != -1) {
            version = nAgt.substring(verOffset + 8);
        }
    }
    // MSIE
    else if ((verOffset = nAgt.indexOf('MSIE')) != -1) {
        browser = 'Microsoft Internet Explorer';
        version = nAgt.substring(verOffset + 5);
    }

    //IE 11 no longer identifies itself as MS IE, so trap it
    //http://stackoverflow.com/questions/17907445/how-to-detect-ie11
    else if ((browser == 'Netscape') && (nAgt.indexOf('Trident/') != -1)) {

        browser = 'Microsoft Internet Explorer';
        version = nAgt.substring(verOffset + 5);
        if ((verOffset = nAgt.indexOf('rv:')) != -1) {
            version = nAgt.substring(verOffset + 3);
        }

    }

    // Chrome
    else if ((verOffset = nAgt.indexOf('Chrome')) != -1) {
        browser = 'Chrome';
        version = nAgt.substring(verOffset + 7);
    }
    // Safari
    else if ((verOffset = nAgt.indexOf('Safari')) != -1) {
        browser = 'Safari';
        version = nAgt.substring(verOffset + 7);
        if ((verOffset = nAgt.indexOf('Version')) != -1) {
            version = nAgt.substring(verOffset + 8);
        }

        // Chrome on iPad identifies itself as Safari. Actual results do not match what Google claims
        //  at: https://developers.google.com/chrome/mobile/docs/user-agent?hl=ja
        //  No mention of chrome in the user agent string. However it does mention CriOS, which presumably
        //  can be keyed on to detect it.
        if (nAgt.indexOf('CriOS') != -1) {
            //Chrome on iPad spoofing Safari...correct it.
            browser = 'Chrome';
            //Don't believe there is a way to grab the accurate version number, so leaving that for now.
        }
    }
    // Firefox
    else if ((verOffset = nAgt.indexOf('Firefox')) != -1) {
        browser = 'Firefox';
        version = nAgt.substring(verOffset + 8);
    }
    // Other browsers
    else if ((nameOffset = nAgt.lastIndexOf(' ') + 1) < (verOffset = nAgt.lastIndexOf('/'))) {
        browser = nAgt.substring(nameOffset, verOffset);
        version = nAgt.substring(verOffset + 1);
        if (browser.toLowerCase() == browser.toUpperCase()) {
            browser = navigator.appName;
        }
    }
    document.write("<center> <br> <h3>Client Machine Details</h3></center>");
    document.write("<center> Browser : " + browser + "</center>");
    // trim the version string
    if ((ix = version.indexOf(';')) != -1) version = version.substring(0, ix);
    if ((ix = version.indexOf(' ')) != -1) version = version.substring(0, ix);
    if ((ix = version.indexOf(')')) != -1) version = version.substring(0, ix);

    majorVersion = parseInt('' + version, 10);
    if (isNaN(majorVersion)) {
        version = '' + parseFloat(navigator.appVersion);
        majorVersion = parseInt(navigator.appVersion, 10);
    }

    // mobile version
    var mobile = /Mobile|mini|Fennec|Android|iP(ad|od|hone)/.test(nVer);

    // cookie
    var cookieEnabled = !!(navigator.cookieEnabled);

    if (typeof navigator.cookieEnabled == 'undefined' && !cookieEnabled) {
        document.cookie = 'testcookie';
        cookieEnabled = (document.cookie.indexOf('testcookie') != -1);
    }

    // system
    var os = unknown;
    var clientStrings = [
        {s: 'Windows 3.11', r: /Win16/},
        {s: 'Windows 95', r: /(Windows 95|Win95|Windows_95)/},
        {s: 'Windows ME', r: /(Win 9x 4.90|Windows ME)/},
        {s: 'Windows 98', r: /(Windows 98|Win98)/},
        {s: 'Windows CE', r: /Windows CE/},
        {s: 'Windows 2000', r: /(Windows NT 5.0|Windows 2000)/},
        {s: 'Windows XP', r: /(Windows NT 5.1|Windows XP)/},
        {s: 'Windows Server 2003', r: /Windows NT 5.2/},
        {s: 'Windows Vista', r: /Windows NT 6.0/},
        {s: 'Windows 7', r: /(Windows 7|Windows NT 6.1)/},
        {s: 'Windows 8.1', r: /(Windows 8.1|Windows NT 6.3)/},
        {s: 'Windows 8', r: /(Windows 8|Windows NT 6.2)/},
        {s: 'Windows NT 4.0', r: /(Windows NT 4.0|WinNT4.0|WinNT|Windows NT)/},
        {s: 'Windows ME', r: /Windows ME/},
        {s: 'Android', r: /Android/},
        {s: 'Open BSD', r: /OpenBSD/},
        {s: 'Sun OS', r: /SunOS/},
        {s: 'Linux', r: /(Linux|X11)/},
        {s: 'iOS', r: /(iPhone|iPad|iPod)/},
        {s: 'Mac OS X', r: /Mac OS X/},
        {s: 'Mac OS', r: /(MacPPC|MacIntel|Mac_PowerPC|Macintosh)/},
        {s: 'QNX', r: /QNX/},
        {s: 'UNIX', r: /UNIX/},
        {s: 'BeOS', r: /BeOS/},
        {s: 'OS/2', r: /OS\/2/},
        {s: 'Search Bot', r: /(nuhk|Googlebot|Yammybot|Openbot|Slurp|MSNBot|Ask Jeeves\/Teoma|ia_archiver)/}
    ];
    for (var id in clientStrings) {
        var cs = clientStrings[id];
        if (cs.r.test(nAgt)) {
            os = cs.s;
            break;
        }
    }
    document.write("<center><br/>OS : " + os + "</center>");

    var osVersion = unknown;

    if (/Windows/.test(os)) {
        osVersion = /Windows (.*)/.exec(os)[1];
        os = 'Windows';
    }

    switch (os) {
        case 'Mac OS X':
            osVersion = /Mac OS X (10[\.\_\d]+)/.exec(nAgt)[1];
            break;

        case 'Android':
            osVersion = /Android ([\.\_\d]+)/.exec(nAgt)[1];
            break;

        case 'iOS':
            osVersion = /OS (\d+)_(\d+)_?(\d+)?/.exec(nVer);
            osVersion = osVersion[1] + '.' + osVersion[2] + '.' + (osVersion[3] | 0);
            break;

    }

    if (navigator.userAgent.indexOf("WOW64") != -1 || navigator.userAgent.indexOf("Win64") != -1) {
        document.write("<center><br/>Architecture :  64 bit OS</center>");
    }
    else {
        document.write("<center><br/>Architecture :  32 bit OS</center>");
    }


    //**********************Browser Details***********************
    numPlugins = navigator.plugins.length;

    if (numPlugins > 0)
        document.writeln("Installed plug-ins<br/><br/>");
    else
        document.writeln("No plug-ins are installed.<br/><br/>");

    for (i = 0; i < numPlugins; i++) {
        plugin = navigator.plugins[i];
        document.write("<font size=+1><b>");
        document.write(i + ") " + plugin.name);
        document.writeln("</b></font></center><br>");
        document.writeln("<dl>");
        document.writeln("<dd>File name:");
        document.write(plugin.filename);
        document.write("<dd><br>");
        document.write(plugin.description);
        document.writeln("</dl>");
        document.writeln("<p>");
        document.writeln("<table border=1 >");
        document.writeln("<tr>");
        document.writeln("<th width=40%>Mime Type</th>");
        document.writeln("<th width=40%>Description</th>");
        document.writeln("<th width=10%>Enabled</th>");
        document.writeln("</tr>");
        numTypes = plugin.length;
        for (j = 0; j < numTypes; j++) {
            mimetype = plugin[j];

            if (mimetype) {
                enabled = "No";
                enabledPlugin = mimetype.enabledPlugin;
                if (enabledPlugin && (enabledPlugin.name == plugin.name))
                    enabled = "Yes";
                document.writeln("<t    r align=center>");
                document.writeln("<td>");
                document.write(mimetype.type);
                document.writeln("</td>");
                document.writeln("<td>");
                document.write(mimetype.description);
                document.writeln("</td>");
                document.writeln("<td>");
                document.writeln(enabled);
                document.writeln("</td>");
                document.writeln("</tr>");
            }
        }
        document.write("</table> <br/>");
    }

    window.browserInfo = {
        screen: screenSize,
        browser: browser,
        browserVersion: version,
        mobile: mobile,
        os: os,
        osVersion: osVersion,
        cookies: cookieEnabled
    };
}