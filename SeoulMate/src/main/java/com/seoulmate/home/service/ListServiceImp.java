package com.seoulmate.home.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.seoulmate.home.dao.ListDAO;
import com.seoulmate.home.vo.ListVO;
import com.seoulmate.home.vo.PropensityVO;

@Service
public class ListServiceImp implements ListService{
	@Inject
	ListDAO dao;

	@Override
	public List<ListVO> premiumHouseList(String userid, int m_gender, String addr, int rent, int deposit, int m_gen) {
		return dao.premiumHouseList(userid, m_gender, addr, rent, deposit, m_gen);
	}

	@Override
	public ListVO premiumHouseScore(String userid, int pno) {
		return dao.premiumHouseScore(userid, pno);
	}

	@Override
	public int myHousePnoCount(String userid) {
		return dao.myHousePnoCount(userid);
	}
	
	@Override
	public List<PropensityVO> myHousePno(String userid) {
		return dao.myHousePno(userid);
	}
	
	@Override
	public int myMatePnoCheck(String userid) {
		return dao.myMatePnoCheck(userid);
	}
	@Override
	public int mate_m_gender(String userid) {
		return dao.mate_m_gender(userid);
	}

	@Override
	public int house_m_gender(String userid, int pno) {
		return dao.house_m_gender(userid, pno);
	}

	@Override
	public int newHpno(String userid) {
		return dao.newHpno(userid);
	}

	@Override
	public List<ListVO> premiumMateList(String userid, int pno, int m_gender, String area, int rent, int deposit, int gender) {
		return dao.premiumMateList(userid, pno, m_gender, area, rent, deposit, gender);
	}

	@Override
	public ListVO premiumMateScore(String userid, int hpno, int mpno) {
		return dao.premiumMateScore(userid, hpno, mpno);
	}
	
}
