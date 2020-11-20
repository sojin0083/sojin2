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
		<h1>서식 등록</h1>
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
						<form name="formForm" class="form-inline" method="post" enctype="multipart/form-data">
							<table class="table table-hover">
								<thead>
									<h4>●상세사항</h4>
									<tr>
										<th style="text-align:center; width:20%;">서식코드</th>
										<td><input type="text" id="FORM_CD" name="FORM_CD" value="${str_formCd}" style=" width:100%;" readOnly></td>
										<th style="text-align:center; width:20%;">카테고리</th>
										<td>
											<select id="CT_ID" name="CT_ID" style="width:100%;height:25px;">
												<option value="">--------------선택--------------</option>
												<c:forEach var="cateList" items="${cateList}">
													<option value="${cateList.ctId}">${cateList.ctName}</option>
												</c:forEach>
											</select>
										</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th style="text-align:center;">등록자</th>
										<td><input type="text" id="REG_USER" name="REG_USER" style=" width:100%;"></td>
										<th style="text-align:center;">등록일</th>
										<td><input type="text" id="REG_DATE" name="REG_DATE" style=" width:100%;"></td>
									</tr>
									<tr>
										<th style="text-align:center; width:20%;">서식명</th>
										<td><input type="text" id="FORM_NAME" name="FORM_NAME" style=" width:100%;"></td>
									</tr>
									<tr>
									<th style="text-align: center;">파일위치</th>
									<td><input type="file" id="FILENAME_form" name="FILENAME_form"></td>
<!--  									<td>
										<button type="button" class="btn btn-primary" onclick="return formUpload('form');" id="formUploadBtn_form">업로드</button>
									</td> 
 -->									</tr>
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
						<div class="panel-body text-center">
							<button type="button" class="btn btn-primary" onclick="return insertForm();" id="insertFormBtn">서식 등록</button>
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
<!-- 서식등록 -->
<script type="text/javascript">
function insertForm(){
	if( $('#FORM_NAME').val() == '' ){
		alert("서식명을 입력하세요.");
		return false;
	}
	if( $('#CT_ID').val() == '' ){
		alert("구분를 선택하세요.");
		return false;
	}
	if($('#REG_USER').val()==''){
		alert("등록자를 입력하세요");
		return false;
	}
	
	/* ajax */
	var param = $("form[name=formForm]").serialize();
	
	 $.ajax({  
	   type: "POST",
	   url: "<c:url value='/formInsertOk.do'/>",
	   data: param,
	   success:function(data){
		   formUpload();
	    alert("서식이 등록되었습니다.");
	    btn = document.getElementById('insertFormBtn');
	    btn.innerText = '서식 등록완료';
	  },
	   error:function(request, status, error){
	    /* alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); */
	    alert("등록중 에러가 발생하였습니다.");
	    console.log('Error', error); 
	  }
	  });
}

function formUpload(param){
	var str_param = '';
	if( $('#FILENAME_' + param).val() == '' ){
		if(param == 'form'){
			str_param = '서식';
		alert(str_param + "을 선택하세요");
		return false;
	}
	
	/* ajax */
	var formData = new FormData($('#formForm')[0]);
	console.log("data : " + formData);
	$.ajax({ 
		type: "POST", 
		enctype: "multipart/form-data", // 필수 
		url: "<c:url value='/formUploadOk.do?PARAM='/>" + param,
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
}
</script>

<!-- <body>끝 -->
<%@include file="../main_bottom.jsp"%>