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

function goBack(){
    window.history.back();
 }
</script>
	<div class="container">
		<h1>프로필</h1>
		<div class="panel panel-default">
			<div class="panel-heading">
			<!-- 로그인 전 -->
			<c:if test="${sessionScope.user_id == null || sessionScope.user_id == ''}">
				<button type="button" class="btn btn-primary form-control" onclick="location.href='loginPage.do'">로그인</button>
			</c:if>
			<c:if test="${sessionScope.user_id == null || sessionScope.user_id == ''}">
				<h3 style="text-align : center;">로그인이 필요합니다.</h3>
			</c:if>
			
			</div>
			<c:if test="${sessionScope.user_id != null && sessionScope.user_id != ''}">
				<div class="panel-body">
					<div class="row">
						<div class="col-sm-4 text-center">
							<img src="images/openlink/img_avatar1.png" class="media-object" style="width:100%">
						</div>
						<div class="col-sm-8">
							<table class="table table-hover">
								<c:forEach var="HRMList" items="${HRMList}">
								<thead>
									<h4>●상세보기</h4>
									<tr>
										<th style="vertical-align:middle; text-align:center;">프로필코드</th>
										<td style="vertical-align:middle;">${HRMList.proCd}</td>
										<th style="vertical-align:middle; text-align:center;">이름</th>
										<td style="vertical-align:middle;">${HRMList.proName}</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th style="text-align:center;">소속</th>
										<td>${HRMList.dep}</td>
										<th style="text-align:center;">부서</th>
										<td>${HRMList.ctName}</td>
									</tr>
									<tr>
										<th style="text-align:center;">상태</th>
										<c:if test="${HRMList.stat == '01'}">
											<td style="color:#0099FF;">재직</td>
										</c:if>
										<c:if test="${HRMList.stat == '02'}">
											<td style="color:#FF0000;"">퇴직</td>
										</c:if>
										<th style="text-align:center;">등록일</th>
										<td>${HRMList.regDate}</td>
									</tr>
									<tr>
										<th style="vertical-align:middle; text-align:center;">비고</th>
										<td colspan="3">
											<textarea name="etc" id="user_etc" style="resize: none; width:100%; height:200px" autocomplete="off" readOnly>${HRMList.rmk}</textarea>
										</td>
									</tr>
								</tbody>
								</c:forEach>
							</table>
						</div>
						<div class="panel-body">
						<table class="table table-hover">
							<thead>
								<h4>●등록문서</h4>
								<tr>
									<th style="width:20%">구분</th>
									<th>문서명</th>
									<th style="width:25%">비고</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>John</td>
									<td>Doe</td>
									<td>다운로드</td>
								</tr>
								<tr>
									<td>Mary</td>
									<td>Moe</td>
									<td>다운로드</td>
								</tr>
								<tr>
									<td>July</td>
									<td>Dooley</td>
									<td>다운로드</td>
								</tr>
								
							</tbody>
						</table>
					</div>
					</div>
				</div>
			</c:if>
			<div class="panel-footer">
				<!-- 로그인 후 -->
				<c:if test="${sessionScope.user_id != null && sessionScope.user_id != ''}">
					<%-- ${sessionScope.user_name}님 환영합니다.
					<button type="submit" class="btn btn-danger" onclick="out();">로그아웃</button> --%>
					<!-- 프로필 버튼 -->
					<div class="panel-body text-center">
						<button type="button" class="btn btn-primary" onclick="searchProfile('all');">수정하기</button>
						<button type="button" class="btn btn-primary" onclick="goBack();">뒤로가기</button>
					</div>
				</c:if>
			</div>
		</div>
	</div>
<!-- <body>끝 -->
<%@include file="../main_bottom.jsp"%>