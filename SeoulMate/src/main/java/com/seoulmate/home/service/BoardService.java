package com.seoulmate.home.service;

import java.util.List;

import com.seoulmate.home.vo.BoardVO;
import com.seoulmate.home.vo.PageVO;

public interface BoardService {
	//커뮤니티 게시판 글 목록 불러오기
	public List<BoardVO> comAllRecord(PageVO pVo);
	//글 등록
	public int boardInsert(BoardVO vo);
	// 페이징에 쓰일 총 레코드 수 구하기
	public int totalRecord(PageVO vo);
	//글 내용보기 /글 수정하기
	public BoardVO boardSelect(int no);
	//댓글 수 확인
	public int replyCount(int no);
	//조회수올리기
	public int hitUpdate(int no);
	//글 삭제하기
	public int communityDelete(int no, String userid);
	//댓글 수 올리기/내리기
	public int replyUpdate(int no, String minusOrPlus);
	//글 수정하기
	public int communityEdit(BoardVO vo);
	//이전글 다음글
	public PageVO nextPrevSelect(int no, String category, String searchKey, String searchWord);
	//비정상적 get방식 체크
	public int stateCheck(int no); //, String userid
	//신고된 게시글인지 확인
	public int reportCheck(int no);
}
