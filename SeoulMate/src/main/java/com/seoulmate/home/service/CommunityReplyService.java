package com.seoulmate.home.service;

import java.util.List;

import com.seoulmate.home.vo.CommunityReplyVO;

public interface CommunityReplyService {
	//댓글 목록 불러오기
	public List<CommunityReplyVO> replyList(int no);
	//댓글 등록하기
	public int replyInsert(CommunityReplyVO vo);
	//댓글 수정하기
	public int replyUpdate(CommunityReplyVO vo);
	//댓글 삭제하기
	public int replyDel(int num, String userid);
	//신고관리에서 원글번호 알아내기
	public String replyOriNum(int no);
}
