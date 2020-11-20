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
		<h1>프로필등록</h1>
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
						<form name="profileForm" class="form-inline" method="post">
							<table class="table table-hover">
								<thead>
									<h4>●상세사항</h4>
									<tr>
										<th style="text-align:center; width:20%;">프로필코드</th>
										<td><input type="text" id="PRO_CD" name="PRO_CD" value="${str_proCd}" style=" width:100%;" readOnly></td>
										<th style="text-align:center; width:20%;">이름</th>
										<td><input type="text" id="PRO_NAME" name="PRO_NAME" style=" width:100%;"></td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th style="text-align:center;">소속</th>
										<td><input type="text" id="DEP" name="DEP" style=" width:100%;"></td>
										<th style="text-align:center;">부서</th>
										<td>
											<select id="CT_ID" name="CT_ID" style="width:100%;height:25px;">
												<option value="">--------------선택--------------</option>
												<c:forEach var="cateList" items="${cateList}">
													<option value="${cateList.ctId}">${cateList.ctName}</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<th style="text-align:center;">상태</th>
										<td>
											<select id="STAT" name="STAT" style="width:100%;height:25px;">
												<option value="01">재직</option>
												<option value="02">퇴직</option>
											</select>
										</td>
										<th style="text-align:center;">등록일</th>
										<td><input type="text" id="REG_DATE" name="REG_DATE" style=" width:100%;" readOnly></td>
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
							<button type="button" class="btn btn-primary" onclick="return insertProfile();" id="insertProfileBtn">프로필 등록</button>
						</div>
						<div class="panel-body">
						<form id="fileUploadForm" method="post" enctype="multipart/form-data">
							<table class="table table-hover text-center">
								<thead>
									<h4>●문서등록</h4>
									<tr>
										<th style="width:15%; text-align:center;">구분</th>
										<th style="text-align:center;">문서명</th>
										<th style="width:25%; text-align:center;">비고</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<!-- <select id="DOC_TYPE" name="DOC_TYPE" style="width:100%;height:25px;">
												<option value="">----------선택----------</option>
												<option value="profile">프로필</option>
												<option value="certification">자격증</option>
												<option value="confirmation">확인서</option>
												<option value="etc">기타</option>
											</select> -->
										</td>
										<td>
											<input type="file" id="FILENAME" multiple="true" name="FILENAME">
										</td>
										<td>
											<button type="button" class="btn btn-primary" onclick="return docUpload();" id="docUploadBtn" >문서 업로드</button>
										</td>
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
function insertProfile(){ 
	if( $('#PRO_NAME').val() == '' ){
		alert("이름을 입력하세요.");
		return false;
	}
	if( $('#DEP').val() == '' ){
		alert("소속을 입력하세요.");
		return false;
	}
	if( $('#CT_ID').val() == '' ){
		alert("부서를 입력하세요.");
		return false;
	}
	
	/* ajax */
	var param = $("form[name=profileForm]").serialize();
	
	 $.ajax({  
	   type: "POST",
	   url: "<c:url value='/profileInsertOk.do'/>",
	   data: param,
	   success:function(data){
	    alert("프로필이 등록되었습니다.");
	    btn = document.getElementById('insertProfileBtn');
	    btn.disabled = 'disabled';
	    btn.innerText = '프로필 등록완료';
	    
	    btn = document.getElementById('docUploadBtn');
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
function docUpload(){
/* 	if( $('#DOC_TYPE').val() == '' ){
		alert("구분을 선택해주세요.");
		return false;
	} */
		
	/* ajax */
	var formData = new FormData($('#fileUploadForm')[0]);
	console.log(formData);
	$.ajax({ 
		type: "POST", 
		enctype: 'multipart/form-data', // 필수 
		url: "<c:url value='/docUploadOk.do'/>",
		data: formData, // 필수 
		processData: false, // 필수 
		contentType: false, // 필수 
		cache: false, 
		success: function (result) {
			alert("성공");
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