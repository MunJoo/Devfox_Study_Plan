<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>



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
						<!-- <sec:authentication property="principal.member.userName" var="pinfo"/><!-- ログインした時  -->
							<!--<c:if test="${pinfo eq nvo.writer}"> -->
								<a href="notice_modify.do?bno=${nvo.bno}&pageNum=${cri.pageNum}&amount=${cri.amount}">修整</a>
								<a href="notice_delete.do?bno=${nvo.bno}" onClick="return confirm('削除しますか?')">削除</a>
							<!--</c:if> -->
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
			</div>
			
		</div>
		

	</div>

	<!-- end contents -->
	
	
	<!-- 댓글 스크립트 할 곳 -->
