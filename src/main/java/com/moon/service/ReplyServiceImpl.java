package com.moon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moon.domain.Criteria;
import com.moon.domain.ReplyVO;
import com.moon.mapper.ReplyMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired(required = false)
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.insert(vo);
	}
	
	@Override
	public ReplyVO get(long rno) {
		// TODO Auto-generated method stub
		return mapper.read(rno);
	}
	
	@Override
	public int remove(long rno) {
		// TODO Auto-generated method stub
		return mapper.delete(rno);
	}
	
	@Override
	public int modify(ReplyVO reply) {
		// TODO Auto-generated method stub
		return mapper.update(reply);
	}
	
	@Override
	public List<ReplyVO> getListPage(Criteria cri, long bno) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri, bno);
	}
	
	@Override
	public int getCountByBno(long bno) {
		// TODO Auto-generated method stub
		return mapper.getCountByBno(bno);
	}
	
	
}
