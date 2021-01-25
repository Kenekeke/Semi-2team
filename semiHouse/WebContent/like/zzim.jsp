<%@page import="houseSemi.beans.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf8");
int member_no = (int)session.getAttribute("check");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>찜목록</title>
    <link rel="stylesheet" type="text/css" href="../css/range.css">
    <style>
   .list-image{
   		float:left;
   }
</style>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=68d4be6c2ce69cb3cfc2551c68619e12&libraries=clusterer,services"></script>
	
	<script src="<%=request.getContextPath()%>/js/pricechoice.js"></script>
	<%request.setCharacterEncoding("UTF-8");%>
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
        					url: "<%=request.getContextPath()%>/like/zzim_type.do",
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
<style>
	.searchLat,
   	.searchLng{
   		display:none;
   	}
   	.selectItem{
   		padding 10px 10px 0;
   	}
   	.searchResult{
   		border: 2px solid white;
   		z-index: 110;
   		width: 260px;
   		max-height: 300px;
   		display: none;
   		background-color: white;
   		overflow: auto;
   	}
   	.searchName{
   		font-size: 14px;
   		font-weight: bold;
   		display: block;
   	}
   	.searchAddress{
   		font-size: 10px;
   		display: block;
   	}
   	.center {
        font-size: 40px;
        font-weight: bold;
    }

    .slide {
        z-index: 99;
        position: fixed;
        right: 0;
        top: 0;
        bottom: 0;
        width: 200px;
        background-color: white;
    }
    .floatBox{
       	z-index: 100;
       	width: 329px;
       	height: 50px;
       	position: absolute;
       	left:20px;
       	top:150px;
       	border: 1px solid;
		background-color: white;
		padding: 10px 10px;
	
    }
    .searchBox{
     	border: 2px solid orange;
    }
	.search{
	   	float: left;
	   	padding: 4px;
	   	border: none;
	   	width: 260px;
	   	margin: 0;
    }
       .search::after{
       	content:"";
       	display: block;
       	clear:both;
    }
	hr{
		background-color: lightgray;
		height: 1px;
		border:0;        
    }
</style>
</head>
<body>
    <main>
        <header>
            <a class="header-a"><img alt="로고" src="https://placeimg.com/50/50/any"></a>
            <a class="header-a">방 찾기</a>
            <a class="header-a">찜한 매물</a>
            <a class="header-a">방 내놓기</a>
        </header>
        <nav>
            <a class="menu-filter menu-choice" id="menu-filter1">빌라, 투룸</a>
            <a class="menu-filter" id="menu-filter2">원룸</a>
            <a class="menu-filter" id="menu-filter3">오피스텔</a>
        </nav>
        <section>
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
               
				<div class="list">
					<div>짜잔</div>
				</div>

            </aside>
        </section>
    </main>
</body>
</html>