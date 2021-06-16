package com.seoulmate.home.dao;

import java.util.List;

import com.seoulmate.home.vo.ListVO;
import com.seoulmate.home.vo.PropensityVO;

public interface ListDAO {
	// 매칭된 하우스 목록 가져오기
	public List<ListVO> premiumHouseList(String userid, int m_gender, String addr, int rent, int deposit, int m_gen);
	// 특정 하우스의 매칭 점수 가져오기
	public ListVO premiumHouseScore(String userid, int pno);
	// 나의 하우스 성향 번호 갯수 가져오기
	public int myHousePnoCount(String userid);
	// 나의 하우스 성향 번호와 집 이름 가져오기
	public List<PropensityVO> myHousePno(String userid);
	// 메이트의 희망 성별이 있는지 확인하기
	public int myMatePnoCheck(String userid);
	// 메이트의 희망 성별 가져오기
	public int mate_m_gender(String userid);
	// 메이트의 성별 가져오기
	public int house_m_gender(String userid, int pno);
	// 매칭된 메이트 목록 가져오기
	public List<ListVO> premiumMateList(String userid, int pno, int m_gender, String area, int rent, int deposit, int gender);
	// 특정 메이트의 매칭 점수 가져오기
	public ListVO premiumMateScore(String userid, int hpno, int mpno);
	
	// 내 최신 하우스 성향 번호 가져오기
	public int newHpno(String userid);
	
}
