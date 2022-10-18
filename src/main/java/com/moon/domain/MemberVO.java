package com.moon.domain;

import java.util.List;

import lombok.Data;


@Data
public class MemberVO {
	
	public MemberVO() {
		
	}
	
	private String userid;
	private String userpw;
	private String userName;
	private String tel;
	private String email;
	private String enable;
	
	private List<Member_authVO> authList;

	
}