package com.seoulmate.home.vo;

public class MemberVO {
	private int no;
	private String userid;
	private String userpwd;
	private String username;
	
	private String tel;
	private String tel1;
	private String tel2;
	private String tel3;
	
	private String email;
	private String emailid;
	private String emaildomain;
	
	private String birth;
	
	private int gender;
	
	private String area="";
	private String aList[]=null;
	
	private String area1;
	private String area2;
	private String area3;
	
	private String regdate;
	private int grade; //1:일반, 2:프리미엄 
	
	private String profilePic;
	private String filename;
	
	private int reportCnt;
	private String state; // 일반, 블랙, 탈퇴 
	
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
	
	public String getUserpwd() {
		return userpwd;
	}
	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getTel() {
		tel=tel1+"-"+tel2+"-"+tel3;
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
		String[] t=tel.split("-");
		tel1=t[0];
		tel2=t[1];
		tel3=t[2];
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getEmail() {
		email=emailid+"@"+emaildomain;
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
		String e[]=email.split("@");
		emailid=e[0];
		emaildomain=e[1];
	}
	public String getEmailid() {
		return emailid;
	}
	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}
	public String getEmaildomain() {
		return emaildomain;
	}
	public void setEmaildomain(String emaildomain) {
		this.emaildomain = emaildomain;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
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
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getProfilePic() {
		return profilePic;
	}
	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}
	public int getReportCnt() {
		return reportCnt;
	}
	public void setReportCnt(int reportCnt) {
		this.reportCnt = reportCnt;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
}
