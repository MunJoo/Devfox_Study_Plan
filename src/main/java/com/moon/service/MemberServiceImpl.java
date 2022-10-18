package com.moon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moon.domain.MemberVO;
import com.moon.mapper.MemberMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	@Autowired(required = false) //객체로 쓰겠다를 알려주는 어노테이션
	private MemberMapper mapper;
	
	
	
	@Override
	public void regist(MemberVO member) {
		mapper.insert(member);
		mapper.insert_auth(member);
		
	}
	
	@Override
	public int idCheck(String id) {
		// TODO Auto-generated method stub
		return mapper.idCheck(id);
	}
}

