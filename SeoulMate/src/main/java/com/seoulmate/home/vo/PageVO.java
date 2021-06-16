package com.seoulmate.home.vo;

public class PageVO {
	private int pageNum = 1; //현재페이지
	private int onePageNum = 5; //한페이지당 나오는 페이지 번호 수
	
	private int totalRecord;	//총 레코드 수 
	private int totalPage;		//마지막 페이지(총 페이지 수)
	private int startPageNum = 1;	//시작페이지
	
	private int lastPageRecord; //마지막 페이지의 남은 레코드 수

	//커뮤니티용	
	private String category;
	private int commOnePageRecord = 15;// 한페이지당 레코드 수
	private String searchKey;
	private String searchWord;
	
	//다음글 이전글
	private int prevNo;
	private int nextNo;
	
	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
		
		//시작페이지 번호를 계산
		startPageNum = (pageNum-1)/onePageNum*onePageNum+1;
	}

	public int getOnePageNum() {
		return onePageNum;
	}

	public void setOnePageNum(int onePageNum) {
		this.onePageNum = onePageNum;
	}

	public int getCommOnePageRecord() {
		return commOnePageRecord;
	}

	public void setCommOnePageRecord(int onePageRecord) {
		this.commOnePageRecord = onePageRecord;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		
		//총 레코드수를 이용하여 총페이지수를 계산
		totalPage = (int)Math.ceil(totalRecord/(double)commOnePageRecord);

		//마지막페이지 레코드 수
		if(totalRecord%commOnePageRecord==0) {
			lastPageRecord = commOnePageRecord;
		}else {
			lastPageRecord = totalRecord%commOnePageRecord; //마지막페이지의 남은 레코드 수
		}
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getStartPageNum() {
		return startPageNum;
	}

	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}

	public int getLastPageRecord() {
		return lastPageRecord;
	}

	public void setLastPageRecord(int lastPageRecord) {
		this.lastPageRecord = lastPageRecord;
	}

	public String getSearchKey() {
		return searchKey;
	}

	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getPrevNo() {
		return prevNo;
	}

	public void setPrevNo(int prevNo) {
		this.prevNo = prevNo;
	}

	public int getNextNo() {
		return nextNo;
	}

	public void setNextNo(int nextNo) {
		this.nextNo = nextNo;
	}
}
