package com.seoulmate.home.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.seoulmate.home.dao.MateWriteDAO;
import com.seoulmate.home.dao.PropensityDAO;
import com.seoulmate.home.vo.HouseMatePagingVO;
import com.seoulmate.home.vo.ListVO;
import com.seoulmate.home.vo.MateWriteVO;
import com.seoulmate.home.vo.PropensityVO;
@Service
public class MateServiceImp implements MateService {
	@Inject
	MateWriteDAO dao; //mate DAO
	@Inject
	PropensityDAO pDAO; //성향 DAO

	@Override
	public int mateInsert(MateWriteVO vo) { //메이트 등록
		return dao.mateInsert(vo);
	}

	@Override
	public int propInsert(PropensityVO vo) { // 성향 추가
		return pDAO.propInsert(vo);
	}
	
	@Override
	public int propMateUpdate(PropensityVO vo) { //메이트성향 수정
		return pDAO.propMateUpdate(vo);
	}

//	@Override
//	public PropensityVO mateSelect(String userid) {
//		// TODO Auto-generated method stub
//		return dao.mateSelect(userid);
//	}

	@Override
	public int mateUpdate(MateWriteVO vo) { //메이트 수정
		return dao.mateUpdate(vo);
	}

//	@Override
//	public int mateSelect(String userid) { //메이트 테이블 no 가져오기
//		return dao.mateSelect(userid);
//	}

	@Override
	public MateWriteVO mateSelect(String userid) { //matewrite 가져오기
		return dao.mateSelect(userid);
	}

	@Override
	public int mateDel(int no, String userid) { //메이트 삭제
		return dao.mateDel(no, userid);
	}

	@Override
	public List<MateWriteVO> getNewIndexMate(HouseMatePagingVO pVO) {
		return dao.getNewIndexMate(pVO);
	}
	@Override
	public String[] MateProfilePic(String userid, int no) {
		return dao.MateProfilePic(userid, no);
	}

	@Override
	public MateWriteVO mateSelect2(int no) {
		return dao.mateSelect2(no); //matewrite 가져오기 (본인 작성글 아니여도)
	}

	@Override
	public PropensityVO propMateSelect2(int pno) { // 메이트 성향 가져오기(본인 작성 글 아니여도 가능)
		return pDAO.propHouseSelect2(pno);
	}

	@Override
	public int mateAreaUpdate(String area, String userid) {
		return dao.mateAreaUpdate(area, userid);
	}

	@Override
	public int mateTotalRecord(HouseMatePagingVO pVO) { // 메이트 total 레코드 수
		return dao.mateTotalRecord(pVO);
	}
	public int proPnoCheck(String userid) { //성향pno의 psq.currval 값 가져오
		return pDAO.proPnoCheck(userid);
	}

	@Override
	public int propPcaseM(String userid) {
		return pDAO.propPcaseM(userid);
	}

	@Override
	public int mateCount(String userid) { //메이트 글 카운트
		return dao.mateCount(userid);
	}

	@Override
	public List<ListVO> mateMatchList(HouseMatePagingVO pVO) {
		return dao.mateMatchList(pVO);
	}

	@Override
	public int mateMatchTotal(HouseMatePagingVO pVO) {
		return dao.mateMatchTotal(pVO);
	}


}
