<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/step01.css" />
<link rel="stylesheet" type="text/css" href="${path}/resources/css/fastway.css" />
<link rel="stylesheet" type="text/css" href="${path}/resources/css/cart.css" />
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<meta charset="UTF-8">
<title>장바구니</title>
<script type="text/javascript">
//수량변경 고정 값들
var min = 1;
var max = "10";
$(document).ready(function(){
	//수량 변경
	$(".plus").click("click",function(){
		var count = $(this).attr('id');
		var qty = $("#qty"+count).val()*1;
		qty += 1;
		if(qty>max){
			alert("최대수량은 10개 입니다.");
			qty -= 1;
			return;
		}
		$("#qty"+count).val(qty);
	});
	$(".minus").click("click",function(){
		var count = $(this).attr('id');
		var qty = $("#qty"+count).val()*1;
		qty -= 1;
		if(qty<min){
			qty += 1;
			return;
		}	
		$("#qty"+count).val(qty);
	});
	
});


</script>
</head>
<body>
<%@ include file="/WEB-INF/views/user/header.jsp"%>

	<!-- container s -->
	<div id="container">
		<!-- sub content s -->
		<div class="cart fast_sub" id="content">
			<!-- index -->
			<h2 class="subTitle_02">장바구니</h2>
			<div class="tab02">
				<ul>
					<li class="swiper-slide "><a href="/lubway/basketfast.do">FAST-SUB</a></li>
					<li class="swiper-slide active"><a href="/lubway/baskethome.do">HOME-SUB</a></li>
				</ul>
			</div>
			<!-- 장바구니 목록 있을때 -->
			<c:if test="${basket != '[]'}">
				<div class="cart_header wh_box" id="cart_header">
					<dl>
						<dt>배달주소/dt>
						<dd>
							<strong></strong>
							<a href="javascript:void(0);" id="changeStore" data-url="/order/view/home/step1" data-stor="66406">
								변경
							</a>
						</dd>
					</dl>
					<div class="txt_last_14day">최근 14일 이내 담은 상품만 확인 가능합니다.</div>
					<div class="all_select">
						<label class="form_checkbox">
							<input data-target="all" type="checkbox" />
							<span class="icon"></span>
							전체선택
						</label>
						<a class="btn bgc_white" href="javascript:void(0);" id="cartItemDelete"><span>선택삭제</span></a>
					</div>
				</div>
				
				
				
				<c:forEach items="${basket}" var="basket" varStatus="stat">
				<ul class="cart_list" id="cart_list">
					<li class="wh_box" data-target="row" data-orderableYn="Y" data-cartIdx="1076572" data-side="N">
						<div class="order_info">
							<div class="menu_info">
								<label class="form_checkbox">
									<input data-target="each" type="checkbox" />
									<span class="icon"></span>
									<th:object>${basket.name}</th:object>
								</label>
								<p>
										<c:if test="${basket.menu_type eq '샌드위치'}">
										<!-- 빵길이 -->
										<th:object>555</th:object>
										</c:if>
										<!-- 빵종류 -->
										<th:object>${basket.bread}</th:object>
										<!-- 치즈 -->
										<th:object>${basket.cheese}</th:object>
										<!-- 야채 -->
										<th:object>${basket.vegetable}</th:object>
										<!-- 소스 -->
										<th:object>${basket.sauce}</th:object>
								</p>
								<strong>
									<em>${basket.single_price}</em>
									<span>원</span>
								</strong>
							</div>
							<img src="${basket.menu_filepath}">
							<!-- 
							<img onError="this.src=''" alt="D로스트 치킨 아보카도 (15cm)" src="" />
							 -->
						</div>
							<dl class="detail_list">
									<dt>
										<em>추가</em>
										<span>오믈렛</span>
									</dt>
									<dd>
										<strong>1,200</strong>
										<span>원</span>
									</dd>
									<c:if test="${basket.set == true}">
									<dt>
										<em>추가</em>
										<span class="sideText">
													더블 초코칩 쿠키/스프라이트 / 
										</span>
									</dt>
									<dd>
										<strong>${basket.set_price}</strong>
										<span>원</span>
									</dd>
									</c:if>
							</dl>
							<div class="total">
								<dl class="count">
									<dt>수량</dt>
									<dd>
										<input name="eachPrice" type="hidden" value="10600" />
										<a class="minus" id="${stat.count }" href="javascript:void(0);">수량 빼기</a>
										<input class="qty" id="qty${stat.count }" name="qty" type="text" value="1" readonly/>
										<a class="plus" id="${stat.count }" href="javascript:void(0);">수량 더하기</a>
									</dd>
								</dl>
								
								<dl class="total_sum">
									<dt>총 주문금액</dt>
									<dd>
										<strong class="eachTotalPrice">${basket.total_price}</strong>
										<span>원</span>
									</dd>
								</dl>
							</div>
						
					</li>
				</ul>
				</c:forEach>
				<div class="final_payment wh_box" id="final_payment">
					<dl>
						<dt>최종 결제 금액</dt>
						<dd>
							<strong id="totalPrice">111</strong>
							<span>원</span>
						</dd>
					</dl>
					<div class="btn_area">
						<form method="post" name="orderForm">
							<input name="ordType" type="hidden" value="ORD_TYPE.HOME_SUB" />
							<input name="storCd" type="hidden" value="66406" />
							
								<input name="receiverZipcd" type="hidden" value="04036" />
								<input name="receiverAddr" type="hidden" value="서울 마포구 양화로 45" />
								<input name="receiverAddrDtl" type="hidden" value="1호" />
							
						</form>
						<a class="btn bgc_white" href="javascript:void(0);" id="addMenu"><span>메뉴추가하기</span></a>
						<a class="btn bgc_point i_reg" href="javascript:void(0);" id="setOrder" data-cart-type="CART_TYPE.HOME_SUB"><span>주문하기</span></a>
					</div>
				</div>
				</c:if>

			<!-- 장바구니 목록 없을때 -->
			<c:if test="${basket == '[]'}">
			<div class="data_none wh_box" id="data_none">
				<p>장바구니가 비어있습니다.</p>
			</div>
			</c:if>
			<!--// index -->
		</div>
		<!--// sub content e -->
	</div>

<%@ include file="/WEB-INF/views/user/footer.jsp"%>
</body>
</html>