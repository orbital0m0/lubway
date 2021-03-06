<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="google-signin-client_id" content="848158094091-dmohdudpt9hfq0m0uubdln37dfg2mqbk.apps.googleusercontent.com">
<link rel="stylesheet" type="text/css" href="${path}/resources/css/login.css" />
<link rel="stylesheet" type="text/css" href="${path}/resources/css/google.css" />
<link rel="shortcut icon" type="image/x-icon" href="${path}/resources/images/subway_favicon.ico">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type = "text/javascript" src = "https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src = "//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	$(window).load(function(){
	    $(".loading").fadeOut();
	});

	$(document).ready(function() {
		$("#loginBtn").on("click", function(){
			if($("#username").val().trim() == "" || $("#password").val().trim() == "") {
				alert("아이디와 비밀번호를 확인해주세요.");
				return;
			} else {
				$("#login").submit();
			}
		});
		$("#username").keydown(function(key) {
            if (key.keyCode == 13) {
                $("#login").submit();
            }
        });
		$("#password").keydown(function(key) {
            if (key.keyCode == 13) {
                $("#login").submit();
            }
        });
	});
</script>
<script type="text/javascript">
	var name = null;
	var email = null;

	function onSignIn(googleUser) {
		  var profile = googleUser.getBasicProfile();
		  name = profile.getName();
		  email = profile.getEmail();
	}
	
	function googleLogin() {
		if(name == null || email == null) {
			return;
		}
		var form = document.createElement("form");

		form.setAttribute("method", "post");
		form.setAttribute("action", "google.do");

		var input_name = document.createElement("input");
		input_name.setAttribute("type", "hidden");
		input_name.setAttribute("name", "name");
		input_name.setAttribute("value", name);

		var input_email = document.createElement("input");
		input_email.setAttribute("type", "hidden");
		input_email.setAttribute("name", "id");
		input_email.setAttribute("value", email);

		form.appendChild(input_name);
		form.appendChild(input_email);
		document.body.appendChild(form);
		form.submit();
	}
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
<title>로그인</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/user/header.jsp"%>
	<div class="loading"></div>
	<!-- login -->
	<!-- container s -->
	<div class="bg_type01" id="container">
		<!-- sub content s -->
		<div id="content">
			<!-- 로그인 -->
			<div class="signin_wrapper">
				<div class="signin_tit">
					<h2>LOGIN</h2>
					<p>
						러브웨이 회원으로 로그인하시면 제공하는<br>다양한 서비스를 이용할 수 있습니다.
					</p>
				</div>
				<form action="main.do" method="post" id="login">
					<div class="signin_input">
						<div class="form_box">
							<div class="write_info_wrap">
								<div class="input_set">
									<dl>
										<dt>이메일 아이디</dt>
										<dd>
											<span class="form_text">
												<c:if test="${findId == null || findId == '1'}"> 
													<input class="required-value" id="username" name="id" placeholder="이메일 아이디 입력" type="text">
												</c:if>
												
												<c:if test="${findId != null && findId != '1'}"> 
													<input class="required-value" id="username" name="id" placeholder="이메일 아이디 입력" type="text" value="${findId}">
												</c:if>
											</span>
										</dd>
										<dt>비밀번호</dt>
										<dd>
											<span class="form_text"> <input class="required-value"
												id="password" name="password" placeholder="비밀번호 입력"
												type="password">
											</span>
										</dd>
									</dl>
								</div>
							</div>
						</div>
					</div>
					<div class="signin_btn">
						<a class="btn bgc_point on" href="javascript:void(0);"
							id="loginBtn" style="width: 370px;"><span>로그인</span></a>
					</div>
					<div style="width:150px; height:40px;"></div>
					<div style="width:150px; height:40px;"></div>
					<div class="btn_naver" style="width:140px; height:32px; float:left; display:block; box-shadow: 2px 2px 2px grey;">
						<a id="naver_id_login" href="${url}"><img class="img01" width="140px" height="32px" src="${path}/resources/images/naver_Bngreen.png"></a>
					</div>
					
					<div class="btn_google" style="width:140px; height:32px; float:left; display:block; padding-left:11px; padding-right:10px;">
					<a class="g-signin2" data-onsuccess="onSignIn" style="width:140px; height:32px;"  onclick="googleLogin()"></a>
					</div>
					<div class="btn_kakao"style="width:140px; height:33px; float:left; display:block; ">
						<a id="kakao-login-btn"></a>
					</div>
					<div style="width:150px; height:40px;"></div>
					<div style="width:150px; height:40px;"></div>
					<script type="text/javascript">
						Kakao.init('6a3508a8b89b4d0077e04113035fff90');
						Kakao.Auth.createLoginButton({ 
							container: '#kakao-login-btn',
							success: function(authObj) {
								Kakao.API.request({
									url: '/v2/user/me',
									success: function(res) {
										console.log(res);
										$.ajax({
											type: "POST",
											url: "/kakao.do",
											data: {
												id : res.id,
												email : res.kakao_account.email,
												name : res.properties.nickname,
												token : authObj.access_token
											},
											success: function(data) {												
												if(data == "lock") {
													alert("관리자에 의해 정지된 계정입니다.");
													return;
												} else if(data == "success") {
													location.href = "/main.do"													
												}
											},
											error: function() {
												console.log("실패");
											}
										});
									}
								})
							},
							fail: function(error) {
								alert(JSON.stringify(error));
							}
						});
					</script>
				</form>
				<div class="signin_link">
					<ul>
						<li><a href="findId.do" id="findIdBtn">아이디 찾기</a></li>
						<li><a href="findPwd.do" id="findPwBtn">비밀번호 찾기</a></li>
						<li><a href="step01.do">회원가입</a></li>
					</ul>
				</div>
			</div>
			<!--// 로그인 -->
		</div>
		<!--// sub content e -->
	</div>
	<%@ include file="/WEB-INF/views/user/footer.jsp"%>
</body>
</html>