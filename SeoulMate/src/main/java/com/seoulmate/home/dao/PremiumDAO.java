package com.seoulmate.home.dao;

import com.seoulmate.home.vo.PayVO;

public interface PremiumDAO {
	
	// ? 개월 뒤 sysdate 받아오기
	public String payEndCalculate(int payMonth);
	// 결제정보 저장(insert) 
	public int payCompleteInsert(PayVO payVO);
	
}
