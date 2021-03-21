<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 등록</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		var check = "";
			$(".allprice").hide();
		$("#select").on("change", function() {
			var selected = $("#select").val();
			if(selected == "sandwich") {
				$(".form").show();
				$(".allprice").hide();
				$(".category").show();
				$(".price15").show();
				$(".price30").show();
			}  else if(selected == "drink"){ 
				$(".form").hide();
				$(".allprice").show();
				$(".category").hide();
				$(".price15").hide();
				$(".price30").hide();
			} else if(selected == "wrap"){
				$(".category").show();
				$(".allprice").show();
				$(".form").show();
				$(".price15").hide();
				$(".price30").hide();
			} else if(selected == "morning"){
				$(".category").show();
				$(".allprice").show();
				$(".form").show();
				$(".price15").hide();
				$(".price30").hide();
			} else if(selected == "salad"){
				$(".category").show();
				$(".allprice").show();
				$(".form").show();
				$(".price15").hide();
				$(".price30").hide();
			} else if(selected == "cookie"){
				$(".category").hide();
				$(".allprice").show();
				$(".form").show();
				$(".price15").hide();
				$(".price30").hide();
			}else if(selected == "was"){
				$(".category").hide();
				$(".allprice").show();
				$(".form").show();
				$(".price15").hide();
				$(".price30").hide();
			} else {
				$(".category").hide();
				$(".form").show();
				$(".allprice").hide();
				$(".price15").show();
				$(".price30").show();
			}
			check = selected;
		});
		
	$("#saveBtn").on("click", function() {
		var select = check;
		if(select == "sandwich") {
			$("#price").remove();
			if ($("#price15").val().trim() == '') {
				return;
			} else if ($("#price30").val().trim() == '') {
				return;
			} else if ($("#name").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#engname").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#code").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#ttl").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#cal").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#fat").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#sod").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#img").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				$("#img").focus();
				return;
			}
			$("#price").append();
		} else if(select == "drink"){
			$("#category").remove();
			$("#price15").remove();
			$("#price30").remove();
			$("#cal").remove();
			$("#pro").remove();
			$("#sug").remove();
			$("#sod").remove();
			$("#ttl").remove();
			$("#fat").remove();
			if ($("#name").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#engname").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#code").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#price").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			}else if ($("#img").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				$("#img").focus();
				return;
			}
			
			$("#category").append();
			$("#price15").append();
			$("#price30").append();
			$("#cal").append();
			$("#pro").append();
			$("#sug").append();
			$("#sod").append();
			$("#ttl").append();
			$("#fat").append();
		} else if(select == "wrap"){
			$("#price15").remove();
			$("#price30").remove();
			
			if ($("#name").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#engname").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#code").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#price").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#category").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#ttl").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#cal").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#fat").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#sod").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#img").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				$("#img").focus();
				return;
			}
			$("#price15").append();
			$("#price30").append();
		} else if (select == "morning"){
			$("#price15").remove();
			$("#price30").remove();
			if ($("#name").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#engname").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#code").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#price").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#category").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#ttl").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#cal").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#fat").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#sod").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#img").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				$("#img").focus();
				return;
			}
			$("#price15").append();
			$("#price30").append();
		} else if (select == "salad"){
			$("#price15").remove();
			$("#price30").remove();
			if ($("#name").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#engname").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#code").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#price").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#category").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#ttl").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#cal").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#fat").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#sod").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#img").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				$("#img").focus();
				return;
			}
			$("#price15").append();
			$("#price30").append();
		} else if(select == "was"){
			$("#price15").remove();
			$("#price30").remove();
			$("#category").remove();
			if ($("#name").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#engname").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#code").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#price").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#ttl").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#cal").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#fat").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#sod").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#img").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				$("#img").focus();
			}
			$("#price15").append();
			$("#price30").append();
			$("#category").append();	
		} else if(select == "cookie"){
			$("#price15").remove();
			$("#price30").remove();
			$("#category").remove();
			if ($("#name").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#engname").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#code").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#price").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#ttl").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#cal").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#fat").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#sod").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				return;
			} else if ($("#img").val().trim() == '') {
				alert("모든 정보를 기입해주세요.");
				$("#img").focus();
			}
			$("#price15").append();
			$("#price30").append();
			$("#category").append();
		}
		//setTime();
	});
});
</script>
<style type="text/css">
.addr {
	border: 1px solid #D3D4E3;
	border-radius: 5px;
	height: 35px;
}
</style>
</head>
<body id="page-top">
	<%@ include file="/WEB-INF/views/admin/header.jsp"%>
	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800">메뉴 정보 입력</h1>
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">메뉴 등록</h6>
			</div>
			<form name="form" id="form" role="form" method="post"
				action="menuInsert.mdo" enctype="multipart/form-data">
				<div class="card-body">


					<div class="mb-3">
						<label for="open">제품 카테고리</label>
						<div class="col-sm-3">
							<div class="small mb-1"></div>
							<div class="dropdown mb-4">
								<span class="form_select" style="width: 300px"> <select
									class="btn btn-primary dropdown-toggle" id="select"
									name="select" style="width: 150px">
										<option value="sandwich">샌드위치</option>
										<option value="wrap">랩&파니니</option>
										<option value="salad">찹샐러드</option>
										<option value="morning">아침메뉴</option>
										<option value="cookie">쿠키</option>
										<option value="was">웻지&스프</option>
										<option value="drink">음료</option>
								</select>
								</span>
							</div>
						</div>
					</div>

					
						<div class="price15">
						<div class="mb-3" id="hyunah">
							<label for="price15">15cm 가격</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="price15"
									id="price15" required>
							</div>
						</div>
						</div>
						<div class="price30">
						<div class="mb-3" id="hyunah">
							<label for="price30">30cm 가격</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="price30"
									id="price30" required>
							</div>
						</div>
					</div>

					
						<div class="mb-3">
							<label for="name">제품명</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="name" id="name"
									required>
							</div>
						</div>
						<div class="mb-3">
							<label for="engname">제품명(english)</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="engname" id="engname"
									required>
							</div>
						</div>
						<div class="mb-3" id="hyunah">
							<label for="code">제품 코드</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="code"
									id="code" required>
							</div>
						</div>
						<div class="allprice">
						<div class="mb-3" id="hyunah">
							<label for="allprice">가격</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="allprice"
									id="allprice" required>
							</div>
						</div>
					</div>
					<div class="category">
					<div class="mb-3" id="hyunah">
							<label for="category">카테고리</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="category"
									id="category" required>
							</div>
						</div>
						</div>
						<div class="content">
					<div class="mb-3" id="hyunah">
							<label for="content">내용</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="content"
									id="content" required>
							</div>
						</div>
						</div>

					<div class="form">
						<div class="mb-3">
							<label for="ttl">총 중량(g)</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="ttl"
									id="ttl" required>
							</div>
						</div>
						<div class="mb-3">
							<label for="cal">열량(kcal)</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="cal" id="cal"
									required>
							</div>
						</div>
						<div class="mb-3">
							<label for="sug">당류(g)</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="sug" id="sug"
									required>
							</div>
						</div>
						<div class="mb-3">
							<label for="pro">단백질(g)</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="pro"
									id="pro" required>
							</div>
						</div>
						<div class="mb-3">
							<label for="fat">포화지방(g)</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="fat"
									id="fat" required>
							</div>
						</div>
						<div class="mb-3">
							<label for="sod">나트륨(g)</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="sod"
									id="sod" required>
							</div>
						</div>
					</div>

					<div class="mb-3">
						
                     <div>
                        <div class="index">이미지</div>
                        <input type="file" name="uploadImg" id="uploadImg" multiple/>
                     </div>
              
					</div>

					<div>
						<button type="submit" class="btn btn-sm btn-primary" id="saveBtn" >저장</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/admin/footer.jsp"%>
</body>
</html>

