<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="<%=request.getContextPath() %>/css/insert-room.css" type="text/css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/Binggrae.woff">
<style>

</style>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe6f523576b10aa9e50625a1962d3635&libraries=services"></script>
<script>
var map;
$(function(){
		//지도
		var mapAddress = document.querySelector(".mapAddress");
		$(".check-location").click(function(){
	        var address = document.querySelector("input[name=address]").value;
			 //입력창의 값을 불러오는 코드
            if(!address){
                alert("주소를 입력하세요");
                return;
            }else{
				$("#insert-map").show();
				//지도 생성
				var mapContainer = document.querySelector("#insert-map"),
	            mapOption = {
	                center: new kakao.maps.LatLng(33.450701, 126.570667),
	                level: 3
	            };  
	
				map = new kakao.maps.Map(mapContainer, mapOption); 
	            
	            var geocoder = new kakao.maps.services.Geocoder();
				
	            geocoder.addressSearch(address, function(result, status) {
	                if (status === kakao.maps.services.Status.OK) {
	                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);                    
	                    //마커 생성
	                    var marker = new kakao.maps.Marker({
	                        map: map,
	                        position: coords
	                    });
	                    
	                 	// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	                    map.setCenter(coords);
	                 	
	                    mapAddress.value = result[0].road_address.address_name;
	                 	$(".address").val(result[0].road_address.address_name);
	                 	var iwContent = '<div style=" width: 150px; height: 40px; padding:5px; font-size:12px;">주소:' + result[0].road_address.address_name + '</div>';
	                 	iwPosition = new kakao.maps.LatLng(33.450701, 126.570667); //인포윈도우 표시 위치입니다
	                	// 인포윈도우를 생성합니다
	                	var infowindow = new kakao.maps.InfoWindow({
	                    position : iwPosition, 
	                    content : iwContent 
	                	});
	                  
	                	// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
	                	infowindow.open(map, marker); 
	                }
	            });
	
		        // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	            var zoomControl = new kakao.maps.ZoomControl();
	            map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);	
            }
		});
		//관리비 및 입주일 check값 연결
		$(".bill-check").change(function(){
			var check = $(this).prop("checked");
			if(check){
				$("input[name=bill]").val("0");
			}else{
				$("input[name=bill]").val(null);
			}
		});
		$(".move_in-check").change(function(){
			var check = $(this).prop("checked");
			if(check){
				$("input[name=move_in]").val(null);
			}
		});
		//사진삭제
		$(".photo-delete1").click(function(){
			$("input[name=f1]").val("");
		});
		$(".photo-delete2").click(function(){
			$("input[name=f2]").val("");
		});
		$(".photo-delete3").click(function(){
			$("input[name=f3]").val("");
		});
		$(".photo-delete4").click(function(){
			$("input[name=f4]").val("");
		});
		$(".photo-delete5").click(function(){
			$("input[name=f5]").val("");
		});
		//상세 설명 1000자 이내 작성
		$(".etc").on("input", function(){
            $("#etc-number").text($(this).val().length);
            if($(this).val().length>1000){
                alert("1000자 이내로 작성해주세요");
            }
        });
		$("input[name=title]").on("input", function(){
            if($(this).val().length>20){$
                alert("제목은 20자 이내로 작성해주세요");
            }
        });
		
		//form 이벤트 검사 추가
		var location_count = 0;
		$(".check-location").click(function(){
			location_count++;
		});
		$(".form").submit(function(e){
 			e.preventDefault();
 			if(location_count == 0){
 				alert("위치 확인 버튼을 눌러주세요")
                $('html, body').animate({scrollTop : $('body').offset().top}, 300);
 				return;
 			}else{
 				if($(".address").val() != mapAddress.value){
 					alert("입력 주소와 지도 주소가 같지 않습니다.")
					$('html, body').animate({scrollTop : $('body').offset().top}, 300);
 					return;
 				}else{
 					if($(".f1").val().length == 0 || $(".f2").val().length == 0 || $(".f3").val().length == 0 || $(".f4").val().length == 0 || $(".f5").val().length == 0){
 						alert("사진을 추가해주세요")
 						$('html, body').animate({scrollTop : $('table').offset().top}, 300);
 	 					return;
 					}else{
 						this.submit(); 					 					 					 						
 					}
 				}
 			}
		});
	});
</script>

<!-- header.jsp를 상단에 불러와 주세요 -->
<jsp:include page="/template/header.jsp"></jsp:include>


