<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>


	<div class="container">
	  <div class="write_wrap">
	  <h2 class="sr-only">Modify</h2>
	  <form name="notice" method="post" action="notice_modify_pro.do" onsubmit="return check()">
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	  	<input type="hidden" name="bno" value="${nvo.bno}"> <!-- get방식 안됨...? -->
		<input type="hidden" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" name="amount" value="${cri.amount }">
			<table class="board_table">
				<colgroup>
					<col width="20%">
					<col width="*">
				</colgroup>
				<tbody>
					<tr class="first">
						<th>著者</th>
						<td><input type="text" name="writer" value="${nvo.writer}" readonly></td>
					</tr>
					<tr>
						<th>タイトル</th>
						<td><input type="text" name="title" value="${nvo.title}"></td>
					</tr>
					<tr>
						<th>内容</th>
						<td><textarea name="content" id="summernote" >${nvo.content}</textarea></td>
					</tr>
				</tbody>
			</table>
			<div class="btn_wrap">
				<input type="submit" value="セーブ" class="btn_ok">&nbsp;&nbsp;
				<input type="reset" value="書き直し" class="btn_reset">&nbsp;&nbsp;
				<input type="button" value="リスト" class="btn_list" onClick="location.href='notice.do';">
			</div>
		</form>
	  </div>
	</div> <!-- end contents -->
	
<!-- Script -->	
	<script>
		function check() {
			if(notice.writer.value=="") {
				alert("著者を入力してください。");
				notice.writer.focus();
				return false;
			}
			if(notice.title.value=="") {
				alert("タイトルを入力してください。");
				notice.title.focus();
				return false;
			}
			if(notice.content.value=="") {
				alert("内容を入力してください。");
				notice.contents.focus();
				return false;
			}
			return true;
		}
	</script> <!-- /Script -->
	
<!-- Summernote Script -->	
	<script>
		$(function() {
			
			//Summernote
			$('#summernote').summernote({
				height: 400,
				fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
				fontNamesIgnoreCheck : [ '맑은고딕' ],
				focus: true,

					callbacks: {//コールバック★サマーノート内にはコールバック機能がない  https://www.w3schools.com/jquery/jquery_callback.asp
					onImageUpload: function(files, editor, welEditable) {
				            for (var i = files.length - 1; i >= 0; i--) {//image 5つ挿入: files.length = image 挿入長(5)
				             sendFile(files[i], this);
				            //挿入したimageをsendFileメソッドに送るようにという
				            }
						}
					}

				});

				
				function sendFile(file, el) {
				var form_data = new FormData();
				
				       form_data.append('file', file);
				       $.ajax({
				         data: form_data,
				         type: "POST",
				         url: 'profileImage.do',//前にスラッシュしない！
				         cache: false,
				         contentType: false,
				         enctype: 'multipart/form-data',//添付があるとき
				         processData: false,
				         success: function(img_name) {
				           $(el).summernote('editor.insertImage', img_name);//開発者が作っておいたものだから触れない
				         }
				       });
				    }
		});
	</script> <!-- /Summernote Script -->		