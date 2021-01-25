<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript"
    	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe6f523576b10aa9e50625a1962d3635&libraries=services"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script>
        $(function () {

            var mapContainer = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
            var mapOption = { //지도를 생성할 때 필요한 기본 옵션
                center: new kakao.maps.LatLng(37.566826, 126.9786567), //지도의 중심좌표.
                level: 9 //지도의 레벨(확대, 축소 정도)
      
            }
	        
            var map = new kakao.maps.Map(mapContainer, mapOption),
                infowindow = new kakao.maps.InfoWindow({
                    removable: true
                });
			
            var sw = new kakao.maps.LatLng(36.75525836792622, 123.7967588131816), // 사각형 영역의 남서쪽 좌표
            ne = new kakao.maps.LatLng(38.67228426335882, 130.5644388631832); // 사각형 영역의 북동쪽 좌표

	        // 사각형을 구성하는 영역정보를 생성합니다
	        // 사각형을 생성할 때 영역정보는 LatLngBounds 객체로 넘겨줘야 합니다
	        var rectangleBounds = new kakao.maps.LatLngBounds(sw, ne);
	
	        // 지도에 표시할 사각형을 생성합니다
	        var rectangle = new kakao.maps.Rectangle({
	            bounds: rectangleBounds, // 그려질 사각형의 영역정보입니다
	            strokeWeight: 1, // 선의 두께입니다
	            strokeColor: '#ced4da', // 선의 색깔입니다
	            strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
	            strokeStyle: 'shortdashdot', // 선의 스타일입니다
	            fillColor: '#ced4da', // 채우기 색깔입니다
	            fillOpacity: 0.8 // 채우기 불투명도 입니다
	        });
	
	        // 지도에 사각형을 표시합니다
	        rectangle.setMap(map);
	        map.setDraggable(false);


            $.getJSON("./house/source/seoul.json", function (geojson) {
                var data = geojson.features;
                var coordinates = [];
                var name = '';
                $.each(data, function (index, element) {
                    coordinates = element.geometry.coordinates[0];
                    name = element.properties.SIG_KOR_NM;
                    displayArea(coordinates, name);
                })

            })
 
            function centroid(points) {
                var i, j, len, p1, p2, f, area, x, y;
                area = x = y = 0;
                for (i = 0, len = points.length, j = len - 1; i < len; j = i++) {
                    p1 = points[i];
                    p2 = points[j];

                    f = p1.y * p2.x - p2.y * p1.x;
                    x += (p1.x + p2.x) * f;
                    y += (p1.y + p2.y) * f;
                    area += f * 3;
                }
                return [x / area, y / area];  
 
            }

            // 다각형을 생성하고 이벤트를 등록하는 함수입니다
            function displayArea(coordinates, name) {
                var path = [];
                var points = [];
                var customOverlay = new kakao.maps.CustomOverlay({});

                $.each(coordinates, function (index, LatLng) {
                    var point = {
                        x: LatLng[1],
                        y: LatLng[0]
                    };
                    points.push(point);
                    path.push(new kakao.maps.LatLng(LatLng[1], LatLng[0]));
                })
                // 다각형을 생성합니다 
                var polygon = new kakao.maps.Polygon({
                    map: map, // 다각형을 표시할 지도 객체
                    path: path,
                    strokeWeight: 1,
                    strokeColor: '#ced4da',
                    strokeOpacity: 0.8,
                    fillColor: '#fff',
                    fillOpacity: 0.8,
                    
                });

                var centerPoint = new kakao.maps.LatLng(centroid(points)[0], centroid(points)[1]);
                if (name == '종로구') {
                    centerPoint.Ma -= 0.009
                }
                customOverlay.setContent('<span class="area">' + name + '</span>');
                customOverlay.setPosition(centerPoint);
                customOverlay.setMap(map);

                // 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다 
                // 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
                kakao.maps.event.addListener(polygon, 'mouseover', function (mouseEvent) {
                    polygon.setOptions({
                        fillColor: '#09f',
                        fillOpacity: 0.6
                    });
                });

                // 다각형에 mousemove 이벤트를 등록하고 이벤트가 발생하면 커스텀 오버레이의 위치를 변경합니다 
                kakao.maps.event.addListener(polygon, 'mousemove', function (mouseEvent) {
                    //customOverlay.setPosition(mouseEvent.latLng);
                });

                // 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
                // 커스텀 오버레이를 지도에서 제거합니다 
                kakao.maps.event.addListener(polygon, 'mouseout', function () {
                    polygon.setOptions({
                        fillColor: '#fff',
                        fillOpacity: 0.8
                    });
                });
                
                // 다각형에 click 이벤트를 등록하고 이벤트가 발생하면 다각형의 이름과 면적을 인포윈도우에 표시합니다 
                kakao.maps.event.addListener(polygon, 'click', function (mouseEvent) { 
                    var Lat=centerPoint.Ma;
                    var Lng=centerPoint.La;
          			$("#Lat").val(Lat);
          			$("#Lng").val(Lng);
                    document.centerForm.submit();
                    
                });
            }	
            
        });
        	
    </script>
	<script>
    function type_bt(type){
    	e.preventdefault()
    	if(type=="oneroom"){
        	document.centerForm.action="./house/oneroom.jsp"
        };
        if(type=="villa"){
        	document.centerForm.action="./house/villa.jsp"
        };
        if(type=="office"){
        	document.centerForm.action="./house/office.jsp"
        };
    };
    document.getElementById('type_bt').addEventListener('onchange',click);
	</script>
<jsp:include page="/template/header.jsp"></jsp:include>
    
<div class="all_wrapper">
		<div class="type_selector">
			<form method="post" name="centerForm">
			    	<input type="hidden" name="Lat" id="Lat">
			    	<input type="hidden" name="Lng" id="Lng">
			    	<select name=type onchange="type_bt(this.value)" class="selector_type">
			    	<option value="anytype">건물 유형 선택</option>
			    	<option value="oneroom">원룸</option>
			    	<option value="villa">투룸|빌라</option>
			    	<option value="office">오피스텔</option>
		    	</select>
    		</form>
    		</div>
  			<div id="map" style="width:100%;height:600px;">
  		</div>
	<div class="home_wrapper">
		<div class="home_lower">
			<div class="home_keeper">
				<h2>사이트 소개</h2>
			</div>
		</div>
		<div class="home_lower">
			<div class="home_keeper">
				<h2>뉴스</h2>
			</div>
		</div>
		<div class="home_lower">
			<div class="home_keeper">
				<h2>공지사항</h2>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>