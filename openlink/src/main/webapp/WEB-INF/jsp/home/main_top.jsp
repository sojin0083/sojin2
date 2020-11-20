<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<!-- 문서타입 -->
<html lang="ko"><!-- 휴먼랭귀지 -->
<head>
<!-- 문자셋 -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="<c:url value='/css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/css/bootstrap/js/bootstrap.min.js'/>"></script> 
	<!-- MultipartHttpServletRequest -->
	<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
<!-- CK에디터 -->
<script type="text/javascript" src="resources/ckeditor/ckeditor.js"></script>
<!-- 스타일 시트 -->
<link href="<c:url value="/css/openlink/style.css"/>" rel="stylesheet">
<!-- 버튼css -->
<link type="text/css" href="<c:url value="/css/bttn.css-master/dist/bttn.min.css"/>" rel="stylesheet">

<title>Openlink System / 주간업무보고</title>
<link rel="shortcut icon" type="image⁄x-icon" href="images/openlink/icon_logo.png">
</head>
<body>
    <nav class="navbar navbar-default" id='fixedHeader'>
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<label><a class="navbar-brand" href="main.do"><img align="center" src="images/openlink/logo.png" width="?" height="25px"></a></label>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="main.do">메인</a></li>
					<!-- 주간업무보고 -->
					<li>
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							주간업무
							<!-- 아래 화살표 -->
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li class="dropdown-header">주간업무보고</li>
							<li><a href="search.do">조회</a></li>
							<li><a href="write.do">작성</a></li> 
							<li><a href="update.do">수정</a></li>
						</ul>
					</li>
					<!-- 자산관리 -->
					<li><a href="http://sub.openlink.kr/glpi/index.php">자산관리</a>
					</li>
					<!-- 사업관리 -->
						<li>
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">사업관리<span class="caret"></span></a>
							<ul class="dropdown-menu">
							<li class="dropdown-header">사업관리</li>
							<li><a href="#">계약현황</a></li>
							<li><a href="#">계약회사관리</a></li> 
						</ul>
						</li>
					<!-- 회원관리 -->
						<li>
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">회원관리<span class="caret"></span></a>
							<ul class="dropdown-menu">
							<li class="dropdown-header">회원관리</li>
							<li><a href="#">회원관리</a></li>
						</ul>
						</li>
					<!-- 문서관리 -->
					<li>
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							문서관리
							<!-- 아래 화살표 -->
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li class="dropdown-header">인력프로필</li>
							<li><a href="profileList.do?CT_ID=all">다운로드</a></li>
							<li class="divider"></li>
							<li class="dropdown-header">증빙자료</li>
							<li><a href="evidenceList.do?CT_ID=all">다운로드</a></li>
							<li class="divider"></li>
							<li class="dropdown-header">서식</li>
							<li><a href="formList.do?CT_ID=all">다운로드</a></li>
						</ul>
					</li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<!-- 로그인 전 -->
							<!-- 세션에 설정해 주었던 Attribute값 JSTL로 쓰기 sessionScope -->
							<c:if test="${sessionScope.user_id == null || sessionScope.user_id == ''}">
								<li class="active"><a href="loginPage.do">로그인</a></li>
								<li><a href="http://portal.openlink.kr:8080/openlink/user_join.user" onclick="window.open('http://portal.openlink.kr:8080/openlink/user_join.user', '회원가입','width=800, height=700'); return false">회원가입</a></li>
							</c:if>
							<!-- 로그인 후 -->
							<c:if test="${sessionScope.user_id != null && sessionScope.user_id != ''}">
								<li class="active"><a href="logout.do">로그아웃</a></li>
							</c:if>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>