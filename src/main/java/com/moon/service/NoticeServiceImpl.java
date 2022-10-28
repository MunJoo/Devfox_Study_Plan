package com.moon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moon.domain.Criteria;
import com.moon.domain.MemberVO;
import com.moon.domain.NoticeVO;
import com.moon.mapper.NoticeMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService{
	
	
	@Autowired(required = false)
	private NoticeMapper mapper;
	
	@Override
	public void register(NoticeVO notice) {
		
		mapper.insertSelectKey(notice);
	}
	
	@Override
	public List<NoticeVO> getList() {
		
		return mapper.getList();
	}
	
	@Override
	public List<NoticeVO> getListWithPaging(Criteria cri) {
		
		System.out.println("hey");
		return mapper.getListWithPaging(cri);
		
	}
	
	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public NoticeVO read(int bno) {
		mapper.readcount(bno);
		return mapper.read(bno);
	}
	
	
	@Override
	public boolean update(NoticeVO notice) {
		return mapper.update(notice) == 1;
	}
	
	@Override
	public boolean delete(int bno) {
		return mapper.delete(bno) == 1;
	}
	
	@Override
	public NoticeVO nextPage(int bno) {
		return mapper.nextPage(bno);
	}
	
	@Override
	public NoticeVO prevPage(int bno) {
		return mapper.prevPage(bno);
	}
	
	
	
	
}//
