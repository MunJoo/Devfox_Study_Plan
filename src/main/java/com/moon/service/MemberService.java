package com.moon.service;

import com.moon.domain.MemberVO;

public interface MemberService {
	public void regist(MemberVO member);
	public int idCheck(String id);
}
