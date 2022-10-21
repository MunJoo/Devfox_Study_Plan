package com.moon.domain;

import lombok.Data;

@Data
public class NoticeVO {
	private int bno;
	private String userid; //로그인 한 유저를 writer에 저장하기 위한
	private String title;
	private String content;
	private String writer;//현재 로그인 한 유저의 id가 들어감 
	private String regdate;
	private int viewcount;
}
