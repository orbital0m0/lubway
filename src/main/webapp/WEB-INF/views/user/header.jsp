<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<meta charset='utf-8'>
<title>LUBWAY 러브웨이</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${path}/resources/css/footer.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/TweenMax.js"></script>
<script type="text/javascript" src="${path}/resources/js/header.js"></script>
</head>

<body>
	<div id="header" style="overflow: hidden; height: 165px;">
		<div class="headercontent">
			<h1 class="logo">
				<a href="/main.do">LUBWAY</a>
			</h1>
			<!-- gnb -->
			<nav id="gnb">
				<ul>
					<li>
						<a class="dp1" href="#none">메뉴소개</a>
						<div class="dp2" style="opacity: 0; top: -20px;">
							<ul>
								<li><a href="/menuSandwich.do">샌드위치</a></li>
								<li><a href="/menuWrap.do">랩ㆍ기타</a></li>
								<li><a href="/menuSalad.do">찹샐러드</a></li>
								<li><a href="/menuMorning.do">아침메뉴</a></li>
								<li><a href="/menuSmileWay.do">스마일 웨이</a></li>
							</ul>
						</div>
					</li>
					<li>
						<a class="dp1" href="#none">이용방법</a>
						<div class="dp2" style="opacity: 0; top: -20px;">
							<ul>
								<li><a href="/howtouse.do">러브웨이 이용방법</a></li>
							</ul>
						</div>
					</li>
					<li>
						<a class="dp1" href="#none">새소식</a>
						<div class="dp2" style="opacity: 0; top: -20px;">
							<ul>
								<li><a href="/getUserEventList.do">이벤트ㆍ프로모션</a></li>
								<li><a href="/getUserNoticeList.do">뉴스ㆍ공지사항</a></li>
								<li><a href="/video.do">광고영상</a></li>
							</ul>
						</div>
					</li>
					<li>
						<a class="dp1" href="#none">러브웨이</a>
						<div class="dp2" style="opacity: 0; top: -20px;">
							<ul>
								<li><a href="/history.do">러브웨이 역사</a></li>
								<li><a href="/promise.do">러브웨이 약속</a></li>
								<li><a href="/findStore.do">매장찾기</a></li>
							</ul>
						</div>
					</li>
					<li>
						<a class="dp1" href="#none">가맹점</a>
						<div class="dp2" style="opacity: 0; top: -20px;">
							<ul>
								<li><a href="/franchise.do">써브웨이 프랜차이즈</a></li>
								<li><a href="/franchisefaq.do">가맹관련 FAQ</a></li>
								<li><a href="/franchiseInquiry.do">가맹신청ㆍ문의</a></li>
							</ul>
						</div>
					</li>
					<li>
						<a class="dp1" href="javascript:void(0);">온라인 주문</a>
						<div class="dp2" style="opacity: 0; top: -20px;">
							<ul>
								<li>
									<c:if test="${user == null}">
										<a href="/login.do">FAST-WAY</a>
									</c:if>
									<c:if test="${user != null}">
										<a href="/fastway/step01.do">FAST-WAY</a>
									</c:if>
								</li>
								<li>
									<c:if test="${user == null}">
										<a href="/login.do">HOME-WAY</a>
									</c:if>
									<c:if test="${user != null}">
										<a href="/homeway/step01.do">HOME-WAY</a>
									</c:if>	
								</li>
							</ul>
						</div>
					</li>
				</ul>
			</nav>
			<!-- gnb 끝 -->
			
			<!-- 회원 로그인시 -->
			<c:if test="${user != null && nuser == null && guser == null}">
				<div class="util_menu">
					<ul>
						<li class="icon_menu global_subway">
							<span class="blind">
								<img src="${path}/resources/images/logo.png" style="width: 30px; height: 30px;" />
							</span>
						</li>
						<li class="before_sign" style="margin-left: 15px"><a href="/logout.do">로그아웃</a></li>
						<li class="before_sign"><a href="/myway.do">MY-WAY</a></li>
						<li class="icon_menu cart on"><a href="/basketfast.do"></a></li>
						<li class="icon_menu global_subway">
							<a href="http://www.subway.com/en-us/exploreourworld" target="_blank" title="Global Subway">
								<span class="blind">
									<img alt="Global Subway" src="${path}/resources/images/icon_utill_global.png" />
								</span>
							</a>
						</li>
					</ul>
				</div>
			</c:if>

			<!-- 네이버 회원 로그인시 -->
			<c:if test="${nuser != null}">
				<div class="util_menu">
					<ul>
						<li class="icon_menu global_subway">
							<span class="blind">
								<img src="${path}/resources/images/naver.png" style="width: 25px; height: 25px; padding-top: 4px;" />
							</span>
						</li>
						<li class="before_sign" style="margin-left: 15px"><a href="/logout.do">로그아웃</a></li>
						<li class="before_sign"><a href="/myway.do">MY-WAY</a></li>		
						<li class="icon_menu cart on"><a href="/basketfast.do"></a></li>
						<li class="icon_menu global_subway">
							<a href="http://www.subway.com/en-us/exploreourworld" target="_blank" title="Global Subway">
								<span class="blind">
									<img alt="Global Subway" src="${path}/resources/images/icon_utill_global.png" />
								</span>
							</a>
						</li>
					</ul>
				</div>
			</c:if>

			<!-- 구글 회원 로그인시 -->
			<c:if test="${guser != null}">
				<div class="util_menu">
					<ul>
						<li class="icon_menu global_subway">
							<span class="blind">
								<img src="${path}/resources/images/google.png" style="width: 25px; height: 25px; padding-top: 4px;" />
							</span>
						</li>
						<li class="before_sign" style="margin-left: 15px"><a href="/logout.do">로그아웃</a></li>
						<li class="before_sign"><a href="/myway.do">MY-WAY</a></li>
						<li class="icon_menu cart on"><a href="/basketfast.do"></a></li>		
						<li class="icon_menu global_subway">
							<a href="http://www.subway.com/en-us/exploreourworld" target="_blank" title="Global Subway">
								<span class="blind">
									<img alt="Global Subway" src="${path}/resources/images/icon_utill_global.png" />
								</span>
							</a>
						</li>
					</ul>
				</div>
			</c:if>
			<!-- 
			<a href="https://kauth.kakao.com/oauth/logout?client_id=792b6ab2dfca5a403d08ae5ab92a5d8e&logout_redirect_uri=http://localhost:8080s/kakaoLogout.do">카카오 로그아웃</a>
			 -->
			<!-- 카카오 회원 로그인시 -->
			<c:if test="${kuser != null}">
				<div class="util_menu">
					<ul>
						<li class="icon_menu global_subway">
							<span class="blind">
								<img src="${path}/resources/images/kakao.png" style="width: 25px; height: 25px; padding-top: 4px;" />
							</span>
						</li>
						<li class="before_sign" style="margin-left: 15px">
							<a href="https://kauth.kakao.com/oauth/logout?client_id=792b6ab2dfca5a403d08ae5ab92a5d8e&logout_redirect_uri=http://ec2-52-79-190-214.ap-northeast-2.compute.amazonaws.com/kakaoLogout.do">로그아웃</a>
						</li>
						<li class="before_sign"><a href="/myway.do">MY-WAY</a></li>	
						<li class="icon_menu cart on"><a href="/basketfast.do"></a></li>	
						<li class="icon_menu global_subway">
							<a href="http://www.subway.com/en-us/exploreourworld" target="_blank" title="Global Subway">
								<span class="blind">
									<img alt="Global Subway" src="${path}/resources/images/icon_utill_global.png" />
								</span>
							</a>
						</li>
					</ul>
				</div>
			</c:if>
						
			<!-- 비로그인시 -->
			<c:if test="${user == null && nuser == null && guser == null && kuser == null}">
				<div class="util_menu">
					<ul>
						<li class="before_sign"><a href="/login.do">로그인</a></li>
						<li class="before_sign"><a href="/step01.do">회원가입</a></li>
						<li class="icon_menu global_subway"><a
							href="http://www.subway.com/en-us/exploreourworld" target="_blank"
							title="Global Subway"><span class="blind"><img
									alt="Global Subway" src="${path}/resources/images/icon_utill_global.png" /></span></a></li>
						</ul>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>