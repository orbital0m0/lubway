<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 페이지 등록</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script>
	$(document).ready(function(){
	
	function setDate() {
		var start = $("#start").val();
		var end = $("#end").val();

		var openField = document.createElement("input");
		openField.setAttribute("type", "hidden");
		openField.setAttribute("name", "start");
		openField.setAttribute("value", start);

		var closeField = document.createElement("input");
		closeField.setAttribute("type", "hidden");
		closeField.setAttribute("name", "end");
		closeField.setAttribute("value", end);

		document.form.appendChild(openField);
		document.form.appendChild(closeField);
		document.form.submit();
	}
	
	});
</script>
<style type="text/css">
*{
	list-style: none;
}

li{
	padding: 5px;
}
</style>
</head>
<body id="page-top">

	<%@ include file="/WEB-INF/views/admin/header.jsp"%>
	<!-- 이 jsp을 복사해서  container-fluid 안에 해당 화면의 내용으로 바꿔서 작성하시면 됩니다. -->
	<form action="/lubway/insertedCoupon.mdo" method="post">
		<div class="container-fluid">

			<!-- Page Heading -->
			<h1 class="h3 mb-2 text-gray-800">쿠폰 관리</h1>
			<br>
			<!-- DataTales Example -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-warning">Coupon List</h6>
				</div>
				<div class="card-body">
					<!-- 전체 frame -->
					<ul>
						<!-- 쿠폰 코드 -->
						<li class="code">
							<div>
								<div class="index">쿠폰 코드</div>
								<input type="text" name="code" required/>
							</div>
						</li>
						<!-- 쿠폰 이름 -->
						<li class="name">
							<div>
								<div class="index">쿠폰 이름</div>
								<input class="title_text" type="text" name="name" required />
							</div>
						</li>
						<!-- 쿠폰 할인율 -->
						<li class="dc">
							<div>
								<div class="index">쿠폰 할인율</div>
								<input type="text" name="dc" required/>&nbsp;%
							</div>
						</li>
						<!-- 쿠폰 사용 방식 -->
						<li class="type">
							<div>
								<div class="index">쿠폰 사용처 [HOME/FAST]</div>
								<input type="radio"" name="type" id="home" value="home" required/> HOME&nbsp;&nbsp;
								<input type="radio"" name="type" id="fast" value="fast" required/> FAST&nbsp;&nbsp;
								<input type="radio"" name="type" id="all" value="all" required/> ALL
							</div>
						</li>
						<!-- 기간 -->
						<li class="term">
							<div class="index">쿠폰 사용 기간</div>
							시작 : <input type="date"" name="start" id="start" required> ~ 종료 : <input type="date" id="end" name="end" required>
						</li>
					</ul>
					<div align="center">
						<input style="padding: 5px" class="btn btn-warning btn-icon-split"
							type="submit" id="insterBtn" value="등록하기" />
					</div>
					<div align="right">
						<a href="getCouponList.mdo" class="btn btn-light btn-icon-split">
							<span class="text">목록가기</span>
						</a>
					</div>
				</div>
			</div>

		</div>
	</form>
	
	<!-- End of Main Content -->

	<%@ include file="/WEB-INF/views/admin/footer.jsp"%>

	<!-- Bootstrap core JavaScript-->
	<script src="${path}/resources/vendor/jquery/jquery.min.js"></script>
	<script
		src="${path}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script
		src="${path}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${path}/resources/js/sb-admin-2.js"></script>

	<!-- Page level plugins -->
	<script src="${path}/resources/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="${path}/resources/js/demo/chart-area-demo.js"></script>
	<script src="${path}/resources/js/demo/chart-pie-demo.js"></script>

</body>
</html>