<%@page import="houseSemi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% //초기 지도의 중심좌표로 사용할 위도, 경도 불어오기
	request.setCharacterEncoding("UTF-8");
	boolean isLatLng = request.getParameter("Lat") !=null && request.getParameter("Lng") !=null;
	double Lat;
	double Lng;
	if(isLatLng){
		Lat = Double.parseDouble(request.getParameter("Lat"));
		Lng = Double.parseDouble(request.getParameter("Lng"));
	}
	int house_no=Integer.parseInt(request.getParameter("house_no"));
	int member_no=(int)session.getAttribute("check");

	OfficeDao officeDao = new OfficeDao();
	OfficeDto officeDto = officeDao.my_office(house_no, member_no);
%>

<jsp:include page="/template/house_header.jsp"></jsp:include>
<script>
    $(function () {
    	
    	$(".active").hide();
        $(".list").show();
		$("#charter-range").hide();
		$(".listDetail").hide();
		
		
		var data=
        {
        	office_no:<%=officeDto.getOffice_no()%>,
        	house_no:<%=officeDto.getHouse_no()%>,
        	member_no:<%=officeDto.getMember_no()%>, 
        	broker_no:<%=officeDto.getBroker_no()%>,
        	deposit : '<%=officeDto.getDeposit()%>',
        	monthly: '<%=officeDto.getMonthly()%>',
        	address: '<%=officeDto.getAddress()%>',
        	address2: '<%=officeDto.getAddress2()%>',
        	floor: '<%=officeDto.getFloor()%>',
        	loan: '<%=officeDto.getLoan()%>',
        	animal: '<%=officeDto.getAnimal()%>',
        	elevator: '<%=officeDto.getElevator()%>',
        	parking: '<%=officeDto.getParking()%>',
        	move_in: '<%=officeDto.getMove_in()%>',
        	area: '<%=officeDto.getArea()%>',
        	broker_agree: '<%=officeDto.getBroker_agree()%>',
        	bill : '<%=officeDto.getBill()%>',
        	direction: '<%=officeDto.getDirection()%>',
        	title: '<%=officeDto.getTitle()%>'
        }
		var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
            center: new kakao.maps.LatLng(37.50042814760636,127.037188602163), // 지도의 중심좌표 
            level: 6 // 지도의 확대 레벨 
        });	
		map.setDraggable(false);
   		var geocoder=new kakao.maps.services.Geocoder();
		geocoder.addressSearch(data.address, function(result, status){
    		if(status===kakao.maps.services.Status.OK){
    			var	MyPoint=new kakao.maps.LatLng(result[0].y, result[0].x);
    		};
			redefine(MyPoint);
        });	

		
		function redefine(MyPoint){
			Lat=MyPoint.Ma;
			Lng=MyPoint.La;
			map.setCenter(new kakao.maps.LatLng(Lat,Lng));
		}
		
        	
      	//로드되면 초기 중심좌표를 저장합니다.
    	var Lat = map.getCenter().getLat();
		var Lng = map.getCenter().getLng();
		$("#Lat").val(Lat);
  		$("#Lng").val(Lng);

		//Dto를 이용하여 datas 배열에 매물 정보를 넣어준다.
        onMap(data);
                
      
        //cluseter.clear(); //기존에 있던 클러스터를 지운다.
        //onMap(datas); //필터링된 data를 받아서 지도위에 표기한다.
        
        function onMap(datas){
      		// 데이터로부터 좌표를 받아 마커 객체를 생성

        	var markers = $(datas).map(function (i, data) {
        		//주소를 받아서 좌표를 생성한 뒤 마커에 좌표 정보를 넣어준다.
           		geocoder.addressSearch(data.address, function(result, status){
            		if(status===kakao.maps.services.Status.OK){
            			var coords=new kakao.maps.LatLng(result[0].y, result[0].x);
            			var marker = new kakao.maps.Marker({
            				position: coords,
            				map:map
            			});
            			marker.no = data.office_no;
                   	 	markers.push(marker); //마커스 배열에 마커를 입력           
            			onBounds();
            		};
            	});
        	});
       
        	// 지도의 경계좌표를 받아 지도 위 마커정보를 사이드바에 표시합니다.
        	var house_no;
        	function onBounds(){
        		var bounds=map.getBounds();//맵의 영역을 받아온다.
        		var Lat = map.getCenter().getLat();
        		var Lng = map.getCenter().getLng();
        		$("#Lat").val(Lat);
      			$("#Lng").val(Lng);
      			var template = $("#template").html();
      			var template_img = $("#image-template").html();
      			var listCount=0;
      			$.each(markers, function(index, marker){
      				if(bounds.contain(marker.getPosition())){
      					listCount = listCount+1;
      					$.ajax({
        					async:false,//순차적으로실행되도록 설정
        					url : "<%=request.getContextPath()%>/house/filter_office.do",
        					type : "POST",
        					data : {
        						office_no : marker.no
        					},
        					success:function(resp){
        						$(template).find(".filterResult").appendTo(".list");
        						var list_price;
        						if(resp[0].monthly==0){
        							list_price = "전세 "+(resp[0].deposit/10000);
        						}
        						else{
        							list_price = "월세 "+(resp[0].deposit/10000) + "/" + (resp[0].monthly/10000);
        						}
       				            var area_floor = resp[0].floor+" ㆍ "+resp[0].area+"㎡";
       				         	$(template).find(".filterImg").children().attr("src", "D:/upload/kh42/"+resp[0].save_name).appendTo($(".list").children().last());
       				      	 	$(template).find(".filterPrice").text(list_price).appendTo($(".list").children().last());
 				             	$(template).find(".filterInfo").text(area_floor).appendTo($(".list").children().last());
 				             	$(template).find(".filterAddress").text(resp[0].address).appendTo($(".list").children().last());
        						$(".list").children().last().click(function(){
        							$(".image-btn-box").remove();
        							$.each(resp, function(index, info){
        								$(template_img).find(".image-btn-box").appendTo(".image-box");
        								$(template_img).find(".detail-imagebtn-box").appendTo($(".image-box").children().last());
        								$(template_img).find(".img-img").attr("src", "D:/upload/kh42/"+info.save_name).appendTo($(".image-box").children().last());
        								$(".image-box").children().last().find(".img-img").mouseover(function(){
        									$(this).prev().show();
        								});
        								$(".image-box").children().last().find(".detail-imagebtn-box").mouseleave(function(){
        									$(this).hide();
        								});
        								$(".image-box").children().last().find(".detail-image-nextBtn").click(function(){
        									$(this).parent().parent().hide();
        									if(index==resp.length-1){
        										$(".image-box").children().first().show();
        									}
        									else{
        										$(this).parent().parent().next().show();
        									}
               							});
        								$(".image-box").children().last().find(".detail-image-prevBtn").click(function(){
        									$(this).parent().parent().hide();
        									if(index==0){
        										$(".image-box").children().last().show();
        									}
        									else{
        										$(this).parent().parent().prev().show();
        									}
               							});
        							});
        							
        							$(".image-btn-box").hide();
        							$(".image-box").children().first().show();
									$(".detail-house-price").text(list_price);
       				        		$(".regist-house-num").text("등록번호 ("+resp[0].house_no+")");
   	       				        	$(".detail-house-area").text(resp[0].area+"㎡");
   	       				        	$(".detail-house-bill").text((resp[0].bill/10000)+"만원");
   	       				        	$(".detail-house-direction").text(resp[0].direction);
   	       				        	$(".detail-house-title").text(resp[0].title);
   	       				        	if(resp[0].parking==="1"){
   	       				        		$(".detail-house-parking").text("가능");
   	       				        	}
   	       				        	else{
   	       				        		$(".detail-house-parking").text("불가능");
   	       				        	}
   	       				        	if(resp[0].elevator==="1"){
   	       				        		$(".detail-house-elevator").text("있음");
   	       				        	}
   	       				        	else{
   	       				        		$(".detail-house-elevator").text("없음");
   	       				        	}
   	       				        	if(resp[0].animal==="1"){
   	       				        		$(".detail-house-animal").text("가능");
   	       				        	}
   	       				        	else{
   	       				        		$(".detail-house-animal").text("불가능");
   	       				        	}
   	       				        	if(resp[0].loan==="1"){
   	       				        		$(".detail-house-loan").text("가능");
   	       				        	}
   	       				        	else{
   	       				        		$(".detail-house-loan").text("불가능");
   	       				        	}
   	       				        	if(resp[0].move_in != null){
   	       				        		$(".detail-house-move_in").text(resp[0].move_in);
   	       				        	}
   	       				        	else{
   	       				        		$(".detail-house-move_in").text("협의가능");
   	       				        	}
   	       				        	$(".detail-house-bill1").text((resp[0].bill/10000)+"만원");
   	       				        	$(".detail-house-area1").text(resp[0].area+"㎡");
   	       				        	$(".detail-house-direction1").text(resp[0].direction);
   	       				        	$(".detail-house-floor").text(resp[0].floor);
   	       				        	$(".detail-house-address").text(resp[0].address+" "+resp[0].address2);
   	       				        	$(".detail-house-etc").text(resp[0].etc);
   	       				        	$(".detail-broker-name").text(resp[0].broker_name);
   	       				        	if(resp[0].broker_landline != null){
   	       				        		$(".detail-broker-landline").text("대표번호 : "+resp[0].broker_landline);
   	       				        		$(".detail-broker-phone").text("핸드폰번호 : "+resp[0].member_phone);
   	       				        		$(".call-broker-landline").text(resp[0].broker_landline);
   	       				        		$(".call-broker-phone").text(resp[0].member_phone);
   	       				        	}
   	       				        	else{
   	       				        		$(".detail-broker-landline").text("");
   	       				        		$(".detail-broker-phone").text("핸드폰번호 : "+resp[0].member_phone);
   	       				        		$(".call-broker-phone").text(resp[0].member_phone);
   	       				        	}
   	       				        	$(".detail-broker-email").text("이메일 : "+resp[0].member_email);
   	       				        	if(resp[0].broker_address2!=null){
   	       				        		$(".detail-broker-address").text("위치 : "+resp[0].broker_address+" "+resp[0].broker_address2);
   	       				        	}
   	       				        	else{
   	       				        		$(".detail-broker-address").text("위치 : "+resp[0].broker_address);
   	       				        	}
   	       				        	$(".call-house-no").text(resp[0].house_no);
   	       				        	$(".call-broker-name").text(resp[0].broker_name);
   	       				        	$(".listDetail").show();
   	       				        	$(".ListAndFilter").hide();
    	       				    });
        					},
        					error:function(){
        						console.log("failfilter");
        					}
        				});//ajax끝
      				}
      			});
      			$(".total-list").text("지역 목록 "+listCount+"개");
        	};
        	//지도의 경계좌표가 변할 시 사이드바 정보를 갱신하는 이벤트
        	kakao.maps.event.addListener(map,'bounds_changed', function(){
            	$("body").children().find(".filterResult").remove(); //기존에 있던 정보들을 삭제시킨다.
            	onBounds(); //사이드바 갱신 함수 호출
        	});
        };
        $(".backlist").click(function(){
        	$(".listDetail").hide();
	        $(".ListAndFilter").show();
        });
        $(".callSpace").click(function(){
        	$(".callInfo").css("display","flex");
        	$(".callInfo").css("align-items","center");
        	$(".callInfo").css("justify-content","center");
	        $(".callInfo").show();
	    });
        $(".call-close").click(function(){
        	$(".callInfo").css("display","none");
        });
   
    });
