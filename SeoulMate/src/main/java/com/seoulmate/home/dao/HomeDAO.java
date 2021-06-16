package com.seoulmate.home.dao;

import java.util.List;

import com.seoulmate.home.vo.HouseRoomVO;
import com.seoulmate.home.vo.HouseWriteVO;
import com.seoulmate.home.vo.ListVO;
import com.seoulmate.home.vo.MateWriteVO;
import com.seoulmate.home.vo.MemberVO;

public interface HomeDAO {
	public List<ListVO> getHouseMap();
	public String[] getMateMap();
	public List<HouseWriteVO> getPreHouse();
	public List<HouseWriteVO> getNewHouse(String addr);
	public List<MateWriteVO> getPreMate();
	public List<MateWriteVO> getNewMate(String area);
	public HouseRoomVO getDesposit(int no);
	public MemberVO getDetail(String userid);
}
