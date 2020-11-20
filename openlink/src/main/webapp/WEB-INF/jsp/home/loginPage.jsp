<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="main_top.jsp"%>
<!-- <body>시작 -->
<script type="text/javascript">
function check(){
	//alert('1');
	if( $('#userID').val() == '' ){
		alert("아이디를 입력하세요");
		return false;
	}
	if( $('#userPW').val() == '' ){
		alert("비밀번호를 입력하세요");
		return false;
	}
	return true;
}
</script>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4 text-center">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="<c:url value='/loginAction.do'/>">
					<h3 style="text-align: center;">로그인 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="user_id" id="userID" maxlength="30">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="user_pw" id="userPW" maxlength="30">
					</div>
					<input class="form-check-input" type="checkbox" name="AUTO_LOGIN" value="yes">자동로그인<br><br>
					<button type="submit" class="btn btn-primary form-control" onclick="return check();">로그인</button>
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
<!-- <body>끝 -->
<%@include file="main_bottom.jsp"%>