<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="main_top.jsp"%>
<!-- <body>시작 -->
<script type="text/javascript">
$( document ).ready(function() {
	<c:if test="${!empty msg}">
		alert("${msg}");
	</c:if>
});
function out(){
	location.href = "<c:url value='/logout.do'/>";
}

function check(){
	if( $('#term_year').val() == '' ){
		alert("년도를 선택하세요");
		return false;
	}
	if( $('#term_week').val() == '' ){
		alert("주차를 선택하세요");
		return false;
	}
	return true;
}

function thisWeek(this_year, this_week){
	location.href = "<c:url value='/search_weekly.do?term_year=" + this_year + "&term_week=" + this_week + "'/>";
}
</script>
	<div class="container">
		<h1>메인화면</h1>
		<div class="panel panel-default">
			<div class="panel-heading">
			<!-- 로그인 전 -->
			<c:if test="${sessionScope.user_id == null || sessionScope.user_id == ''}">
				<button type="button" class="btn btn-primary form-control" onclick="location.href='loginPage.do'">로그인</button>
			</c:if>
			<c:if test="${sessionScope.user_id == null || sessionScope.user_id == ''}">
				<h3 style="text-align : center;">로그인이 필요합니다.</h3>
			</c:if>
			
			<!-- 로그인 후 -->
			<c:if test="${sessionScope.user_id != null && sessionScope.user_id != ''}">
				${sessionScope.user_name}님 환영합니다.
				<button type="submit" class="btn btn-danger" onclick="out();">로그아웃</button>
			</c:if>
			</div>
			<c:if test="${sessionScope.user_id != null && sessionScope.user_id != ''}">
				<div class="panel-body" align="center">

					<button style="width:25%;"class="bttn-slant bttn-lg bttn-success" onclick="location.href='search.do'">조회</button>
					<button style="width:65%;" class="bttn-slant bttn-lg bttn-primary" onclick="location.href='search_weekly.do?term_year=${this_year}&term_week=${this_week-1}'">${this_year}년 ${this_week-1}주차</button><br><br>
					
					<button style="width:25%;" class="bttn-slant bttn-lg bttn-success" onclick="location.href='write.do'">작성</button>
					<button style="width:65%;" class="bttn-slant bttn-lg bttn-primary" onclick="location.href='write.do'">${this_year}년 ${this_week}주차</button><br><br>
					
					<button style="width:25%;" class="bttn-slant bttn-lg bttn-success" onclick="location.href='update.do'">수정</button>
					<button style="width:65%;" class="bttn-slant bttn-lg bttn-primary" onclick="location.href='update_form.do?term_year=${this_year}&term_week=${this_week}&user_id=${sessionScope.user_id}&select_project='">${this_year}년 ${this_week}주차</button>
				
				</div>
			</c:if>
			<div class="panel-footer">
			
			</div>
		</div>
	</div>
<!-- <body>끝 -->
<%@include file="main_bottom.jsp"%>