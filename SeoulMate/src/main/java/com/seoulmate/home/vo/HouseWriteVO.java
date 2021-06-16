package com.seoulmate.home.vo;

public class HouseWriteVO {
	private int no;
	private int pno;
	private String userid;
	private String addr;
	private String housename;
	
	private String filename; //사진 업로드
	private String filename2;
	private String filename3;
	private String filename4;
	private String filename5;
	
	private String housepic1;
	private String housepic2; 
	private String housepic3;
	private String housepic4;
	private String housepic5;
	private int room;
	private int bathroom;
	private int nowpeople;
	private int searchpeople;
//	private String publicfacility;
	private String publicfacility[]; //공용시설
	private String publicfacilityStr="";  //공용시설 배열 값 문자열
	
	private String writedate;
	private String enddate;
	private String housestate; // 모집중, 매칭 완료, 기간 만료, 비공개
	private String houseprofile;
	private int score;
	
	// index 최신 쉐어하우스 목록에서 
	// 각 쉐어하우스의 제일 저렴한 보증금,월세 구할때
	private int deposit;
	private int rent;
	private int m_gender;
	
	//admin page에서 사용하기 위함.  
	private int grade;  // 1:일반, 2:프리미엄 
	private int reportNum; //신고수
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
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
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getHousename() {
		return housename;
	}
	public void setHousename(String housename) {
		this.housename = housename;
	}
	public String getHousepic1() {
		return housepic1;
	}
	public void setHousepic1(String housepic1) {
		this.housepic1 = housepic1;
	}
	public String getHousepic2() {
		return housepic2;
	}
	public void setHousepic2(String housepic2) {
		this.housepic2 = housepic2;
	}
	public String getHousepic3() {
		return housepic3;
	}
	public void setHousepic3(String housepic3) {
		this.housepic3 = housepic3;
	}
	public String getHousepic4() {
		return housepic4;
	}
	public void setHousepic4(String housepic4) {
		this.housepic4 = housepic4;
	}
	public String getHousepic5() {
		return housepic5;
	}
	public void setHousepic5(String housepic5) {
		this.housepic5 = housepic5;
	}
	public int getRoom() {
		return room;
	}
	public void setRoom(int room) {
		this.room = room;
	}
	public int getBathroom() {
		return bathroom;
	}
	public void setBathroom(int bathroom) {
		this.bathroom = bathroom;
	}
	public int getNowpeople() {
		return nowpeople;
	}
	public void setNowpeople(int nowpeople) {
		this.nowpeople = nowpeople;
	}
	public int getSearchpeople() {
		return searchpeople;
	}
	public void setSearchpeople(int searchpeople) {
		this.searchpeople = searchpeople;
	}

	public String[] getPublicfacility() {
		return publicfacility;
	}
	public void setPublicfacility(String[] publicfacility) {
		this.publicfacility = publicfacility;
		for(String i: publicfacility) { //배열의 값을 Str 문자열로
			publicfacilityStr += i+"/";
		}
	}
	public String getPublicfacilityStr() {
		return publicfacilityStr;
	}
	public void setPublicfacilityStr(String publicfacilityStr) {
		this.publicfacilityStr = publicfacilityStr;
		publicfacility = publicfacilityStr.split("/");
	}
	
//	public String getPublicfacility() {
//		return publicfacility;
//	}
//	public void setPublicfacility(String publicfacility) {
//		this.publicfacility = publicfacility;
//	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getHousestate() {
		return housestate;
	}
	public void setHousestate(String housestate) {
		this.housestate = housestate;
	}
	public String getHouseprofile() {
		return houseprofile;
	}
	public void setHouseprofile(String houseprofile) {
		this.houseprofile = houseprofile;
	}
	public int getDeposit() {
		return deposit;
	}
	public void setDeposit(int deposit) {
		this.deposit = deposit;
	}
	public int getRent() {
		return rent;
	}
	public void setRent(int rent) {
		this.rent = rent;
	}
	public int getM_gender() {
		return m_gender;
	}
	public void setM_gender(int m_gender) {
		this.m_gender = m_gender;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getReportNum() {
		return reportNum;
	}
	public void setReportNum(int reportNum) {
		this.reportNum = reportNum;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	
	
	
}
