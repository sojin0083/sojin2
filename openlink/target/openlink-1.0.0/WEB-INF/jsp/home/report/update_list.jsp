<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../main_top.jsp"%>
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
		<h1>작성목록</h1>
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
				<div class="panel-body">
					<table class="table table-hover">
						<thead>
							<tr>
								<th style="text-align:center;">번호</th>
								<th style="text-align:center;">작성연도</th>
								<th style="text-align:center;">작성주차</th>
								<th style="text-align:center;">비고</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="reportList" items="${reportList}">
								<tr>
									<td style="text-align:center;">${reportList.no}</td>
									<td style="text-align:center;">${reportList.term_year}</td>
									<td style="text-align:center;">${reportList.term_week}</td>
									<td style="text-align:center;">
									<a href="update_form.do?term_year=${reportList.term_year}&term_week=${reportList.term_week}&user_id=${sessionScope.user_id}&select_project=${select_project}">수정</a>
									|
									<a href="deleteWeekly.do?term_year=${reportList.term_year}&term_week=${reportList.term_week}&user_id=${sessionScope.user_id}" 
										onclick="return confirm('${reportList.term_year}년 ${reportList.term_week}주차에 작성한 모든 업무가 삭제됩니다.');">삭제</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:if>
			<div class="panel-footer">
			
			</div>
		</div>
	</div>
<!-- <body>끝 -->
<%@include file="../main_bottom.jsp"%>