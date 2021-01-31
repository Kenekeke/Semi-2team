<%@page import="java.util.List"%>
<%@page import="houseSemi.beans.OfficeDto"%>
<%@page import="houseSemi.beans.OfficeDao"%>
<%@page import="houseSemi.beans.VillatwoDto"%>
<%@page import="houseSemi.beans.VillatwoDao"%>
<%@page import="houseSemi.beans.OneDto"%>
<%@page import="houseSemi.beans.PhotoDao"%>
<%@page import="houseSemi.beans.PhotoDto"%>
<%@page import="houseSemi.beans.OneDao"%>
<%@page import="houseSemi.beans.HouseDto"%>
<%@page import="houseSemi.beans.HouseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int house_no = Integer.parseInt(request.getParameter("house_no"));

	HouseDao houseDao = new HouseDao();
	HouseDto houseDto = houseDao.find(house_no);
	
	
		
	OneDao	oneDao = new OneDao();
	OneDto oneDto = oneDao.find(house_no);
	
	VillatwoDao villatwoDao = new VillatwoDao();
	VillatwoDto villatwoDto = villatwoDao.find(house_no);
	
	OfficeDao officeDao = new OfficeDao();
	OfficeDto officeDto = officeDao.find(house_no);
	
	
	PhotoDao photoDao = new PhotoDao();
	List<PhotoDto> photoList = photoDao.selectThis(house_no);
%>

<style>
	li{list-style: none;}
	.main-table_wrapper{
		width: 1000px;
		margin: 40px auto 0 auto;
		border: 3px solid #7b9acc;
	}
	.main-table{
		width: 1000px;
		padding: 20px 0;
	}
	.main-table > tbody > tr > td {
		border-right: 2px solid lightgray;
		padding-left: 15px;
	}
	.main-table > tbody > tr > td:last-child {
		border-right: none;
	}
	.main-table > tbody > tr > td > h2{
		display: inline-block;
		margin: 19px 0;
	}
	.room-list{
		margin: 0 auto;
	}
	.room-list ul{
            margin: 0;
            padding: 0;
        }
	.list > li{
            display: inline-block;
            padding: 5px;
            margin: 0 3px;
            width: 320px;
        }
    .list > li > span{
			display: inline-block;
			width: 120px;
			padding-left: 8px;
    }
    .list > li > p {
    		display: inline-block;
    		margin: 0;
    }
    .main-table-row > td > div > h2{
    		display: inline-block;
    }
	
	.slide_wrapper{
	  position: relative;
	  width: 320px;
	  margin: 0 auto;
	  height: 100px;
	  overflow:hidden;
	}
	.slides{
	  padding-left: 10px;
	  margin: 10px 0;
	  height: 80px;
	  position: absolute;
	  left: 0; top: 0;
	  width: 700px;  
	  transition: left 0.5s ease-out;
	}
	.slides li:not(:last-child){
	  float: left;
	  margin-bottom: 10px;
	  margin-right:30px;
	}
	.controls{
	  text-align: center;
	  margin: 20px 50px;
	}
	.controls span{
	  background:#333;
	  color: #fff;
	  padding: 5px 10px;
	  margin: 0 10px;
	}
	.controls span:hover{
		cursor: pointer;
	}
	.room-text{
		width: 1000px;
		margin: 0 auto;
		pading:0;
	}
	.float-left{
		float: left;
		width: 50%;
	}
	.float-right{
		float: right;
		width: 50%;
	}
	.float-box::after {
            content: "";
            display: block;
            clear: both;
    }
    .address{
    	width: 1000px;
    	margin: 0 auto;
    }
    .photo-place{
    	width: 1000px;
    	margin: 0 auto;
    }
    .room-text > div > p{
    	padding-left: 8px; 
    }
