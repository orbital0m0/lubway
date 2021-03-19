<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 찾기</title>
<link rel="stylesheet" type="text/css"
	href="${path}/resources/css/ui.common.css" />
<link rel="stylesheet" type="text/css"
	href="${path}/resources/css/ui.subway.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/user/header.jsp"%>

	<div id="content">
		<!-- 매장찾기 s -->
		<div class="store_search_wrapper">
			<!-- 매장찾기 레이어 s -->
			<div class="store_search_layer">
				<h2>매장찾기</h2>
				<!-- 검색 -->
				<div class="form_search">
					<form id="mapFrm" method="POST" name="mapFrm"
						onsubmit="return shopMap.search()">
						<input id="keyword" maxlength="30" placeholder="지역 또는 매장명 입력"
							type="text" value="" /> <a class="btn_search" href="#"
							onclick="shopMap.search();return false;"></a>
					</form>
				</div>
				<!--// 검색 -->

				<!-- 검색결과 -->
				<div class="search_result_cont" id="uiReslutCont"
					style="display: none;">
					<p class="search_total">
						검색 결과 <strong id="uiResultCount">0</strong>건
					</p>

					<div class="store_list_scroll">
						<ul id="uiResultList">
						</ul>
					</div>

					<!-- board 페이지 -->
					<div class="pagination" id="ui_pager"></div>
					<!--// board 페이지 -->
				</div>
				<!--// 검색결과 -->
			</div>
			<!--// 매장찾기 레이어 e -->

			<!-- 매장지도 s -->
			<div class="store_map" id="map">
				<script type="text/javascript"
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ffe7c5af8a7826856c48dec067ac9849&libraries=services"></script>
				<script>
		
					var container = document.getElementById('map');
					var options = {
						center : new kakao.maps.LatLng(37.56249087747179, 126.97657325145),
						level : 5
					};

					var map = new kakao.maps.Map(container, options);
					
					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder(); 
					var arr = new Array();
					
					// 주소로 좌표를 검색합니다 for문 안에 넣기
					<c:forEach items="${findStore}" var="info">
						var storeinfo = new Object();
						storeinfo.address_road = "${info.address_road}";
						storeinfo.storename = "${info.storename}";
						arr.push(storeinfo);
					</c:forEach>
						
					for(var i=0; i <arr.length; i++){
							var obj = arr[i];
							console.log(obj.address_road);
							console.log(obj.storename);
						
						geocoder.addressSearch(obj.address_road, function(result, status) { 
							// 정상적으로 검색이 완료됐으면 
							if (status === kakao.maps.services.Status.OK) { 
								console.log(result);
								var markerPosition = new kakao.maps.LatLng(result[0].y,result[0].x);
							// 결과값으로 받은 위치를 마커를 생성하고 표시합니다 
								var marker = new kakao.maps.Marker({ 
								map: map, 
								position: markerPosition
							});
						}
					});
				}
					
				</script>
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/views/user/footer.jsp"%>
</body>
</html>