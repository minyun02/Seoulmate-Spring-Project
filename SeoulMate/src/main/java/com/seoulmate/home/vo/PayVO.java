package com.seoulmate.home.vo;

public class PayVO {
	private int no;				//paysq
	private String userid;		
	private String username;
	private String imp_uid;		// 고유 결제 아이디
	private String merchant_uid; // 주문번호 
	private int amount;	//결제완료된 금액
	private int amountCard;
	private int amountCash;
	private int amountRefund;
	private String payStart;	//결제일 
	private String payEnd;		//결제 종료일 (결제일로부터 한달) 
	private String payMethod; 	//결제수단 
	private String refund; 		// 환불날짜 (null) 
	
	private int payMonth; //결제 체크한 개월수 
	
	private String selectYearMonthDate; // 년, 월, 일 선택 
	private String selectStartDate;  //보여줄 기간 선택    2021.02 ~ 2021.03 까지 만 출력.. 이런거처럼 
	private String selectEndDate;	//보여줄 기간 선택 

	private String orderCondition = "no"; //정렬 조건 (날짜, 아이디, 이름, 결제일, 결제종료일, 결제방법)
	private String orderUpDown = "desc"; //내림차순, 오름차순 
	
	//해당 유저의 grade 
	private int grade;  //1 : 일반, // 2: 프리미엄 
	
	//년도, 월 비교확인
	private String msg;
	
	public String getSelectStartDate() {
		return selectStartDate;
	}
	public void setSelectStartDate(String selectStartDate) {
		this.selectStartDate = selectStartDate;
	}
	public String getSelectEndDate() {
		return selectEndDate;
	}
	public void setSelectEndDate(String selectEndDate) {
		this.selectEndDate = selectEndDate;
	}
	public String getSelectYearMonthDate() {
		return selectYearMonthDate;
	}
	public void setSelectYearMonthDate(String selectYearMonthDate) {
		this.selectYearMonthDate = selectYearMonthDate;
	}
	public String getOrderCondition() {
		return orderCondition;
	}
	public void setOrderCondition(String orderCondition) {
		this.orderCondition = orderCondition;
	}
	public String getOrderUpDown() {
		return orderUpDown;
	}
	public void setOrderUpDown(String orderUpDown) {
		this.orderUpDown = orderUpDown;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
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
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getImp_uid() {
		return imp_uid;
	}
	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}
	public String getMerchant_uid() {
		return merchant_uid;
	}
	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}
	public int getAmount() {
		return amount;
	}
	public int getAmountCard() {
		return amountCard;
	}
	public void setAmountCard(int amountCard) {
		this.amountCard = amountCard;
	}
	public int getAmountCash() {
		return amountCash;
	}
	public void setAmountCash(int amountCash) {
		this.amountCash = amountCash;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getAmountRefund() {
		return amountRefund;
	}
	public void setAmountRefund(int amountRefund) {
		this.amountRefund = amountRefund;
	}
	public String getPayStart() {
		return payStart;
	}
	public void setPayStart(String payStart) {
		this.payStart = payStart;
	}
	public String getPayEnd() {
		return payEnd;
	}
	public void setPayEnd(String payEnd) {
		this.payEnd = payEnd;
	}
	public String getPayMethod() {
		return payMethod;
	}
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}
	public String getRefund() {
		return refund;
	}
	public void setRefund(String refund) {
		this.refund = refund;
	}
	public int getPayMonth() {
		return payMonth;
	}
	public void setPayMonth(int payMonth) {
		this.payMonth = payMonth;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
}