</style>
<jsp:include page="/template/header.jsp"></jsp:include>
<script>
$(function(){
	var slides = document.querySelector('.slides'),
		slide = document.querySelectorAll('.slides li'),
		currentIdx = 0,
		slideCount = slide.length,
		slideWidth = 80,
		slideMargin = 30,
		prevBtn = document.querySelector('.prev'),
		nextBtn = document.querySelector('.next');
	
	slides.style.width = (slideWidth + slideMargin)*slideCount - slideMargin + 'px';
	
	function moveSlide(num){  
	  slides.style.left = -num * 110 +'px';
	  currentIdx = num;
	}
	nextBtn.addEventListener('click', function(){
		if(currentIdx < slideCount - 3){
	  	moveSlide(currentIdx + 1);
	  	console.log(currentIdx); 
		}else{
		  	moveSlide(0);
		}
	});
	prevBtn.addEventListener('click', function(){
		if(currentIdx > 0){
	  		moveSlide(currentIdx - 1);
	  		console.log(currentIdx); 
		}else{
		  	moveSlide(slideCount - 3);
		}
	});
    $(".img-btn").click(function(){
        //this: 선택한 썸네일 이미지
        var id = $(this).attr("id");
        var targetId = id + "-target";
        $(".target").hide();
        $("#"+targetId).show();
    });
    $("#img-1").click();
	$(".prev").onclick(function(){
		
	});
	$(".next").onclick(function(){
		
	});
});
</script>
<%if(houseDto.getHouse_type().equals("one")) {%>
<div class="container">
	<div class="main-table_wrapper">
		<table class="main-table">
			<tbody>
			<tr>
				<td width="27%">
					<span>원룸</span><br>
					<h2>보증금 <%=oneDto.getDeposit()/10000 %></h2><span>만원</span>
				</td>				
				<td width="20%">
					<span>적용면적</span><br>
					<h2><%=oneDto.getArea() %>㎡</h2>
				</td>				
				<td>
					<span>한달 예상 주거비</span><br>
					<h2 style="color: blue;"><%=(oneDto.getMonthly()+oneDto.getBill())/10000 %>만원+ α</h2>
				</td>				
			</tr>
			</tbody>
		</table>
	</div>
	<br>
	<div class="address">
		<p>주소: <%=oneDto.getAddress() %> / <%=oneDto.getAddress2() %></p>
	</div>
	<br>
	<div class="room-list" style="width: 1000px;">
		<ul class="list">
			<li>
				<span>· 보증금(전세)</span>
				<p><%=oneDto.getDeposit()/10000 %>만원</p>
			</li>
			<li>
				<span>· 월세</span>
				<p><%=oneDto.getMonthly()/10000 %>만원</p>
			</li>		
			<li>
				<span>· 관리비</span>
				<p><%=oneDto.getBill()/10000 %>만원</p>
			</li>
			<hr>
			<li>
				<span>· 해당층/건물층</span>
				<p><%=oneDto.getFloor() %>/5층</p>
			</li>
			<li>
				<span>· 적용/공급면적</span>
				<p><%=oneDto.getArea() %>㎡</p>
			</li>
			<li>
				<span>· 방향</span>
				<p><%=oneDto.getDirection() %></p>
			</li>
			<hr>
			<li>
				<span>· 엘리베이터</span>
				<p>
					<%if(oneDto.getElevator().equals("0")){ %>
					없음
					<%}else{ %>
					있음
					<%} %>
				</p>
			</li>
			<li>
				<span>· 입주가능일</span>
				<p>
					<%if(oneDto.getMove_in() == null){ %>
					협의 가능
					<%}else{ %>
					<%=oneDto.getMove_in() %>
					<%} %>
				</p>
			</li>
			<li>
				<span>· 반려동물</span>
				<p>
					<%if(oneDto.getAnimal().equals("0")){ %>
					불가능
					<%}else{ %>
					가능
					<%} %>
				</p>
			</li>
			<hr>
			<li>
				<span>· 건물 주차수</span>
				<p>
					<%if(oneDto.getParking().equals("0")){ %>
					없음
					<%}else{ %>
					가능
					<%} %>
				</p>
			<li>
				<span>· 전세자금대출</span>
				<p>
					<%if(oneDto.getLoan().equals("0")){ %>
					불가능
					<%}else{ %>
					가능
					<%} %>
				</p>
			</li>
			<li>
				<span>· 최초 등록일</span>
				<p><%=houseDto.getInsert_date() %></p>
			</li>
		</ul>
		<br><br><br><br>
		<hr>
	</div>
	<br>
	<div class="slide_wrapper">
 		<ul class="slides">
 			<%for (PhotoDto photoDto : photoList){ %>
	    	<li><img id="img-1" class="img-btn" src="../img/<%=photoDto.getSave_name()%>" alt="대표사진" width="80px;" height="80px;"></li>
	    	<li><img id="img-2" class="img-btn" src="../img/<%=photoDto.getSave_name()%>" alt="방사진1" width="80px;" height="80px;" ></li>
	    	<li><img id="img-3" class="img-btn" src="../img/<%=photoDto.getSave_name()%>" alt="방사진2" width="80px;" height="80px;"></li>
	    	<li><img id="img-4" class="img-btn" src="../img/<%=photoDto.getSave_name()%>" alt="방사진3" width="80px;" height="80px;"></li>
	    	<li><img id="img-5" class="img-btn" src="../img/<%=photoDto.getSave_name()%>" alt="방사진4" width="80px;" height="80px;"></li>
    		<%break;}%>
	    	<li><img src="http://placehold.it/80x80" alt="더미사진"></li>
	  </ul>
	</div>
	  <p class="controls">
	    <span class="prev" >prev</span>
	    <span class="next">next</span>
	  </p>
	<br>
	<div class="photo-place center">
		<%for (PhotoDto photoDto : photoList){ %>
		<img id="img-1-target" class="target" src="../img/<%=photoDto.getSave_name()%>" alt="대표사진" width="300px;" height="300px;">
		<img id="img-2-target" class="target" src="../img/<%=photoDto.getSave_name()%>" alt="방사진1" width="300px;" height="300px;">
		<img id="img-3-target" class="target" src="../img/<%=photoDto.getSave_name()%>" alt="방사진2" width="300px;" height="300px;">
		<img id="img-4-target" class="target" src="../img/<%=photoDto.getSave_name()%>" alt="방사진3" width="300px;" height="300px;">
		<img id="img-5-target" class="target" src="../img/<%=photoDto.getSave_name()%>" alt="방사진4" width="300px;" height="300px;">
		<%break;} %>
		<br>
		<hr>
	</div>
	<br>
	<div class="room-text float-box">
		<div class="float-left">
			<p>
				<%=oneDto.getTitle() %>
			</p>
		</div>
		<div class="float-right">
			<p>
				<%=oneDto.getEtc() %>
			</p>
		</div>
		<br><hr><br>
	</div>
</div>
<%} %>

<jsp:include page="/template/footer.jsp"></jsp:include>
