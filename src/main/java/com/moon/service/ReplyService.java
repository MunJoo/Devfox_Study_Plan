package com.moon.service;

import java.util.List;

import com.moon.domain.Criteria;
import com.moon.domain.ReplyVO;

public interface ReplyService {
	public int register(ReplyVO vo); 
	public ReplyVO get(long rno);
	public int remove(long rno);
	public int modify(ReplyVO reply);
	public List<ReplyVO> getListPage(Criteria cri, long bno);
	public int getCountByBno(long bno);
}
