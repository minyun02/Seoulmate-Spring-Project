package com.seoulmate.home.vo;

public class HouseMatePagingVO {
	// 페이징 
	private int pageNum = 1; //현재 페이지 
	private int onePageNum = 4; //페이징 개수
	private int onePageRecode = 9; //한페이지당 레코드 수
	private int totalRecode; // 총 레코드 수
	private int totalPage; // 마지막페이지, 총 페이지 수 
	private int startPageNum = 1; //시작 페이지
	private int lastPageRecode = 9; //마지막페이지의 남은 레코드 수
	
	// 하우스, 메이트 필터
	private String addr;
	private String area;
	private int rent;
	private int deposit;
	private int m_gen;
	private int gender;

	// 메이트 매칭리스트
	private int pno;
	private String userid;
	private int m_gender; // 하우스의 희망성별
	
	
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
	public int getRent() {
		return rent;
	}
	public void setRent(int rent) {
		this.rent = rent;
	}
	public int getDeposit() {
		return deposit;
	}
	public void setDeposit(int deposit) {
		this.deposit = deposit;
	}
	public int getM_gen() {
		return m_gen;
	}
	public void setM_gen(int m_gen) {
		this.m_gen = m_gen;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}

	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getM_gender() {
		return m_gender;
	}
	public void setM_gender(int m_gender) {
		this.m_gender = m_gender;
	}
	
}
