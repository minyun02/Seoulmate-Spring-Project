package com.seoulmate.home.vo;

import java.util.List;

public class HouseRoomVO {
	private int no; //houseWrite 테이블에 no (일련번호)
	private int hno; // 룸 일련번호 
	private String userid;
	private String roomName; // 룸 이름
	private int deposit;  //보증금 
	private int rent;  //월세 
	private String enterdate; //입주 가능일 
	private String minStay; // 최소 거주기간  (1~3개월, 4~6개월, 7~12개월, 1년이상)
	private String maxStay; // 최대 거주 기 (1~3개월, 4~6개월, 7~12개월, 1년이상)
	private int roomPeople; // 방 인원 
	private int furniture;  // 가구 여부 (있음, 없음) 
	private String incFurniture;  //포함된 가구 
	
	//방 여러개 테스트
	private List<HouseRoomVO> roomVOList;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getHno() {
		return hno;
	}
	public void setHno(int hno) {
		this.hno = hno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
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
	public int getRoomPeople() {
		return roomPeople;
	}
	public void setRoomPeople(int roomPeople) {
		this.roomPeople = roomPeople;
	}
	public int getFurniture() {
		return furniture;
	}
	public void setFurniture(int furniture) {
		this.furniture = furniture;
	}
	public String getIncFurniture() {
		return incFurniture;
	}
	public void setIncFurniture(String incFurniture) {
		this.incFurniture = incFurniture;
	}
	///////
	public List<HouseRoomVO> getRoomVOList() {
		return roomVOList;
	}
	public void setRoomVOList(List<HouseRoomVO> roomVOList) {
		this.roomVOList = roomVOList;
	}
}
