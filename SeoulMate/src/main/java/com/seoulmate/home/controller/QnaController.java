package com.seoulmate.home.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndView;

import com.seoulmate.home.service.QnaService;
import com.seoulmate.home.vo.ContactVO;
@Controller
public class QnaController {
	@Inject
	QnaService service;
	
	//자주하는 질문 게시판
	@RequestMapping("/qna")
	public ModelAndView faqList() {
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("faqList", service.faqAllRecord());
		mav.setViewName("faq/qna");
		
		return mav;
	}
		
		//문의하기
		@RequestMapping("/contact")
		public ModelAndView inquiry(HttpServletRequest req) {
			ModelAndView mav = new ModelAndView();

			String result = (String)req.getParameter("result");
			if(result == null) {
				mav.addObject("result", 0);
			}
			mav.setViewName("/faq/contact");
			return mav;
		}
		
		//문의 등록
		@RequestMapping(value="/contactInsert", method = RequestMethod.POST)
		public ModelAndView contactInsert(ContactVO cVO) {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("/faq/contact");
			int contactInsertResult = service.contactInsert(cVO);
			if(contactInsertResult==1) {
				mav.addObject("result", contactInsertResult);
			}else {
				mav.addObject("result", 0);
			}
			return mav;
		}
		
		//비회원 문의 아이디 확인하기
		@RequestMapping(value="contactUseridCheck", method=RequestMethod.POST)
		@ResponseBody
		public String contactUseridCheck(String userid) {
			String idCheck = service.useridCheck(userid);
			if(idCheck==null) {
				idCheck = "no";
			}else {
				idCheck = "yes";
			}
			return idCheck;
		}
}
