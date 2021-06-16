package com.seoulmate.home.dao;

import java.util.List;

import com.seoulmate.home.vo.HouseMatePagingVO;
import com.seoulmate.home.vo.ListVO;
import com.seoulmate.home.vo.MateWriteVO;
import com.seoulmate.home.vo.MemberVO;
import com.seoulmate.home.vo.PropensityVO;

public interface MateWriteDAO {

	//메이트 등록
	public int mateInsert(MateWriteVO vo);
	
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

	//메이트 인덱스에서 New 메이트 리스트 9개 출력하기
	public List<MateWriteVO> getNewIndexMate(HouseMatePagingVO pVO);

	//메이트 희망지역 == 회원정보 희망지역
	public int mateAreaUpdate(String area, String userid);
	
	// 페이징 토탈레코드수 구하기
	public int mateTotalRecord(HouseMatePagingVO pVO);

	//메이트 글 카운트
	public int mateCount(String userid);
	
	// 메이트 매칭 리스트 구하기
	public List<ListVO> mateMatchList(HouseMatePagingVO pVO);
	
	// 메이트 매칭리스트 페이징 토탈레코드수 구하기
	public int mateMatchTotal(HouseMatePagingVO pVO);

}
