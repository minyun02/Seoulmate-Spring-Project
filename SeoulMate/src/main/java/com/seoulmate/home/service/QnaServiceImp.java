package com.seoulmate.home.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.seoulmate.home.dao.QnaDAO;
import com.seoulmate.home.vo.ContactVO;
import com.seoulmate.home.vo.FaqVO;

@Service
public class QnaServiceImp implements QnaService {
	@Inject
	QnaDAO dao;

	@Override
	public int contactInsert(ContactVO cVO) {
		return dao.contactInsert(cVO);
	}

	@Override
	public String useridCheck(String userid) {
		return dao.useridCheck(userid);
	}

	@Override
	public List<FaqVO> faqAllRecord() {
		return dao.faqAllRecord();
	}
}
