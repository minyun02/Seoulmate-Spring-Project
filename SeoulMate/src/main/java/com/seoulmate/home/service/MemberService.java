package com.seoulmate.home.service;

import java.util.List;

import com.seoulmate.home.vo.HouseWriteVO;
import com.seoulmate.home.vo.MemberVO;
import com.seoulmate.home.vo.PropensityVO;

public interface MemberService {
	// 구
	public String[] gu();
	// 동
	public String[] dong(String gu);
	// 로그인
	public MemberVO loginCheck(String userid, String username);
	// 아이디 중복 검사
	public int idCheck(String userid);
	// 이메일 중복 검사
	public int emailCheck(String email);
	// 회원 가입
	public int memberInsert(MemberVO vo);
	// 회원정보 가져오기
	public MemberVO memberSelect(String userid);
	// 회원 프로필 사진 가져오기
	public String memberProfile(String userid);
	// 기존 비밀번호 가져오기
	public int memberPwdSelect(String userid, String userpwd);
	// 회원정보 수정(비밀번호 포함)
	public int memberUpdatePwdY(MemberVO vo);
	// 회원정보 수정(비밀번호 미포함)
	public int memberUpdatePwdN(MemberVO vo);
	// 아이디 찾기
	public String memberFindId(MemberVO vo);
	// 아이디, 이메일 입력해 비밀번호 가져오기
	public String pwdFind(String userid, String email);
	// 회원 탈퇴
	public int memberExit(String userid, String userpwd);
	
	// 성향 추가
	public int propInsert(PropensityVO vo);
	// 메이트 성향이 있는지 가져옴
	public int propPcaseM(String userid);
	// 하우스 성향이 있는지 가져옴
	public int propPcaseH(String userid);
	// 메이트 성향 가져오기
	public PropensityVO propMateSelect(String userid);
	// 메이트 성향 수정
	public int propMateUpdate(PropensityVO pVO);
	
	//회원 프리미엄 결제 후 grade 2(프리미엄)으로 변경
	public int gradePremiumUpdate(String userid);
	
	// 특정 대상의 하우스 목록 가져오기
	List<HouseWriteVO> houseList(String userid);
	// 특정 대상의 하우스 집이 등록된 성향의 목록을 가져오기
	List<HouseWriteVO> houseproList(String userid);
	// 하우스글의 성향 번호 가져오기
	int pnoCheck(String userid, int pno);
	// 하우스 성향 가져오기
	public PropensityVO propHouseSelect(String userid, int pno);
	// 하우스 성향 수정
	public int propHouseUpdate(PropensityVO pVO);
	// 집 등록을 하지않은 하우스 성향 갯수 가져오기
	public int propHcnt(String userid);
	// 집 등록을 하지않은 하우스의 번호 가져오기
	public int propNoHouse(String userid);
	// 집 등록을 하지않은 하우스의 성향을 VO로 가져오기
	public int[] proNoHouse(String userid);
	// 집 등록을 하지않은 하우스의 성향 가져오기
	public int noHousePnoChk(String userid, int pno);
	// 집 등록을 하지않은 하우스의 성향 수정
	public int propNoHouseUpdate(PropensityVO pVO);
	// 집 등록을 하지않은 하우스 성향 삭제하기
	public int proDelNoHouse(String userid, int pno);
	// 모집중이 아닌 성향 가져오기
	public int housestateCheck(int pno);
	// userid 로 등록된 성향 전체필드 리스트 가져오기
	public List<PropensityVO> housePropensityList(String userid);
}
