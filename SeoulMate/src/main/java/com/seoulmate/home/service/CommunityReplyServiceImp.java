package com.seoulmate.home.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.seoulmate.home.dao.CommunityReplyDAO;
import com.seoulmate.home.vo.CommunityReplyVO;
@Service
public class CommunityReplyServiceImp implements CommunityReplyService {
	@Inject
	CommunityReplyDAO dao;
	
	//댓글 불러오기
	@Override
	public List<CommunityReplyVO> replyList(int no) {
		return dao.replyList(no);
	}

	//댓글 등록하기
	@Override
	public int replyInsert(CommunityReplyVO vo) {
		return dao.replyInsert(vo);
	}

	@Override
	public int replyUpdate(CommunityReplyVO vo) {
		return dao.replyUpdate(vo);
	}

	@Override
	public int replyDel(int num, String userid) {
		return dao.replyDel(num, userid);
	}

	@Override
	public String replyOriNum(int no) {
		return dao.replyOriNum(no);
	}
}