<form class="form" action="insert-room.do" method="post" enctype="multipart/form-data" >
<!-- 추후 타입 히든으로 변경 -->
<input type="hidden" name="house_type" value="one">
<div class="container">
	<div class="title">
		<div class="title-main">
			<h1>중개사무소에 방 내놓기 · 관리</h1>
		</div>
		<p>
		· 일반적인 형태의 주거용 전월세 매물만 내놓을 수 있습니다.<br>
		&nbsp;&nbsp;&nbsp;1) 한 번의 방등록으로 해당 행정구역이내 중개사무소에 방 정보가 노출되어 중개가 시작됩니다.<br>
  		&nbsp;&nbsp;&nbsp;2) 내놓은 방은 검증된 공인중개사가 매물을 확인하여 이용자들에게 중개해 드립니다.<br>
  		&nbsp;&nbsp;&nbsp;3) 방을 내놓는 데에는 별도의 비용이 들지 않습니다. (거래 성사 시 법정 중개보수가 발생합니다)<br>
		· 등록된 매물은 30일 후에 중개가 종료되며, 재등록이 필요합니다.<br>
		· 내놓은 방의 정보가 정확하지 않는 경우, 중개가 종료되고 정보수정을 요청드릴 수 있습니다.<br>
		</p>
	</div>
	<div class="add-address">
		<h3>◇ 위치정보</h3>
		<table>
			<tbody>
				<tr>
					<th width="20%">주소</th>
					<td colspan="3" width="80%">
						<span>
							<input class="inline-input address" type="text" name="address" required style="width: 340px;">
							<input class="mapAddress" type="text" style="display: none;">
						</span>
						<span>
							<input class="check-location" type="button" value="위치확인하기">
						</span>
						<div>
							<span style="color: red;">※주소 입력후 위치 확인을 꼭 눌러주세요.</span><br>	
							<p>
							· 주소와 단지명 모두 검색이 가능합니다.<br>
							· 주소 입력 시에는 동/읍/면 으로 검색해 주세요. 예) 자곡동, 동읍면, 신월읍<br>
							· 오피스텔을 검색할 때에는 동/읍/면 이름과 단지 명을 함께 입력하면 좀 더<br>
							&nbsp;&nbsp;편하게 주소를 검색할 수 있습니다. 예) 계산동 하이베라스
							</p>						
						</div>
						<div id="insert-map" style="width:100%;height:200px; display: none;"></div>
					</td>
				</tr>
				<tr>
					<th width="20%">나머지주소</th>
					<td colspan="3" width="80%">
						<div>
							<input class="inline-input" type="text" name="address2" required style="width: 100%;">		
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

<div class="add-photo">
	<h3>◇사진 등록</h3>
	<p class="photo-txt">
		· 대표사진 및 방사진을 등록해주세요.<br>
		· 직접 찍은 실제 방 사진의 원본을 등록해야 합니다.<br>                
		· 워터마크, 날짜, 전화번호 등이 포함된 사진이나 방과 관련없는 사진을 등록할 경우 중개가 종료될 수 있습니다.
	</p>
	<table>
		<tbody>
			<tr>
				<th width="20%">대표사진</th>
				<td colspan="3" width="80%">
					<input type="file" class="f1" name="f1" accept=".jpg, .png"> 
					<input class="inline-input photo-delete1" type="button" value="삭제">
				</td>
			</tr>
			<tr>
				<th width="20%">방사진1</th>
				<td colspan="3" width="80%">
						<input type="file" class="f2" name="f2" accept=".jpg, .png"> 
						<input class="inline-input photo-delete2" type="button" value="삭제">
				</td>
			</tr>
			<tr>
				<th width="20%">방사진2</th>
				<td colspan="3" width="80%">
						<input type="file" class="f3" name="f3" accept=".jpg, .png"> 
						<input class="inline-input photo-delete3" type="button" value="삭제">
				</td>
			</tr>
			<tr>
				<th width="20%">방사진3</th>
				<td colspan="3" width="80%">
						<input type="file" class="f4" name="f4" accept=".jpg, .png"> 
						<input class="inline-input photo-delete4" type="button" value="삭제">
				</td>
			</tr>
			<tr>
				<th width="20%">방사진4</th>
				<td colspan="3" width="80%">
						<input type="file" class="f5" name="f5" accept=".jpg, .png"> 
						<input class="inline-input photo-delete5" type="button" value="삭제">
				</td>
			</tr>
		</tbody>
	</table>
</div>

