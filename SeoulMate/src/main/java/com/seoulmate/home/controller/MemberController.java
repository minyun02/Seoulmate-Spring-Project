package com.seoulmate.home.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Arrays;
import java.util.Calendar;
import java.util.UUID;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.seoulmate.home.service.ListService;
import com.seoulmate.home.service.MemberService;
import com.seoulmate.home.vo.MemberVO;
import com.seoulmate.home.vo.PropensityVO;
@Controller
public class MemberController {
	@Inject
	MemberService service;
	@Inject
	ListService listService;
	@Inject
	JavaMailSenderImpl mailSender;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	@RequestMapping("/memberForm")
	public ModelAndView memForm(HttpSession session) {
		ModelAndView mav=new ModelAndView();
		
		session.removeAttribute("code"); // 새로 고침 했을 때 인증 번호를 지워버림
		
		Calendar now=Calendar.getInstance();
		int year=now.get(Calendar.YEAR);
		mav.addObject("year", year);
		
		String arr1[] = {"010","02","031","032","033","041","042","043","044","051","052","053","054","055","061","062","063","064"};
		mav.addObject("arr1", arr1);
		
		// 구
		String guArr[]=service.gu();
		mav.addObject("guArr", guArr); 
		
		mav.setViewName("member/memberForm");
		
		return mav;
	}
	
	@RequestMapping("/emailCheck")
	@ResponseBody
	public String emailCheck(HttpSession session, HttpServletRequest req) {
		String email=req.getParameter("email"); // 인증 번호를 받을 이메일
		String result="fail";
		
		int emailCheck=service.emailCheck(email);
		if(emailCheck==0) {
			UUID random=UUID.randomUUID();
			String uuid=random.toString();
			String code=uuid.substring(0,6);
			String subject="서울메이트 이메일 인증 번호 메일입니다.";
			String content="<div style='width: 600px; height: 225px; border-radius: 20px; "
					+ "background-color: #fff; box-shadow: 4px 3px 10px 0px rgb(0 0 0 / 15%); overflow: hidden;'>"
					+ "<div style='height: 50px; line-height: 50px; background-color: #13a89e; color: #fff; text-align: center;'>"
					+ "<img style='width: 121; height: 30px; margin:10px 0;' src='https://0905cjw.github.io/seoulmate_email.png'/></div>"
					+ "<div style='padding: 30px;'>"
					+ "<div style='margin:10px auto;'><h3>회원 가입을 위한 서울메이트 이메일 인증 번호</h3></div>"
					+ "<span>인증 번호 : "+code
					+ "</span></div><div style=\"padding: 15px 0; text-align: center; box-shadow: 0 -1px 22px -2px rgb(0 0 0 / 15%);\">"
					+ "<span style=\"color: #13a89e; font-weight:bold; font-size:12px;\">Copyright © 2021 공일이오 Co., Ltd. All rights reserved.</span>"
					+ "</div></div>";
			try {
				MimeMessage message=mailSender.createMimeMessage();
				MimeMessageHelper messageHelper=new MimeMessageHelper(message, true, "UTF-8");
				messageHelper.setFrom("seoulmatemanager@gmail.com");
				messageHelper.setTo(email);
				messageHelper.setSubject(subject);
				messageHelper.setText("text/html; charset=UTF-8", content);
				mailSender.send(message);
				
				session.setAttribute("code", code);
			}catch(Exception e) {
				System.out.println("이메일 인증번호 전송 에러 발생...");
				e.printStackTrace();
			}
			result=code;
		}
		
		
		return result;
	}
	
