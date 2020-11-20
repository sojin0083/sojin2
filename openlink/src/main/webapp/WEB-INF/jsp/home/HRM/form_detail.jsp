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

function goList(){
    location.href="formList.do?CT_ID=all";
 }
 
 function updateForm(formCd){
	 location.href="formUpdate.do?FORM_CD=" + formCd;
 }
 
 function deleteForm(formCd){
	 var result = confirm("서식을 삭제하시겠습니까?");
	 if(result){
		 location.href="deleteFormOK.do?FORM_CD=" + formCd;
	 }
 }
</script>
	<div class="container">
		<h1>서식</h1>
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
							<table class="table table-hover">
								<c:forEach var="HRMList" items="${HRMList}">
									<thead>
										<h4> ●상세보기</h4>
										<tr>
											<th style="vertical-align:middle; text-align:center;">서식코드</th>
											<td style="vertical-align:middle;">${HRMList.formCd}</td>
											<th style="vertical-align:middle; text-align:center;">서식명</th>
											<td style="vertical-align:middle;">${HRMList.formName}</td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th style="text-align:center;">등록자</th>
											<td>${HRMList.regUser}</td>
											<th style="text-align:center;">둥록일</th>
											<td>${HRMList.regDate}</td>
										</tr>
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
								<h4> ●등록문서</h4>
								<tr>
									<th style="text-align:center;">구분</th>
									<th style="text-align:center;">문서명</th>
									<!-- 삭제는 수정하기에서 적용-->
									<!-- <th style="text-align:center;">비고</th> -->
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty DocList}">
									<td colspan="3" style="text-align:center;">등록된 문서가 없습니다.</td>
								</c:if>
								<c:forEach var="DocList" items="${DocList}">
									<tr>
										<c:if test="${!empty DocList}">
											<td style="vertical-align:middle; text-align:center;">
												<c:if test="${DocList.proType=='pro'}">프로필</c:if>
												<c:if test="${DocList.proType=='cer'}">자격증</c:if>
												<c:if test="${DocList.proType=='con'}">확인서</c:if>
												<c:if test="${DocList.proType=='etc'}">기타</c:if>
											</td>
											<td style="vertical-align:middle;">
												<c:if test="${DocList.proType == 'pro'}">
													<a href="resources/document/profile/pro_profile/${DocList.docName}" download>${DocList.docName}</a>
												</c:if>
												<c:if test="${DocList.proType == 'cer'}">
													<a href="resources/document/profile/pro_certification/${DocList.docName}" download>${DocList.docName}</a>
												</c:if>
												<c:if test="${DocList.proType == 'con'}">
													<a href="resources/document/profile/pro_confirmation/${DocList.docName}" download>${DocList.docName}</a>
												</c:if>
												<c:if test="${DocList.proType == 'etc'}">
													<a href="resources/document/profile/pro_etc/${DocList.docName}" download>${DocList.docName}</a>
												</c:if>
											</td>
											<!-- 삭제는 수정하기에서 적용-->
<%-- 											<td style="vertical-align:middle; text-align:center;">
												<button type="button" class="btn btn-danger" onclick="deleteOneDoc('${DocList.docName}');">삭제</button>
												<input type="hidden" id="DOC_NAME" value="${DocList.docName}">
												<input type="hidden" id="PRO_CD" value="${DocList.proCd}">
											</td> --%>
										</c:if>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</c:if>
			<div class="panel-footer">
				<!-- 로그인 후 -->
				<c:if test="${sessionScope.user_id != null && sessionScope.user_id != ''}">
					<!-- 프로필 버튼 -->
					<div class="panel-body text-center">
						<c:forEach var="HRMList" items="${HRMList}">
							<button type="button" class="btn btn-primary" onclick="updateForm('${HRMList.formCd}');">수정하기</button>
							<button type="button" class="btn btn-danger" onclick="deleteForm('${HRMList.formCd}');">삭제하기</button>
							<button type="button" class="btn btn-primary" onclick="goList();">목록으로</button>
						</c:forEach>
					</div>
				</c:if>
			</div>
		</div>
	</div>
<!-- 문서삭제 -->
<script type="text/javascript">
function deleteOneDoc(){ 
	/* ajax */	
	 $.ajax({  
	   type: "POST",
	   url: "<c:url value='/deleteFormDocOK.do'/>",
	   data: {
		   FORM_CD : $('#FORM_CD').val(),
		   FORM_NAME : $('#FORM_NAME').val()
	   },
	   success:function(data){
		  location.reload();
	  },
	   error:function(request, status, error){
	    /* alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); */
	    alert("삭제중 에러가 발생하였습니다.");
	    console.log('Error', error); 
	  }
	  });
}
</script>
<!-- <body>끝 -->
<%@include file="../main_bottom.jsp"%>