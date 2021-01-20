<%@page import="houseSemi.beans.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/range.css">
<style>
   .list-image{
   		float:left;
   }
</style>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript"
    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=724a7918d5c20b6b105ff0bdad826269&libraries=clusterer,services"></script>
<script src="<%=request.getContextPath()%>/js/pricechoice.js"></script>
<%request.setCharacterEncoding("UTF-8");%>
<script>
    $(function () {
    	$(".active").hide();
        $(".list").show();
		$("#charter-range").hide();
		
    	<% //초기 지도의 중심좌표로 사용할 위도, 경도 불어오기
    		double Lat = Double.parseDouble(request.getParameter("Lat"));
        	double Lng = Double.parseDouble(request.getParameter("Lng"));
        %>
    	
        var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
            center: new kakao.maps.LatLng(<%=Lat%>,<%=Lng%>), // 지도의 중심좌표 
            level: 6 // 지도의 확대 레벨 
        });
        
        // 마커 클러스터러를 생성합니다 
        var clusterer = new kakao.maps.MarkerClusterer({
            map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
            averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
            minLevel: 1, // 클러스터 할 최소 지도 레벨 
            disableClickZoom: true,
            minClusterSize: 1
        });
        
        
        var datas=[];
		//Dto를 이용하여 datas 배열에 매물 정보를 넣어준다.
        <%
        	OneDao oneDao=new OneDao();
        	List<OneDto> onelist;
        	if(request.getParameter("filter") == null){
        		onelist = oneDao.select();
        	}
        	else{
        		OneVO oneVO = new OneVO();
        		oneVO.setCharter_min(request.getParameter("charter_min"));
        		oneVO.setCharter_max(request.getParameter("charter_max"));
        		oneVO.setDeposit_min(request.getParameter("deposit_min"));
        		oneVO.setDeposit_max(request.getParameter("deposit_max"));
        		oneVO.setMonthly_min(request.getParameter("monthly_min"));
        		oneVO.setMonthly_max(request.getParameter("monthly_max"));
        		oneVO.setFloor1(request.getParameter("floor1"));
        		oneVO.setFloor2(request.getParameter("floor2"));
        		oneVO.setFloor3(request.getParameter("floor3"));
        		oneVO.setParking(request.getParameter("parking"));
        		oneVO.setElevator(request.getParameter("elevator"));
        		oneVO.setAnimal(request.getParameter("animal"));
        		oneVO.setLoan(request.getParameter("loan"));
        		onelist = oneDao.select(oneVO);
        	}
        
        	for(OneDto oneDto : onelist){
        %>
        	datas.push({
        		"번호" : <%=oneDto.getOne_no()%>,
        		"주소" : '<%=oneDto.getOne_address()%>'
        		//스트링을 넣어줄때는 ''를 반드시 사용해 줘야함
        	});
        <%} %>
        
        onMap(datas); //data를 지도위에 표기한다.
        
      
        //cluseter.clear(); //기존에 있던 클러스터를 지운다.
        //onMap(datas); //필터링된 data를 받아서 지도위에 표기한다.
        
        function onMap(datas){
      		// 데이터로부터 좌표를 받아 마커 객체를 생성
       		var geocoder=new kakao.maps.services.Geocoder();
        	var total=datas.length;
       		var count=0;
        	var markers = $(datas).map(function (i, data) {
        		//주소를 받아서 좌표를 생성한 뒤 마커에 좌표 정보를 넣어준다.
           		geocoder.addressSearch(data.주소, function(result, status){
            		if(status===kakao.maps.services.Status.OK){
            			var coords=new kakao.maps.LatLng(result[0].y, result[0].x);
            			var marker = new kakao.maps.Marker({
            				position: coords
            			});
            			marker.no = data.번호;
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
					//모든 마커들에 대해 변환이 수행됐을 때 클러스터링 함수와 사이드바 갱신 함수를 호출한다.
            		if(total===count){
            			clustering();//클러스터링 호출 함수
            			onBounds(); //사이드바 갱신 함수
            		}
            	});
        	});
       
        	// 클러스터러에 마커들을 추가합니다
      		function clustering(){
        		clusterer.addMarkers(markers);
        	}    
        	// 지도의 경계좌표를 받아 지도 위 마커정보를 사이드바에 표시합니다.
        	function onBounds(){
        		var bounds=map.getBounds();//맵의 영역을 받아온다.
        		var Lat = map.getCenter().getLat();
        		var Lng = map.getCenter().getLng();
        		$("#Lat").val(Lat);
      			$("#Lng").val(Lng);
      			var div = $("<div>");
      			$(div).addClass("list-text").appendTo(".list");
      			$.each(markers, function(index, marker){
      				if(bounds.contain(marker.getPosition())){
      					$.ajax({
        					async:false,//순차적으로실행되도록 설정
        					url : "<%=request.getContextPath()%>/semi-project/filter.do",
        					type : "get",
        					data : {
        						one_no : marker.no
        					},
        					success:function(resp){
        						console.log("ajax finish!");
        						console.log(resp);
        						console.log("each function");
        						console.log(this);
       				            var div1 = $("<div>");
       				            var div2 = $("<div>");
       				            var div3 = $("<div>");
       				         	var img = $("#template").html();
       				            var list_price = resp.one_deposit + "/" + resp.one_monthly;
       				         	$(img).prop("src", "http://placeimg.com/150/120/any").appendTo(".list-text");
       				            $(div1).addClass("list-price").text(list_price).appendTo(".list-text");
       				            $(div2).addClass("list-floor").text(resp.floor).appendTo(".list-text");
       				            $(div3).addClass("list-address").text(resp.one_address).appendTo(".list-text");
        					},
        					error:function(){
        						
        					}
        				});
      				}
      			});
        	};
        	//클러스터 클릭 시 지도의 중심이 클러스터로 이동하는 이벤트 
        	kakao.maps.event.addListener(clusterer, 'clusterclick', function (cluster) {
        		//클러스터의 위도와 경도를 변수화한다.
        		var Lat=cluster.getCenter().Ma;
        		var Lng=cluster.getCenter().La;
        	
       	 		map.setCenter(new kakao.maps.LatLng(Lat,Lng));   //지도의 중심좌표를 설정한다.
        
        	    var level = map.getLevel() - 2; // 클러스터 클릭 시 지도가 level 2만큼 확대된다. 
           		map.setLevel(level, {
                	anchor: cluster.getCenter()
            	});
        	});
        	//지도의 경계좌표가 변할 시 사이드바 정보를 갱신하는 이벤트
        	kakao.maps.event.addListener(map,'bounds_changed', function(){
            	$("body").children().find(".list-text").remove(); //기존에 있던 정보들을 삭제시킨다.
            	onBounds(); //사이드바 갱신 함수 호출
        	});
        };
    
    });