	@RequestMapping("/pwdFind")
	@ResponseBody
	public String pwdFind(HttpSession session, HttpServletRequest req) {
		String userid=req.getParameter("userid");
		String email=req.getParameter("email"); // 인증 번호를 받을 이메일
		String userpwd=service.pwdFind(userid, email);
		
		System.out.println(userpwd);
		
		String subject="서울메이트 회원정보 찾기 메일입니다.";
		String content="<div style='width: 600px; height: 225px; border-radius: 20px; "
				+ "background-color: #fff; box-shadow: 4px 3px 10px 0px rgb(0 0 0 / 15%); overflow: hidden;'>"
				+ "<div style='height: 50px; line-height: 50px; background-color: #13a89e; color: #fff; text-align: center;'>"
				+ "<img style='width: 121; height: 30px; margin:10px 0;' src='https://0905cjw.github.io/seoulmate_email.png'/></div>"
				+ "<div style='padding: 30px;'>"
				+ "<div style='margin:10px auto;'><h3>회원정보 찾기를 위한 서울메이트 이메일</h3></div>"
				+ "<span>비밀번호 : "+userpwd
				+ "</span></div><div style=\"padding: 15px 0; text-align: center; box-shadow: 0 -1px 22px -2px rgb(0 0 0 / 15%);\">"
				+ "<span style=\"color: #13a89e; font-weight:bold; font-size:12px;\">Copyright © 2021 공일이오 Co., Ltd. All rights reserved.</span>"
				+ "</div></div>";
		
		String result="no";
		if(userpwd!=null && !userpwd.equals("")) {
			try {
				MimeMessage message=mailSender.createMimeMessage();
				MimeMessageHelper messageHelper=new MimeMessageHelper(message, true, "UTF-8");
				messageHelper.setFrom("seoulmatemanager@gmail.com");
				messageHelper.setTo(email);
				messageHelper.setSubject(subject);
				messageHelper.setText("text/html; charset=UTF-8", content);
				mailSender.send(message);
				
			}catch(Exception e) {
				System.out.println("이메일 인증번호 전송 에러 발생...");
				e.printStackTrace();
			}
			
			result="pass";
		}
		
		return result;
	}
	
	@RequestMapping("/emailCheckResult")
	@ResponseBody
	public String emailCheckResult(HttpSession session, HttpServletRequest req) {
		String emailCheckNum=req.getParameter("emailCheckNum");
		String code=(String)session.getAttribute("code");
		
		String result="nonpass";
		if(emailCheckNum.equals(code)) {
			result="pass";
		}
		
		return result;
	}
	
	@RequestMapping("/idChk")
	@ResponseBody
	public int idChk(HttpServletRequest req) {
		String userid=req.getParameter("userid");
		int result=service.idCheck(userid);
		
		return result;
	}
	
	@RequestMapping(value="/memberOk", method=RequestMethod.POST)
	@Transactional(rollbackFor= {Exception.class, RuntimeException.class})
	public ModelAndView memberOk(MemberVO vo, PropensityVO proVO,HttpSession session, @RequestParam("filename") MultipartFile filename, HttpServletRequest req) {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("home");
		
		proVO.setUserid(vo.getUserid()); // 성향 테이블에 userid 추가
		
		// 프로필 사진 업로드 /////////////////////
		String path=req.getSession().getServletContext().getRealPath("/profilePic");
		String orgName=filename.getOriginalFilename(); // 기존 파일 명
		String realName="";
		String delFilename=req.getParameter("delFile");
		try {
			if(orgName != null && !orgName.equals("")) {
				File f=new File(path, orgName);
				int i=1;
				while(f.exists()) {
					int point=orgName.lastIndexOf(".");
					String name=orgName.substring(0, point);
					String extName=orgName.substring(point+1);
					
					f=new File(path, name+"_"+ i++ +"."+extName);
				}
				filename.transferTo(f); // 업로드
				realName=f.getName();
				vo.setProfilePic(f.getName());
				
				// 파일을 복사하여 Node서버에 올린다.
				/*
				 * File f2 = new File("D:/workspaceWeb/SeoulMateChat/img/profilePic", realName);
				 * FileInputStream fi = new FileInputStream(f); FileOutputStream fo = new
				 * FileOutputStream(f2);
				 * 
				 * while(true) { int inData = fi.read(); if (inData == -1) { break; }
				 * fo.write(inData); } fo.flush(); fo.close();
				 */
			}
		}catch(Exception e) {
			System.out.println("프로필 사진 업로드 에러 발생");
			e.printStackTrace();
		}
		
		String a1=vo.getArea1()+"/";
		String a2="";
		String a3="";
		if(vo.getArea2()!=null && !vo.getArea2().equals("")) {
			a2=vo.getArea2()+"/";
		}
		if(vo.getArea3()!=null && !vo.getArea3().equals("")) {
			a3=vo.getArea3()+"/";
		}
		vo.setArea(a1+a2+a3);
		
		
		///////////////////////////////////////
		// 트랜잭션
		DefaultTransactionDefinition def=new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED); // 트랜잭션 호출
		TransactionStatus status=transactionManager.getTransaction(def);
		
