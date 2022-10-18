<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MunJoo_Project</title>
</head>
<body>
	<div class="container">
		<div class="con_title">
            <h1>Join</h1>
        </div>
        <form name="member" method="post" action="memberinsert.do" id="member">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> <!-- ハッキングを防ぐための -->
		<div class="join_write col_989">
                <div class="list_con">
                	<div>
                		<input type="checkbox" id="chkCtrl">全体同意
                	</div>
                		<h2>利用規約</h2>
                    	<textarea style="padding:18px; width:100%; height:100px;">グーグルサービス及び製品（以下「サービス」という。）をご利用いただきありがとうございます。 本約款は多様なグーグルサービスの利用に関してグーグルサービスを提供するグーグル株式会社(以下「グーグル」という)とこれを利用するグーグルサービス会員(以下「会員」という)または非会員との関係を説明し、また皆様のグーグルサービス利用に役立つ有益な情報を含んでいます。 Googleサービスを利用したり、Googleサービス会員として加入する場合、皆さんは本約款および関連運営ポリシーを確認または同意することになりますので、しばらくお時間を割いて注意深くご覧ください。
                    </textarea>
                    <div>
                    	<input type="checkbox" name="agree" id="agree1" value="y">同意します
                    </div>
                    	<h2>個人情報収集及び利用同意</h2>
                    	<textarea style="padding:18px; width:100%; height:100px;">グーグルサービス及び製品（以下「サービス」という。）をご利用いただきありがとうございます。 本約款は多様なグーグルサービスの利用に関してグーグルサービスを提供するグーグル株式会社(以下「グーグル」という)とこれを利用するグーグルサービス会員(以下「会員」という)または非会員との関係を説明し、また皆様のグーグルサービス利用に役立つ有益な情報を含んでいます。 Googleサービスを利用したり、Googleサービス会員として加入する場合、皆さんは本約款および関連運営ポリシーを確認または同意することになりますので、しばらくお時間を割いて注意深くご覧ください。
                    	</textarea>
                    <div>
                    	<input type="checkbox" name="agree" id="agree2" value="y">同意します
                    </div>
                    <p id="agreemsg" style="padding-bottom:30px;"></p>
                </div>
            <table class="table_write02">
                <colgroup>
                    <col width="160px">
                    <col width="auto">
                </colgroup>
                <tbody id="joinDataBody">
                    <tr>
                        <th><label for="username">Name</label></th>
                        <td>
                            <input type="text" name="userName" id="name"class="w300">
                            <span id="namemsg"></span>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="id">ID<span class="must"><b>必須入力</b></span></label></th>
                        <td>
                            <input type="text" name="userid" id="id" class="w300">
                            <span id="idmsg"></span>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="pw1">Password</label></th>
                        <td>
                            <input type="password" name="userpw" id="pw1" class="w300">
                            <p class="guideTxt"><span class="tc_point">英文（大文字区分）、数字、特殊文字の組み合わせ</span>で9~13文字で作成してください。</p>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="pw2">Password Check</label></th>
                        <td>
                            <input type="password" name="userpw2" id="pw2" class="w300">
                        </td>
                    </tr>
                   
					<tr>
                        <th><label for="tel">Phone<span class="must"><b>必須入力</b></span></label></th>
                        <td>
                            <input type="text" name="tel" id="phone" class="w300" >
                        </td>
                    </tr>
                    <tr>
                        <th><label for="email">Mail Address<span class="must"><b>必須入力</b></span></label></th>
                        <td>
                            <input type="text" name="email" id="email" class="w300">
                        </td>
                    </tr>
                    
                    <tr>
							<td colspan="2" style="text-align: center;">
								<input type="button" id="btn_ok" onclick="fn_save()" value="Join">
								<input type="button" onclick="history.back()" value="Back">
							</td>
					</tr>
                    
            </table>
            
        </div>
        </form>
	</div>
	<!-- end contents -->
	

<!-- 約款全体の同意functionを作成する予定 -->
	
	<script>
		function fn_save() {
			//有効性検査が終わったら
			if(!member.name.value){
				alert("名前を入力してください。");
				member.name.focus();
				return false;
			}
			
			if(!member.id.value){
				alert("IDを入力してください。");
				member.id.focus();
				return false;
			}
			
			if(!member.pw1.value){
				alert("パスワードを入力してください。");
				member.pw1.focus();
				return false;
			}
			
			if(!member.pw2.value){
				alert("パスワードを再入力してください。");
				member.pw2.focus();
				return false;
			}
			
			if(!member.phone.value){
				alert("電話番号を入力してください。");
				member.phone.focus();
				return false;
			}
			
			if(!member.email.value){
				alert("メールアドレスを入力してください。");
				member.email.focus();
				return false;
			}
		
			//サーバーに転送
			member.submit();
		}
	</script>
	
	
</body>
</html>