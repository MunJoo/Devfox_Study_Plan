<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../header.jsp" %>

<div class="sub_title">
		<div class="container">
		</div><!-- container end -->
	</div>

	<div class="container">
			<div class="member_boxL">
                <div class="login_form">
                    <form id="login" name="login" action="/login">
                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <div class="fl_clear">
                    	<label for="id">ID</label>
                    	<input name="username" id="id" type="text">
                    </div>
                    <div class="fl_clear">
                    	<label for="pw">Password</label>
                    	<input name="password" id="pw" type="password">
                    </div>
                    <a class="btn_login btn_Blue" href="javascript:fn_login();">Login</a>
                    </form>
                </div>
            </div>
	  
	</div> <!-- end contents -->
	

<!-- 約款全体の同意functionを作成する予定 -->
	
 	<script>
		function fn_login(){
			
			if(login.id.value==""){
				alert("IDを入力してください。");
				login.id.focus();
				return false;
			}
			if(login.pw.value==""){
				alert("パスワードを入力してください。");
				login.pw.focus();
				return false;
			}
			
			var form = document.login;//フォーム名loginを変数に保存（扱えるようになる）
			form.method='post';
			form.action="/login";// /login.do NOOOOO!
			form.submit();
		}
	</script>

	
</body>
</html>