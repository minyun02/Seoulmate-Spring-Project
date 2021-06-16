package com.seoulmate.home.vo;

public class LikeMarkVO {
	private int lno; // 찜목록번호 
	private int no;  //글쓴번호 (하우스, 메이트) 
	private int pno;  //글쓴번호의 성향번호
	private String userid; // 찜목록 누른 유저아이디
	private String category; // 하우스 or 메이트
	private String likedate; //찜목록누른 날짜 
	public int getLno() {
		return lno;
	}
	public void setLno(int lno) {
		this.lno = lno;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getLikedate() {
		return likedate;
	}
	public void setLikedate(String likedate) {
		this.likedate = likedate;
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}

}
