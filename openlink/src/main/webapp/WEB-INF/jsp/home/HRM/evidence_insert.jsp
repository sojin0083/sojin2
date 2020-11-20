<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="../main_top.jsp"%>
<!-- <body>시작 -->
<script type="text/javascript">
$( document ).ready(function() {
	<c:if test="${!empty msg}">
		alert("${msg}");
	</c:if>
	
	/* 오늘날짜 입력 */
	var regDate = getToday();
	document.getElementById("REG_DATE").value = regDate;
});

function out(){
	location.href = "<c:url value='/logout.do'/>";
}

function goBack(){
    window.history.back();
 }
 
function getToday(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + '-' +  month + '-' + day;
}
</script>

	<div class="container">
		<h1>증빙자료등록</h1>
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
						<div>
						<form name="evidenceForm" class="form-inline" method="post">
							<table class="table table-hover">
								<thead>
									<h4>●상세사항</h4>
									<tr>
										<th style="text-align:center; width:20%;">증빙자료코드</th>
										<td><input type="text" id="EVI_CD" name="EVI_CD" value="${str_eviCd}" style=" width:100%;" readOnly></td>
										<th style="text-align:center; width:20%;">이름</th>
										<td><input type="text" id="EVI_NAME" name="EVI_NAME" style=" width:100%;"></td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th style="text-align:center;">구분</th>
										<td>
											<select id="CT_ID" name="CT_ID" style="width:100%;height:25px;">
												<option value="">--------------선택--------------</option>
												<c:forEach var="cateList" items="${cateList}">
													<option value="${cateList.ctId}">${cateList.ctName}</option>
												</c:forEach>
											</select>
										</td>
										<th style="text-align:center;">등록자</th>
										<td><input type="text" id="REG_USER" name="REG_USER" style=" width:100%;"></td>
									</tr>
									<tr>
										<th style="text-align:center;">등록일</th>
										<td><input type="date" id="REG_DATE" name="REG_DATE" style=" width:100%;"></td>
										<th style="text-align:center;">만료일</th>
										<td><input type="date" id="EXP_DATE" name="EXP_DATE" style="width: 100%"></td>
									</tr>
									<tr>
										<th style="vertical-align:middle; text-align:center;">비고</th>
										<td colspan="3">
											<textarea name="RMK" id="RMK" style="resize: none; width:100%; height:200px" autocomplete="off"></textarea>
						 					<!-- <script type="text/javascript">
												CKEDITOR.replace('RMK', {
													width : '100%',
													toolbarCanCollapse : true,
													toolbarStartupExpanded : false
												});
											</script> -->
										</td>
									</tr>
								</tbody>
							</table>
						</form>
						</div>
						
						<div class="panel-body text-center">
							<button type="button" class="btn btn-primary" onclick="return insertEvidence();" id="insertEvidenceBtn">증빙자료 등록</button>
						</div>
						<div class="panel-body">
						<form id="fileUploadForm" method="post" enctype="multipart/form-data">
							<input type="hidden" name="EVI_CD" value="${str_eviCd}">
							<table class="table table-hover text-center">
								<thead>
									<h4>●증빙자료 등록</h4>
									<h5><font style="color: red;">*문서명이 중복되지 않도록 주의(모든인원 공통)</font></h5>
									<tr>
										<th style="text-align:center;">구분</th>
										<th style="text-align:center;">문서명</th>
										<th style="text-align:center;">비고</th>
									</tr>
								</thead>
								<tbody>
									<!-- 문서 -->
									<tr>
										<td style="vertical-align:middle; text-align:center;">문서</td>
										<td><input type="file" id="FILENAME_doc" name="FILENAME_doc"></td>
										<td><button type="button" class="btn btn-primary" onclick="return eviUpload('doc');" id="eviUploadBtn_doc" disabled="disabled">업로드</button></td>
									</tr>
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
						<button type="button" class="btn btn-primary" onclick="goBack();">뒤로가기</button>
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
	if( $('#CT_ID').val() == '' ){
		alert("구분을 선택하세요.");
		return false;
	}
	if( $('#REG_USER').val() == '' ){
		alert("등록자를 입력하세요.");
		return false;
	}
	
	/* ajax */
	var param = $("form[name=evidenceForm]").serialize();
	
	 $.ajax({  
	   type: "POST",
	   url: "<c:url value='/evidenceInsertOk.do'/>",
	   data: param,
	   success:function(data){
	    alert("증빙자료가 등록되었습니다.");
	    btn = document.getElementById('insertEvidenceBtn');
	    btn.disabled = 'disabled';
	    btn.innerText = '증빙자료 등록완료';
	    
	    btn = document.getElementById('eviUploadBtn_doc');
	    btn.disabled = false;
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
function eviUpload(param){
	var str_param = '';
	if( $('#FILENAME_' + param).val() == '' ){
		if(param == 'doc'){
			str_param = '문서';
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
		url: "<c:url value='/eviUploadOk.do?PARAM='/>" + param,
		data: formData, // 필수 
		processData: false, // 필수 
		contentType: false, // 필수 
		cache: false, 
		success: function (result) {
			alert("업로드완료");
		}, 
		error: function (e) {
			alert("실패 : " + e);
			console.log(e);
		} 
	});

}
</script>

<!-- <body>끝 -->
<%@include file="../main_bottom.jsp"%>