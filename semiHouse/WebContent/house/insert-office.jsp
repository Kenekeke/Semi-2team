<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	table{
		font-size: 15px;
	}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=229e2c08f37ef9afeaa49b3fd7017d47&libraries=services" charset="UTF-8"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
var map;
$(function(){
		//검색을 원할 때 실행 할 함수
		$(".check-location").click(function(){
			$('#map').show();
			//지도 생성
			var mapContainer = document.querySelector("#map"),
            mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667),
                level: 3
            };  

			 map = new kakao.maps.Map(mapContainer, mapOption); 
            
			 //입력창의 값을 불러오는 코드
            var address = document.querySelector("input[name=address]").value;
            if(!address){
                alert("주소를 입력하세요");
                return;
            }
            
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
		});
		
		$(".bill-check").change(function(){
			var check = $(this).prop("checked");
			if(check){
				$("input[name=bill]").val("0");
			}else{
				$("input[name=bill]").val(null);
			}
		});
		$(".photo-delete").click(function(){
			var photo = document.querySelector("input[name=f1]");
			photo[0].select();
			document.selection.clear();
		});
	});
	
</script>
<!-- header.jsp를 상단에 불러와 주세요 -->
<jsp:include page="/template/header.jsp"></jsp:include>


<form action="insert-room.do" method="post" enctype="multipart/form-data" >
<!-- 추후 타입 히든으로 변경 -->
<input type="hidden" name="house_type" value="office">
<div class="add-adress" style="width: 600px;">
	<h4>위치정보</h4>
		<table style="width: 600px;">
		<tr>
			<th width="20%">주소</th>
			<td colspan="3" width="80%">
				<div>
					<span>
						<input class="inline-input address" type="text" name="address" required style="width: 350px;">
					</span>
					<span>
						<input class="check-location" type="button" value="위치확인하기">
					</span>
				</div>
				<div>
					· 주소와 단지명 모두 검색이 가능합니다.<br>
					· 주소 입력 시에는 동/읍/면 으로 검색해 주세요. 예) 자곡동, 동읍면, 신월읍<br>
					· 오피스텔을 검색할 때에는 동/읍/면 이름과 단지 명을 함께 입력하면 좀 더<br>
					&nbsp;&nbsp;편하게 주소를 검색할 수 있습니다. 예) 계산동 하이베라스
				</div>
				<div id="map" style="width:100%;height:200px; display: none;"></div>
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
	</table>
</div>

<div class="add-photo" style="width: 600px;">
	<h4>사진 등록</h4>
	<p class="photo-txt">
		· 대표사진 및 방사진을 등록해주세요.<br>
	<span>
		· 직접 찍은 실제 방 사진의 원본을 등록해야 합니다.<br>                
		· 워터마크, 날짜, 전화번호 등이 포함된 사진이나 방과 관련없는 사진을 등록할 경우 중개가 종료될 수 있습니다.
	</span>
	</p>
	<table style="width: 600px;">
		<tr>
			<th width="20%">대표사진</th>
			<td colspan="3" width="80%">
				<input type="file" name="f1" accept=".jpg, .png"> 
				<input class="inline-input photo-delete1" type="button" value="삭제">
			</td>
		</tr>
		<tr>
			<th width="20%">방사진</th>
			<td colspan="3" width="80%">
					<input type="file" name="f2" accept=".jpg, .png"> 
					<input class="inline-input photo-delete2" type="button" value="삭제">
			</td>
		</tr>
	</table>
</div>

<div class="add-detail" style="width: 600px;">
	<h4>상세 정보</h4>
	<table style="width: 600px;">
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
					<span style="color: red;">※전세일 경우, 0을 입력하세요.</span>								
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
					<span style="color: red;">※지상층일 경우, 상세정보에 층 수를 입력해주세요.</span>							
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
						<option value="남동향">남동</option>
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
					<input class="inline-input" type="date" name="move_in">
					<span style="color: red;">※협의가능시, 날짜 선택을 하지마세요.</span>							
				</td>
			</tr>
			<tr>
				<th width="20%">제목 </th>
				<td colspan="3" width="80%">
					<input class="inline-input" type="text" name="title" style="width: 100%">					
				</td>
			</tr>
			<tr>
				<th width="20%">상세 설명 </th>
				<td colspan="3" width="80%">
					<textarea rows="15" style="width: 100%" name="etc" 
					placeholder="해당 방에 대한 특징과 소개를 최소 50자 이상 입력해야 합니다.
방의 위치와 교통, 주변 편의시설, 방의 특징과 장점, 보안시설, 옵션, 주차, 전체적인 방의 느낌 등을 작성 해주세요.
다른 방에 대한 설명, 연락처, 홍보 메세지 등 해당 방과 관련없는 내용을 입력하거나 해당 방에 대한 설명이 부적절한 경우 중개가 종료될 수 있습니다.">
					</textarea>
				</td>
			</tr>				
		</tbody>
	</table>
</div>
<div style="width: 600px;">
	<input class="input" type="submit" value="방 등록하기">
</div>
</form>
	
	
	
	
<!-- footer.jsp를 하단에 불러와 주세요 -->
<jsp:include page="/template/footer.jsp"></jsp:include>
