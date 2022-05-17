alert('welcome')

var connect="ws://localhost:8070/WebSocket_Chat/endpoint";
var websocket=new WebSocket(connect);


var msg,sender,receiver;
sender=document.getElementById('Sender').value;
receiver=document.getElementById("Receiver").value;

websocket.onmessage = function(message){
	document.getElementById('message').innerHTML= "";
	onMessage(message);
	
}

websocket.onopen = function() {
	onOpen();
}

function onOpen(){
	//console.log("Opened: "+connect);
}
function onClose(){
	//console.log("Closed: "+connect);
}
function onMessage(message){
	//alert(message);
	//console.log(message);
	display(message.data);
	
}
function send(){
	
	msg=document.getElementById('message').value;
	sender=document.getElementById("Sender").value;
	receiver=document.getElementById("Receiver").value;

	if(msg.trim()=="" || msg==null){
		alert("Enter the message");
	}
	
	document.getElementById('message').innerHTML= "";	
	//alert(msg);
	//console.log("Message : "+msg);
	var obj={
		username:sender, 
		messages:msg,
		client:receiver
	};
	websocket.send(JSON.stringify(obj));
}
function display(msg){
	
	var arr=msg.split(":");
	var Read=arr[1].split(",");
	
	var sender1=Read[0].substring(1,Read[0].length-1);
	var len1=arr[arr.length-1];
	
	var len=len1.length;
	var receiver1=arr[arr.length-1].substring(1,len-2);
	//console.log(sender+" "+sender1+" "+receiver+" "+receiver1);
	var temp=msg.split(",");
	var answer=temp[1].split(":");  var output=answer[1].substring(1,answer[1].length-1);
	
	
	if(output.trim()!="" && output!=null){
		if((sender==sender1 && receiver==receiver1)||(sender==receiver1 && receiver==sender1  ))
		{
			document.getElementById('Area').innerHTML+=(sender1+":"+output +"<br><br>");
		}
	}	
}
