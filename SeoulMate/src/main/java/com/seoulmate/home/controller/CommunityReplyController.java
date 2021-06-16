package com.seoulmate.home.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.seoulmate.home.dao.BoardDAO;
import com.seoulmate.home.service.BoardService;
import com.seoulmate.home.service.BoardServiceImp;
import com.seoulmate.home.service.CommunityReplyService;
import com.seoulmate.home.vo.BoardVO;
import com.seoulmate.home.vo.CommunityReplyVO;

@Controller
public class CommunityReplyController {
	@Inject
	CommunityReplyService service;
	@Inject
	BoardService bService;
	
	//댓글 목록 불러오기 ajax
	@RequestMapping("/replyList")
	@ResponseBody
	public List<CommunityReplyVO> replyList(int no){
		return service.replyList(no);
	}
	//댓글 등록하기 
	@RequestMapping("/replyWriteOk")
	@ResponseBody
	public String replyInsert(BoardVO bVo, CommunityReplyVO vo, HttpServletRequest req) {
		String result = "";
		vo.setUserid((String)req.getSession().getAttribute("logId"));
		vo.setIp(req.getRemoteAddr());
		int replyCnt = service.replyInsert(vo);
			if(replyCnt>0) {
				//댓글 수 올려주기.
				bService.replyUpdate(bVo.getNo(), "plus");
			}
		
		return result = replyCnt+"개 댓글 등록 성공";
	}
	//댓글 수정하기
	@RequestMapping(value = "/replyEdit", method=RequestMethod.POST)
	@ResponseBody
	public String replyEdit(CommunityReplyVO rVo) {
		int updateCnt = service.replyUpdate(rVo);
		return updateCnt+"개 수정 성공";
	}
	//댓글 삭제하기
	@RequestMapping(value="/replyDel", method=RequestMethod.POST)
	@ResponseBody
	public String replyDel(int num, String userid, int no) {
		int deleteCnt = service.replyDel(num, userid);
		if(deleteCnt==1) {
			bService.replyUpdate(no, "minus");
		}
		return deleteCnt+"개 삭제 성공";
	}
	// 신고 관리에서 댓글의 원글번호 받기 
	@RequestMapping("/replyOriNum")
	@ResponseBody
	public int replyOriNum(int no) {
		System.out.println(no+"///");
		int oriNo = Integer.parseInt(service.replyOriNum(no));
				
		return oriNo;
	}
}
