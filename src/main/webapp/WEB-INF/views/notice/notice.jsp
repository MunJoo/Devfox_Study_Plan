<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../header.jsp" %>
    


	<div class="container">
	  <div class="search_wrap">
		<div class="record_group">
			<p>Total Bulletin<span>${pageMaker.total }</span>Case</p>
		</div>
		<div class="search_group">
			<form name="myform" method="get" action="/notice/notice.do" id="searchForm">
				<select name="type" class="select">
					<option value="">選択</option>
					<option value="T">タイトル</option>
					<option value="C">内容</option>
					<option value="W">著者</option>
					<option value="TC">タイトル+内容</option>
				</select>
				<input type="text" name="keyword" class="search_word">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
            	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
				<button class="btn_search" type="submit"><i class="fa fa-search"></i><span class="sr-only">検索ボタン</span></button>
			</form>
		</div>
	  </div> <!-- /search-->

	  <div class="board_list">
		<table class="board_table">
			<colgroup>
				<col width="10%">
				<col width="*">
				<col width="10%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			
			<thead>
				<tr>
					<th>番号</th>
					<th>タイトル</th>
					<th>著者</th>
					<th>作成日</th>
					<th>カウント</th>
				</tr>
			</thead>
			
			<tbody>
			<c:set var="num" value="${pageMaker.total - ((pageMaker.cri.pageNum-1) * 10)}"/>
			<c:forEach var="list" items="${list}">
				<tr>
					<td>${num}</td>
					<td class="title"><a href="/notice/notice_view.do?bno=${list.bno}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">${list.title}</a></td>					<td>${list.writer }</td>
					<td>
						<fmt:parseDate var="regdate" value="${list.regdate }" pattern="yyyy-MM-dd"/><!-- Stringから Dateタイプへ -->
						<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/><!-- 日の形を出歴 -->
					</td>
					<td>${list.viewcount}</td>
				</tr>
				<c:set var="num" value="${num-1}" />
			</c:forEach>
			</tbody>
		</table>

<!-- Pagination -->		
		<div class="paging">
			<c:if test="${pageMaker.prev }">
				<a href="${pageMaker.startPage-1}"><i class="fa  fa-angle-double-left"></i></a>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<a href="${num}" class="${pageMaker.cri.pageNum == num?'active':''}">${num}</a>
			</c:forEach>
			<c:if test="${pageMaker.next }">
				<a href="${pageMaker.endPage+1}"><i class="fa  fa-angle-double-right"></i></a>
			</c:if>
			
			<div>
				<sec:authorize access="isAuthenticated()"> <!-- ログインする人だけにボタンが見れる -->
					<a href="/notice/notice_write.do" class="btn_write">Write</a>
				</sec:authorize>
			</div>
	
			<form id="actionForm" action="notice.do" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<input type="hidden" name="type" value="${pageMaker.cri.type}">
				<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
			</form>
		</div> <!-- /Pagination -->
	  </div>
	</div> <!-- /contents -->

	
	
<!-- Script -->
	
	<script>
	
		$(function() {
			
			var actionForm = $("#actionForm");
			
			$(".paging > a").on("click", function(e){
				
				e.preventDefault();
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));//現在のページ番号の値を取得して転送しなさい
				actionForm.submit();
				
			})
			
			
			var searchForm = $("#searchForm");
			
			$("#searchForm button").on("click", function(e) {
				
				if(!searchForm.find("option:selected").val()){
					alert("検索の種類を選択してください。");
					return false;
				}
				if(!searchForm.find("input[name='keyword']").val()){
					alert("検索キーワード入力");
					return false;
				}
				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefault();
				
				searchForm.submit();
				
			})
			
		}); //function
		
	</script> <!-- /Script -->
	
	