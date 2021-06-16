package com.seoulmate.home.dao;

import com.seoulmate.home.vo.MemberVO;

public interface MemberDAO {
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
	// 기존 비밀번호 가져오기
	public int memberPwdSelect(String userid, String userpwd);
	// 회원 프로필 사진 가져오기
	public String memberProfile(String userid);
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
	
	//회원 프리미엄 결제 후 grade 2(프리미엄)으로 변경
	public int gradePremiumUpdate(String userid);
	//회원 등급 확인
	public int gradeCheck(String userid);
}
