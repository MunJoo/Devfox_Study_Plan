<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>


	<div class="container">
	  <div class="write_wrap">
	  <form name="notice" method="post" action="notice_write_pro.do" onsubmit="return check()">
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<table class="board_table">
				<colgroup>
					<col width="20%">
					<col width="*">
				</colgroup>
				<tbody>
					<tr class="first">
						<th>著者</th>
						<sec:authorize access="isAuthenticated()">
						<td><input type="text" name="writer" value="<sec:authentication property="principal.username"/>" readonly></td>
						</sec:authorize>
					</tr>
					<tr>
						<th>タイトル</th>
						<td><input type="text" name="title"></td>
					</tr>
					<tr>
						<th>内容</th>
						<td><textarea name="content"  id="summernote"></textarea></td>
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
		} //function fin
	</script> <!-- Script -->
	
	
<!-- Summernote Script -->	
	<script>
		$(function() {

		//Summernote
		$('#summernote').summernote({
         height: 400,
         fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
         fontNamesIgnoreCheck : [ '맑은고딕' ],
         focus: true,
         
	         callbacks: {
	         onImageUpload: function(files, editor, welEditable) {
		            for (var i = files.length - 1; i >= 0; i--) {
		             sendFile(files[i], this);
		             //挿入した画像をsendfileマスタードに送れ
		            }
	         	}
	         }

         });
           
         var csrfHeaderName = "${_csrf.headerName}";
         var csrfTokenValue = "${_csrf.token}";
         
         $(document).ajaxSend(function(e,xhr,option){
            xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
         })
         
         
        function sendFile(file, el) {
         
            data = new FormData();
            data.append("file", file);
      
            console.log(file);
            $.ajax({
               data : data,
               type : "POST",
               url : "/pull/upload",
               contentType : false,
               enctype : 'multipart/form-data',
               processData : false,
               success : function(data) {
                  if(data){
                     console.log("Succeed");
                     $(el).summernote('editor.insertImage', data.url);
                  }
                  else{
                     
                  }
               }
            });
         }
			
			
		}); // function fin
</script> <!-- /Summernote Script -->