package com.seoulmate.home.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.seoulmate.home.dao.BoardDAO;
import com.seoulmate.home.vo.BoardVO;
import com.seoulmate.home.vo.PageVO;
@Service
public class BoardServiceImp implements BoardService {
	@Inject
	BoardDAO dao;
	
	@Override
	public List<BoardVO> comAllRecord(PageVO pVo) {
		return dao.comAllRecord(pVo);
	}

	@Override
	public int boardInsert(BoardVO vo) {
		return dao.boardInsert(vo);
	}

	@Override
	public int totalRecord(PageVO vo) {
		return dao.totalRecord(vo);
	}

	@Override
	public BoardVO boardSelect(int no) {
		return dao.boardSelect(no);
	}

	@Override
	public int replyCount(int no) {
		return dao.replyCount(no);
	}

	@Override
	public int hitUpdate(int no) {
		return dao.hitUpdate(no);
	}
	
	@Override
	public int communityDelete(int no, String userid) {
		return dao.communityDelete(no, userid);
	}

	@Override
	public int replyUpdate(int no, String minusOrPlus) {
		return dao.replyUpdate(no, minusOrPlus);
	}

	@Override
	public int communityEdit(BoardVO vo) {
		return dao.communityEdit(vo);
	}

	@Override
	public PageVO nextPrevSelect(int no, String category, String searchKey, String searchWord) {
		System.out.println(searchWord+"------>daodaodao");
		return dao.nextPrevSelect(no, category, searchKey, searchWord);
	}

	@Override
	public int stateCheck(int no) { //, String userid
		return dao.stateCheck(no); //, userid
	}

	@Override
	public int reportCheck(int no) {
		// 신고된 게시글인지 확인
		return dao.reportCheck(no);
	}

	
}
