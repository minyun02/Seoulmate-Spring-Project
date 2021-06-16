package com.seoulmate.home.service;


import java.util.List;

import com.seoulmate.home.vo.HouseMatePagingVO;
import com.seoulmate.home.vo.ListVO;
import com.seoulmate.home.vo.MateWriteVO;
import com.seoulmate.home.vo.MemberVO;
import com.seoulmate.home.vo.PropensityVO;

public interface MateService {

	//메이트 등록
	public int mateInsert(MateWriteVO vo);
	
	// 성향 추가
	public int propInsert(PropensityVO vo);
	
	//성향 수정
	public int propMateUpdate(PropensityVO vo);
	
	//메이트 성향 no 가져오기
//	public PropensityVO mateSelect(String userid);
	
	//메이트 수정
	public int mateUpdate(MateWriteVO vo);
	
	//메이트 테이블 no 가져오기
//	public int mateSelect(String userid);
	
	//matewrite 가져오기
	public MateWriteVO mateSelect(String userid);
	
	//메이트 삭제
	public int mateDel(int no, String userid);
	
	//메이트 사진 가져오기
	public String[] MateProfilePic(String userid, int no);
	
	//matewrite 가져오기 (본인 작성글 아니여도)
	public MateWriteVO mateSelect2(int no);
	
	// 메이트 성향 가져오기(본인 작성 글 아니여도 가능)
	public PropensityVO propMateSelect2(int pno);

	// 메이트 index에서 9개의 메이트 목록 가져오기
	public List<MateWriteVO> getNewIndexMate(HouseMatePagingVO pVO);

	//메이트 희망지역 == 회원정보 희망지역
	public int mateAreaUpdate(String area, String userid);

	// 페이징 토탈레코드수 구하기
	public int mateTotalRecord(HouseMatePagingVO pVO);

	//성향pno의 psq.currval 값 가져오기
	public int proPnoCheck(String userid);
	
	// 메이트 성향이 있는지 가져옴
	public int propPcaseM(String userid);
	
	//메이트 글 카운트
	public int mateCount(String userid);
	
	// 메이트 매칭리스트 구하기
	public List<ListVO> mateMatchList(HouseMatePagingVO pVO);
	
	// 메이트 매칭리스트 페이징 토탈레코드수 구하기
	public int mateMatchTotal(HouseMatePagingVO pVO);

}
