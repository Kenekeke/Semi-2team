<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function(){
		$(document).ready(function(){
			alert("등록이 완료 되었습니다.")
			location.href ="<%=request.getContextPath()%>/member/room-list.jsp";
		});
		
	});
</script>




