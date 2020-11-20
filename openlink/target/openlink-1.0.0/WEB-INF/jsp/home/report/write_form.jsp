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
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<div class="container">
		<h1>주간업무보고 작성</h1>
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
				<form class="form-inline" method="get" action="<c:url value='/select_project.do'/>">
					<div class="form-group">
						<label>날짜선택</label><br>
						<select id="select-year" name="term_year">
							<option value="">년도선택</option>
							<c:forEach var="term_year_list" items="${term_year_list}">
								<c:if test="${term_year == null}">
									<c:if test="${term_year_list == this_year}">
										<option value="${term_year_list}" selected>${term_year_list}</option>
									</c:if>
									<c:if test="${term_year_list != this_year}">
										<option value="${term_year_list}">${term_year_list}</option>
									</c:if>
								</c:if>
								<c:if test="${term_year != null}">
									<c:if test="${term_year_list == term_year}">
										<option value="${term_year_list}" selected>${term_year_list}</option>
									</c:if>
									<c:if test="${term_year_list != term_year}">
										<option value="${term_year_list}">${term_year_list}</option>
									</c:if>
								</c:if>
							</c:forEach>
						</select>
						<label>년　</label>
						<select id="select-week" name="term_week">
							<option value="">주차선택</option>
							<c:forEach var="term_week_list" items="${term_week_list}">
								<c:if test="${term_week == null}">
									<c:if test="${term_week_list == this_week}">
										<option value="${term_week_list}" selected>${term_week_list}</option>
									</c:if>
									<c:if test="${term_week_list != this_week}">
										<option value="${term_week_list}">${term_week_list}</option>
									</c:if>
								</c:if>
								<c:if test="${term_week != null}">
									<c:if test="${term_week_list == term_week}">
										<option value="${term_week_list}" selected>${term_week_list}</option>
									</c:if>
									<c:if test="${term_week_list != term_week}">
										<option value="${term_week_list}">${term_week_list}</option>
									</c:if>
								</c:if>
							</c:forEach>
						</select>
						<label>주차　　</label><br><br>
						
						<label>프로젝트 선택　　</label><br>
						<select id="select-project" name="select_project" onclick="return check();" onchange="this.form.submit();">
							<option value="">프로젝트선택</option>
							<c:forEach var="projectList" items="${projectList}">
								<c:if test="${projectList.project_code == select_project}">
									<option value="${projectList.project_code}" selected>● ${projectList.project_name}</option>
								</c:if>
								<c:if test="${projectList.project_code != select_project}">
									<option value="${projectList.project_code}">○ ${projectList.project_name}</option>
								</c:if>
							</c:forEach>
						</select>
						<!-- 프로젝트추가 -->
						<button type="button" onclick="window.open('http://portal.openlink.kr:8080/openlink/insert_project.report', '프로젝트 추가','width=800, height=700'); return false" class="btn btn-primary">추가</button><br><br>
					</div>
				</form>
				<!-- 입력form -->
				<form name="write" id="write" class="form-inline" method="get" action="<c:url value='/insertReport.do'/>">
				<div class="table-responsive">
					<table class="table table-hover" border="1" bordercolor="#CCCCCC">
						<thead>
							<tr>
								<th style="text-align:center; font-size:large;">
									<c:if test="${select_project == null}"> 
										<label>프로젝트를 선택해주세요.</label>
									</c:if>
									<c:if test="${select_project != null}"> 
										<label>${term_year}년  ${term_week}주차</label><br>
										<c:forEach var="projectList" items="${projectList}">
											<c:if test="${projectList.project_code == select_project}">
												<label>${projectList.project_name}</label>
											</c:if>
										</c:forEach>
									</c:if>
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<c:if test="${term_week == null}">
										<label>금주계획</label><br>
									</c:if>
									<c:if test="${term_week != null}">
										<label>${term_week}주차계획</label><br>
									</c:if>
									<c:if test="${weeklyReport == ''}">
										<textarea id="write-from1" readOnly placeholder="계획된 업무가 없습니다."></textarea>
									</c:if>
									<c:if test="${weeklyReport != ''}">
										<textarea id="write-from1" readOnly>${weeklyReport}</textarea>
									</c:if>
								</td>
								<script type="text/javascript">
									CKEDITOR.replace('write-from1', {
										width : '100%', 
										height : '200px', 
										startupFocus : false
									});
								</script>
							</tr>
							<tr>
								<td>
									<c:if test="${term_week == null}">
										<label>금주실적</label><br>
									</c:if>
									<c:if test="${term_week != null}">
										<label>${term_week}주차실적 (*필요시 수정*)</label><br>
									</c:if>
									<textarea id="write-from2" name="last_week">${weeklyReport}</textarea>
								</td>
								<script type="text/javascript">
									CKEDITOR.replace('write-from2', {
										width : '100%', 
										height : '200px', 
										startupFocus : false
									});
								</script>
							</tr>
							<tr>
								<td>
									<c:if test="${term_week == null}">
										<label>차주계획</label><br>
									</c:if>
									<c:if test="${term_week != null}">
										<label>${term_week+1}주차계획</label><br>
									</c:if>
									<textarea id="write-from3" name="next_week" placeholder="차주 계획을 입력해주세요."></textarea>
								</td>
								<script type="text/javascript">
									CKEDITOR.replace('write-from3', {
										width : '100%', 
										height : '200px', 
										startupFocus : false
									});
								</script>
							</tr>
							<tr>
								<td>
									<label>기타</label><br>
									<textarea id="write-from4" name="etc"></textarea>
									<script type="text/javascript">
									CKEDITOR.replace('write-from4', {
										width : '100%', 
										height : '100px', 
										startupFocus : false
									});
								</script>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 파라미터 -->
				<input type="hidden" name="select_project" value="${select_project}">
				<input type="hidden" name="term_year" value="${term_year}">
				<input type="hidden" name="term_week" value="${term_week}">
				</form>
				</div>
				<div class="panel-footer">
					<button type="button" onclick="write.submit();" class="btn btn-primary">등록</button>
				</div>
			</c:if>
		</div>
	</div>
<!-- <body>끝 -->
<%@include file="../main_bottom.jsp"%>