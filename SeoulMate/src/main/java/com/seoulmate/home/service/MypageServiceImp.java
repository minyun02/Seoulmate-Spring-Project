package com.seoulmate.home.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.seoulmate.home.dao.MypageDAO;
import com.seoulmate.home.vo.ApplyInviteVO;
import com.seoulmate.home.vo.ChatRoomVO;
import com.seoulmate.home.vo.HouseRoomVO;
import com.seoulmate.home.vo.HouseWriteVO;
import com.seoulmate.home.vo.LikeMarkVO;
import com.seoulmate.home.vo.MateWriteVO;
import com.seoulmate.home.vo.PagingVO;
import com.seoulmate.home.vo.PayVO;
@Service
public class MypageServiceImp implements MypageService {
	@Inject
	MypageDAO dao;

	@Override
	public int likemarkInsert(int no, String userid, String category) {
		// 찜 등록
		return dao.likemarkInsert(no, userid, category);
	}
	
	@Override
	public int likemarkDelete(int no, String userid) {
		// 찜 삭제하기
		return dao.likemarkDelete(no, userid);
	}
	
	@Override
	public List<LikeMarkVO> likemarkAllRecord(String category, String userid) {
		// 찜 목록 출력
		return dao.likemarkAllRecord(category, userid);
	}

	@Override
	public String[] getLikedNumber(String userid) {
		// 사용자의 찜목록
		return dao.getLikedNumber(userid);
	}
	
	@Override
	public HouseWriteVO getHousedetails(int no) {
		// 하우스
		return dao.getHousedetails(no);
	}

	@Override
	public HouseRoomVO getMinRentDeposit(int no) {
		// min rent, min deposit
		return dao.getMinRentDeposit(no);
	}
	
	@Override
	public MateWriteVO getMatedetails(int no) {
		// 메이트
		return dao.getMatedetails(no);
	}
	
	public int houseConfirm(String userid) {
		return dao.houseConfirm(userid);
	}
	@Override
	public List<HouseWriteVO> myPageHouseWriteSelect(String userid) {
		return dao.myPageHouseWriteSelect(userid);
	}
	@Override
	public int mateConfirm(String userid) {
		return dao.mateConfirm(userid);
	}
	@Override
	public MateWriteVO myPageMateWriteSelect(String userid) {
		return dao.myPageMateWriteSelect(userid);
	}
	@Override
	public int likeMarkConfirm(String userid) {
		return dao.likeMarkConfirm(userid);
	}
	@Override
	public List<LikeMarkVO> likeMarkSelect(String userid) {
		return dao.likeMarkSelect(userid);
	}
	@Override
	public HouseWriteVO houseLikeSelect(LikeMarkVO lmVO) {
		return dao.houseLikeSelect(lmVO);
	}

	@Override
	public MateWriteVO mateLikeSelect(LikeMarkVO lmVO) {
		return dao.mateLikeSelect(lmVO);
	}

	
	
	//팝업
	@Override
	public List<ApplyInviteVO> applyInviteSelect(ApplyInviteVO aiVO) {
		// 메이트확인. 받은초대, 보낸신청 (userid)
		// 하우스확인. 받은신청, 보낸초대 (no)
		return dao.applyInviteSelect(aiVO);
	}
	// 메이트 글 vo받아오는거는 myPageMateWriteSelect사용하여 받기, 
	// 하우스 글 vo받아오기 
	@Override
	public HouseWriteVO oneHouseWriteSelect(int no) {
		return dao.oneHouseWriteSelect(no);
	}
	//보낸신청, 보낸초대 삭제. 
	@Override
	public int mypageApplyInviteCancel(ApplyInviteVO aiVO) {
		return dao.mypageApplyInviteCancel(aiVO);
	}
	//받은신청, 받은초대 - 승인
	@Override
	public int applyInviteApproveUpdate(ApplyInviteVO aiVO) {
		return dao.applyInviteApproveUpdate(aiVO);
	}
	//초대하기, 신청하기
	@Override
	public int applyInviteInsert(ApplyInviteVO aiVO) {
		return dao.applyInviteInsert(aiVO);
	}
	// 승인 후 housename, userid 가져오기. 
	@Override
	public HouseWriteVO chatHouseSelect(int no) {
		return dao.chatHouseSelect(no);
	}
	// housename list 
	@Override
	public List<HouseWriteVO> houseListSelect(String userid, String selectMate) {
		return dao.houseListSelect(userid, selectMate);
	}
	// 채팅 DB 데이터 확인. 
	@Override
	public ChatRoomVO chatCheck(String chatuser1, String chatuser2) {
		return dao.chatCheck(chatuser1, chatuser2);
	}
	// 승인 후 채팅 insert 
	@Override
	public int chatInsert(String name, String chatuser1, String chatuser2) {
		return dao.chatInsert(name, chatuser1, chatuser2);
	}
	// 채팅 name update
	@Override
	public int chatUpdate(ChatRoomVO crVO) {
		return dao.chatUpdate(crVO);
	}
	//하우스명이 채팅방 네임에 있는지 확인.
	@Override
	public int chatCheckName(String name, String chatuser1, String chatuser2) {
		return dao.chatCheckName(name, chatuser1, chatuser2);
	}
	//하우스인지, 메이트인지 확인. 
	@Override
	public int noConfirmHouseOrMate(int no, String msg) {
		return dao.noConfirmHouseOrMate(no, msg);
	}
	//pno확인
	@Override
	public int pnoConfirm(String userid, String pcase) {
		return dao.pnoConfirm(userid, pcase);
	}
	//매칭완료로 변경
	@Override
	public int stateCompleteUpdate(String tableName, String stateName, String no, String userid) {
		return dao.stateCompleteUpdate(tableName, stateName, no, userid);
	}

	@Override
	public int pno_Select(int no) {
		return dao.pno_Select(no);
	}

	@Override
	public int housenameSelect(String housename) {
		return dao.housenameSelect(housename);
	}
	@Override
	public String[] getUsersHouseWriteNum(String userid) {
		return dao.getUsersHouseWriteNum(userid);
	}

	@Override
	public String[] getUsersMateWriteNum(String userid) {
		return dao.getUsersMateWriteNum(userid);
	}
	//초대,신청 내역 중복확인 
	@Override
	public int checkApplyInvite(ApplyInviteVO aiVO) {
		return dao.checkApplyInvite(aiVO);
	}
	// 초대신청 리스트 (로그인유저아이디로)
	@Override
	public List<ApplyInviteVO> applyInviteList(String userid) {
		return dao.applyInviteList(userid);
	}
	// 글번호, 유저아이디, 카테고리로 찜한 내역이 있는지 확인
	@Override
	public int likemarkerSelect(int no, String userid, String msg) {
		return dao.likemarkerSelect(no, userid, msg);
	}	
	//결제내역 목록 레코드 수 구하기
	@Override
	public int payRecordCnt(String userid) {
		return dao.payRecordCnt(userid);
	}
	// 결제내역 목록리스트
	@Override
	public List<PayVO> payList(Map<String, Object> map) {
		return dao.payList(map);
	}
}
