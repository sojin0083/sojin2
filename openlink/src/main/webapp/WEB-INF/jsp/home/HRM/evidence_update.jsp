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

function complete(param){
    location.href = "evidenceDetail.do?EVI_CD=" + param;
 }

</script>

	<div class="container">
		<h1>증빙자료수정</h1>
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
						<form name="evidenceForm" class="form-inline" method="post">
							<table class="table table-hover">
								<c:forEach var="HRMList" items="${HRMList}">
									<thead>
										<h4>●상세사항</h4>
										<tr>
											<th style="text-align:center; width:20%;">증빙자료코드</th>
											<td><input type="text" id="EVI_CD" name="EVI_CD" value="${HRMList.eviCd}" style=" width:100%;" readOnly></td>
											<th style="text-align:center; width:20%;">이름</th>
											<td><input type="text" id="EVI_NAME" name="EVI_NAME" value="${HRMList.eviName}" style=" width:100%;"></td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th style="text-align:center;">구분</th>
												<td>
												<select id="CT_ID" name="CT_ID" style="width:100%;height:25px;">
													<option value="">--------------선택--------------</option>
													<c:forEach var="cateList" items="${cateList}">
														<c:if test="${HRMList.ctId == cateList.ctId}">
															<option value="${cateList.ctId}" selected>${cateList.ctName}</option>
														</c:if>
														<c:if test="${HRMList.ctId != cateList.ctId}">
															<option value="${cateList.ctId}">${cateList.ctName}</option>
														</c:if>
													</c:forEach>
												</select>
											</td>
											<th style="text-align:center;">등록자</th>
											<td><input type="text" id="REG_USER" name="REG_USER" value="${HRMList.regUser}" style=" width:100%;"></td>
										</tr>
										<tr>
											<th style="text-align:center;">등록일</th>
											<td><input type="text" id="REG_DATE" name="REG_DATE" value="${HRMList.regDate}" style=" width:100%;"></td>
											<th style="text-align:center;">만료일</th>
											<td><input type="text" id="EXP_DATE" name="EXP_DATE" value="${HRMList.expDate}" style=" width:100%;"></td>
										</tr>
										<tr>
											<th style="vertical-align:middle; text-align:center;">비고</th>
											<td colspan="3">
												<textarea name="RMK" id="RMK" style="resize: none; width:100%; height:200px" autocomplete="off">${HRMList.rmk}</textarea>
											</td>
										</tr>
									</tbody>
								</c:forEach>
							</table>
						</form>
						<div class="panel-body text-center">
							<button type="button" class="btn btn-primary" onclick="return insertEvidence();" id="insertEvidenceBtn">증빙자료 수정</button>
						</div>
						<div class="panel-body">
						<form id="fileUploadForm" method="post" enctype="multipart/form-data">
							<c:forEach var="HRMList" items="${HRMList}">
								<input type="hidden" name="EVI_CD" value="${HRMList.eviCd}">
							</c:forEach>
							<table class="table table-hover text-center">
								<thead>
									<h4>●문서등록</h4>
									<h5><font style="color: red;">*문서명이 중복되지 않도록 주의(모든인원 공통)</font></h5>
									<tr>
										<th style="text-align:center;">구분</th>
										<th style="text-align:center;">문서명</th>
										<th style="text-align:center;">비고</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td style="vertical-align:middle; text-align:center;">증빙자료</td>
										<td><input type="file" id="FILENAME_doc" name="FILENAME_doc"></td>
										<td><button type="button" class="btn btn-primary" onclick="return docUpload('doc');" id="docUploadBtn_doc">업로드</button></td>
									</tr>
									<tr>
										<th colspan="3" style="vertical-align:middle; text-align:center;"><h4>등록된 문서</h4></th>
									</tr>
									<c:if test="${empty DocList}">
										<td colspan="3" style="text-align:center;">등록된 문서가 없습니다.</td>
									</c:if>		
									<c:forEach var="DocList" items="${DocList}">
										<tr>
											<c:if test="${!empty DocList}">
												<td style="vertical-align:middle; text-align:center;">
													<c:if test="${DocList.proType=='pro'}">프로필</c:if>
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
												<td style="vertical-align:middle; text-align:center;">
													<button type="button" class="btn btn-danger" onclick="deleteOneDoc('${DocList.docName}');">삭제</button>
													<input type="hidden" id="DOC_NAME" value="${DocList.docName}">
													<input type="hidden" id="EVI_CD" value="${DocList.eviCd}">
												</td>
											</c:if>
										</tr>
									</c:forEach>			
								</tbody>
							</table>
						</form>
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
						<c:forEach var="HRMList" items="${HRMList}">
							<button type="button" class="btn btn-primary" onclick="complete('${HRMList.formCd}');">완료</button>
						</c:forEach>
					</div>
				</c:if>
			</div>
		</div>
	</div>
<!-- 프로필등록 -->
<script type="text/javascript">
function insertEvidence(){ 
	if( $('#EVI_NAME').val() == '' ){
		alert("이름을 입력하세요.");
		return false;
	}
	if( $('#EXP_DATE').val() == '' ){
		alert("만료일을 입력하세요.");
		return false;
	}
	if( $('#CT_ID').val() == '' ){
		alert("구분를 입력하세요.");
		return false;
	}
	
	/* ajax */
	var param = $("form[name=evidenceForm]").serialize();
	
	 $.ajax({  
	   type: "POST",
	   url: "<c:url value='/evidenceUpdateOk.do'/>",
	   data: param,
	   success:function(data){
	    alert("증빙자료가 수정되었습니다.");
	    location.reload();
	  },
	   error:function(request, status, error){
	    /* alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); */
	    alert("등록중 에러가 발생하였습니다.");
	    console.log('Error', error); 
	  }
	  });
}
</script>

<!-- 문서등록 -->
<script type="text/javascript">
function docUpload(param){
	var str_param = '';
	if( $('#FILENAME_' + param).val() == '' ){
		if(param == 'pro'){
			str_param = '프로필';
		}else if(param == 'cer'){
			str_param = '자격증';
		}else if(param == 'con'){
			str_param = '확인서';
		}else if(param == 'etc'){
			str_param = '기타파일';
		}
		alert(str_param + "을 선택하세요");
		return false;
	}
	
	/* ajax */
	var formData = new FormData($('#fileUploadForm')[0]);
	console.log("data : " + formData);
	$.ajax({ 
		type: "POST", 
		enctype: "multipart/form-data", // 필수 
		url: "<c:url value='/docUploadOk.do?PARAM='/>" + param,
		data: formData, // 필수 
		processData: false, // 필수 
		contentType: false, // 필수 
		cache: false, 
		success: function (result) {
			//alert("성공");
			location.reload();
		}, 
		error: function (e) {
			alert("실패 : " + e);
			console.log(e);
		} 
	});

}
</script>

<!-- 문서삭제 -->
<script type="text/javascript">
function deleteOneDoc(docName){ 
	/* ajax */	
	 $.ajax({  
	   type: "POST",
	   url: "<c:url value='/deleteEvidenceDocOK.do'/>",
	   data: {
		   EVI_CD : $('#EVI_CD').val(),
		   DOC_NAME : docName
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