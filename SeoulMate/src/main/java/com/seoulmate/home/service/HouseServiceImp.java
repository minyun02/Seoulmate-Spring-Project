package com.seoulmate.home.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.seoulmate.home.dao.HouseRoomDAO;
import com.seoulmate.home.dao.HouseWriteDAO;
import com.seoulmate.home.dao.MemberDAO;
import com.seoulmate.home.dao.PropensityDAO;
import com.seoulmate.home.vo.HouseMatePagingVO;
import com.seoulmate.home.vo.HouseRoomVO;
import com.seoulmate.home.vo.HouseWriteVO;
import com.seoulmate.home.vo.ListVO;
import com.seoulmate.home.vo.PropensityVO;
@Service
public class HouseServiceImp implements HouseService {
	@Inject
	HouseRoomDAO dao; //방 등록
	@Inject
	HouseWriteDAO hDAO; //하우스 등록
	@Inject
	PropensityDAO pDAO; //성향 등록
	@Inject
	MemberDAO mDAO; //회원가입시 사진 가져오기

	@Override
	public int roomInsert(HouseRoomVO vo) { //하우스(방) 등록
		return dao.roomInsert(vo);
	}

	@Override
	public int houseInsert(HouseWriteVO vo) { //하우스 등록
		return hDAO.houseInsert(vo);
	}

	@Override
	public int propInsert(PropensityVO vo) { //성향 등록
		return pDAO.propInsert(vo);
	}

	@Override
	public int propHouseUpdate(PropensityVO vo) { //하우스성향 수정
		return pDAO.propHouseUpdate(vo);
	}

	@Override
	public int houseCheck(String userid) {
		return pDAO.houseCheck(userid);
	}

	@Override
	public int housePnoCheck(String userid) {
		return pDAO.housePnoCheck(userid);
	}

	@Override
	public int proPnoCheck(String userid) {
		return pDAO.proPnoCheck(userid);
	}

	@Override
	public int proHouseCheck(String userid) {
		// TODO Auto-generated method stub
		return pDAO.proHouseCheck(userid);
	}

//	@Override
//	public String housenameCheck(String housename) { //하우스네임 가져오기
//		return hDAO.housenameCheck(housename);
//	}

	@Override
	public int housenameUpdate(String housename, int pno) {
		return hDAO.housenameUpdate(housename, pno);
	}

	@Override
	public PropensityVO propHouseSelect(String userid, int pno) { //pcase='h' 일 경우 성향 가져오기, 하우스 성향 가져오기
		return pDAO.propHouseSelect(userid, pno);
	}

	@Override
	public HouseWriteVO houseSelect(int no, String userid) { //housewrite 가져오기
		System.out.println(no);
		return hDAO.houseSelect(no, userid);
	}

	@Override
	public HouseRoomVO roomSelect(int no, String userid) { //houseRoom 가져오기
		return dao.roomSelect(no, userid);
	}

	@Override
	public int houseUpdate(HouseWriteVO vo) { //하우스 수정하기
		return hDAO.houseUpdate(vo);
	}
	
	@Override
	public int roomUpdate(HouseRoomVO vo) { //방 수정하기
		return dao.roomUpdate(vo);
	}

	@Override
	public int houseDel(int no, String userid) { //하우스 삭제
		return hDAO.houseDel(no, userid);
	}

	@Override
	public int roomDel(int no, String userid, int hno) { //방 삭제
		return dao.roomDel(no, userid, hno);
	}

	@Override
	public String[] houseProfilePic(String userid ,int no) { //하우스사진 가져오기
		return hDAO.houseProfilePic(userid, no);
	}

	@Override
	public List<HouseWriteVO> getNewIndexHouse(HouseMatePagingVO pVO) {
		return hDAO.getNewIndexHouse(pVO);
	}
	
	@Override
	public int HouseTotalRecode(HouseMatePagingVO pVO) {
		return hDAO.HouseTotalRecode(pVO);
	}

	@Override
	public HouseWriteVO houseSelect2(int no) { //하우스 보기 (내가쓴글 아니여도 가능)
		return hDAO.houseSelect2(no);
	}

	@Override
	public HouseRoomVO roomSelect2(int no) { //HouseRoom 가져오기 (본인 작성글 아니여도 가능)
		return dao.roomSelect2(no);
	}

	@Override
	public PropensityVO propHouseSelect2(int pno) { //Propensity 가져오기 (본인 작성글 아니여도 가능)
		// TODO Auto-generated method stub
		return pDAO.propHouseSelect2(pno);
	}


	@Override
	public String memberProfile(String userid) { //회원가입시 사진 가져오기
		return mDAO.memberProfile(userid);
	}

	@Override
	public int ProHouseNameUpdate(PropensityVO vo) { // 하우스+룸 삭제 -> 하우스네임 null 로 변경
		return pDAO.ProHouseNameUpdate(vo);
	}

	@Override
	public List<HouseRoomVO> roomListSelect(int no) {
		return dao.roomListSelect(no);
	}
	@Override
	public int propPcaseM(String userid) { // 메이트 성향이 있는지 가져옴
		return pDAO.propPcaseM(userid);
	}

	@Override
	public List<PropensityVO> getPropInfo(String userid) {
		//하우스 이름 있는 성향만 가져오기
		return hDAO.getPropInfo(userid);
	}

	@Override
	public List<ListVO> HouseMatchList(HouseMatePagingVO pVO) {
		return hDAO.HouseMatchList(pVO);
	}

	@Override
	public int houseMatchTotal(HouseMatePagingVO pVO) {
		return hDAO.houseMatchTotal(pVO);
	}	
	//성향 매칭 점수 가져오기. 
	@Override
	public PropensityVO getMatchingSelect(int house_pno, int mate_pno) {
		return pDAO.getMatchingSelect(house_pno, mate_pno);
	}
	// 1:1 성향매칭 스코어 가져오기
	@Override
	public PropensityVO getMatchingScore(int house_pno, int mate_pno) {
		return pDAO.getMatchingScore(house_pno, mate_pno);
	}
	public PropensityVO getFullPropensity(String userid, int pno) {
		//선택한 성향 정보 가져오기
		return hDAO.getFullPropensity(userid, pno);
	}

	@Override
	public String houseProfilePic2(String userid, int no) { //하우스 사진2 가져오기
		return hDAO.houseProfilePic2(userid, no);
	}

	@Override
	public int gradeCheck(String userid) { //회원 등급 확인
		return mDAO.gradeCheck(userid);
	}
	
	@Override
	public int houseWriteCheck(String userid) { //하우스 글 작성 확인
		return hDAO.houseWriteCheck(userid);
	}
	
	@Override
	public int houseStateCheck(String userid) { //하우스 모집중인지 확인
		return hDAO.houseStateCheck(userid);
	}

}
