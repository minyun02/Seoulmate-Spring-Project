package com.seoulmate.home.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.seoulmate.home.dao.PremiumDAO;
import com.seoulmate.home.vo.PayVO;
@Service
public class PremiumServiceImp implements PremiumService {
	@Inject
	PremiumDAO pDAO;

	@Override
	public String payEndCalculate(int payMonth) {
		return pDAO.payEndCalculate(payMonth);
	}
	@Override
	public int payCompleteInsert(PayVO payVO) {
		return pDAO.payCompleteInsert(payVO);
	}
}
