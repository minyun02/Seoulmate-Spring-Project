package com.seoulmate.home.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.seoulmate.home.service.MemberService;
import com.seoulmate.home.service.PremiumService;
import com.seoulmate.home.vo.MemberVO;
import com.seoulmate.home.vo.PayVO;
@Controller
public class PremiumController {
	@Inject
	PremiumService premiumService;
	@Inject
	MemberService memberService;
	
	@RequestMapping("/premiumInfo")
	public ModelAndView premiumInfo( MemberVO memberVO, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//결제를 위하여 세션에있는 id와, name을 사용하여 vo에 저장한다.  
		String userid = (String)session.getAttribute("logId");
		if(userid!=null) {
			//MemberDAO에 있는 회원정보 가져오기. 
			memberVO = memberService.memberSelect(userid);
			mav.addObject("memberVO", memberVO);
			mav.setViewName("premium/premiumInfo");
		}else {
			//로그인 하지않았다면 로그인 페이지로
			mav.setViewName("premium/premiumInfo");
		}
		return mav;
	}
	
	@RequestMapping("/premiumPay")
	public ModelAndView premiumPay(MemberVO memberVO, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String userid = (String)session.getAttribute("logId");
//		System.out.println("MemberVO = "+memberVO.getUserid());
//		System.out.println("세션저장아이디 = "+userid);
		if(userid!=null) {
			//세션에 저장된  grade 확인 후 memberVO 받기 
			int grade = (Integer)session.getAttribute("logGrade");
			if(grade==1) {
				// 가입안한 상태.  
				//MemberDAO에 있는 회원정보 가져오기. 
				memberVO = memberService.memberSelect(userid);
//				System.out.println("저장한 MemberVO = "+memberVO.getUserid());
				mav.addObject("memberVO", memberVO);
				mav.setViewName("premium/premiumPay");
			}else{
				// 이미 프리미엄 상태. 
				mav.setViewName("home");
			}
		}else {
			//로그인 하지않았다면 로그인 페이지로
			mav.setViewName("login");
		}
		return mav;
	}
	@RequestMapping("/premiumPayOk")
	@ResponseBody
	public String premiumPayOk(PayVO payVO, HttpSession session) {
//		System.out.println("결제 아이디 : "+payVO.getUserid()+", 결제한 사람이름 : "+payVO.getUsername());
//		System.out.println("고유결제 아이디 : "+payVO.getImp_uid());
//		System.out.println("주문번호 : "+payVO.getMerchant_uid());
//		System.out.println("결제금액 : "+payVO.getAmount());
//		System.out.println("결제수단 : "+payVO.getPayMethod());
//		System.out.println("체크한 개월 수"+payVO.getPayMonth());
		payVO.setPayEnd(premiumService.payEndCalculate(payVO.getPayMonth()));	
//		System.out.println("지금으로부터 2개월 뒤 "+payVO.getPayEnd());
		try {
			if(premiumService.payCompleteInsert(payVO)>0) {
				//insert완료 -> ajax success 로 리턴, 
//				System.out.println("DB insert 성공 200리턴 ");
				//logGrade 변경해야함,  member 테이블에 grade 값 2(프리미엄) 으로 변경
				if(memberService.gradePremiumUpdate(payVO.getUserid())>0) {
//					System.out.println("grade변경완료.. " );
					//session에 저장된 grade 변경. 
					session.setAttribute("logGrade", 2);
				}
			}
		} catch (Exception e) {   
//			System.out.println("DB insert 실패 300리턴 ");
			return "300";
		}
		return "200";
	}
}
