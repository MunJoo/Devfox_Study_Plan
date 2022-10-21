<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<script src="/resources/js/reply.js"></script>


	<div class="container">
		<div class="board_view">
			<h2>${nvo.title }</h2>
			<p class="info"><span class="user">${nvo.writer }
			</span> | <fmt:parseDate var="regdate" value="${nvo.regdate }" pattern="yyyy-MM-dd"/><!-- fmt:parseDate : StringからDateタイプに -->
						<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/> | <i class="fa fa-eye"></i> ${nvo.viewcount}</p>
			<div class="board_body">
				${nvo.content }
			</div>
			
			<div class="prev_next">
			<c:if test="${prevVO != null}"><!-- 前文があれば -->
				<a href="notice_view.do?bno=${prevVO.bno}&pageNum=${cri.pageNum}&amount=${cri.amount}" class="btn_prev">
					<i class="fa fa-angle-left"></i>
					<span class="prev_wrap">
						<strong>前文</strong><span>${prevVO.title}</span>
					</span>
				</a>
			</c:if>
				<div class="btn_3wrap">
					<a href="notice.do?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">リスト</a><!-- 見たページに戻るように -->
					<sec:authorize access="isAuthenticated()"><!-- ログインしたのか -->
						 <sec:authentication property="principal.username" var="pinfo"/><!-- ログインした時  -->
							<c:if test="${pinfo == nvo.userid}">
								<a href="notice_modify.do?bno=${nvo.bno}&pageNum=${cri.pageNum}&amount=${cri.amount}">修整</a>
								<a href="notice_delete.do?bno=${nvo.bno}" onClick="return confirm('削除しますか?')">削除</a>
							</c:if> 
						</sec:authorize>
				</div>
			<c:if test="${nextVO != null }">
				<a href="notice_view.do?bno=${nextVO.bno}&pageNum=${cri.pageNum}&amount=${cri.amount}" class="btn_next">
					<span class="next_wrap">
						<strong>次の文</strong><span>${nextVO.title}</span>
					</span>
					<i class="fa fa-angle-right"></i>
				</a>
			</c:if>
			</div> <!-- /Prev, Next -->
		</div>
	</div> <!-- end contents -->

	
	<!-- Comment Part -->
	<div class="container" style="margin-top:60px;">
		<div class="row">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>Reply
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New REPLY</button>
			</div>
		</div>
		<div class="row">
			<ul class="chat">
				<li class="left clearfix" data-rno="12">
					<div>
						<strong>User00</strong>
						<small class="pull-right">2022-01-12</small>
					</div>
					<p>댓글 확인 중</p>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
	      </div>
	      <div class="modal-body">
	        <div class="form-group">
	        	<label>Reply</label>
	        	<input class="form-control" name="reply" value="New Reply">
	        </div>
	         <div class="form-group">
	        	<label>Replyer</label>
	        	<input class="form-control" name="replyer" value="replyer" readonly>
	        </div>
	         <div class="form-group">
	        	<label>Reply Date</label>
	        	<input class="form-control" name="replydate" value="" readonly>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
	        <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
	        <button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
	        <button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Comment Script-->
	<script>
      $(function() {
         
         var bnoValue = '<c:out value="${nvo.bno}"/>';
         
         var replyUL = $(".chat");
         showList(1);
         
         function showList(page){
             replyService.getList({bno:bnoValue,page:page||1}, function(list){
                var str = "";
                if(list == null || list.length==0){
                   replyUL.html(str);
                   return;
                }//if fin
                for(var i=0, len=list.length || 0; i<len; i++){
                   str += "<li class='left clerfix' data-rno='"+list[i].rno+"'>";
                   str += "<div><div class='header'><Strong class='primary-font'>"+list[i].replyer+"</strong>";
                   str += "<small class='pull-right text-muted'>"+list[i].replyDate+"</small>";
                   str += "<p>"+list[i].reply+"</p></div><li>";
                }//for fin
                replyUL.html(str);
             });//getList(function{})
          }//showList(page)
         
         
         var modal = $(".modal");
         
         var modalInputReply = modal.find("input[name='reply']");
         var modalInputReplyer = modal.find("input[name='replyer']");
         var modalInputReplyDate = modal.find("input[name='replydate']");
         
         var modalModBtn = $("#modalModBtn");
         var modalRemoveBtn = $("#modalRemoveBtn");
         var modalRegisterBtn = $("#modalRegisterBtn");
         
         var replyer = null;
         
         <sec:authorize access="isAuthenticated()">
         	replyer = '<sec:authentication property="principal.username"/>';
         </sec:authorize>
         
         //スプリングセキュリティを利用する場合、csrfトークンを一緒に伝送するようにしなければならない
         var csrfHeaderName = "${_csrf.headerName}";
         var csrfTokenValue = "${_csrf.token}";
         
         $("#modalCloseBtn").on("click", function(e){
            modal.modal("hide");
         })
         
         $("#addReplyBtn").on("click", function(e){
        	if(replyer==null){
        		alert("ログインしてください");
        		location.href='/member/login.do';
        	}else{
        		 modal.find("input").val("");
                 modalInputReplyDate.closest("div").hide();
                 modal.find("input[name='replyer']").val(replyer);
                 modal.find("button[id != 'modalCloseBtn']").hide();
                 modalRegisterBtn.show();
                 $(".modal").modal("show");
        	}
           
         })
         
	//スプリングセキュリティが適用されれば、post、put、patch、deleteのような方式でデータを伝送する場合には、
	//必ず追加的にtokenのようなヘッダー情報を追加してcsrfトークン値を伝達するように修正しなければならない。
	//ajaxはJavaScriptを利用するため、ブラウザではcsrfトークンと関連した値を変数として宣言し、転送時に含める。
         
         $(document).ajaxSend(function(e, xhr, options){
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
         })
         
         modalRegisterBtn.on("click", function(e){
            var reply = {
                  reply:modalInputReply.val(),
                  replyer:modalInputReplyer.val(),
                  bno:bnoValue
            }
            
            replyService.add(reply, function(result){
            alert(result);
               modal.find("input").val("");
               modal.modal("hide");
               showList(1);
            })
         })
         
        //コメントliクリックしたとき、モーダルに該当するコメント内容、作成者、日付を出力
         $(".chat").on("click", "li", function(e){
        	 var rno = $(this).data("rno");//liにdata-rnoの値（コメント番号）をインポートする
        	 replyService.get(rno, function(reply){
        		 modalInputReply.val(reply.reply);
        		 modalInputReplyer.val(reply.replyer);
        		 modalInputReplyDate.val(reply.replyDate);
        		 modal.data("rno", reply.rno);
        		 
        		 modal.find("button[id != 'modalCloseBtn']").hide();
        		 modalModBtn.show();
        		 modalRemoveBtn.show();
        		 
        		 $(".modal").modal("show");
        	 })
         })
         
        //MODIFY
         modalModBtn.on("click", function(e){
        	 var originalReplyer = modalInputReplyer.val();
        	 
        	 if(!replyer){
        		 alert("ログイン後に修正可能");
        		 modal.modal("hide");
        		 return;
        	 }
        	 
        	 
        	 if(replyer != originalReplyer){
        		 alert("自分が作成したコメントのみ修正可能");
        		 modal.modal("hide");
        		 return;
        	 }
        	 var reply = {
        			 rno:modal.data("rno"), 
        			 reply:modalInputReply.val(),
        			 replyer:originalReplyer
        			 };
        	//alert(reply.reply);
        	 replyService.update(reply, function(result){
        		 modal.modal("hide");
        		 showList(1);
        	 })
         })
         
         //REMOVE
         modalRemoveBtn.on("click", function(e){
        	 var originalReplyer = modalInputReplyer.val();
        	 
        	 if(!replyer){
        		 alert("ログイン後に削除可能");
        		 modal.modal("hide");
        		 return;
        	 }
        	
        	 if(replyer != originalReplyer){
        		 alert("自分が作成したコメントのみ削除可能");
        		 modal.modal("hide");
        		 return;
        	 }
        	 var rno = modal.data("rno"); //css data-rno("12")
        	 replyService.remove(rno, originalReplyer, function(result){
        		 modal.modal("hide");
        		 showList(1);
        	 })
         })
         
      });
   </script>
   
