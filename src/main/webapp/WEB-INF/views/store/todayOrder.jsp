<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:url var="getNoticeList" value="/lubway/search.mdo">
	<c:param name="page" value="${pagination.page}" />
	<c:param name="range" value="${pagination.range}" />
	<c:param name="rangeSize" value="${pagination.rangeSize}" />
</c:url>

<!DOCTYPE html>
<html>
<head>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script>
   //이전 버튼 이벤트

   function fn_prev(page, range, rangeSize) {

      var page = ((range - 2) * rangeSize) + 1;

      var range = range - 1;

      var url = "${pageContext.request.contextPath}/search.mdo";

      url = url + "?page=" + page;

      url = url + "&range=" + range;


      location.href = url;

   }

   //페이지 번호 클릭
   function fn_pagination(page, range, rangeSize) {
      
      var url = "${pageContext.request.contextPath}/search.mdo";

      url = url + "?page=" + page;

      url = url + "&range=" + range;


      location.href = url;
      
      
   }
   
   
   //다음 버튼 이벤트

   function fn_next(page, range, rangeSize) {

      var page = parseInt((range * rangeSize)) + 1;

      var range = parseInt(range) + 1;

      var url = "${pageContext.request.contextPath}/search.mdo";

      url = url + "?page=" + page;

      url = url + "&range=" + range;

      location.href = url;
   }
   



</script>
</head>
<body id="page-top">

	<%@ include file="/WEB-INF/views/store/header.jsp"%>

	<!-- 관리자 버전 화면 만들기  -->
	<!-- Begin Page Content -->
	<div class="container-fluid">
		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800">주문 조회</h1>
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-warning">오늘의 주문</h6>
			</div>
			<form action="/lubway/updateOrder.sdo" method="post">
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
							<thead>
								<tr align="center" style="font-size: 14px">
									<th width="5%">주문 코드</th>
									<th width="3%">아이디</th>
									<th width="5%">이름</th>
									<th width="8%">주문 시간</th>
									<th width="8%">도착 예정 시간</th>
									<th width="10%">주소</th>
									<th width="5%">연락처</th>
									<th width="9%">주문 메뉴</th>
									<th width="10%">주문 상세</th>
									<th width="5%">총 금액</th>
									<th width="5%">수령 방법</th>
									<th width="5%">결제 수단</th>
									<th width="5%">결제 상태</th>
									<th width="7%">주문 상태</th>
									<th width="10%">요청 사항</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${orderList}" var="list">
									<tr style="font-size: 14px">
										<td>${list.code }</td>
										<td>${list.id }</td>
										<td>${list.name }</td>
										<td><fmt:formatDate type="both" value="${list.ordertime }"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td><fmt:formatDate type="both" value="${list.deliverytime }"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td>${list.address }</td>
										<td>${list.tel }</td>
										<td>${list.menuname }</td>
										<td>${list.menu }</td>
										<td>${list.totalprice  }</td>
										<td>${list.receive }</td>
										<td>${list.payment_list }</td>
										<td><c:if test="${list.payment_status eq 'true'}">
												결제 완료
											</c:if>
											<c:if test="${list.payment_status eq 'false'}">
												결제 대기
											</c:if>
										</td>
										<td><select name="status">
											<option value="주문 접수">주문 접수</option>
											<option value="주문 완료">주문 완료</option>
											<option value="배달 중">배달 중</option>
											<option value="배달 완료">배달 완료</option>
											<option value="주문 취소">주문 취소</option>
										</select></td>
										<td>${list.request }</td>
									</tr>
								</c:forEach>
							</tbody>

						</table>
					</div>
				</div>
			</form>
			
			<!-- 페이지 네비게이션 (페이지 알고리즘 관련) 출력 -->
			<!-- pagination{s} -->

			<div align="center">
				<ul class="pagination" class="NoticeVO">
					<c:if test="${pagination.prev}">
						<li class="page-item"><a class="page-link" href="#"
							onClick="fn_prev('${pagination.page}','${pagination.range}','${pagination.rangeSize}','${pagination.searchKeyword }')">Prev</a></li>
					</c:if>
					<c:forEach begin="${pagination.startPage}"
						end="${pagination.endPage}" var="idx">
						<li
							class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a
							class="page-link" href="#"
							onClick="fn_pagination('${idx}','${pagination.range}','${pagination.rangeSize}','${pagination.searchKeyword }','${pagination.fix }')">
								${idx} </a></li>
					</c:forEach>


					<c:if test="${pagination.next}">
						<li class="page-item"><a class="page-link" href="#"
							onClick="fn_next('${pagination.page}','${pagination.range}', '${pagination.rangeSize}','${pagination.searchKeyword }')">Next</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
<!-- /.container-fluid -->
<!-- End of Main Content -->
<%@ include file="/WEB-INF/views/store/footer.jsp"%>
</body>
</html>