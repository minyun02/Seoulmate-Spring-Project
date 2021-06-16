package com.seoulmate.home.dao;

import java.util.List;

import com.seoulmate.home.vo.HouseMatePagingVO;
import com.seoulmate.home.vo.HouseRoomVO;
import com.seoulmate.home.vo.HouseWriteVO;
import com.seoulmate.home.vo.ListVO;
import com.seoulmate.home.vo.PropensityVO;

public interface HouseWriteDAO {
	// 특정 대상의 하우스 목록 가져오기
	List<HouseWriteVO> houseList(String userid);
	// 특정 대상의 하우스 집이 등록된 성향의 목록을 가져오기
	List<HouseWriteVO> houseproList(String userid);
	// 하우스글의 성향 번호 가져오기
	int pnoCheck(String userid, int pno);
	
	//하우스 등록
	public int houseInsert(HouseWriteVO vo);
	
	//성향pno의 psq.currval 값 가져오기
	public int proPnoCheck(HouseWriteVO vo);
	
//	public int houseInsert2(HouseWriteVO vo);
	
	//가입할때 h 유형가입, pno 확인
//	public int proHouseCheck(String userid);
	
	//house name 가져오기
//	public String housenameCheck(String housename);
	
	//house name 수정하기
	public int housenameUpdate(String housename, int pno);
	
	//housewrite 가져오기
	public HouseWriteVO houseSelect(int no, String userid);
	
	//houseroom 가져오기
	public HouseRoomVO roomSelect(int no, String userid);

	// 하우스 성향 가져오기
	public PropensityVO propHouseSelect(String userid, int pno);
	
	//하우스 업데이트
	public int houseUpdate(HouseWriteVO vo);
	
	//하우스 삭제
	public int houseDel(int no, String userid);
	
	//하우스 사진 가져오기
	public String[] houseProfilePic(String userid ,int no);
	
	//하우스 사진2 가져오기
	public String houseProfilePic2(String userid, int no);
	
	//하우스 인덱스에서 New 하우스 리스트 9개 출력하기
	public List<HouseWriteVO> getNewIndexHouse(HouseMatePagingVO pVO);
	
	//최신 하우스 글 totalRecode 가져오기
	public int HouseTotalRecode(HouseMatePagingVO pVO);
	
	//하우스 보기(내가 쓴 글 아니여도 가능)
	public HouseWriteVO houseSelect2(int no);

	//사용자의 모든 성향 가져오기
	public List<PropensityVO> getPropInfo(String userid, String housename);

	// 하우스 매칭 리스트 구하기(9개)
	public List<ListVO> HouseMatchList(HouseMatePagingVO pVO);
	
	// 하우스 매칭 리스트 count 가져오기
	public int houseMatchTotal(HouseMatePagingVO pVO);

	//하우스 이름 있는 성향만 가져오기
	public List<PropensityVO> getPropInfo(String userid);
	
	//선택한 성향 정보 가져오기
	public PropensityVO getFullPropensity(String userid, int pno);

	//하우스 글 작성 확인
	public int houseWriteCheck(String userid);
	
	//하우스 모집중인지 확인
	public int houseStateCheck(String userid);
}
