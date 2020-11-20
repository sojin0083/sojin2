<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../main_top.jsp"%>
<!-- <body>시작 -->
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

function profileInsert(){
	location.href="profileInsert.do";
}

function searchProfile(param){
	if(param == 'all'){
		location.href="profileList.do";
	}
}
</script>
	<div class="container">
		<h1>프로필목록</h1>
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
				<%-- ${sessionScope.user_name}님 환영합니다.
				<button type="submit" class="btn btn-danger" onclick="out();">로그아웃</button> --%>
				<!-- 프로필 구분 -->
				<div class="panel-body text-center">
					<button type="button" class="btn btn-primary" onclick="searchProfile('all');">전체</button>
					<c:forEach var="cateList" items="${cateList}">
						<button type="button" class="btn btn-primary">${cateList.ctName}</button>
					</c:forEach>
					<button type="button" class="btn btn-primary">기타</button>
				</div>
				<!-- 검색창 -->
				<div class="panel-body text-center">
					검색 : 
					<input type="text" id="searchInput" placeholder="이름,소속,상태,등록일 등">
					<button type="button" class="btn btn-primary" onclick="profileInsert();">프로필추가</button>
				</div>
			</c:if>
			
			</div>
			<c:if test="${sessionScope.user_id != null && sessionScope.user_id != ''}">
				<div class="panel-body">
					<table class="table table-hover">
						<thead>
							<tr>
								<th style="text-align:center; width:5%">번호</th>
								<th style="text-align:center;">이름</th>
								<th style="text-align:center;">소속</th>
								<th style="text-align:center;">상태</th>
								<th style="text-align:center;">등록일</th>
								<th style="text-align:center;">상세보기</th>
							</tr>
						</thead>
						<tbody id="myTable">							
							<c:forEach var="HRMList" items="${HRMList}">
								<tr>
									<td style="text-align:center;">${HRMList.no}</td>
									<td style="text-align:center;">${HRMList.proName}</td>
									<td style="text-align:center;">${HRMList.dep}</td>
									<c:if test="${HRMList.stat == '01'}">
										<td style="text-align:center; color:#0099FF;">재직</td>
									</c:if>
									<c:if test="${HRMList.stat == '02'}">
										<td style="text-align:center; color:#FF0000;"">퇴직</td>
									</c:if>
									<td style="text-align:center;">${HRMList.regDate}</td>
									<td style="text-align:center;">
									<a href="profileDetail.do?PRO_CD=${HRMList.proCd}">상세보기</a>
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