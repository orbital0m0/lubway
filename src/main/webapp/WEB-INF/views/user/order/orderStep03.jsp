<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문하기 > Step03</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<!-- 
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min. js"></script>
 -->
<script src="${path}/resources/js/order.js"></script>
<script src="${path}/resources/js/orderStep03.js"></script>
<link rel="stylesheet" href="${path}/resources/css/modal.css" />
<link rel="stylesheet" href="${path}/resources/css/choice_option.css" />
<link rel="stylesheet" href="${path}/resources/css/menu.css?v=2">
<link rel="stylesheet" href="${path}/resources/css/ui.popup.css" />
<link rel="stylesheet" type="text/css" href="${path}/resources/css/fastway.css" />
<link rel="shortcut icon" type="image/x-icon" href="${path}/resources/images/subway_favicon.ico">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
$(window).load(function(){
    $(".loading").fadeOut();
});

//메뉴에 따른 선택 항목 노출 설정
var min = 1;
var max = 10;

function hideDiv() {
	var protocol = '${hideNum}';
	console.log("hideNum : " + protocol);
	switch(protocol){
	case "4" :
		console.log("4번입니다~");
		$("#breadSize").hide();
		$("#breadType").hide();
		break;
	case "3" :
		console.log("3번입니다~");
		$(".required").hide();
		$(".extra").hide();
		$("#strong").text("STEP 01");
		break;
	case "2" :
		console.log("2번입니다~");
		$(".list_wrapper").hide();
		break;
	case "1" :
		console.log("1번입니다~");
		$("#component_chart").hide();
		$(".list_wrapper").hide();
		$(".cal").hide();
		break;
	}
}

