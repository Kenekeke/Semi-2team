<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카카오 실습</title>
    <link rel="stylesheet" type="text/css" href="../css/common.css">
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=68d4be6c2ce69cb3cfc2551c68619e12&libraries=clusterer,services"></script>
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

			//행정구역 경계좌표를 json파일로 가져와서 좌표배열을 생성합니다. 
            $.getJSON("./sources/seoul.json", function (geojson) {
                var data = geojson.features;
                var coordinates = [];
                var name = '';
                $.each(data, function (index, element) {
                    coordinates = element.geometry.coordinates[0];
                    name = element.properties.SIG_KOR_NM;
                    displayArea(coordinates, name);
                })

            })
			// 폴리곤의 중심좌표를 구해주는 함수
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

            // 다각형을 생상하고 이벤트를 등록하는 함수입니다
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
                    path: path, //폴리곤 경계 객체
                    strokeWeight: 2, //폴리곤 경계 두께
                    strokeColor: '#004c80', //폴리곤 경계 색상
                    strokeOpacity: 0.8, //폴리곤 경계 투명도
                    fillColor: '#fff', //폴리곤 배경 색상
                    fillOpacity: 0.8, //폴리곤 투명도
                    zIndex: 5 
                });
				//종로구는 커스텀오버레이 위치가 애매해서 따로 조정 해주었습니다.
                var centerPoint = new kakao.maps.LatLng(centroid(points)[0], centroid(points)[1]);
                if (name == '종로구') {
                    centerPoint.Ma -= 0.009
                }
                //폴리곤 안쪽 행정구역명을 표시합니다.
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
    <style>
        .outbox {
            padding: 5px;
        }

        #map {
            width: 600px;
            margin: 10px auto;
            height: 500px;
        }

        .input {
            width: 300px;
            padding: 0.25rem;
            margin: 0 1rem;
        }

        .area {
            font-size: 10px;
            font-weight: bold;
            color: blue;
        }
    </style>
</head>

<body>
    <div class="outbox center">
        <div id="map" style="width:100%;height:700px;"></div>
    </div>
    <form action="filter.jsp" method="post" name="centerForm">
    	<input type="hidden" name="Lat" id="Lat">
    	<input type="hidden" name="Lng" id="Lng">
    </form>
</body>

</html>