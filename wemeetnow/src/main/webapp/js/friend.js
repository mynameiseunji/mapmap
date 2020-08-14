function frpush(inviter, status){	
	var check = true;
	if(status=="1"){
		check=confirm("수락하시겠습니까?");
	}else{
		check=confirm("거절하시겠습니까?");
	}
	if(check){
		$.ajax({
			type:"POST",
	        url:"friend_accept.do",
	        data: {"inviter":inviter,
	        	"status":status
	        },
	        dataType:'text', 
	        success: function (data){
	        	location.reload(true);
	        }
		});
	}
}
	