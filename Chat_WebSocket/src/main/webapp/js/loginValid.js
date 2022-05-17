function check(){
	var username = document.getElementById('name').value;
	var password = document.getElementById('pass').value;
	if(username==null || username=='' || password==null || password==''){
		alert("Invalid User Details")
		window.location.href='index1.html';
	}
	else{
		alert('Login Details Submitted');
	}
}

function close_tab(){
	var condition = confirm("Do You want to Close the Tab");
	if(condition) close();
}