$(document).ready(function() {
	// fast/home 배경 구분
	var way = '${whatWay}';
	console.log("whatWay : " + way);
	
	if(way == 'Fast-Way'){
		$('.order').addClass('fast_sub');
		$('.order').removeClass('home_sub');
	} else if(way == 'Home-Way'){
		$('.order').addClass('home_sub');
		$('.order').removeClass('fast_sub');
	}
});
</script>
<style type="text/css">
.loading{
	width: 100%;
	height: 100%;
	position: fixed;
	z-index: 1000;
	background-image : url("https://lubway.s3.ap-northeast-2.amazonaws.com/KakaoTalk_20210405_101739419.gif");
	background-repeat: no-repeat;
	background-position: center;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/user/header.jsp"%>
<div class="loading"></div>
	<div id="content" class="order" style="padding-top: 175px">
		<div class="order_title">
			<c:if test="${whatWay eq 'Fast-Way' }">
				<h3>Fast-Way</h3>
				<p>온라인 주문 후 매장에서 픽업/시식하는 서비스 입니다.</p>
			</c:if>
			<c:if test="${whatWay eq 'Home-Way' }">
				<h3>Home-Way</h3>
				<p>온라인 주문 시 배달되는 서비스입니다.</p>
			</c:if>
		</div>
		<!-- 메뉴소개 s -->
		<div class="menu_view_wrapper" style="padding-left: 180px; padding-top:0px;">
			<!-- 메뉴 content -->
			<div class="menu_content"
				style="width: 85%; background-color: white;">
				<!-- 메뉴 header -->
				<div class="hd">
					<div class="category"></div>
					<h2 class="title_name">${menu.name }</h2>
					<p class="eng">${menu.engname }</p>
					<p class="cal">${nutrient.cal }Kcal</p>
				</div>
				<!--// 메뉴 header -->

				<!-- 메뉴정보 -->
				<div class="menu_info">
					<div class="menu_img">
						<img src="${menu.filePath }" />
					</div>
					<p class="summary">${menu.content }</p>
				</div>
				<!--// 메뉴정보 -->

				<!-- 영양성분표 -->
				<div class="component_chart" id="component_chart" style="background-color:white">
					<div class="content" style="width: 85%;">
						<h3>영양성분표</h3>
						<!-- 로스트 치킨 베이컨 -->
						<div class="board_list_wrapper">
							<table>
								<thead>
									<TR>
										<th scope="col">중량(g)</th>
										<th scope="col">열량(kcal)</th>
										<th scope="col">당류(g)</th>
										<th scope="col">단백질(g)</th>
										<th scope="col">포화지방(g)</th>
										<th scope="col">나트륨(mg)</th>

									</TR>
								</thead>
								<tbody>
									<TR>
										<td>${nutrient.ttl }</td>
										<td>${nutrient.cal }</td>
										<td>${nutrient.sug }</td>
										<td>${nutrient.pro}</td>
										<td>${nutrient.fat}</td>
										<td>${nutrient.sod}</td>

									</TR>
								</tbody>
							</table>
						</div>
						<ul class="notice">
							<li>※ 기본야채 5종(양상추, 토마토, 양파, 피망, 오이) 및 제품에 따른 미트류 포함, 치즈 및 소스
								제외, 15cm 위트 브레드 기준</li>
							<li>※ 괄호 안 %는 1일 영양소 기준치에 대한 비율</li>
						</ul>

						<div class="btns_wrapper">
							<a id="popup" class="btn bgc_black size1" style="width: 110px;"
								href="#popup_wrap" rel="modal:open"> <span>원산지 정보</span>
							</a>
						</div>
					</div>
				</div>

				<!-- 상세 선택 메뉴 -->
				<div class="list_wrapper" style="background-color:white">
					<div class="content">
						<div class="choice_option">
							<div class="step01 required">
								<div class="th_name_step01">
									<strong>STEP 01</strong>&nbsp;&nbsp;필수 선택 *
								</div>
								<div id="length" class="modal">
									<div class="option_display">
										<dl>
											<dt>빵 길이 선택</dt>
											<dd id="lengthText"></dd>
										</dl>
									</div>
									<div class="popup_content length">
										<ul>
											<li><label class="form_circle" for="15cm"> <input
													name="length" type="radio" id="15cm"
													value="15cm"> <span class="icon"></span> <em>15cm</em>
											</label></li>
											<li><label class="form_circle" for="30cm">
											<c:if test="${hideNum eq 5 }">
												<input type="hidden" value="${menu.price30 }" id="price30">
											</c:if>
											<input name="length" type="radio" id="30cm" value="30cm">
											<span class="icon"></span> <em>30cm</em>
											</label></li>
											<label style="color:#FF8300">빵 길이 선택 변경시 모든 추가 선택이 초기화 됩니다.</label>
										</ul>
										<input class="choice_btn" type="button" value="선택"
											onclick="endSize();">
									</div>
								</div>
								<div class="wrap_pop" id="breadSize">
									<a class="pop" href="#length" rel="modal:open">길이 선택</a>
								</div>

								<div id="bread" class="modal">
									<div class="option_display">
										<dl>
											<dt>빵 선택</dt>
											<dd id="breadText">빵을 선택해 주세요</dd>
										</dl>
									</div>
									<div class="popup_content bread">
										<ul>
											<c:forEach items="${breadList}" var="bread">
												<li><label class="form_circle"> <input
														name="bread" type="radio" value="${bread.name }">
														<span class="icon"></span> <em>${bread.name }</em>
												</label></li>
											</c:forEach>
										</ul>
										<input class="choice_btn" type="button" value="선택"
											onclick="endBread();">
									</div>
								</div>
								<div class="wrap_pop" id="breadType">
									<a class="pop" href="#bread" rel="modal:open">빵 선택</a>
								</div>

								<div id="cheese" class="modal">
									<div class="option_display">
										<dl>
											<dt>치즈 선택</dt>
											<dd id="cheeseText">치즈를 선택해 주세요</dd>
										</dl>
									</div>
									<div class="popup_content cheese">
										<ul>
											<c:forEach items="${cheeseList }" var="cheese">
												<li><label class="form_circle"> <input
														name="cheese" type="radio" value="${cheese.name }">
														<span class="icon"></span> <em>${cheese.name }</em>
												</label></li>
											</c:forEach>
										</ul>
										<c:if test="${hideNum eq 4 }">
											<input class="choice_btn" type="button" value="선택"
												onclick="saladOnly();">
										</c:if>
										<c:if test="${hideNum ne 4 }">
											<input class="choice_btn" type="button" value="선택"
												onclick="endCheese();">
										</c:if>
									</div>
								</div>
								<div class="wrap_pop">
									<a class="pop" href="#cheese" rel="modal:open">치즈 선택</a>
								</div>

								<div id="vegetable" class="modal">
									<div class="option_display">
										<dl>
											<dt>야채 선택 (다중 선택)</dt>
											<dd id="vegeText">야채를 선택해 주세요.</dd>
										</dl>
									</div>
									<div class="popup_content vegetable">
										<ul>
											<c:forEach items="${vegeList }" var="vege">
												<li><label class="form_circle"> <input
														name="vegetable" type="checkbox" value="${vege.name }">
														<span class="icon"></span> <em>${vege.name }</em>
												</label></li>
											</c:forEach>
											<li><label class="form_circle"> <input
														name="vegetable" type="checkbox" value="야채 모두 선택" onclick='selectAll(this)'>
														<span class="icon"></span> <em>야채 모두 선택</em>
												</label></li>
										</ul>
										<input class="choice_btn" type="button" value="선택"
											onclick="endVegetable();">
									</div>
								</div>
								<div class="wrap_pop">
									<a class="pop" href="#vegetable" rel="modal:open">야채 선택</a>
								</div>

								<div id="sauce" class="modal">
									<div class="option_display">
										<dl>
											<dt>소스/시즈닝 선택</dt>
											<dd id="sauceText">소스/시즈닝을 선택해 주세요.</dd>
										</dl>
									</div>
									<div class="popup_content sauce">
										<ul>
											<c:forEach items="${sauceList }" var="sauce">
												<li><label class="form_circle"> <input
														name="sauce" type="checkbox" value="${sauce.name }">
														<span class="icon"></span> <strong>${sauce.sub }</strong><em>${sauce.name }</em>
												</label></li>
											</c:forEach>
										</ul>
										<input class="choice_btn" type="button" value="선택"
											onclick="endSauce();">
									</div>
								</div>
								<div class="wrap_pop">
									<a class="pop" href="#sauce" rel="modal:open">소스/시즈닝 선택</a>
								</div>
								<p id="selectStep01"></p>
							</div>
							<!-- end of step01 -->

							<!----------------------------------- 02 추가선택 영역 ----------------------------------------->
							<div class="step01 extra">
								<div class="th_name_step02">
									<strong>STEP 02</strong>&nbsp;&nbsp;추가 선택
								</div>
								<div id="topping" class="modal">
									<div class="option_display">
										<dl>
											<dt>추가 선택 (다중 선택 가능)</dt>
											<dd id="toppingText">원하는 제품을 추가 선택해 주세요</dd>
											<dd>
												<span id="sum">+ 0원</span>
											</dd>
										</dl>
									</div>
									<div class="popup_content topping">
										<ul>
											<c:forEach items="${toppingList }" var="topping">
												<li><label class="form_circle"> <input
														name="topping" type="checkbox"
														value="${topping.name }, ${topping.topping_price}"> <span
														class="icon"></span><em>${topping.name }</em> <span>+<em><fmt:formatNumber
																	value="${topping.topping_price }" pattern="#,###" /></em>&nbsp;원
													</span>
												</label></li>
											</c:forEach>
										</ul>
										<input class="choice_btn" type="button" value="선택"
											onclick="endAddSelect();">
									</div>
								</div>
								<div class="wrap_pop">
									<a class="pop" href="#topping" rel="modal:open">추가 선택</a>
								</div>

								<div id="meat" class="modal">
									<div class="option_display">
										<dl>
											<dt>미트 추가</dt>
											<dd id="meatText">미트 추가를 선택해 주세요</dd>
											<dd>
												<span id="sum2">+ 0원</span>
											</dd>
										</dl>
									</div>
									<div class="popup_content meat">
										<ul>
											<c:forEach items="${meatList }" var="meat">
												<li><label class="form_circle"> <input
														name="meat" type="checkbox"
														value="${meat.name }, ${meat.meat_price}"> <span
														class="icon"></span><em>${meat.name }</em> <span>+<em><fmt:formatNumber
																	value="${meat.meat_price }" pattern="#,###" /></em>&nbsp;원
													</span>
												</label></li>
											</c:forEach>
										</ul>
										<input class="choice_btn" type="button" value="선택"
											onclick="endAddMeatSelect();">
									</div>
								</div>
								<div class="wrap_pop">
									<a class="pop" href="#meat" rel="modal:open">미트 추가</a>
								</div>

								<div id="add_cheese" class="modal">
									<div class="option_display">
										<dl>
											<dt>치즈 추가</dt>
											<dd id="addCheeseText">치즈 추가를 선택해 주세요</dd>
											<dd>
												<span id="sum3">+ 0원</span>
											</dd>
										</dl>
									</div>
									<div class="popup_content add_cheese">
										<ul>
											<c:forEach items="${cheeseList }" var="chee">
												<li><label class="form_circle">
												<input name="add_cheese" type="checkbox" value="${chee.name }, ${chee.cheese_price}">
												<span class="icon"> </span>
												<em>${chee.name }</em>
												<span>+<em><fmt:formatNumber value="${chee.cheese_price }" pattern="#,###" /></em>&nbsp;원
													</span>
												</label></li>
											</c:forEach>
										</ul>
										<input class="choice_btn" type="button" value="선택"
											onclick="endAddCheeseSelect();">
									</div>
								</div>
								<div class="wrap_pop">
									<a class="pop" href="#add_cheese" rel="modal:open">치즈 추가</a>
								</div>
								<p id="selectStep02"></p>
							</div>
							<!-- end of step02 -->

							<!----------------------------------- 03 세트선택 영역 ----------------------------------------->
							<div class="step01">
								<div class="th_name_step03">
									<strong id="strong">STEP 03</strong>&nbsp;&nbsp;상품 선택
								</div>
								<div id="select_one" class="modal">
									<div class="one">
										<label>단품을 선택하셨습니다.</label>
									</div>
								</div>
								<div class="wrap_pop">
									<a class="pop" href="#select_one" rel="modal:open">단품</a>
								</div>

								<div id="select_set" class="modal">
									<div class="option_display">
										<dl>
											<dt>세트 선택</dt>
											<dd id="setText"></dd>
											<dd>
												<span id="sum4">+ 0원</span>
											</dd>
										</dl>
									</div>
									<div class="popup_content set_menu">
										<ul>
											<li><label class="form_circle"> <input
													name="select_set" type="radio"
													value="cookie, 1900"> <span class="icon"></span>
												<em>쿠키 세트</em><span> +<em><fmt:formatNumber value="1900" pattern="#,###" /></em>&nbsp;원
													</span>
											</label></li>
											<li><label class="form_circle"> <input
													name="select_set" type="radio" value="wedge, 2400"> <span
													class="icon"></span> <em>웨지/스프 세트</em><span> +<em><fmt:formatNumber value="2400" pattern="#,###" /></em>&nbsp;원
													</span>
											</label></li>
										</ul>
									</div>
									<div class="popup_content cookie">
										<ul>
											<c:forEach items="${cookieList }" var="coo">
												<li><label class="form_circle"> <input
														name="cookie" type="radio" value="${coo.name }"> <span
														class="icon"></span> <em>${coo.name }</em>
												</label></li>
											</c:forEach>
										</ul>
									</div>
									<div class="popup_content wedge">
										<ul>
											<c:forEach items="${wedgeList }" var="wedge">
												<li><label class="form_circle"> <input
														name="wedge" type="radio" value="${wedge.name }">
														<span class="icon"></span> <em>${wedge.name }</em>
												</label></li>
											</c:forEach>
										</ul>
									</div>
									<div class="popup_content drink">
										<ul>
											<li><label class="form_circle"> <input
													name="drink" type="radio"
													value="탄산음료 16oz"> <span class="icon"></span> <em>탄산음료
														16oz</em>
											</label></li>
											<li><label class="form_circle"> <input
													name="drink" type="radio" value="탄산음료 22oz"> <span
													class="icon"></span> <em>탄산음료 22oz</em><span> +<em><fmt:formatNumber value="200" pattern="#,###" /></em>&nbsp;원
													</span>
											</label></li>
										</ul>
										<input class="choice_set_btn" type="button" value="선택">
									</div>
								</div>
								<div class="wrap_pop">
									<a class="pop" href="#select_set" rel="modal:open">세트</a>
								</div>
								<p id="selectStep03"></p>
							</div>
							<!-- end of step03 -->
							
							
						</div>
					</div>
				</div>
				<!-- 수량 및 결제 금액  -->
				<div class="menu_total" style="background-color:white">
					<dl class="count">
						<dt>수량</dt>
						<dd>
							<a class="minus" href="javascript:;" id="qtySub">수량 빼기</a>
							<input id="ordQty" onfocus="this.blur();" type="text" value="1" />
							<a class="plus" href="javascript:;" id="qtyAdd">수량 더하기</a>
						</dd>
					</dl>
					<dl class="total_won">
						<dt>최종 결제 금액</dt>
						<dd>
							<input id="eachPrice" type="hidden" value="${menu.price }" />
							<strong id="finalAmt"> <fmt:formatNumber value="${menu.price }" pattern="#,###" /> </strong>
							<span>원</span>
						</dd>
					</dl>
				</div>
			</div>
			<!--// 메뉴 content -->
			<!-- 목록보기 -->
			<div style="width: 85%; background-color:white">
				<div class="order_btn">
					<a class="car" href="javascript:;" onclick="gotoBasket();">장바구니</a>
					<a class="bill" href="javascript:;" onclick="gotoStep04();">주문하기</a>
				</div>
			</div>
			<div class="btns_list_wrapper" style="width: 85%; background-color:white;">
				<div class="btn_list">
					<a href="#" onclick="history.go(-1); return false;">목록보기</a>
				</div>
			</div>
		</div>
		<!--// 메뉴소개 e -->
	</div>

	<!-- 원산지 표시 Modal -->
	<div id="popup_wrap" style="display: none;">
		<h1 class="title">원산지정보</h1>
		<div class="popup_content"
			style="overflow-y: auto; overflow-x: hidden; height: 630px;">
			<div class="country_origin_wrapper">
				<div>
					<div id="mCSB_1" tabindex="0" style="max-height: none;">
						<div id="mCSB_1_container" class="mCSB_container"
							style="position: relative; top: 0px; left: 0px;" dir="ltr">
							<ul>
								<li>
									<div class="icon">
										<img alt="쇠고기"
											src="https://lubway.s3.ap-northeast-2.amazonaws.com/icon_country_origin01.png"
											class="mCS_img_loaded"> <span>쇠고기</span>
									</div>
									<div class="info">
										<dl>
											<dt>로스트 비프, 미트볼</dt>
											<dd>: 호주산</dd>
											<dt>스테이크</dt>
											<dd>: 미국산</dd>
										</dl>
									</div>
								</li>
								<li>
									<div class="icon">
										<img alt="돼지고기"
											src="https://lubway.s3.ap-northeast-2.amazonaws.com/icon_country_origin02.png"
											class="mCS_img_loaded"> <span>돼지고기</span>
									</div>
									<div class="info">
										<dl>
											<dt>베이컨, 살라미, 페퍼로니, 풀드 포크 바비큐</dt>
											<dd>: 미국산</dd>
											<dt>베이컨 비츠</dt>
											<dd>: 미국산</dd>
											<dt>햄</dt>
											<dd>: 국내산 돈육,수입후지(네덜란드)</dd>
										</dl>
									</div>
								</li>
								<li>
									<div class="icon">
										<img alt="닭고기"
											src="https://lubway.s3.ap-northeast-2.amazonaws.com/icon_country_origin03.png"
											class="mCS_img_loaded"> <span>닭고기</span>
									</div>
									<div class="info">
										<dl>
											<dt>치킨 브레스트, 치킨 스트립, 로티세리 바비큐 치킨</dt>
											<dd>: 미국산</dd>
										</dl>
									</div>
								</li>
								<li>
									<div class="icon">
										<img alt="칠면조고기"
											src="https://lubway.s3.ap-northeast-2.amazonaws.com/icon_country_origin04.png"
											class="mCS_img_loaded"> <span>칠면조고기</span>
									</div>
									<div class="info">
										<dl>
											<dt>터키 브레스트</dt>
											<dd>: 터키가슴살(칠레,미국)</dd>
										</dl>
									</div>
								</li>
								<li>
									<div class="icon">
										<img alt="참치"
											src="https://lubway.s3.ap-northeast-2.amazonaws.com/icon_country_origin06.png"
											class="mCS_img_loaded"> <span>참치</span>
									</div>
									<div class="info">
										<dl>
											<dt>참치</dt>
											<dd>: 태국산</dd>
										</dl>
									</div>
								</li>
							</ul>
						</div>
						<div style="display: block;">
							<div class="mCSB_draggerContainer">
								<div id="mCSB_1_dragger_vertical" class="mCSB_dragger"
									style="position: absolute; min-height: 30px; height: 429px; top: 0px; display: block; max-height: 536px;">
									<div class="mCSB_dragger_bar" style="line-height: 30px;">
									</div>
								</div>
								<div class="mCSB_draggerRail"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<a id="closeLength" rel="modal:close"></a>
<%@ include file="/WEB-INF/views/user/footer.jsp"%>
<!-- 주문 확인 결제 페이지 이동 -->
<form action="orderStep04.do" method="post" id="orderForm" style="display: none;">
	<input type="hidden" id="code" name="code" value="${code}">
	<input type="hidden" name="whatWay" value="${whatWay}">
	<input type="hidden" id="franchiseNo" name="franchiseNo" value="${franchiseNo}">
	<input type="hidden" id="totalPrice" name="totalPrice" value="">
	<input type="hidden" id="step01Text" name="step01Text" value="">
	<input type="hidden" id="step02Text" name="step02Text" value="">
	<input type="hidden" id="step03Text" name="step03Text" value="">
	<input type="hidden" id="cheeseList" name="basicCheese" value="">
	<input type="hidden" id="vegetableList" name="vegetable" value="">
	<input type="hidden" id="sauceList" name="sauce" value="">
	<input type="hidden" id="quantity" name="quantity" value="">
	<input type="hidden" id="eachCost" name="eachCost" value="">
	<input type="hidden" id="menuName" name="menuName" value="${menu.name}">
	<input type="hidden" id="toppingAdd" name="toppingAdd" value="">
	<input type="hidden" id="meatAdd" name="meatAdd" value="">
	<input type="hidden" id="cheeseAdd" name="cheeseAdd" value="">
	<input type="hidden" id="setAdd" name="setAdd" value="">
	<input type="hidden" id="menu_type" name="menu_type" value="${select}">
	<input type="hidden" id="fullAddr" name="fullAddr" value="${fullAddr}">
</form> 
</body>
</html>