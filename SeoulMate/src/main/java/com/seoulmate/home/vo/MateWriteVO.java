package com.seoulmate.home.vo;

public class MateWriteVO {
	private int no;
	private int pno;
	private String userid;
	
	private String area="";
	private String aList[]=null;
	
	private String area1;
	private String area2;
	private String area3;
	
	private String filename;
	
	private String matePic1;
	private String matePic2;
	private String matePic3;
	private int deposit;
	private int rent;
	private String enterdate;
	private String minStay;
	private String maxStay;
	private String writedate;
	private String enddate;
	private String matestate;
	private String mateProfile;
	
	// index에서 필요한 성별, 생년월일 정보
	private int gender;
	private String birth;
	
	//admin page에서 사용하기 위함.  
	private int grade;  // 1:일반, 2:프리미엄 
	private int reportNum; //신고수
	private String username;
	
	private int score;
	
	private int age;
	private int m_now; 
	
	private ListVO listVO;
	
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
	public String getArea() {
//		area="";
//		if(area1!=null && !area1.equals("")) {
//			area+=area1+"/";
//		}
//		if(area2!=null && !area2.equals("")) {
//			area+=area2+"/";
//		}
//		if(area3!=null && !area3.equals("")) {
//			area+=area3;
//		}
		return area;
	}
	public void setArea(String area) {
		this.area = area;
		if(area!=null) {
			aList=area.split("/");
		}
	}
	public String getArea1() {
		if(aList!=null && aList.length>=1) {
			area1=aList[0];
		}
		return area1;
	}
	public void setArea1(String area1) {
		this.area1 = area1;
	}
	public String getArea2() {
		if(aList!=null && aList.length>=2) {
			area2=aList[1];
		}
		return area2;
	}
	public void setArea2(String area2) {
		this.area2 = area2;
	}
	public String getArea3() {
		if(aList!=null && aList.length>=3) {
			area3=aList[2];
		}
		return area3;
	}
	public void setArea3(String area3) {
		this.area3 = area3;
	}
	public String getMatePic1() {
		return matePic1;
	}
	public void setMatePic1(String matePic1) {
		this.matePic1 = matePic1;
	}
	public String getMatePic2() {
		return matePic2;
	}
	public void setMatePic2(String matePic2) {
		this.matePic2 = matePic2;
	}
	public String getMatePic3() {
		return matePic3;
	}
	public void setMatePic3(String matePic3) {
		this.matePic3 = matePic3;
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
	public String getEnterdate() {
		return enterdate;
	}
	public void setEnterdate(String enterdate) {
		this.enterdate = enterdate;
	}
	public String getMinStay() {
		return minStay;
	}
	public void setMinStay(String minStay) {
		this.minStay = minStay;
	}
	public String getMaxStay() {
		return maxStay;
	}
	public void setMaxStay(String maxStay) {
		this.maxStay = maxStay;
	}
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
	public String getMatestate() {
		return matestate;
	}
	public void setMatestate(String matestate) {
		this.matestate = matestate;
	}
	public String getMateProfile() {
		return mateProfile;
	}
	public void setMateProfile(String mateProfile) {
		this.mateProfile = mateProfile;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String[] getaList() {
		return aList;
	}
	public void setaList(String[] aList) {
		this.aList = aList;
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
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public int getM_now() {
		return m_now;
	}
	public void setM_now(int m_now) {
		this.m_now = m_now;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public ListVO getListVO() {
		return listVO;
	}
	public void setListVO(ListVO listVO) {
		this.listVO = listVO;
	}
	
}
