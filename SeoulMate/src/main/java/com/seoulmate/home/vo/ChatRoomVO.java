package com.seoulmate.home.vo;

public class ChatRoomVO {
	private int no; // 채팅방 번호
	private String name; //채팅방이름
	private String chatUser1; // 하우스유저 아이디
	private String chatUser2; // 메이트유저 아이디
	private String chatRoomDate;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getChatUser1() {
		return chatUser1;
	}
	public void setChatUser1(String chatUser1) {
		this.chatUser1 = chatUser1;
	}
	public String getChatUser2() {
		return chatUser2;
	}
	public void setChatUser2(String chatUser2) {
		this.chatUser2 = chatUser2;
	}
	public String getChatRoomDate() {
		return chatRoomDate;
	}
	public void setChatRoomDate(String chatRoomDate) {
		this.chatRoomDate = chatRoomDate;
	}
}
