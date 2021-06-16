package com.seoulmate.home.vo;

public class ReportVO {
	private int num; //신고접수번호
	private int no; //신고 글 번호
	private String category;
	private String reportid; //신고자
	private String userid; //신고당하는사람
	private String reportcategory;
	private String reportcontent;
	private String reportdate;
	private String state;
	
	private String vState;  // 해당 게시글 공개 상태 여부
	private String bState;	// 해당 멤버 블랙리스트 등록 여부
	
	//채팅방용 프로필 사진
	private String profilepic1;
	private String profilepic2;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getReportid() {
		return reportid;
	}
	public void setReportid(String reportid) {
		this.reportid = reportid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getReportcategory() {
		return reportcategory;
	}
	public void setReportcategory(String reportcategory) {
		this.reportcategory = reportcategory;
	}
	public String getReportcontent() {
		return reportcontent;
	}
	public void setReportcontent(String reportcontent) {
		this.reportcontent = reportcontent;
	}
	public String getReportdate() {
		return reportdate;
	}
	public void setReportdate(String reportdate) {
		this.reportdate = reportdate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getvState() {
		return vState;
	}
	public void setvState(String vState) {
		this.vState = vState;
	}
	public String getbState() {
		return bState;
	}
	public void setbState(String bState) {
		this.bState = bState;
	}
	public String getProfilepic1() {
		return profilepic1;
	}
	public void setProfilepic1(String profilepic1) {
		this.profilepic1 = profilepic1;
	}
	public String getProfilepic2() {
		return profilepic2;
	}
	public void setProfilepic2(String profilepic2) {
		this.profilepic2 = profilepic2;
	}
}
