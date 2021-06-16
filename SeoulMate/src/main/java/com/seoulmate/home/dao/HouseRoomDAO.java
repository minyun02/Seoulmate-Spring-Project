package com.seoulmate.home.dao;

import java.util.List;

import com.seoulmate.home.vo.HouseRoomVO;

public interface HouseRoomDAO {
	//하우스(방) 등록
	public int roomInsert(HouseRoomVO vo);
	
	//houseroom 가져오기
	public HouseRoomVO roomSelect(int no, String userid);
	
	//방 수정
	public int roomUpdate(HouseRoomVO vo);
	
	//방 삭제
	public int roomDel(int no, String userid, int hno);
	
	//houseRoom 가져오기 (본인 작성글 아니여도 가능)
	public HouseRoomVO roomSelect2(int no);
	
	//houseRoom List로 가져오기 
	public List<HouseRoomVO> roomListSelect(int no);
	
}
