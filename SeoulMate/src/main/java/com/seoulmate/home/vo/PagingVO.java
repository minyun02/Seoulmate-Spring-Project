package com.seoulmate.home.vo;

public class PagingVO {
	private String searchKey; 	//검색키 
	private String searchWord;  //검색어
	private String grade; // 회원관리 등급 / 신고관리 게시판
	private String state; // 회원관리 상태 / 신고관리 처리상태
	
	// 페이징 
	private int pageNum = 1; //현재 페이지 
	private int onePageNum = 4; //페이징 개수
	private int onePageRecode = 10; //한페이지당 레코드 수
	private int totalRecode; // 총 레코드 수
	private int totalPage; // 마지막페이지, 총 페이지 수 
	private int startPageNum = 1; //시작 페이지
	private int lastPageRecode = 10; //마지막페이지의 남은 레코드 수
	
	// 하우스, 메이트 필터
	private String addr;
	private String area;
	private String rent;
	private String diposit;
	private String m_gen;
	private String gender;
	
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
	
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
		//시작페이지 번호 계산
		startPageNum = ((pageNum-1) / onePageNum * onePageNum)+1;
	}
	public int getOnePageNum() {
		return onePageNum;
	}
	public void setOnePageNum(int onePageNum) {
		this.onePageNum = onePageNum;
	}
	public int getOnePageRecode() {
		return onePageRecode;
	}
	public void setOnePageRecode(int onePageRecode) {
		this.onePageRecode = onePageRecode;
	}
	public int getTotalRecode() {
		return totalRecode;
	}
	public void setTotalRecode(int totalRecode) {
		this.totalRecode = totalRecode;
		
		//총 페이지수 계산
		totalPage = (int)Math.ceil(totalRecode/(double)onePageRecode);
		//마지막 페이지에 레코드 수 
		if(totalRecode%onePageRecode == 0) {
			lastPageRecode = onePageRecode;
		}else {
			lastPageRecode = totalRecode%onePageRecode; 
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
	public int getLastPageRecode() {
		return lastPageRecode;
	}
	public void setLastPageRecode(int lastPageRecode) {
		this.lastPageRecode = lastPageRecode;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getRent() {
		return rent;
	}
	public void setRent(String rent) {
		this.rent = rent;
	}
	public String getDiposit() {
		return diposit;
	}
	public void setDiposit(String diposit) {
		this.diposit = diposit;
	}
	public String getM_gen() {
		return m_gen;
	}
	public void setM_gen(String m_gen) {
		this.m_gen = m_gen;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
}
