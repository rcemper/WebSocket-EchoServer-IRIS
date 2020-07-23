/// Enhanced test Client from Caché SAMPLES
Class WSS.csp Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
	&HTML<
	 <html>
<!-- Client JavaScript to validate the values entered by the user -->
<script language="JavaScript" type="text/javascript">
var ws;
var line
var wsserver = "/csp/##($namespace)##/WS.EchoServer.cls"

if ((typeof(WebSocket) == 'undefined') && (typeof(MozWebSocket) != 'undefined')) {
	WebSocket = MozWebSocket;
}
function init() {
	ws = new WebSocket(((window.location.protocol == "https:") ? "wss:" : "ws:") + "//" + window.location.host + wsserver);
	ws.onopen = function(event) {
		document.getElementById("main").style.visibility = "visible";
		document.getElementById("connected").innerHTML = "Connected to WebSocket server: <b>" + decodeURIComponent(wsserver) + "</b>";
	};
	ws.onmessage = function(event) {
		document.getElementById("output").innerHTML = "<b>" + event.data + "</b>";
		line = document.getElementById("log").innerHTML;
		document.getElementById("log").innerHTML = line + "<li>" + event.data + "</li>" ; 
	};
	ws.onerror = function(event) {
		document.getElementById("connected").innerHTML = "Connection Error - Check that the web server supports web sockets";
	};
	ws.onclose = function(event) {
		ws = null;
		document.getElementById("main").style.visibility = "hidden";
		document.getElementById("connected").innerHTML = "Connection Closed";
 	}
}
function send(message) {
	if (ws) {
		ws.send(message);
		document.getElementById("input").value="" ;
	}
}
</script>
</head>	
<body bgcolor="#C0FFC0" onload="init();">
<title>WebSocket Sample</title>
<h1>WebSocket Sample</h1><p>
This sample uses the <b>WebSocket</b> protocol to communicate with the server.<br>
Note that it requires a web server compatible with web sockets and the browser<br> 
also support web sockets, so the following versions or later <br>
<ul><li>IE10</li><li>Firefox 11</li><li>Chrome 16</li><li>Safari 6</li><li>Opera 12</li></ul>

<h3>WebSocket Echo Demo</h3>
<p>
    <div id="connected">Not Connected</div>
</p>
<p>
    <div id="main" style="visibility:hidden">
    Enter Message (Enter 'exit' to quit): <input type="text" name="message" id="input" value="" size="80" onchange="send(this.value)"/><br/>
    <p>Response from Cache Server ... <div id="output"></div></p>
    <b>Connection Log</b><ul>
    <div id="log"></div></ul>
    </div>

</body>
</html>
>
	Quit $$$OK
}

}
