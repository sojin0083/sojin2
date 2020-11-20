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
<!-- <script>
var mobileKeyWords = new Array('iPhone', 'iPod', 'BlackBerry', 'Android', 'Windows CE', 'Windows CE;', 'LG', 'MOT', 'SAMSUNG', 'SonyEricsson', 'Mobile', 'Symbian', 'Opera Mobi', 'Opera Mini', 'IEmobile');
for (var word in mobileKeyWords){
    if (navigator.userAgent.match(mobileKeyWords[word]) != null){
    	if (window.matchMedia("(orientation: portrait)").matches) {
    		// 세로 모드 (평소 사용하는 각도)
    		alert("화면을 가로로 회전시켜주세요.");
    	}
        break;
    }
}
</script> -->
	<div class="container">
		<h1>주간업무보고 조회</h1>
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
				<form class="form-inline" method="get" action="<c:url value='/search_weekly.do'/>">
					<div class="form-group">
						<label>날짜선택</label><br>
						<select id="select-year" name="term_year">
							<option value="">년도선택</option>
							<c:forEach var="term_year_list" items="${term_year_list}">
								<c:if test="${term_year_list == term_year}">
									<option value="${term_year_list}" selected>${term_year_list}</option>
								</c:if>
								<c:if test="${term_year_list != term_year}">
									<option value="${term_year_list}">${term_year_list}</option>
								</c:if>
							</c:forEach>
						</select>
						<label>년</label>
						<select id="select-week" name="term_week">
							<option value="">주차선택</option>
							<c:forEach var="term_week_list" items="${term_week_list}">
								<c:if test="${term_week_list == term_week}">
									<option value="${term_week_list}" selected>${term_week_list}</option>
								</c:if>
								<c:if test="${term_week_list != term_week}">
									<option value="${term_week_list}">${term_week_list}</option>
								</c:if>
							</c:forEach>
						</select>
						<label>주차</label>
						<button type="submit" class="btn btn-default" onclick="return check();">검색</button><br><br>
						<button type="button" class="btn btn-default" onclick="thisWeek('${this_year}','${this_week-1}');">${this_week-1}주차</button>
						<button type="button" class="btn btn-default" onclick="thisWeek('${this_year}','${this_week}');">${this_week}주차</button><br><br>
					</div>
				</form>
				<div class="table-responsive">
					<table class="table table-hover" border="1" bordercolor="#CCCCCC">
						<thead>
							<tr>
								<th colspan="2" style="text-align:center; font-size:large;">
									<c:if test="${term_year == null || term_week == null}"> 
										<label>날짜를 선택해주세요.</label>
									</c:if>
									<c:if test="${term_year != null && term_week != null && term_year != '' && term_week != ''}"> 
										<label>${term_year}년  ${term_week}주차</label>
									</c:if>
								</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="weeklyReportWriter" items="${weeklyReportWriter}">
								<tr>
									<th colspan="2" style="background-color: #bbdefb;">작성자 : ${weeklyReportWriter.user_id}</th>
								</tr>
								<tr>
									<th style="text-align:center; width:50%;">금주실적(${term_week}주차)</th>
									<th style="text-align:center; width:50%;">차주계획(${term_week+1}주차)</th>
								</tr>
								<c:forEach var="weeklyReport" items="${weeklyReport}">
									<!-- 작성자별로 구별 -->
									<c:set var="user_name" value="${weeklyReportWriter.user_id}"/>
									<c:if test="${user_name == weeklyReport.user_id}">
										<tr>
											<th colspan="2" style="text-align:center; background-color: #DDDDDD">${weeklyReport.project_name}</th>
										</tr>
										<%-- <tr>
											<th width="50%" style="text-align:center;">금주실적(${term_week}주차)</th>
											<th width="50%" style="text-align:center;">차주계획(${term_week+1}주차)</th>
										</tr> --%>
										<tr>
											<td>
											${weeklyReport.last_week}
											</td>
											<td>
											${weeklyReport.next_week}
											</td>
										</tr>
									</c:if>
								</c:forEach>
										<tr>
											<td colspan="2">
											<label>기타사항 : </label><br>
											<c:forEach var="weeklyReport" items="${weeklyReport}">
												<!-- 작성자별로 구별 -->
												<c:set var="user_name" value="${weeklyReportWriter.user_id}"/>
												<c:if test="${user_name == weeklyReport.user_id}">
													<c:if test="${weeklyReport.etc != ''}">  
														${weeklyReport.etc}
													</c:if>
												</c:if>
											</c:forEach>
											</td>
										</tr>
										<tr><td colspan="2" style="border-right:hidden; border-left:hidden;"><br><br><br></td></tr>
										
							</c:forEach>
						</tbody>
					</table>
				</div>
				</div>
			</c:if>
			<div class="panel-footer">
			<!-- <button type="button" class="btn btn-default">등록</button>
			<button type="button" class="btn btn-default">Default</button> -->
			</div>
		</div>
	</div>
<!-- <body>끝 -->
<%@include file="../main_bottom.jsp"%>