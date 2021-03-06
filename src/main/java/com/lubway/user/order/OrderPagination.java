package com.lubway.user.order;

import org.springframework.stereotype.Repository;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Repository
public class OrderPagination {
	private int rownum;
	private int listSize=10;
	private int rangeSize=10;
	private int page;
	private int range;
	private int listCnt;
	private int pageCnt;
	private int startPage;
	private int startList;
	private int endPage;
	private boolean prev;
	private boolean next;
	private String id;
	private String order_type;
	
	public void pageInfo(int page, int range, int listCnt) {

		this.page = page;
		this.range = range;
		this.listCnt = listCnt;

		//전체 페이지수 
		this.pageCnt = (int) Math.ceil((double)listCnt/listSize);
		
		//시작 페이지
		this.startPage = (range-1) * rangeSize + 1 ;

		//끝 페이지
		this.endPage = range * rangeSize;

		//게시판 시작번호
		this.startList = (page-1) * listSize;

		if (this.endPage > this.pageCnt) {
			this.endPage = this.pageCnt;
		}
	}
	
}
