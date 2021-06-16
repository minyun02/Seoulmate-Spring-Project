package com.seoulmate.home.service;

import com.seoulmate.home.vo.PayVO;

public interface PremiumService {
	public String payEndCalculate(int payMonth);
	public int payCompleteInsert(PayVO payVO);
}
