package com.moon.mapper;

import java.util.List;

import com.moon.domain.Criteria;
import com.moon.domain.MemberVO;
import com.moon.domain.NoticeVO;

public interface NoticeMapper {
	public void insertSelectKey(NoticeVO notice);
	public List<NoticeVO> getList();
	public List<NoticeVO> getListWithPaging(Criteria cri);
	public int getTotalCount(Criteria cri);//총 게시글 수
	public NoticeVO read(int bno);
	public int update(NoticeVO notice);//공지사항 수정
	public int delete(int bno);// 공지사항 삭제
	public void readcount(int bno);//공지사항 조회수
	public NoticeVO nextPage(int bno);//다음글
	public NoticeVO prevPage(int bno);//이전글
}


