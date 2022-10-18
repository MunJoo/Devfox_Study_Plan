package com.moon.mapper;

import com.moon.domain.MemberVO;

public interface MemberMapper {
	
	public int idCheck(String id);
	public void insert(MemberVO member);
	public void insert_auth(MemberVO member);
	public MemberVO read(String userid);
}