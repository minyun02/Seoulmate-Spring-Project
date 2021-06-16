package com.seoulmate.home.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

public interface AdminDAO {
//Dashboard ///////////////////////////////////////
	//오늘 신고	
	public int todayReportNum(String category);
	//오늘 문의, 프리미엄
	public int todayNum(String tablename);
	//오늘 매출
	public String salesAmount();
	//하우스 지역
	public int getHouseAddr(String Gu);
	//일반 프리미엄
	public int getMemberGrade(int grade);
//Member Management ///////////////////////////////////////	
	// 회원 목록 출력
	public List<String> memberSelect(PagingVO pVO);
	// 회원 정보 출력
	public MemberVO memberInfo(String userid);
	// 회원 정보 수정
	public int memberInfoSave(MemberVO vo);
	// 회원 총 레코드
	public int membertotalRecord(PagingVO pVO);

//house Management ///////////////////////////////////////
	//하우스관리 페이지 총 레코드 수 확인 
	public int houseTotalRecode(Map<String, Object> map);
	// 하우스관리 페이지 리스트 가져오기 
	public List<HouseWriteVO> houseOnePageListSelect(Map<String, Object> map);
	// 하우스관리 - 개인정보 확인 
	public HouseWriteVO houseDetailInfoSelect(HouseWriteVO hwVO);
	// 하우스관리 - Hosuse propensity 확인 
	public PropensityVO propensitySelect(HouseWriteVO hwVO);
	// 하우스관리 - HouseRoom정보 확인 
	public List<HouseRoomVO> houseRoomInfoSelect(HouseWriteVO hwVO);
	//하우스관리 조건에맞는 총레코드 리스트
	public List<HouseWriteVO> houseListSelect(Map<String, Object> map);
	//현재 사진 가져오기 
	public HouseWriteVO housepicSelect(int pno);
	//선택사진 수정 
	public int housePicUpdate(Map<String, String> map);
	// 게재상태 수정 
	public int houseStateUpdate(HouseWriteVO hwVO);
//하우스, 메이트 관리 
	//propensity 확인 
	public PropensityVO propensitySelect(int pno);
//mate Management ///////////////////////////////////////	
	public int mateTotalRecode(Map<String, Object> map);
	//메이트관리 - 페이지 리스트 가져오기
	public List<MateWriteVO> mateOnePageListSelect(Map<String, Object> map);
	//메이트 관리 - 개인정보 셀렉트
	public MateWriteVO mateDetailInfoSelectMateWrite(MateWriteVO mwVO);
	//메이트관리 - memberVO 셀렉트 
	public MemberVO mateDetailInfoSelectMember(String userid);
	//메이트관리 조건에맞는 총레코드 리스트
	public List<MateWriteVO> mateListSelect(Map<String, Object> map);
	//현재 사진 가져오기 
	public MateWriteVO matepicSelect(int pno);
	// 게재상태 수정 
	public int mateStateUpdate(MateWriteVO mwVO);
	//선택사진 수정 
	public int matePicUpdate(Map<String, String> map);
//pay management /////////////////////////////////////////
	// 결제관리 페이지 총 레코드 수 확인 
	//public int payTotalRecode(PayVO payVO);
	public int payTotalRecode(Map<String, Object> map);
	// 결제관리 페이지 리스트 가져오기 
	public List<PayVO> payOnePageListSelect(Map<String, Object> map);
	//조건에맞는 총레코드 리스트
	public List<PayVO> payListSelect(Map<String, Object> map);
	
	
//sales management ///////////////////////////////////////
	//조건에 맞는 레코드리스트 구하기 (year, month, date)
	public List<PayVO> salesList(PayVO payVO);
	//유저 목록 가져오기.  
	public List<PayVO> salesUserList(String date);
//report management ///////////////////////////////////////
	// 신고 등록
	public int reportInsert(ReportVO vo);
	// 신고 목록 불러오기
	public List<ReportVO> reportTotalRecord(PagingVO pVo);
	// 신고 상세보기
	public ReportVO reportInfo(int num, String category);
	// 검색 자동완성 테스트
	public String[] reportCategorySelect(String keyword);
	// 신고 처리 - 게시글/댓글 상태 수정
	public int allStateUdate(int no, String userid, String category, String state);
	// 신고 처리 - 처리완료
	public int reportStateUpdate(int num, String state);
	// 신고 처리 - 처리완료 누적수 확인
	public int checkReportCnt(String userid);
	// 신고 처리 - 블랙리스트 등록
	public int addBlacklist(String userid);
	// 글이 삭제될때 신고테이블에 있는지 확인하는 메소드
	public String[] getNumFromReport(int no);
	// 페이징을 위한 총 레코드 수 구하기
	public int reportRecordCnt(PagingVO pVO);
	// 블랙리스트에서 제거
	public int removeBlacklist(String userid);
	// 신고자 프로필 사진 가져오기
	public String getProfilePic2(String reportid);
//contact management ///////////////////////////////////////
	//문의 목록 출력
	public List<ContactVO> contactAllRecord(PagingVO pVO);
	//문의 목록 레코드 수 구하기
	public int contactRecordCnt(PagingVO pVO);
	//문의 상세보기
	public ContactVO contactInfo(int no);
	//문의 답변하기
	public int contactUpdate(ContactVO cVO);
	
// faq management
	// 자주하는 질문 목록 출력
	public List<FaqVO> faqAllRecord();
	// 자주하는 질문 보기
	public FaqVO faqInfo(int no);
	// 자주하는 질문 추가
	public int faqInsert(FaqVO fVO);
	// 자주하는 질문 수정
	public int faqUpdate(FaqVO fVO);
	// 자주하는 질문 삭제
	public int faqDel(FaqVO fVO);
	
	// 기간 만료인 하우스 목록 가져오기
	public String[] endHouseList();
	// 기간 만료인 메이트 목록 가져오기
	public String[] endMateList();
	// 모집중인 하우스를 기간 만료로 변경하기
	public int endHouse(String no);
	// 모집중인 메이트를 기간 만료로 변경하기
	public int endMate(String no);
	
}
