package com.seoulmate.home.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.seoulmate.home.dao.AdminDAO;
import com.seoulmate.home.dao.MemberDAO;
import com.seoulmate.home.vo.FaqVO;
import com.seoulmate.home.vo.HouseRoomVO;
import com.seoulmate.home.vo.HouseWriteVO;
import com.seoulmate.home.vo.MateWriteVO;
import com.seoulmate.home.vo.MemberVO;
import com.seoulmate.home.vo.PagingVO;
import com.seoulmate.home.vo.PayVO;
import com.seoulmate.home.vo.PropensityVO;
import com.seoulmate.home.vo.ReportVO;
import com.seoulmate.home.vo.ContactVO;

@Service
public class AdminServiceImp implements AdminService {
	@Inject
	AdminDAO dao;
	@Inject
	MemberDAO mDAO;
	
	@Override
	public List<String> memberSelect(PagingVO pVO) {
		return dao.memberSelect(pVO);
	}
	@Override
	public MemberVO memberInfo(String userid) {
		return dao.memberInfo(userid);
	}
	@Override
	public int memberInfoSave(MemberVO vo) {
		return dao.memberInfoSave(vo);
	}
	@Override
	public String memberProfile(String userid) {
		return mDAO.memberProfile(userid);
	}
	@Override
	public int membertotalRecord(PagingVO pVO) {
		return dao.membertotalRecord(pVO);
	}
	// house management ///////////////////////////////////
	@Override
	public int houseTotalRecode(Map<String, Object> map) {
		return dao.houseTotalRecode(map);
	}	
	@Override
	public List<HouseWriteVO> houseOnePageListSelect(Map<String, Object> map) {
		return dao.houseOnePageListSelect(map);
	}
	@Override
	public HouseWriteVO houseDetailInfoSelect(HouseWriteVO hwVO) {
		return dao.houseDetailInfoSelect(hwVO);
	}
	@Override
	public PropensityVO propensitySelect(int pno) {
		return dao.propensitySelect(pno);
	}
	@Override
	public List<HouseRoomVO> houseRoomInfoSelect(HouseWriteVO hwVO) {
		return dao.houseRoomInfoSelect(hwVO);
	}
	@Override
	public List<HouseWriteVO> houseListSelect(Map<String, Object> map) {
		return dao.houseListSelect(map);
	}
// mate management /////////////////////////////////////
	@Override
	public int mateTotalRecode(Map<String, Object> map) {
		return dao.mateTotalRecode(map);
	}
	@Override
	public List<MateWriteVO> mateOnePageListSelect(Map<String, Object> map) {
		return dao.mateOnePageListSelect(map);
	}
	@Override
	public MateWriteVO mateDetailInfoSelectMateWrite(MateWriteVO mwVO) {
		return dao.mateDetailInfoSelectMateWrite(mwVO);
	}
	@Override
	public MemberVO mateDetailInfoSelectMember(String userid) {
		return dao.mateDetailInfoSelectMember(userid);
	}
	@Override
	public List<MateWriteVO> mateListSelect(Map<String, Object> map) {
		return dao.mateListSelect(map);
	}
// pay management ///////////////////////////////////
	@Override
	public int payTotalRecode(Map<String, Object> map) {
		return dao.payTotalRecode(map);
	}
	@Override
	public List<PayVO> payOnePageListSelect(Map<String, Object> map) {
		return dao.payOnePageListSelect(map);
	}
	@Override
	public List<PayVO> payListSelect(Map<String, Object> map) {
		return dao.payListSelect(map);
	}
// sales management ///////////////////////////////////
	@Override
	public List<PayVO> salesList(PayVO payVO) {
		return dao.salesList(payVO);
	}
	@Override
	public List<PayVO> salesUserList(String date) {
		return dao.salesUserList(date);
	}
// report management ///////////////////////////////////	
	@Override
	public int reportInsert(ReportVO vo) {
		return dao.reportInsert(vo);
	}
	@Override
	public List<ReportVO> reportTotalRecord(PagingVO pVo) {
		return dao.reportTotalRecord(pVo);
	}
	@Override
	public ReportVO reportInfo(int num, String category) {
		return dao.reportInfo(num, category);
		
	}
	@Override
	public String[] reportCategorySelect(String keyword) {
		return dao.reportCategorySelect(keyword);
	}
	@Override
	public int allStateUdate(int no, String userid, String category, String state) {
		return dao.allStateUdate(no, userid, category, state);
	}
	@Override
	public int reportStateUpdate(int num, String state) {
		return dao.reportStateUpdate(num, state);
	}
	@Override
	public int checkReportCnt(String userid) {
		return dao.checkReportCnt(userid);
	}
	@Override
	public int addBlacklist(String userid) {
		return dao.addBlacklist(userid);
	}
	@Override
	public String[] getNumFromReport(int no) {
		return dao.getNumFromReport(no);
	}
	@Override
	public int reportRecordCnt(PagingVO pVO) {
		return dao.reportRecordCnt(pVO);
	}
	// contact management ///////////////////////////////////	
	@Override
	public List<ContactVO> contactAllRecord(PagingVO pVO) {
		return dao.contactAllRecord(pVO);
	}
	@Override
	public int contactRecordCnt(PagingVO pVO) {
		return dao.contactRecordCnt(pVO);
	}
	@Override
	public ContactVO contactInfo(int no) {
		return dao.contactInfo(no);
	}
	@Override
	public int contactUpdate(ContactVO cVO) {
		return dao.contactUpdate(cVO);
	}
// DASHBOARD ///////////////////////////////////	
	@Override
	public int todayReportNum(String category) {
		return dao.todayReportNum(category);
	}
	@Override
	public int todayNum(String tablename) {
		return dao.todayNum(tablename);
	}
	@Override
	public String salesAmount() {
		return dao.salesAmount();
	}
	@Override
	public List<FaqVO> faqAllRecord() {
		return dao.faqAllRecord();
	}
	@Override
	public FaqVO faqInfo(int no) {
		return dao.faqInfo(no);
	}
	@Override
	public int faqInsert(FaqVO fVO) {
		return dao.faqInsert(fVO);
	}
	@Override
	public int faqUpdate(FaqVO fVO) {
		return dao.faqUpdate(fVO);
	}
	@Override
	public int removeBlacklist(String userid) {
		// 신고관리 - 블랙리스트 제거
		return dao.removeBlacklist(userid);
	}
	@Override
	public int faqDel(FaqVO fVO) {
		return dao.faqDel(fVO);
	}
	@Override
	public String[] endHouseList() {
		return dao.endHouseList();
	}
	@Override
	public String[] endMateList() {
		return dao.endMateList();
	}
	@Override
	public int endHouse(String no) {
		return dao.endHouse(no);
	}
	@Override
	public int endMate(String no) {
		return dao.endMate(no);
	}
	@Override	
	public int getHouseAddr(String Gu) {
		// 하우스 지역 가져오기
		return dao.getHouseAddr(Gu);
	}
	@Override
	public int getMemberGrade(int grade) {
		// 일반 프리미엄
		return dao.getMemberGrade(grade);
	}
	@Override
	public String getProfilePic2(String reportid) {
		// 신고관리- 신고자 프로필 사진명 가져오기
		return dao.getProfilePic2(reportid);
	}
	//사진 및 게재상태 수정
	@Override
	public int housePicUpdate(Map<String, String> map) {
		return dao.housePicUpdate(map);
	}
	// 게재상태 수정 
	@Override
	public int houseStateUpdate(HouseWriteVO hwVO) {
		return dao.houseStateUpdate(hwVO);
	}
	//현재 사진 가져오기 
	@Override
	public HouseWriteVO housepicSelect(int pno) {
		return dao.housepicSelect(pno);
	}
	@Override
	public MateWriteVO matepicSelect(int pno) {
		return dao.matepicSelect(pno);
	}
	@Override
	public int mateStateUpdate(MateWriteVO mwVO) {
		return dao.mateStateUpdate(mwVO);
	}
	@Override
	public int matePicUpdate(Map<String, String> map) {
		return dao.matePicUpdate(map);
	}
}