		try {
			int result=service.memberInsert(vo);
			if(result>0) { // 회원가입 성공
				System.out.println("회원가입 성공");
				int pResult=service.propInsert(proVO);
				if(pResult>0) { // 성향 등록 성공
					System.out.println("성향 등록 성공");
					// 정상 구현되면 commit 실행
					transactionManager.commit(status);
					mav.setViewName("redirect:login");
				}else {
					System.out.println("성향 등록 실패");
					mav.setViewName("redirect:memberForm");
				}
			}else { // 회원가입 실패
				if(realName!=null) { // 레코드 추가 실패 시 프로필 사진 삭제
					File f=new File(path, realName);
					f.delete();
				}
				System.out.println("회원가입 실패");
				mav.setViewName("redirect:memberForm");
				// 나중에 history.back() 해줘야 함
			}
		}catch(Exception e){
			System.out.println("회원가입 실패(트랜잭션)");
			try { // 트랜잭션이 발생할 때 업로드하려던 파일을 다시 삭제한다.
				File dFileObj=new File(path, realName);
				dFileObj.delete();
			}catch(Exception e1) {
				System.out.println("회원가입 실패(트랜잭션) 파일 삭제 에러 발생");
				e1.printStackTrace();
			}
			mav.setViewName("redirect:memberForm");
		}
		
		/*
		System.out.println("아이디 : "+vo.getUserid());
		System.out.println("비밀번호 : "+vo.getUserpwd());
		System.out.println("이름 : "+vo.getUsername());
		System.out.println("연락처 전체 : "+vo.getTel());
		System.out.println("연락처1 : "+vo.getTel1());
		System.out.println("연락처2 : "+vo.getTel2());
		System.out.println("연락처3 : "+vo.getTel3());
		System.out.println("생년월일 : "+vo.getBirth());
		System.out.println("희망지역 전체 : "+vo.getArea());
		System.out.println("희망1 : "+vo.getArea1());
		System.out.println("희망2 : "+vo.getArea2());
		System.out.println("희망3 : "+vo.getArea3());
		System.out.println("이메일 전체 : "+vo.getEmail());
		System.out.println("이메일 아이디 : "+vo.getEmailid());
		System.out.println("이메일 도메인 : "+vo.getEmaildomain());
		
		System.out.println("하우스 내 지원 서비스 : "+proVO.getH_support());
		System.out.println("지원 배열 : "+proVO.getH_supportStr());
		System.out.println("기타 배열 : "+proVO.getH_etcStr());
		*/
		
