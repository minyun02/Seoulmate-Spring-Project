package com.seoulmate.home.service;

import com.seoulmate.home.vo.ContactVO;

import java.util.List;

import com.seoulmate.home.vo.FaqVO;

public interface QnaService {
	//문의 등록하기
	public int contactInsert(ContactVO cVO);
	//비회원 아이디 체크
	public String useridCheck(String userid);
	// 자주하는 질문 목록 불러오기
	public List<FaqVO> faqAllRecord();
}