</script>
<script id="template" type="text/template">
    <img class="list-image" alt="매물이미지">
</script>
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
            </article>
            <aside class="filtering">
                

                <div class="fb">
                    <input type="button" id="filter-btn" class="filter-open">
                </div>
                
				<div class="list">
					<div>짜잔</div>
				</div>
					    
                <form action="filter.jsp" method="get">
                    <div class="active">
                    	<input type="hidden" name="filter">
                    	<input type="hidden" id="Lat" name="Lat">
                    	<input type="hidden" id="Lng" name="Lng">
                        <div class="mOrc">
                            <input type="button" id="monthly" class="choice" value="월세">
                            <input type="button" id="charter" value="전세">
                        </div>
    
                        <div class="detailFilter">
                            <div id="charter-range" class="margin-t">
                                <div class="priceTitle">전세금</div>
                                <div class="margin-t">
                                    <div class="box">
                                        <div class="price-show">
                                            <span id="priceMin1"></span>
                                            <span id="cp1">전체</span>
                                            <span id="priceMax1"></span>
                                            <span id="cp2"></span>
                                        </div>
                                        <div class="slider">
                                          <input type="range" id="input-left1" min="0" max="25" value="0" step="1">
                                          <input type="hidden" name="charter_min" value="N">
                                          <input type="range" id="input-right1" min="0" max="25" value="25" step="1">
                                          <input type="hidden" name="charter_max" value="N">
                                          <div class="track">
                                            <div class="range" id="range1"></div>
                                            <div class="thumb left" id="thumb-left1"></div>
                                            <div class="thumb right" id="thumb-right1"></div>
                                          </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="deposit-range" class="margin-t">
                                <div class="priceTitle">보증금</div>
                                <div class="margin-t">
                                    <div class="box">
                                        <div class="price-show">
                                            <span id="priceMin3"></span>
                                            <span id="mmp1">전체</span>
                                            <span id="priceMax3"></span>
                                            <span id="mmp2"></span>
                                        </div>
                                        <div class="slider">
                                          <input type="range" id="input-left3" min="0" max="25" value="0" step="1">
                                          <input type="hidden" name="deposit_min" value="0">
                                          <input type="range" id="input-right3" min="0" max="25" value="25" step="1">
                                          <input type="hidden" name="deposit_max" value="max">
                                          <div class="track">
                                            <div class="range" id="range3"></div>
                                            <div class="thumb left" id="thumb-left3"></div>
                                            <div class="thumb right" id="thumb-right3"></div>
                                          </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="monthly-range" class="margin-t">
                                <div class="priceTitle">월세</div>
                                <div class="margin-t">
                                    <div class="box">
                                        <div class="price-show">
                                            <span id="priceMin2"></span>
                                            <span id="mp1">전체</span>
                                            <span id="priceMax2"></span>
                                            <span id="mp2"></span>
                                        </div>
                                        <div class="slider">
                                          <input type="range" id="input-left2" min="0" max="20" value="0" step="1">
                                          <input type="hidden" name="monthly_min" value="0">
                                          <input type="range" id="input-right2" min="0" max="20" value="20" step="1">
                                          <input type="hidden" name="monthly_max" value="max">
                                          <div class="track">
                                            <div class="range" id="range2"></div>
                                            <div class="thumb left" id="thumb-left2"></div>
                                            <div class="thumb right" id="thumb-right2"></div>
                                          </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="floor margin-t">
                                <div>층수</div>
                                <div class="margin-t">
                                    <input type="button" id="floor1" value="반지하">
                                    <input type="hidden" name="floor1" value="N">
                                    <input type="button" id="floor2" value="지상층">
                                    <input type="hidden" name="floor2" value="N">
                                    <input type="button" id="floor3" value="옥탑방">
                                    <input type="hidden" name="floor3" value="N">
                                </div>
                            </div>
                            <div class="etc margin-t">
                                <div>기타</div>
                                <div class="margin-t">
                                    <input type="button" id="parking" value="주차">
                                    <input type="hidden" name="parking" value="0">
                                    <input type="button" id="elevator" value="엘리베이터">
                                    <input type="hidden" name="elevator" value="0">
                                    <input type="button" id="animal" value="반려동물">
                                    <input type="hidden" name="animal" value="0">
                                    <input type="button" id="loan" value="전세대출">
                                    <input type="hidden" name="loan" value="0">
                                </div>
                            </div>
                        </div>
    
                        <div class="applySpace"></div>
                        <div class="apply-reset">
                            <div class="reset">
                                <input type="button" id="reset-btn" value="초기화">
                            </div>
                            <div class="apply">
                                <input id="apply-btn" type="submit" value="적용하기">
                            </div>
                        </div>
                    </div>
                </form>
            </aside>
        </section>
    </main>
</body>
</html>