		return mav;
	}
	
	@RequestMapping("/login")
	public String loginForm() {
		return "member/login";
	}


	@RequestMapping(value="/loginOk", method = RequestMethod.POST)
	public ModelAndView loginCheck(String userid, String userpwd, HttpSession session) {
		MemberVO logVO = service.loginCheck(userid, userpwd);

		ModelAndView mav = new ModelAndView();
		if (logVO==null) { // 로그인 실패
			mav.addObject("logState", "fail");
			mav.setViewName("member/login");
		} else if(logVO.getState().equals("블랙") || logVO.getState().equals("탈퇴")) {
			mav.addObject("logState", logVO.getState());
			mav.setViewName("member/login");
		}
		else { // 로그인 성공
			session.setAttribute("logId", logVO.getUserid());
			session.setAttribute("logName", logVO.getUsername());
			session.setAttribute("logGrade", logVO.getGrade());
			session.setAttribute("logArea", logVO.getArea1());
			session.setAttribute("logEmail", logVO.getEmail());
			
			// 내 하우스 성향의 갯수를 구한다.(프리미엄인 하우스에게 메이트 매칭 목록을 띄워주기 위해)
			int myHousePnoCnt=listService.myHousePnoCount(userid);
			if(myHousePnoCnt>0) {
				int newHpno=listService.newHpno(userid); // 내 최신 하우스 성향을 세션에 저장한다.
				session.setAttribute("hPno", newHpno);
			}
			
			mav.setViewName("redirect:/");
		}

		return mav;
    }
	
	@RequestMapping("/memberEdit")
	public String memberEdit() {
		
		return "member/memberEdit";
	}
	
	@RequestMapping(value="/memberEditCheck", method=RequestMethod.POST)
	public ModelAndView memberEditCheck(String userpwd, HttpSession session) {
		ModelAndView mav=new ModelAndView();
		
		String userid=(String)session.getAttribute("logId");
		int result=service.memberPwdSelect(userid, userpwd);
		
		if(result>0) { // 비밀번호 OK
			System.out.println("비밀번호 맞음");
			mav.setViewName("redirect:memberEditForm");
		}else { // 비밀번호를 잘못 입력한 경우
			System.out.println("비밀번호 틀림");
			mav.addObject("notPwd", "1");
			mav.setViewName("member/memberEdit");
		}
		
		return mav;
	}
	@RequestMapping("/memberEditForm")
	public ModelAndView memberEditForm(HttpSession session) {
		ModelAndView mav=new ModelAndView();
		
		session.removeAttribute("code"); // 새로 고침 했을 때 인증 번호를 지워버림
		
		// 연락처 앞자리
		String arr1[] = {"010","02","031","032","033","041","042","043","044","051","052","053","054","055","061","062","063","064"};
		// 구
		String guArr[]=service.gu();
		
		String userid=(String)session.getAttribute("logId");
		
		MemberVO vo=service.memberSelect(userid);
		
		/* 구, 동 start */
		String[] area1=vo.getArea1().split(" "); // 희망 지역 1의 구
		String[] area2=null;
		String[] area3=null;
		if(vo.getArea2()!=null) {
			area2=vo.getArea2().split(" "); // 희망 지역 2의 구
			mav.addObject("selDong2", service.dong(area2[0]));
		}
		if(vo.getArea3()!=null) {
			area3=vo.getArea3().split(" "); // 희망 지역 3의 구
			mav.addObject("selDong3", service.dong(area3[0]));
		}
		mav.addObject("guArr", guArr); // 구
		mav.addObject("selDong1", service.dong(area1[0]));
		/* 구, 동 end */
		
		mav.addObject("arr1", arr1); // 연락처 앞자리
		mav.addObject("vo", service.memberSelect(userid));
		mav.setViewName("member/memberEditForm");
		
		return mav;
	}
	
	@RequestMapping("/memberDong")
	@ResponseBody
	public String[] memberDong(String gu) {
		String[] dong=service.dong(gu);
		
		return dong;
	}
	
	@RequestMapping(value="/memberEditOk", method=RequestMethod.POST)
	public ModelAndView memberEditOk(MemberVO vo, HttpSession session, HttpServletRequest req) {
		ModelAndView mav=new ModelAndView();
		
		vo.setUserid((String)session.getAttribute("logId"));
		
		System.out.println(vo.getArea1());
		System.out.println(vo.getArea2());
		String a1=vo.getArea1()+"/";
		String a2="";
		String a3="";
		if(vo.getArea2()!=null && !vo.getArea2().equals("")) {
			a2=vo.getArea2()+"/";
		}
		if(vo.getArea3()!=null && !vo.getArea3().equals("")) {
			a3=vo.getArea3()+"/";
		}
		vo.setArea(a1+a2+a3);
		
		String path=session.getServletContext().getRealPath("/profilePic");
		String selFilename=service.memberProfile(vo.getUserid());
		String delFilename=req.getParameter("delFile");
		
		MultipartHttpServletRequest mr=(MultipartHttpServletRequest)req;
		if(mr.getFile("filename")!=null) {
			MultipartFile newName=mr.getFile("filename");

			String newUpload="";
			
			if(newUpload!=null && newName!=null) {
				String orgname=newName.getOriginalFilename();
				
				if(orgname!=null && !orgname.equals("")) {
					File ff=new File(path, orgname);
					int i=1;
					while(ff.exists()) {
						int pnt=orgname.lastIndexOf(".");
						String firstName=orgname.substring(0, pnt);
						String extName=orgname.substring(pnt+1);
						
						ff=new File(path, firstName+"_"+ i++ +"."+extName);
					}
					try {
						newName.transferTo(ff);
						
						// 파일을 복사하여 Node서버에 올린다.
						/*
						 * File f2 = new File("D:/workspaceWeb/SeoulMateChat/img/profilePic",
						 * ff.getName()); FileInputStream fi = new FileInputStream(ff); FileOutputStream
						 * fo = new FileOutputStream(f2);
						 * 
						 * while(true) { int inData = fi.read(); if (inData == -1) { break; }
						 * fo.write(inData); } fo.flush(); fo.close();
						 */
					}catch(Exception e) {
						System.out.println("새로운 파일 추가 수정 에러 발생");
						e.printStackTrace();
					}
					newUpload=ff.getName();
					System.out.println("리네임된 새로운 파일명 : "+newUpload);
				}
			}
			vo.setProfilePic(newUpload);
			
			if(!vo.getUserpwd().equals("")) { // 비밀번호를 바꾸려는 경우
				if(service.memberUpdatePwdY(vo)>0) {
					System.out.println("비밀번호 포함 회원수정 변경 성공");
					if(delFilename!=null) {
						try {
							File dFileObj=new File(path, delFilename);
							dFileObj.delete();
						}catch(Exception e) {
							System.out.println("글 수정 중 삭제할 파일 삭제 에러 발생");
							e.printStackTrace();
						}
					}
				}else {
					System.out.println("비밀번호 포함 회원수정 변경 실패");
					if(newUpload!=null && !newUpload.equals("")){ // 올리려는 새 이미지가 있을 때
						try {
							File dFileObj=new File(path, newUpload);
							dFileObj.delete();
						}catch(Exception e) {
							System.out.println("새로 업로드된 파일 지우기 에러 발생");
							e.printStackTrace();
						}
					}
				}
			}else {
				if(service.memberUpdatePwdN(vo)>0) {
					System.out.println("비밀번호 미포함 회원수정 변경 성공");
					if(delFilename!=null) {
						try {
							File dFileObj=new File(path, delFilename);
							dFileObj.delete();
						}catch(Exception e) {
							System.out.println("글 수정 중 삭제할 파일 삭제 에러 발생");
							e.printStackTrace();
						}
					}
				}else {
					System.out.println("비밀번호 미포함 회원수정 변경 실패");
					if(newUpload!=null && !newUpload.equals("")){ // 올리려는 새 이미지가 있을 때
						try {
							File dFileObj=new File(path, newUpload);
							dFileObj.delete();
						}catch(Exception e) {
							System.out.println("새로 업로드된 파일 지우기 에러 발생");
							e.printStackTrace();
						}
					}
				}
			}
		}else {
			vo.setProfilePic(selFilename);
			if(!vo.getUserpwd().equals("")) { // 비밀번호를 바꾸려는 경우
				if(service.memberUpdatePwdY(vo)>0) {
					System.out.println("비밀번호 포함 회원수정 변경 성공");
				}else {
					System.out.println("비밀번호 포함 회원수정 변경 실패");
				}
			}else {
				if(service.memberUpdatePwdN(vo)>0) {
					System.out.println("비밀번호 미포함 회원수정 변경 성공");
				}else {
					System.out.println("비밀번호 미포함 회원수정 변경 실패");
				}
			}
		}
		
		// int pwdResult=service.memberPwdSelect(vo.getUserid(), vo.getUserpwd());
		/*
		System.out.println("아이디 : "+vo.getUserid());
		System.out.println("비밀번호 : "+vo.getUserpwd());
		System.out.println("연락처 전체 : "+vo.getTel());
		System.out.println("희망지역 전체1 : "+vo.getArea());
		System.out.println("희망1 : "+vo.getArea1());
		System.out.println("희망2 : "+vo.getArea2());
		System.out.println("희망3 : "+vo.getArea3());
		System.out.println("이메일 전체 : "+vo.getEmail());
		System.out.println("이메일 아이디 : "+vo.getEmailid());
		System.out.println("이메일 도메인 : "+vo.getEmaildomain());
		*/
		/*
		if(!vo.getUserpwd().equals("")) { // 비밀번호를 바꾸려는 경우
			System.out.println("비밀번호 O 회원수정 O");
			if(service.memberUpdatePwdY(vo)>0) {
				System.out.println("비밀번호 포함 회원수정 변경 성공");
			}else {
				System.out.println("비밀번호 포함 회원수정 변경 실패");
			}
		}else {
			System.out.println("비밀번호 X 회원수정 O");
			if(service.memberUpdatePwdN(vo)>0) {
				System.out.println("비밀번호 미포함 회원수정 변경 성공");
			}else {
				System.out.println("비밀번호 미포함 회원수정 변경 실패");
			}
		}
		*/
		mav.setViewName("redirect:memberEditForm");
		return mav;
	}
	
	@RequestMapping("/memberExitOk")
	public ModelAndView memberExitOk(String userpwd, HttpSession session) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		
		int result=service.memberPwdSelect(userid, userpwd);
		
		if(result>0) { // 비밀번호가 일치하는 경우
			System.out.println("일치하는 경우");
			service.memberExit(userid, userpwd);
			mav.addObject("pwdCheck", "일치");
			mav.setViewName("home");
			session.invalidate();
		}else { // 비밀번호가 일치하지 않는 경우
			System.out.println("일치하지않는 경우");
			mav.addObject("pwdCheck", "불일치");
			mav.setViewName("member/memberEdit");
		}
		
		return mav;
	}
	
	@RequestMapping("/memberProEdit")
	public ModelAndView memberProEdit(HttpSession session) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		
		int pcaseH=service.propPcaseH(userid);
		int noHouse=service.propHcnt(userid);
		
		mav.addObject("pcaseM", service.propPcaseM(userid)); // 메이트인 경우
		mav.addObject("pcaseH", pcaseH); // 하우스인 경우
		mav.addObject("noHouse", noHouse);
		if(pcaseH>0) {
			mav.addObject("list", service.houseproList(userid)); // 성향의 집이름과 하우스 글의 집이름이 동일한 레코드만 선택함
		}
		
		if(noHouse>0) {
			mav.addObject("noList", service.proNoHouse(userid)); // 집 이름이 없는 성향의 VO가 반환된다.
		}
		
		mav.setViewName("member/memberProEdit");
		return mav;
	}
	
	@RequestMapping("/proEditNoHouseForm")
	public ModelAndView proEditnoHouseForm(HttpSession session, int pno) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		int result=service.noHousePnoChk(userid, pno);
		
		if(result>0) { // 집 등록을 하지않은 내 하우스의 성향 맞는 경우
			mav.setViewName("member/proEditNoHouseForm");
			mav.addObject("pVO", service.propHouseSelect(userid, pno));
		}else { // 내 집이 아닌 경우
			mav.setViewName("redirect:memberProEdit");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/proEditNoHouseOk", method=RequestMethod.POST)
	public ModelAndView proEditNoHouseOk(PropensityVO pVO, HttpSession session) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		pVO.setUserid(userid);
		int result=service.propHouseUpdate(pVO);
		
		if(result>0) { // 성향 수정 성공
			System.out.println("No 성향 수정에 성공한 경우");
			// mav.addObject("pcaseH", service.propPcaseH(userid)); // 하우스인 경우 >????
			
			// 내 하우스 성향의 갯수를 구한다.(프리미엄인 하우스에게 메이트 매칭 목록을 띄워주기 위해)
			int myHousePnoCnt=listService.myHousePnoCount(userid);
			if(myHousePnoCnt>0) {
				int newHpno=listService.newHpno(userid); // 내 최신 하우스 성향을 세션에 저장한다.
				session.setAttribute("hPno", newHpno);
			}
						
			mav.setViewName("redirect:memberProEdit");
		}else { // 성향 수정 실패
			System.out.println("No 성향 수정에 실패한 경우");
			mav.addObject("fail", "fail");
			mav.setViewName("member/proEditHouseForm");
			// mav.setViewName("member/proEditHouseForm");
			// 나중에는 history.back()을 해줘야 할듯
		}
		
		return mav;
	}
	
	// 집 이름이 없는 성향 삭제
	@RequestMapping("/proDelNoHouse")
	public ModelAndView proDelNoHouse(HttpSession session, int pno) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		int result=service.noHousePnoChk(userid, pno);
		
		if(result>0) { // 집 등록을 하지않은 내 하우스의 성향인 경우
			int delResult=service.proDelNoHouse(userid, pno);
			if(delResult>0) { // 성향 삭제 성공
				System.out.println("성향 삭제 성공");
				
				// 내 하우스 성향의 갯수를 구한다.(프리미엄인 하우스에게 메이트 매칭 목록을 띄워주기 위해)
				int myHousePnoCnt=listService.myHousePnoCount(userid);
				if(myHousePnoCnt>0) {
					int newHpno=listService.newHpno(userid); // 내 최신 하우스 성향을 세션에 저장한다.
					session.setAttribute("hPno", newHpno);
				}
			}else { // 성향 삭제 실패
				System.out.println("성향 삭제 실패");
			}
		}
		mav.setViewName("redirect:memberProEdit");
		
		return mav;
	}
	
	// 집 이름이 있지만 모집중이 아닌 성향 삭제
	@RequestMapping("/proDelHouse")
	public ModelAndView proDelHouse(HttpSession session, int pno) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		int result=service.noHousePnoChk(userid, pno);
		
		if(result>0) {
			int mozipNoCnt=service.housestateCheck(pno);
			if(mozipNoCnt>0) {
				int delResult=service.proDelNoHouse(userid, pno);
				if(delResult>0) { // 성향 삭제 성공
					System.out.println("성향 삭제 성공");
					
					// 내 하우스 성향의 갯수를 구한다.(프리미엄인 하우스에게 메이트 매칭 목록을 띄워주기 위해)
					int myHousePnoCnt=listService.myHousePnoCount(userid);
					if(myHousePnoCnt>0) {
						int newHpno=listService.newHpno(userid); // 내 최신 하우스 성향을 세션에 저장한다.
						session.setAttribute("hPno", newHpno);
					}
				}else { // 성향 삭제 실패
					System.out.println("성향 삭제 실패");
				}
			}else {
				System.out.println("모집중인 하우스의 성향은 삭제가 불가능합니다.");
			}
		}
		mav.setViewName("redirect:memberProEdit");
		
		return mav;
	}
	
	@RequestMapping("/proEditHouseForm")
	public ModelAndView proEditHouseForm(HttpSession session, int pno) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		int result=service.pnoCheck(userid, pno);
		
		if(result>0) { // 내 집이 맞는 경우
			mav.setViewName("member/proEditHouseForm");
			mav.addObject("pVO", service.propHouseSelect(userid, pno));
		}else { // 내 집이 아닌 경우
			mav.setViewName("redirect:memberProEdit");
		}
		
		return mav;
	}
	
	@RequestMapping("/proEditMateForm")
	public ModelAndView proEditMateForm(HttpSession session) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		PropensityVO pVO=service.propMateSelect(userid);
		System.out.println("Str->"+pVO.getH_supportStr());
		System.out.println("배열->"+pVO.getH_support());
		MemberVO vo=service.memberSelect(userid);
		/*
		System.out.println("성향 번호 : "+pVO.getPno());
		System.out.println("아이디 : "+pVO.getUserid());
		System.out.println("분류 : "+pVO.getPcase());
		System.out.println("집 이름 : "+pVO.getHousename());
		System.out.println("집 생활소음 : "+pVO.getH_noise());
		System.out.println("집 생활 시간 : "+pVO.getH_pattern());
		System.out.println("집 애완 동물 : "+pVO.getH_pet());
		System.out.println("집 애완 동물 동반 입실 : "+pVO.getH_petwith());
		System.out.println("집 흡연 : "+pVO.getH_smoke());
		System.out.println("집 분위기 : "+pVO.getH_mood());
		System.out.println("집 소통 방식 : "+pVO.getH_communication());
		System.out.println("집 모임 빈도 : "+pVO.getH_party());
		System.out.println("집 모임 참가 의무 : "+pVO.getH_enter());
		System.out.println("집 지원 : "+pVO.getH_supportStr());
		System.out.println("집 기타 : "+pVO.getH_etcStr());
		System.out.println("메이트 생활 시간 : "+pVO.getM_pattern());
		System.out.println("메이트 성격 : "+pVO.getM_personality());
		System.out.println("메이트 애완 동물 : "+pVO.getM_pet());
		System.out.println("메이트 흡연 여부 : "+pVO.getM_smoke());
		System.out.println("메이트 나이 : "+pVO.getM_age());
		System.out.println("메이트 성별 : "+pVO.getM_gender());
		System.out.println("메이트 외국인 입주 가능 여부 : "+pVO.getM_global());
		System.out.println("메이트 즉시 입주 가능 여부 : "+pVO.getM_now());
		System.out.println("성향 등록일 : "+pVO.getPdate());
		*/
		mav.addObject("vo", vo);
		mav.addObject("pVO", pVO);
		mav.setViewName("member/proEditMateForm");
		
		return mav;
	}
	
	@RequestMapping(value="/proEditMateOk", method=RequestMethod.POST)
	public ModelAndView proEditMateOk(PropensityVO pVO, HttpSession session) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		pVO.setUserid(userid);
		
		int result=service.propMateUpdate(pVO);
		
		if(result>0) { // 성향 수정 성공
			System.out.println("성향 수정에 성공한 경우");
			mav.setViewName("redirect:memberProEdit");
		}else { // 성향 수정 실패
			System.out.println("성향 수정에 실패한 경우");
			mav.addObject("fail", "fail");
			mav.setViewName("member/historyBack");
			// mav.setViewName("member/proEditMateForm");
			// 나중에는 history.back()을 해줘야 할듯
		}
		
		return mav;
	}
	
	@RequestMapping(value="/proEditHouseOk", method=RequestMethod.POST)
	public ModelAndView proEditHouseOk(PropensityVO pVO, HttpSession session) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		pVO.setUserid(userid);
		
		int result=service.propHouseUpdate(pVO);
		
		if(result>0) { // 성향 수정 성공
			System.out.println("성향 수정에 성공한 경우");
			// mav.addObject("pcaseH", service.propPcaseH(userid)); // 하우스인 경우 >????
			
			// 내 하우스 성향의 갯수를 구한다.(프리미엄인 하우스에게 메이트 매칭 목록을 띄워주기 위해)
			int myHousePnoCnt=listService.myHousePnoCount(userid);
			if(myHousePnoCnt>0) {
				int newHpno=listService.newHpno(userid); // 내 최신 하우스 성향을 세션에 저장한다.
				session.setAttribute("hPno", newHpno);
			}
			mav.setViewName("redirect:memberProEdit");
		}else { // 성향 수정 실패
			System.out.println("성향 수정에 실패한 경우");
			mav.addObject("fail", "fail");
			mav.setViewName("member/historyBack");
			// mav.setViewName("member/proEditHouseForm");
			// 나중에는 history.back()을 해줘야 할듯
		}
		
		return mav;
	}
	
	@RequestMapping("/proInsertForm")
	public ModelAndView proInsert(HttpSession session) {
		ModelAndView mav=new ModelAndView();
		
		mav.setViewName("member/proInsertForm");
		return mav;
	}
	
	@RequestMapping("/proInsertOk")
	public ModelAndView proInsertOk(PropensityVO pVO, HttpSession session) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		pVO.setUserid(userid);
		pVO.setPcase("m");
		int result=service.propInsert(pVO);
		if(result>0) { // 성향 등록 성공
			mav.setViewName("redirect:memberProEdit");
		}else {
			mav.setViewName("member/historyBack");
			// mav.setViewName("redirect:proInsertForm");
			// history.back(); 해야할듯
		}
		
		return mav;
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/memberFind")
	public String memberFind() {
		return "member/memberFind";
	}
	
	@RequestMapping(value="/memberFindId", method=RequestMethod.POST)
	public ModelAndView memberFindId(MemberVO vo) {
		ModelAndView mav=new ModelAndView();
		
		String result=service.memberFindId(vo);
		
		if(result!=null) { // 입력한 정보에 맞는 아이디가 있는 경우
			mav.addObject("findId", result);
		}else { // 입력한 정보에 맞는 아이디가 없는 경우
			mav.addObject("findNotId", "no");
		}
		
		mav.setViewName("member/memberFind");
		return mav;
	}
	
	@RequestMapping("/sample")
	public String sample() {
		return "sample";
	}
}
