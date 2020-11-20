<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../main_top.jsp"%>

<script type="text/javascript">
$( document ).ready(function() {
	<c:if test="${!empty msg}">
		alert("${msg}");
	</c:if>
	
	$("#searchInput").on("keyup", function() {
	    var value = $(this).val().toLowerCase();
	    $("#myTable tr").filter(function() {
	      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    });
	  });
});

function out(){
	location.href = "<c:url value='/logout.do'/>";
}

function searchForm() {
	if(param == 'all'){
		location.href="formList.do?CT_ID=" + param;
	}else if(param != 'all'){
		location.href="formList.do?CT_ID=" + param;
	}	
}

function formInsert() {
	location.href = "formInsert.do";
}
</script>

<div class="container">
	<h1>서식 목록</h1>
	<div class="panel panel-default">
		<div class="panel-heading">
			<!-- 로그인 전 -->
			<c:if
				test="${sessionScope.user_id == null || sessionScope.user_id == ''}">
				<button type="button" class="btn btn-primary form-control"
					onclick="location.href='loginPage.do'">로그인</button>
			</c:if>
			<c:if
				test="${sessionScope.user_id == null || sessionScope.user_id == ''}">
				<h3 style="text-align: center;">로그인이 필요합니다.</h3>
			</c:if>

			<!-- 로그인 후 -->
			<c:if
				test="${sessionScope.user_id != null && sessionScope.user_id != ''}">
				<%-- ${sessionScope.user_name}님 환영합니다.
				<button type="submit" class="btn btn-danger" onclick="out();">로그아웃</button> --%>
				<!-- 프로필 구분 -->
				<div class="panel-body text-center">
					<h4>구분 카테고리</h4>
					<button type="button" class="btn btn-primary" onclick="searchForm('all');">전체</button>
					<c:forEach var="cateList" items="${cateList}">
						<button type="button" class="btn btn-primary" onclick="searchForm('${cateList.ctId}');">${cateList.ctName}</button>
					</c:forEach>
				</div>
				<!-- 검색창 -->
				<div class="panel-body text-center">
					<h4>
						검색 : <input type="text" id="searchInput" placeholder="휴가, 출장, 정산, 등록일 등">
					</h4>
					<div class="panel-body">
						<button type="button" class="btn btn-primary" onclick="formInsert();">서식추가</button>
						<!-- 추후제작 -->
						<!-- <button type="button" class="btn btn-primary" onclick="profileManager();">구분관리</button> -->
					</div>
				</div>
			</c:if>
		</div>
		<c:if
			test="${sessionScope.user_id != null && sessionScope.user_id != ''}">
			<div class="panel-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<th style="text-align: center;">번호</th>
							<th style="text-align: center;">구분</th>
							<th style="text-align: center;">서식명</th>
							<th style="text-align: center;">등록일</th>
							<th style="text-align: center;">비고</th>
						</tr>
					</thead>
					<tbody id="myTable">
						<c:if test="${empty HRMList}">
							<td colspan="5" style="text-align: center;">등록된 서식이 없습니다.</td>
						</c:if>
						<c:forEach var="HRMList" items="${HRMList}">
							<tr>
								<td style="text-align: center;">${HRMList.no}</td>	
								<td style="text-align: center;">${HRMList.ctName}</td>
								<td style="text-align: center;">${HRMList.formName}</td>
								<td style="text-align: center;">${HRMList.regDate}</td>
								<td style="text-align: center;"><a href="formDetail.do?FORM_CD=${HRMList.formCd}">상세보기</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
		<div class="panel-footer"></div>
	</div>
</div>
<%@include file="../main_bottom.jsp"%>