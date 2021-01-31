<%@page import="houseSemi.beans.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf8");
boolean isMember = session.getAttribute("check")!=null;
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
    			$(".searchItem").css("background-color","transparent");
    			$(this).css("background-color","lightgray");
    		});
    		$(".floatBox").find(".searchItem").bind('mouseleave', function(e){
    			$(this).css("background-color","transparent");
    		});
    		$(".floatBox").find(".searchBtn").on("click", function(){
    			if($(".searchResult").length!=0){
        			$(".search").val($(".searchResult").children().first().find(".searchName").text());
        			var searchLat=$(".searchResult").children().first().find(".searchLat").text();
                	var searchLng=$(".searchResult").children().first().find(".searchLng").text();
    				map.setCenter(new kakao.maps.LatLng(searchLat,searchLng));
        			map.setLevel(4);
        			$(".searchResult").remove();
    			}
    		});			
    		$(".search").on("click",function(){
    			index=-1;
    			$(".searchResult").children().blur();
	    		$(".searchResult").children().css("background-color","transparent");
    		})
   			var index=-1;
    		window.addEventListener("keyup", function(e){
				if($(".search").focus()){
				
	 	  			if(e.keyCode==13 && $(".searchItem").length!=0){
	 	  				if(index==-1){
	 	  					$(".search").val($(".searchResult").children().first().find(".searchName").text());
		        			var searchLat=$(".searchResult").children().first().find(".searchLat").text();
		                	var searchLng=$(".searchResult").children().first().find(".searchLng").text();
		    				map.setCenter(new kakao.maps.LatLng(searchLat,searchLng));
		        			map.setLevel(4);
		        			$(".searchResult").remove();
	 	  				}
	 	  				else{
		 	  				$(".search").val($(".searchResult").children().eq(index).find(".searchName").text());
		        			var searchLat=$(".searchResult").children().eq(index).find(".searchLat").text();
		                	var searchLng=$(".searchResult").children().eq(index).find(".searchLng").text();
		    				map.setCenter(new kakao.maps.LatLng(searchLat,searchLng));
		        			map.setLevel(4);
		        			$(".searchResult").remove();
	 	  				}
	    				
	    			}
	 	  			else if(e.keyCode==40){
	 	  				if(index==$(".searchItem").length-1){
	 	  					index=-1;
	 	  				}
	 	  				index++;	
	 	  				$(".searchResult").children().not(index).blur();
	 	    			$(".searchResult").children().not(index).css("background-color","transparent");
	
	 	  				$(".searchResult").children().eq(index).focus();
	 	    			$(".searchResult").children().eq(index).css("background-color","lightgray");
	 	    			
	 	  			}
	 	  			else if(e.keyCode==38){
	 	  				console.log(index);
	 	  				if(index<=0){
	 	  					index=$(".searchItem").length;
	 	  				}
	 	  				index--;
	 	  				$(".searchResult").children().not(index).blur();
	 	    			$(".searchResult").children().not(index).css("background-color","transparent");
	 	    			
	 	  				$(".searchResult").children().eq(index).focus();
	 	    			$(".searchResult").children().eq(index).css("background-color","lightgray");
	 	  				
	 	  			}
				}
    		});
    	});
        $(".list").show();
		$("#charter-range").hide();
		$(".listDetail").hide();
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
      			var template = $("#template").html();
      			var template_img = $("#image-template").html();
      			var listCount=0;
      			$.each(markers, function(index, marker){
      				if(bounds.contain(marker.getPosition())){
      					listCount = listCount+1;
      					$.ajax({
        					async:false,//순차적으로실행되도록 설정
        					url: "<%=request.getContextPath()%>/like/zzim_detail.do",
        					type : "POST",
        					data : {
        						house_type : marker.type,
        						house_no: marker.no
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
       				         	$(template).find(".filterImg").children().attr("src", "<%=request.getContextPath()%>/img/"+resp[0].save_name).appendTo($(".list").children().last());
       				      	 	$(template).find(".filterPrice").text(list_price).appendTo($(".list").children().last());
 				             	$(template).find(".filterInfo").text(area_floor).appendTo($(".list").children().last());
 				             	$(template).find(".filterAddress").text(resp[0].address).appendTo($(".list").children().last());
        						$(".list").children().last().click(function(){
        							$(".image-btn-box").remove();
        							$.each(resp, function(index, info){
        								$(template_img).find(".image-btn-box").appendTo(".image-box");
        								$(template_img).find(".detail-imagebtn-box").appendTo($(".image-box").children().last());
        								$(template_img).find(".img-img").attr("src", "<%=request.getContextPath()%>/img/"+info.save_name).appendTo($(".image-box").children().last());
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
   	       				        		$(".call-broker-landline").text("");
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
   	       				        	if(<%=isMember%>){
   	       				        		zzimCheck(resp[0].house_no);
   	       				        	}
   	       				        	else{
   	       				        		$(".zzimSpace").children().prop("src", "../img/zzim.png");
   	       				        	}
	       				      		house_no = resp[0].house_no;
    	       				    });
        					},
        					error:function(){
        						console.log("false_filter")
        					}
        					
        				});
      				}
      			});
      			$(".total-list").text("지역 목록 "+listCount+"개");
        	};
        	$(".zzimSpace").click(function(){
        		if(<%=isMember%>){
        			zzimAdd(house_no);
        		}
        		else{
        			alert("로그인후에 이용가능합니다.");
        		}
        	});
	    	function zzimAdd(house_no){
	    		var y;
	    		$.ajax({
						async:false,//순차적으로실행되도록 설정
						url : "<%=request.getContextPath()%>/like/zzim_add.do",
						type : "POST",
						data : {
							house_no : house_no
						},
						success:function(zzim){
			        	if(zzim==="add"){
			        		alert("찜목록에 추가되었습니다.");
			        		y="../img/zzima.png";
			        	}
			        	else{
			        		alert("찜목록에서 삭제되었습니다.");
			        		y="../img/zzim.png";
			        	}
						},
					error:function(){
						
					}
	    		});
	    		$(".zzimSpace").children().prop("src", y);
	    	};
	    	function zzimCheck(house_no){
	    		var z;
	    		$.ajax({
						async:false,//순차적으로실행되도록 설정
						url : "<%=request.getContextPath()%>/like/zzim_check.do",
						type : "POST",
						data : {
							house_no : house_no
						},
						success:function(zzim){
			        	if(zzim==="yes"){
			        		z="../img/zzima.png";
			        	}
			        	else{
			        		z="../img/zzim.png";
			        	}
						},
					error:function(){
						
					}
	    		});
	    		$(".zzimSpace").children().prop("src", z);
	    	};
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
<article>
   	<div id="map" style="width: 100%; height: 100%;"></div>
	<div class="floatBox">
		<div class="searchBox">
			<input type="text" placeholder="지역, 지하철역 검색" class="search">
			<button class="searchBtn"><img alt="돋보기" src="../img/search.png" style="width: 30px;"></button>
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
				
			</div>
			<div class="infoinfoList">
				<div class="detail-house-price"></div>
				<div class="regist-house-num"></div>
			</div>
			<div class="infoinfoList displayList">
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
			<div class="titleListlast">
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
				<img alt="전화이미지" src="../img/call.png" style="width: 30px;">
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