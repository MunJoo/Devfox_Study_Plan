package com.moon.domain;

import lombok.Data;

@Data
public class Criteria {
	//페이징 필요한 변수 1)페이지 번호 2)한 페이지 레코드 개수
	private int pageNum;
	private int amount;
	
	private String type;// 제목, 내용
	private String keyword;// 검색 내용
	
	public Criteria() {//객체가 호출되면 생성자 호출, 기본적으로 pageNum에는 1, amount 에는 10이 저장된다
		this(1, 10);//같은 클래스 내의 매개변수가 있는 생성자 호출
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}