</script>
<script id="image-template" type="text/template">
	<div>
		<div class="image-btn-box" style="width:100%; height:300px;"></div>
		<div class="detail-imagebtn-box">
			<span class="detail-image-prevBtn">＜</span>
			<span class="detail-image-nextBtn">＞</span>
		</div>
		<img alt="매물상세이미지" class="img-img" style="width: 100%; height:300px;">
	</div>
</script>
<script id="template" type="text/template">
	<div>
		<div class="filterResult"></div>
		<div class="filterImg">
            <img class="list-image" alt="매물이미지">
        </div>
		<div class="filterPrice"></div>
		<div class="filterInfo"></div>
		<div class="filterAddress"></div>
	</div>
</script>
<style>
.de-info {
    height: calc(100vh - 170px);
    }
</style>
<article>
	<div id="map" style="width: 100%; height: 100%;"></div>
	
</article>
<aside class="filtering">

	<div class="ListAndFilter">
		<div class="fb">
			<div class="total-list"></div>
		</div>
		<div class="list"></div>
	</div>

	<div class="listDetail">
		<div class="backlist">◀</div>
		<div class="de-info">
			<div class="image-box">
				
			</div>
			<div class="boundaryList">
				<div class="detail-house-price"></div>
				<div class="regist-house-num"></div>
			</div>
			<div class="boundaryList displayList">
				<div>
					<span>면적(전용)</span>
					<div class="detail-house-area"></div>
				</div>
				<div>
					<span>관리비</span>
					<div class="detail-house-bill"></div>
				</div>
				<div>
					<span>방향</span>
					<div class="detail-house-direction"></div>
				</div>
			</div>
			<div class="titleList detail-house-title"></div>

			<div class="boundaryList">매물 정보</div>
			<div class="titleList">
				<div class="detailInfoList">
					<div class="detailInfoWidth">주차</div>
					<div class="detail-house-parking"></div>
				</div>
				<div class="detailInfoList">
					<div class="detailInfoWidth">엘리베이터</div>
					<div class="detail-house-elevator"></div>
				</div>
				<div class="detailInfoList">
					<div class="detailInfoWidth">반려동물</div>
					<div class="detail-house-animal"></div>
				</div>
				<div class="detailInfoList">
					<div class="detailInfoWidth">전세대출</div>
					<div class="detail-house-loan"></div>
				</div>
				<div class="detailInfoList">
					<div class="detailInfoWidth">입주가능일</div>
					<div class="detail-house-move_in"></div>
				</div>
				<div class="detailInfoList">
					<div class="detailInfoWidth">관리비</div>
					<div class="detail-house-bill1"></div>
				</div>
				<div class="detailInfoList">
					<div class="detailInfoWidth">면적(전용)</div>
					<div class="detail-house-area1"></div>
				</div>
				<div class="detailInfoList">
					<div class="detailInfoWidth">방향</div>
					<div class="detail-house-direction1"></div>
				</div>
				<div class="detailInfoList">
					<div class="detailInfoWidth">층수</div>
					<div class="detail-house-floor"></div>
				</div>
				<div class="lastList">
					<div class="detailInfoWidth">주소</div>
					<div class="detail-house-address"></div>
				</div>
			</div>
			<div class="boundaryList">상세 설명</div>
			<div class="titleList detail-house-etc"></div>
			<div class="titleList">
				<div class="detail-broker-name"></div>
				<div class="detail-broker-landline"></div>
				<div class="detail-broker-phone"></div>
				<div class="detail-broker-email"></div>
				<div class="detail-broker-address"></div>
			</div>
		</div>
	</div>

</aside>

<jsp:include page="/template/house_footer.jsp"></jsp:include>