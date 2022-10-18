package com.moon.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class PageVO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;// レコードの全数
	private Criteria cri;
	
	 public PageVO(Criteria cri, int total) {
	      this.cri = cri;
	      this.total=total;
	      this.endPage = (int)(Math.ceil(cri.getPageNum() /10.0)*10);//Math.ceil =切り上げ
	      this.startPage = this.endPage - 9;
	      int realEnd = (int)(Math.ceil((total * 1.0)/cri.getAmount()));
	      if(realEnd < this.endPage) {
	    	  this.endPage = realEnd;
	      }
	      this.prev = this.startPage >1;
	      this.next = this.endPage < realEnd;
	      
	 }
}
