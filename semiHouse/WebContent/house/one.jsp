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
	else{
		Lat = 37.50042814760636;
		Lng = 127.037188602163;
	}
%>

<jsp:include page="/template/house_header.jsp"></jsp:include>
<script>
    $(function () {
    	//검색어를 받아서 추천 검색목록을 출력합니다.
    	var searchTemplate = $("#search_template").html();
    	$(".search").on('input', function(){
        	var searchKeyword=$(".search").val();
			$(".searchResult").remove();
    		$.ajax({
    			async: false,
        		url: "<%=request.getContextPath()%>/house/test.do",
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
        			console.log('false');
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
    		$(".floatBox").find(".searchItem").bind('mouseover', function(e){
    			$(this).css("background-color","lightgray");
    		});
    		$(".floatBox").find(".searchItem").bind('mouseleave', function(e){
    			$(this).css("background-color","transparent");
    		});
    		
    	});
    	$(".active").hide();
        $(".list").show();
		$("#charter-range").hide();
		$(".listDetail").hide();
        var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
            center: new kakao.maps.LatLng(<%=Lat%>,<%=Lng%>), // 지도의 중심좌표 
            level: 6 // 지도의 확대 레벨 
        });
      	//로드되면 초기 중심좌표를 저장합니다.
    	var Lat = map.getCenter().getLat();
		var Lng = map.getCenter().getLng();
		$("#Lat").val(Lat);
  		$("#Lng").val(Lng);
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
        $.ajax({
        	async:false,
        	url:"<%=request.getContextPath()%>/house/list_one.do",
        	type: "POST",
        	data: {
        		filter : '<%=request.getParameter("filter")%>',
        		charter_min : '<%=request.getParameter("charter_min")%>',
        		charter_max : '<%=request.getParameter("charter_max")%>',
        		deposit_min : '<%=request.getParameter("deposit_min")%>',
        		deposit_max : '<%=request.getParameter("deposit_max")%>',
        		monthly_min : '<%=request.getParameter("monthly_min")%>',
        		monthly_max : '<%=request.getParameter("monthly_max")%>',
        		floor1 : '<%=request.getParameter("floor1")%>',
	    	   	floor2 : '<%=request.getParameter("floor2")%>',
	    	   	floor3 : '<%=request.getParameter("floor3")%>',
	    	   	parking : '<%=request.getParameter("parking")%>',
	    	   	elevator : '<%=request.getParameter("elevator")%>',
	    	   	animal : '<%=request.getParameter("animal")%>',	
	    	   	loan : '<%=request.getParameter("loan")%>'     		
        	},
        	success: function(resp){
        		datas=resp;
        		onMap(datas);
        	},
        	error: function(){
        		console.log('false2');
        	}
        	
        })
                
      
        //cluseter.clear(); //기존에 있던 클러스터를 지운다.
        //onMap(datas); //필터링된 data를 받아서 지도위에 표기한다.
        
        function onMap(datas){
      		// 데이터로부터 좌표를 받아 마커 객체를 생성
       		var geocoder=new kakao.maps.services.Geocoder();
        	var total=datas.length;
       		var count=0;
        	var markers = $(datas).map(function (i, data) {
        		//주소를 받아서 좌표를 생성한 뒤 마커에 좌표 정보를 넣어준다.
           		geocoder.addressSearch(data.address, function(result, status){
            		if(status===kakao.maps.services.Status.OK){
            			var coords=new kakao.maps.LatLng(result[0].y, result[0].x);
            			var marker = new kakao.maps.Marker({
            				position: coords
            			});
            			marker.no = data.one_no;
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
      			var template = $("#template").html();
      			var listCount=0;
      			var photolist=[];
      			var n =[];
      			$.each(markers, function(index, marker){
      				if(bounds.contain(marker.getPosition())){
      					listCount = listCount+1;
      					$.ajax({
        					async:false,//순차적으로실행되도록 설정
        					url : "<%=request.getContextPath()%>/house/filter_one.do",
        					type : "POST",
        					data : {
        						one_no : marker.no
        					},
        					success:function(resp){
        						console.log(resp);
        						$(template).find(".filterResult").appendTo(".list");
       							$.each(resp, function(index, info){
       								console.log(index);
           							if(resp.length>1){
           								photolist.push(info.save_name+info.photo_type);
           								n.push(index);
           							}
           							console.log(photolist);
           							console.log("<%=request.getContextPath()%>/img/"+info.save_name+info.photo_type);
           							console.log(n.length);
           							if(index==0){
           								var list_price = info.deposit + "/" + info.monthly;
               				            var area_floor = info.floor+" ㆍ "+info.area;
               				         	$(".image-next").addClass("n"+n[0]);
               				         	$(".image-box").children().prop("src", "<%=request.getContextPath()%>/img/"+info.save_name+info.photo_type);
               				         	$(template).find(".filterImg").children().prop("src", "<%=request.getContextPath()%>/img/"+info.save_name+info.photo_type).appendTo($(".list").children().last());
               				      	 	$(template).find(".filterPrice").text(list_price).appendTo($(".list").children().last());
         				             	$(template).find(".filterInfo").text(area_floor).appendTo($(".list").children().last());
         				             	$(template).find(".filterAddress").text(info.address).appendTo($(".list").children().last());
         				            	$(".list").children().last().click(function(){
    	       				        		$(".detail-house-price").text("월세 "+list_price);
    	       				        		$(".regist-house-num").text("등록번호 ("+info.house_no+")");
	    	       				        	$(".detail-house-area").text(info.area);
	    	       				        	$(".detail-house-bill").text(info.bill);
	    	       				        	$(".detail-house-direction").text(info.direction);
	    	       				        	$(".detail-house-title").text(info.title);
	    	       				        	if(info.parking==="1"){
	    	       				        		$(".detail-house-parking").text("가능");
	    	       				        	}
	    	       				        	else{
	    	       				        		$(".detail-house-parking").text("불가능");
	    	       				        	}
	    	       				        	if(info.elevator==="1"){
	    	       				        		$(".detail-house-elevator").text("있음");
	    	       				        	}
	    	       				        	else{
	    	       				        		$(".detail-house-elevator").text("없음");
	    	       				        	}
	    	       				        	if(info.animal==="1"){
	    	       				        		$(".detail-house-animal").text("가능");
	    	       				        	}
	    	       				        	else{
	    	       				        		$(".detail-house-animal").text("불가능");
	    	       				        	}
	    	       				        	if(info.loan==="1"){
	    	       				        		$(".detail-house-loan").text("가능");
	    	       				        	}
	    	       				        	else{
	    	       				        		$(".detail-house-loan").text("불가능");
	    	       				        	}
	    	       				        	if(info.move_in != null){
	    	       				        		$(".detail-house-move_in").text(info.move_in);
	    	       				        	}
	    	       				        	else{
	    	       				        		$(".detail-house-move_in").text("협의가능");
	    	       				        	}
	    	       				        	$(".detail-house-bill1").text(info.bill);
	    	       				        	$(".detail-house-area1").text(info.area);
	    	       				        	$(".detail-house-direction1").text(info.direction);
	    	       				        	$(".detail-house-floor").text(info.floor);
	    	       				        	$(".detail-house-address").text(info.address+" "+info.address2);
	    	       				        	$(".detail-house-etc").text(info.etc);
	    	       				        	$(".detail-broker-name").text(info.broker_name);
	    	       				        	if(info.broker_landline != null){
	    	       				        		$(".detail-broker-landline").text("대표번호 : "+info.broker_landline);
	    	       				        		$(".detail-broker-phone").text("핸드폰번호 : "+info.member_phone);
	    	       				        		$(".call-broker-landline").text(info.broker_landline);
	    	       				        		$(".call-broker-phone").text(info.member_phone);
	    	       				        	}
	    	       				        	else{
	    	       				        		$(".detail-broker-landline").text("");
	    	       				        		$(".detail-broker-phone").text("핸드폰번호 : "+info.member_phone);
	    	       				        		$(".call-broker-phone").text(info.member_phone);
	    	       				        	}
	    	       				        	$(".detail-broker-email").text("이메일 : "+info.member_email);
	    	       				        	if(info.broker_address2!=null){
	    	       				        		$(".detail-broker-address").text("위치 : "+info.broker_address+" "+info.broker_address2);
	    	       				        	}
	    	       				        	else{
	    	       				        		$(".detail-broker-address").text("위치 : "+info.broker_address);
	    	       				        	}
	    	       				        	$(".call-house-no").text(info.house_no);
	    	       				        	$(".call-broker-name").text(info.broker_name);
	    	       				        	$(".listDetail").show();
	    	       				        	$(".ListAndFilter").hide();
	    	       				        	$(".zzimSpace").click(function(){
	    		       				         	if($(this).hasClass("zzimDo")){
	    		       				         		$(this).children().prop("src","../img/zzim.png");
	    		       				         		$(this).removeClass("zzimDo");
	    		       				         		//location.href="찜삭제";
	    		       				         	}
	    		       				         	else{
	    		       				         		$(this).children().prop("src","../img/zzima.png");
	    		       				         		$(this).addClass("zzimDo");
	    		       				         		//location.href="찜등록";
	    		       				         	}
	    		       				        });
	    	       				        });
           							}
           						});//안에 each문
           						var indexs=n.length;
           						$(".image-next").click(function(){
           							for(var i=0; i<indexs; i++){
           								if(i==(indexs-1)){
           									i=-1;
           								}
           								if(!$(this).hasClass(photolist[i+1])){
               								$(this).addClass(photolist[i+1]);
               								$(".image-box").children().prop("src", "<%=request.getContextPath()%>/img/"+photolist[i+1]);
               								if(i==-1){
               									$(this).removeClass(photolist[indexs-1]);
               								}
               								else{
               									$(this).removeClass(photolist[i]);
               								}
               							}
           							}
           						});
           						photolist=[];
        					},
        					error:function(){
        						
        					}
        				});//ajax끝
      				}
      			});
      			$(".total-list").text("지역 목록 "+listCount+"개");
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

<article>
	<div id="map" style="width: 100%; height: 100%;"></div>
	<div class="floatBox">
		<div class="searchBox">
			<input type="text" placeholder="지역, 지하철역 검색" class="search">
			<button class="searchBtn">검색</button>
		</div>
	</div>
</article>
<aside class="filtering">

	<div class="ListAndFilter">
		<div class="fb">
			<div class="total-list"></div>
			<input type="button" id="filter-btn" class="filter-open">
		</div>
		<div class="list"></div>

		<form action="one.jsp" method="post">
			<div class="active">
				<input type="hidden" name="filter" value="a"> 
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
									<span id="priceMin1"></span> <span id="cp1">전체</span> <span
										id="priceMax1"></span> <span id="cp2"></span>
								</div>
								<div class="slider">
									<input type="range" id="input-left1" min="0" max="25" value="0"
										step="1"> <input type="hidden" name="charter_min"
										value="N"> <input type="range" id="input-right1"
										min="0" max="25" value="25" step="1"> <input
										type="hidden" name="charter_max" value="N">
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
									<span id="priceMin3"></span> <span id="mmp1">전체</span> <span
										id="priceMax3"></span> <span id="mmp2"></span>
								</div>
								<div class="slider">
									<input type="range" id="input-left3" min="0" max="25" value="0"
										step="1"> <input type="hidden" name="deposit_min"
										value="0"> <input type="range" id="input-right3"
										min="0" max="25" value="25" step="1"> <input
										type="hidden" name="deposit_max" value="max">
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
									<span id="priceMin2"></span> <span id="mp1">전체</span> <span
										id="priceMax2"></span> <span id="mp2"></span>
								</div>
								<div class="slider">
									<input type="range" id="input-left2" min="0" max="20" value="0"
										step="1"> <input type="hidden" name="monthly_min"
										value="0"> <input type="range" id="input-right2"
										min="0" max="20" value="20" step="1"> <input
										type="hidden" name="monthly_max" value="max">
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
							<input type="button" id="floor1" value="반지하"> <input
								type="hidden" name="floor1" value="N"> <input
								type="button" id="floor2" value="지상층"> <input
								type="hidden" name="floor2" value="N"> <input
								type="button" id="floor3" value="옥탑방"> <input
								type="hidden" name="floor3" value="N">
						</div>
					</div>
					<div class="etc margin-t">
						<div>기타</div>
						<div class="margin-t">
							<input type="button" id="parking" value="주차"> <input
								type="hidden" name="parking" value="0"> <input
								type="button" id="elevator" value="엘리베이터"> <input
								type="hidden" name="elevator" value="0"> <input
								type="button" id="animal" value="반려동물"> <input
								type="hidden" name="animal" value="0"> <input
								type="button" id="loan" value="전세대출"> <input
								type="hidden" name="loan" value="0">
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