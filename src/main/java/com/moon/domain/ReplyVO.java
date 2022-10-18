package com.moon.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ReplyVO {
	private long rno;
	private long bno;
	
	private String reply;
	private String replyer;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone = "Asia/Tokyo") //JasonFormat=JSONを変換する時に使用
	private Date replyDate;
}
