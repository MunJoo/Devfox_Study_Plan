package com.moon.service;

import java.util.List;

import com.moon.domain.Criteria;
import com.moon.domain.MemberVO;
import com.moon.domain.NoticeVO;

public interface NoticeService {
	public void register(NoticeVO notice);
	
	public List<NoticeVO> getList();
	
	public List<NoticeVO> getListWithPaging(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public NoticeVO read(int bno);
	
	public boolean update(NoticeVO notice);
	
	public boolean delete(int bno);
	
	public NoticeVO nextPage(int bno);//次の文
	public NoticeVO prevPage(int bno);//前文
	 
	
	
}
