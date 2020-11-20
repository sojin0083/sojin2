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

function evidenceInsert(){
	location.href="evidenceInsert.do";
}

function profileManager(){
	/* location.href="profileManager.do"; */
	alert("제작중..추가는 관리자에게 문의..");
}

function searchEvidence(param){
	if(param == 'all'){
		location.href="evidenceList.do?CT_ID=" + param;
	}else if(param != 'all'){
		location.href="evidenceList.do?CT_ID=" + param;
	}
}
</script>
	<div class="container">
		<h1>증빙자료목록</h1>
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
					<h4>구분 카테고리</h4>
					<button type="button" class="btn btn-primary" onclick="searchEvidece('all');">전체</button>
					<c:forEach var="cateList" items="${cateList}">
						<button type="button" class="btn btn-primary" onclick="searchEvidence('${cateList.ctId}');">${cateList.ctName}</button>
					</c:forEach>
				</div>
				<!-- 검색창 -->
				<div class="panel-body text-center">
					<h4>검색 : 
					<input type="text" id="searchInput" placeholder="사업자등록증, 확인서 등"></h4>
					<div class="panel-body">
						<button type="button" class="btn btn-primary" onclick="evidenceInsert();">증빙자료 추가</button>
						<!-- 추후제작 -->
						<!-- <button type="button" class="btn btn-primary" onclick="profileManager();">구분관리</button> -->
					</div>
				</div>
			</c:if>
			
			</div>
			<c:if test="${sessionScope.user_id != null && sessionScope.user_id != ''}">
				<div class="panel-body">
					<table class="table table-hover">
						<thead>
							<tr>
								<th style="text-align:center;">번호</th>
								<th style="text-align:center;">구분</th>
								<th style="text-align:center;">서식명</th>
								<th style="text-align:center;">등록일</th>
								<th style="text-align:center;">만료일</th>
								<th style="text-align:center;">상세보기</th>
							</tr>
						</thead>
						<tbody id="myTable">
							<c:if test="${empty HRMList}">
								<td colspan="6" style="text-align:center;">등록된 증빙자료가 없습니다.</td>
							</c:if>						
							<c:forEach var="HRMList" items="${HRMList}">
								<tr>
									<td style="text-align:center;">${HRMList.no}</td>
									<td style="text-align:center;">${HRMList.ctName}</td>
									<td style="text-align:center;">${HRMList.eviName}</td>
									<td style="text-align:center;">${HRMList.regDate}</td>
									<td style="text-align:center;">${HRMList.expDate}</td>
									<td style="text-align:center;"><a href="evidenceDetail.do?EVI_CD=${HRMList.eviCd}">상세보기</a></td>
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