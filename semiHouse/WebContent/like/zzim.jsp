<%@page import="houseSemi.beans.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf8");
int member_no = (int)session.getAttribute("check");
%>
<jsp:include page="/template/house_header.jsp"></jsp:include>
    <script>
    $(function () {
		var searchTemplate = $("#search_template").html();
    	$(".search").on('input', function(){
        	var searchKeyword=$(".search").val();
			$(".searchResult").remove();
    		$.ajax({
    			async: false,
        		url: "test.do",
        		type: "POST",
        		data: {
        			keyword : searchKeyword
        		},
        		success: function(resp){
        			$(searchTemplate).find(".searchResult").appendTo(".floatBox");
        			if(resp.length==0){
        				$(searchTemplate).find(".searchItem").appendTo(".searchResult");
        				$(searchTemplate).find(".searchAddress").text('검색 결과가 없습니다.').appendTo(($(".searchResult").children().last()));
        			}
        			else{
	        			$.each(resp, function(index,data){
	        				$(searchTemplate).find(".searchItem").appendTo(".searchResult");
	        				$(searchTemplate).find(".searchName").text(data.name).appendTo(($(".searchResult").children().last()));
	        				$(searchTemplate).find(".searchAddress").text(data.address).appendTo(($(".searchResult").children().last()));
	        				$(searchTemplate).find(".searchLat").text(data.lat).appendTo(($(".searchResult").children().last()));
	        				$(searchTemplate).find(".searchLng").text(data.lng).appendTo(($(".searchResult").children().last()));
	
	        				$("<hr>").appendTo(($(".searchResult").children().last()));        	
		    			});
        			}
					$(".searchResult").css("display","block");
        		},
        		error: function(){
        			console.log('실패');
        		}
        	});
    		if($(".search").val().length==0){$(".searchResult").remove();}

    		$(".floatBox").find(".searchItem").bind('click', function(e){
    			$(".search").val($(this).find(".searchName").text());
    			$(".searchResult").remove();
    			var searchLat=$(this).find(".searchLat").text();
            	var searchLng=$(this).find(".searchLng").text();
    			map.setCenter(new kakao.maps.LatLng(searchLat,searchLng));
    			map.setLevel(4);	
    		});
    		//색깔 변경 이벤트
    		$(".floatBox").find(".searchItem").bind('mouseover', function(e){
    			$(this).css("background-color","lightgray");
    		});
    		$(".floatBox").find(".searchItem").bind('mouseleave', function(e){
    			$(this).css("background-color","transparent");
    		});
    	});
        
		
   		var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
      	 		center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표 
           	level: 8 // 지도의 확대 레벨 
       	});
		
   		var zzimList=[];

   		$.ajax({
   			async: false,
   			url: "<%=request.getContextPath()%>/like/zzim.do",
   			type: "POST",
   			data : {
  					member_no : <%=member_no%>
   			},
   			success: function(resp){
   				$.each(resp, function(index, zzim){
   					$.ajax({
   						async: false,
   		   				url:"zzim_type.do",
   		   				type: "POST",
   		   				data: {
   		   					house_type : zzim.house_type,
   		   					house_no : zzim.house_no
   		   				},
   		   				success: function(resp){
   		   					console.log(resp);
		   					zzimList.push(resp);
   		   				},
   		   				error: function(){
   		   					console.log("false4")
   		   				}
   		   			});
   		   		});
				
   			},
   			error: function(){
   				console.log("false3");
   			}
   		})

   		onMap(zzimList);
   		
        function onMap(datas){
       		
       		var geocoder=new kakao.maps.services.Geocoder();
       		var total=datas.length;
       		var count=0;
       		console.log(datas);
       		var markers = $(datas).map(function (i, data) {
        		//주소를 받아서 좌표를 생성한 뒤 마커에 좌표 정보를 넣어준다.
           		geocoder.addressSearch(data.address, function(result, status){
            		if(status===kakao.maps.services.Status.OK){
            			var coords=new kakao.maps.LatLng(result[0].y, result[0].x);
            			var marker = new kakao.maps.Marker({
            				position: coords,
            				map:map
            			});
            			marker.no = data.house_no;
            			marker.type=data.house_type;
                   	 	markers.push(marker); //마커스 배열에 마커를 입력 
                    	//사실 필요없는데 남겨둔 변수
                    	var pos = marker.getPosition();
                    	//사실 필요없는 객체(마커를 클릭 시 설명문 나오게하는...)
                   		var info = new kakao.maps.InfoWindow({
                        	zIndex: 1,
                        	position: pos,
                        	disableAutoPan: true,
                    	});
            		};
					count++;
					//모든 마커들에 대해 변환이 수행됬을 때 클러스터링 함수와 사이드바 갱신 함수를 호출한다.
            		if(total===count){
            			onBounds(); //사이드바 갱신 함수
            		}
            	});
        	});
       		function onBounds(){
        		var bounds=map.getBounds();//맵의 영역을 받아온다.
        		var Lat = map.getCenter().getLat();
        		var Lng = map.getCenter().getLng();
        		$("#Lat").val(Lat);
      			$("#Lng").val(Lng);
      			$(".list").empty();
      			var div = $("<div>");
      			$(div).addClass("list-text").appendTo(".list");
      		
      			$.each(markers, function(index, marker){
          			
      				if(bounds.contain(marker.getPosition())){
      					$.ajax({
        					async:false,//순차적으로실행되도록 설정
        					url: "<%=request.getContextPath()%>/like/zzim_detail.do",
        					type : "POST",
        					data : {
        						house_type : marker.type,
        						house_no: marker.no
        					},
        					success:function(resp){
        						console.log(resp);
        						var template = $("#template").html();
        						$(template).find(".filterResult").appendTo(".list");
      				            var list_price = resp.deposit + "/" + resp.monthly;
      				            var area_floor = resp.floor+" ㆍ "+resp.area;
      				            var photo_name = resp.save_name;
      				         	$(template).find(".filterImg").children().prop("src", "http://placeimg.com/150/120/any").appendTo($(".list").children().last());
      				            $(template).find(".filterPrice").text(list_price).appendTo($(".list").children().last());
      				            $(template).find(".filterInfo").text(area_floor).appendTo($(".list").children().last());
      				            $(template).find(".filterAddress").text(resp.one_address).appendTo($(".list").children().last());
        					},
        					error:function(){
        						console.log("false_filter")
        					}
        				});
      				}
      			});
        	};
        	kakao.maps.event.addListener(map,'bounds_changed', function(){
            	$("body").children().find(".text").remove(); //기존에 있던 정보들을 삭제시킨다.
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
<script id="search_template" type="text/template">
	<div>
		<div class="searchResult"></div>
		<div class="searchName"></div>
		<div class="searchItem"></div>
		<div class="searchAddress"></div>
		<div class="searchLat"></div>
		<div class="searchLng"></div>
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
<article>
    <div id="map" style="width:100%;height:100%;"></div>
    <div class="floatBox">
		<div class="searchBox" >
			<input type="text" placeholder="지역, 지하철역 검색" class="search">
			<button class="searchBtn">제출</button>
		</div>
	</div>
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
				<img alt="매물상세이미지" style="width: 100%; height: 100%;">
				<div class="detail-image-nextBtn" style="width: 100%; height: 100%;">
					<div class="image-back">＜</div>
					<div class="image-next">＞</div>
				</div>
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

		<div class="callzzimSpace"></div>
		<div class="callzzimSpace callzzim">
			<div class="callSpace">
				<img alt="전화이미지" src="../img/call.jpg" style="width: 30px;">
				<div>전화하기</div>
			</div>
			<div class="zzimSpace">
				<img alt="찜이미지" src="../img/zzim.png" style="width: 30px;">
				<div>찜하기</div>
			</div>
		</div>
	</div>
            </aside>
<jsp:include page="/template/house_footer.jsp"></jsp:include>