package com.seoulmate.home.vo;

public class ApplyInviteVO {
	private int aino; // aisq 
	private int no; // 글번호 (하우스 번호만 들어간다.) 
	private String userid; // mate의 유저 아이디만 들어간다. 
	private String aidate; // 신청,초대 일자
	private String state; //신청인지 초대인지 확인  '신청' or '초대'
	private String confirm; //승인, 미승인
	private String msg; // 보낸초대 or 받은초대 or 보낸신청 or 보낸초대 / 팝업확인용 
	
	
	public int getAino() {
		return aino;
	}
	public void setAino(int aino) {
		this.aino = aino;
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
	public String getAidate() {
		return aidate;
	}
	public void setAidate(String aidate) {
		this.aidate = aidate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getConfirm() {
		return confirm;
	}
	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}
	
}
