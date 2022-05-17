alert('Welcome');


var connect = "ws://localhost:8070/WebSocket_Chat/GroupChat";
var websocket = new WebSocket(connect);

var user,grpname,msg;
user=document.getElementById('user').value;
grpname=document.getElementById('group').value;

websocket.onmessage = function(message){
	onMessage(message);
}

websocket.onopen = function(){
	onOpen();
}


function onMessage(message){
	display(message.data);
}

function onOpen() { }
function onClose(){ }

function send(){
	user = document.getElementById('user').value;
	grpname = document.getElementById('group').value;
	msg = document.getElementById('msg').value;
	
	if(msg.trim()==null || msg=='') {
		alert("Enter the message");
	}
	
	var obj = {
		username:user,
		groupname:grpname,
		message:msg
	};
	
	websocket.send(JSON.stringify(obj));
}

function display(msg){
	var arr= msg.split(",");
	
	var names=arr[1].split(":");
	var grp_Name=names[1].substring(1,names[1].length-1);
	
	var send=arr[0].split(":"); 
	var sender = send[1].substring(1,send[1].length-1);
	
	var mesgs = arr[2].split(":");
	var mesg = mesgs[1].substring(1,mesgs[1].length-2);
	
	if(grp_Name==grpname && mesg.trim()!="" && mesg!=null) 
	 	document.getElementById('Area').innerHTML+=((sender+" : "+mesg)+"<br><br>");
	
	document.getElementById('msg').innerHTML = ""; 	 	
}