<div class="add-detail">
	<h3>◇상세정보</h3>
	<table>
		<tbody>
			<tr>
				<th width="20%">보증금 / 전세</th>
				<td colspan="3" width="80%">
					<input class="inline-input" type="text" name="deposit" required style="width: 150px;">만원
				</td>
			</tr>
			<tr>
				<th width="20%">월세</th>
				<td colspan="3" width="80%">
					<input class="inline-input" type="text" name="monthly" required style="width: 150px;">만원
					<p style="color: red;">※전세일 경우, 0을 입력하세요.</p>								
				</td>
			</tr>
			<tr>
				<th width="20%">관리비</th>
				<td colspan="3" width="80%">
					<input class="inline-input" type="text" name="bill" required style="width: 150px;">만원 &nbsp;/
					<label>					
						<input class="inline-input bill-check" type="checkbox">없음					
					</label>
				</td>
			</tr>
			<tr>
				<th width="20%">면적</th>
				<td colspan="3" width="80%">
					<input class="inline-input" type="text" name="area" required style="width: 150px;">㎡
				</td>
			</tr>
			<tr>
				<th width="20%">층수</th>
				<td colspan="3" width="80%">
					<select class="inline-input" name="floor">
						<option value="">선택하세요</option>
						<option value="반지하">반지하</option>
						<option value="1층">1층</option>
						<option value="2층">2층</option>
						<option value="3층">3층</option>
						<option value="4층">4층</option>
						<option value="5층">5층</option>
						<option value="옥탑방">옥탑방</option>
					</select>
					<p style="color: red;">※지상층일 경우, 상세정보에 층 수를 입력해주세요.</p>							

				</td>
			</tr>
			<tr>
				<th width="20%">방향</th>
				<td colspan="3" width="80%">
					<select class="inline-input" name="direction">
						<option value="">선택하세요</option>
						<option value="동향">동향</option>
						<option value="서향">서향</option>
						<option value="남향">남향</option>
						<option value="북향">북향</option>
						<option value="남동향">남동향</option>
						<option value="남서향">남서향</option>
						<option value="북동향">북동향</option>
						<option value="북서향">북서향</option>
						<option value="확인필요">확인필요</option>
					</select>
				</td>
			</tr>
			<tr>
				<th width="20%">전세대출</th>
				<td colspan="3" width="80%">
					<label>				
						<input class="inline-input" type="radio" name="loan" value="1" required>가능							
					</label>
					<label>				
						<input class="inline-input" type="radio" name="loan" value="0">불가능							
					</label>
				</td>
			</tr>
			<tr>
				<th width="20%">반려동물</th>
				<td colspan="3" width="80%">
					<label>				
						<input class="inline-input" type="radio" name="animal" value="1" required>가능							
					</label>
					<label>				
						<input class="inline-input" type="radio" name="animal" value="0">불가능							
					</label>
				</td>
			</tr>
			<tr>
				<th width="20%">엘리베이터</th>
				<td colspan="3" width="80%">
					<label>				
						<input class="inline-input" type="radio" name="elevator" value="1" required>있음						
					</label>
					<label>				
						<input class="inline-input" type="radio" name="elevator" value="0">없음				
					</label>
				</td>
			</tr>
			<tr>
				<th width="20%">주차</th>
				<td colspan="3" width="80%">
					<label>				
						<input class="inline-input" type="radio" name="parking" value="1" required>가능							
					</label>
					<label>				
						<input class="inline-input" type="radio" name="parking" value="0">없음							
					</label>
				</td>
			</tr>
			<tr>
				<th width="20%">입주 가능일 </th>
				<td colspan="3" width="80%">
					<input class="inline-input" type="date" name="move_in" id="datepicker">
					<label>					
						<input class="inline-input move_in-check" type="checkbox">협의가능					
					</label><br>
					<p style="color: red;">※협의가능시, 협의가능을 체크해주세요.</p>							
				</td>
			</tr>
			<tr>
				<th width="20%">제목 </th>
				<td colspan="3" width="80%">
					<input class="inline-input" type="text" name="title" style="width: 100%" required placeholder="ex): 넓은 오픈형 원룸 전세  전세대출가능">					
				</td>
			</tr>
			<tr>
				<th width="20%">상세 설명 </th>
				<td colspan="3" width="80%">
            		<div class="right">
					<textarea class="etc" rows="15" style="width: 100%" name="etc"
placeholder="해당 방에 대한 특징과 소개를 최소 50자 이상 입력해야 합니다.
방의 위치와 교통, 주변 편의시설, 방의 특징과 장점, 보안시설, 옵션, 주차, 
전체적인 방의 느낌 등을 작성 해주세요.

다른 방에 대한 설명, 연락처, 홍보 메세지 등 해당 방과 관련없는 내용을 입력하거나 해당 방에 대한 설명이 부적절한 경우 중개가 종료될 수 있습니다."></textarea>
            			<span class="etc-length" id="etc-number" >0</span>
            			<span class="etc-length">/1000</span>            		
            		</div>
				</td>
			</tr>				
		</tbody>
	</table>
</div>
<div class="submit">
	<input class="submit-btn" type="submit" value="방 등록하기">
</div>
</div>
</form>
	
	
	
	
<!-- footer.jsp를 하단에 불러와 주세요 -->
<jsp:include page="/template/footer.jsp"></jsp:include>
