package com.seoulmate.home.controller;

import java.util.ArrayList;
import java.util.HashMap;

import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.seoulmate.home.service.MypageService;
import com.seoulmate.home.vo.ApplyInviteVO;
import com.seoulmate.home.vo.ChatRoomVO;
import com.seoulmate.home.vo.HouseWriteVO;
import com.seoulmate.home.vo.LikeMarkVO;
import com.seoulmate.home.vo.MateWriteVO;
import com.seoulmate.home.vo.PagingVO;
import com.seoulmate.home.vo.PayVO;
@Controller
public class MypageController {
	@Inject
	MypageService service;
	
	//마이페이지 하우스&메이트 관리 
	@RequestMapping(value="/myHouseAndMateList", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView myHouseAndMateList(HttpSession session, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		try {
		String msg = req.getParameter("msg");
		
		//기본 하우스로 세팅.
		//1. 세션아이디, 등급(일반 /프리미엄) 
		String userid = (String)session.getAttribute("logId");
		List<HouseWriteVO> hwList = new ArrayList<HouseWriteVO>();
		//로그인한 사람이 (mate성향가입자인지, house성향 가입자인지 확인) 
		String memberCheck = "";
		//1. 하우스로 등록된 성향으로 작성된 글이 있는지 확인.
		if( service.houseConfirm(userid)>0) {
			//1개이상 작성된 글이 있는 경우. 
			//1-1. 후 목록 가져오기 (모집중이 아닌것도 모두 가져온다,) 
			hwList = service.myPageHouseWriteSelect(userid);
			if(!hwList.isEmpty()) {
				msg = "house";
			}
			mav.addObject("hwList", hwList);
		}
		//2. 메이트로 등록된 성향+글이 있는지 확인. 
		MateWriteVO mwVO = new MateWriteVO();
		if(service.mateConfirm(userid)>0) {
			//2-1. 후 목록 가져오기
			mwVO= service.myPageMateWriteSelect(userid);
			if(mwVO.getUserid()!=null) {
				msg = "mate";
			}
			mav.addObject("mwVO", mwVO);
			// 하우스 글이 없을 경우엔 mate로 메세지 변경.
		}
		//3, likemark가 있는 지 확인. 
		if(service.likeMarkConfirm(userid)>0) {
			//3. likemark List 확인. (lno, no, category(하우스 or 메이트) 
			 List<LikeMarkVO> lmConfirm = service.likeMarkSelect(userid);
			 
			 List<HouseWriteVO> houseLikeList = new ArrayList<HouseWriteVO>();
			 List<MateWriteVO> mateLikeList = new ArrayList<MateWriteVO>();
			 
			 LikeMarkVO lmVO = new LikeMarkVO();
			 HouseWriteVO hCheckVO = new HouseWriteVO();
			 MateWriteVO mCheckVO = new MateWriteVO();
			int no=0;
			String category = "";
			if(lmConfirm.size()>0) {
	System.out.println("lmConfirm = "+ lmConfirm.size());
				for(int i=0; i<lmConfirm.size(); i++) {
					no = lmConfirm.get(i).getNo(); //하우스 글번호.
					lmVO.setNo(no);
					lmVO.setUserid(userid);
					
					category = lmConfirm.get(i).getCategory();
					if(category.equals("하우스")){ //
						//하우스를 찜 했을 경우. 
						
						// 1. 로그인한 사람이 메이트인경우, 
						
						// 2, 로그인한 사람이 하우스인경우 
						
						// 메이트가 작성한 no가 없기때문에 문제가 생긴다. 
						hCheckVO = service.houseLikeSelect(lmVO);
						if(hCheckVO!=null) {
	System.out.println("hCheckVO"+ hCheckVO.getNo());
							houseLikeList.add(hCheckVO);
						}
					}
					if(category.equals("메이트")){
						// 메이트글 일경우엔 mateWriteVO를 넣는다.
						//메이트를 찜 했을 경우
//						if(session.getAttribute("hPno")!=null) {
//							pno = (Integer)session.getAttribute("hPno");
//						}else {
//							pno=0;
//						}
						// 로그인한 사람이 하우스. 
						mCheckVO = service.mateLikeSelect(lmVO);
						if(mCheckVO!=null) {
System.out.println("mCheckVO"+ mCheckVO.getNo());							
							mateLikeList.add(mCheckVO);
						}
					}
				}
				mav.addObject("houseLikeList", houseLikeList);
				mav.addObject("mateLikeList", mateLikeList);
			}	
		}  
		List<ApplyInviteVO> aiVO_List = new ArrayList<ApplyInviteVO>();
		aiVO_List= service.applyInviteList(userid);
		mav.addObject("aiVO_List", aiVO_List);
		
		if(session.getAttribute("hPno")!=null) {
			memberCheck = "houseMem";
		}else{
			memberCheck = "mateMem";
		}
		if(msg==null || msg.equals("")) {
			msg = "house";
		}
		mav.addObject("memberCheck", memberCheck);
//		if(msg==null || msg.equals("")) {
//			if(service.pnoConfirm(userid, "m")>0) {
//				// mate 로 등록된 pno가 있다면
//				msg = "mate";
//			}
//			if(service.pnoConfirm(userid, "h")>0) {
//				// house 로 등록된 pno가 있다면, 
//				msg = "house";
//			}
//		}
		mav.addObject("msg", msg);
		mav.setViewName("mypage/myHouseAndMateList");
		} catch (Exception e) {
			mav.setViewName("mypage/myHouseAndMateList");
			e.printStackTrace();
		}
		return mav;
	}
	//마이페이지 팝업 
	@RequestMapping(value="/mypagePopup", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public Map<String, Object> mypagePopup(int no, String msg, HttpServletRequest req){
		Map<String, Object> result = new HashMap<String, Object>();
		ApplyInviteVO aiVO = new ApplyInviteVO();
		aiVO.setNo(no);
		aiVO.setMsg(msg);
		aiVO.setUserid((String)req.getSession().getAttribute("logId"));
		
		List<ApplyInviteVO> aiList = new ArrayList<ApplyInviteVO>();
		aiList =  service.applyInviteSelect(aiVO);
		if(aiList.size()>0) {
			result.put("aiList", aiList);
			// 하우스 기준
			if(msg.equals("takeApply") || msg.equals("sendInvite")) {
				//받은 신청  // 보낸초대 
				List<MateWriteVO> pop_mwVO = new ArrayList<MateWriteVO>();
				for(int i=0; i<aiList.size(); i++) {
					pop_mwVO.add(service.myPageMateWriteSelect(aiList.get(i).getUserid()));
				}
				result.put("pop_mwVO", pop_mwVO);
			}//메이트 기준
			else if(msg.equals("takeInvite") || msg.equals("sendApply")) {
				List<HouseWriteVO> pop_hwVO = new ArrayList<HouseWriteVO>();
				//받은초대  or 보낸 신청
				// list값 중에서 no를 사용하여 리스트를 가져온다.  
				for(int i=0; i<aiList.size(); i++) {
					System.out.println("aiList.get(i).getNo())=="+aiList.get(i).getNo());
					pop_hwVO.add(service.oneHouseWriteSelect(aiList.get(i).getNo()));
				}
				result.put("pop_hwVO", pop_hwVO);
			}
		}
		return result;
	}
	// 하우스 리스트 받아오기 houseListSelect
	//초대하기, 신청하기 
	@RequestMapping(value="/houseListSelect", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public List<HouseWriteVO> houseListSelect(HttpSession session, String selectMate) {
		List<HouseWriteVO> hwList = new ArrayList<HouseWriteVO>();
		
		String userid = (String)session.getAttribute("logId");
		hwList = service.houseListSelect(userid, selectMate);
		return hwList;	
	}
	@RequestMapping(value="/applyInsert", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public int applyInsert(int no, String msg, String userid) {
		ApplyInviteVO aiVO = new ApplyInviteVO();
		System.out.println("신청 = >하우스글번호="+no+"  신청msg="+msg + " 메이트자신userid="+userid);
		// 메이트가 하우스한테 신청한거 
		// no = 하우스글번호가 맞고 , userid=나자신ㅅ-세션아이디 맞고,  //msg=신청이 맞음 
		aiVO.setNo(no);
		aiVO.setUserid(userid);
		aiVO.setMsg(msg);
		int result=0;
		if(userid==null || userid.equals("")) {
			result = -1;
		}else {
			int r = service.checkApplyInvite(aiVO);
			System.out.println("r? = "+ r);
			if(r>0) {
				result = 0;
			}else {
				result = service.applyInviteInsert(aiVO);
			}
		}
		return result;
	}
	@RequestMapping(value="/inviteInsert", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public int inviteInsert(String msg, String userid, String housename) {
		ApplyInviteVO aiVO = new ApplyInviteVO();
		System.out.println(" 신청msg="+msg + " 메이트자신userid="+userid);
		
		int no = service.housenameSelect(housename);
		// 하우스가 메이트에게 초대한것
		// 위에서 받아온 no는 메이트의 글번호임.. 
		// 위에서 받아온 userid는 하우스의 유저아이디임.. 
		// 세션에있는 no 를 받아오면된다.  
		// no = 하우스글번호,  // userid = 내가 초대를한 메이트의 아이디,  // msg = 초대 
		aiVO.setNo(no);
		aiVO.setUserid(userid);
		aiVO.setMsg(msg);
		
		int result=0;
		
		int r = service.checkApplyInvite(aiVO);
		System.out.println("r? = "+ r);
		if(r>0) {
			result = 0;
		}else {
			result = service.applyInviteInsert(aiVO);
		}
		return result;
	}
	
	//마이페이지 보낸신청, 보낸초대 취소 ,  받은신청, 받은초대- 거절
	@RequestMapping(value="/mypageApplyInviteCancel", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public int mypageApplyInviteCancel(int no, String msg, String userid) {
		ApplyInviteVO aiVO = new ApplyInviteVO();
		aiVO.setNo(no);
		aiVO.setMsg(msg);
		aiVO.setUserid(userid);
		//sendInvite 보낸초대 취소 (house -> mate 초대를 취소함) 
		 	// no=본인글 , userid='초대받은사람 ', state='초대 '
		// takeApply 받은 신청 거절 (mate -> house 신청을 거절 함)
			 // no=본인글 , userid='신청한사람', state='신청'
		//sendApply 보낸신청 취소  (mate -> house 신청을 취소함)
			// no=신청한 하우스글,  userid=본인아이디, state='신청'
		// takeInvite 받은초대 거절 (house->mate 초대를 거절함) 
			// no=날초대한 하우스글, userid=본인아이디, state='초대'
		
		// 신청자 본인 아이디와 글번호를 확인하여 삭제. mypageSendApplyInviteCancel
		int result =0;
		result = service.mypageApplyInviteCancel(aiVO);
		return result;
	}
	//마이페이지 받은신청, 받은초대 승인
	@RequestMapping(value="/applyInviteApprove", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public int applyInviteApprove(int no, String userid, String msg, HttpSession session) {
		ApplyInviteVO aiVO = new ApplyInviteVO();
		aiVO.setNo(no);
		aiVO.setMsg(msg);
		aiVO.setUserid(userid);
		
		System.out.println("no = "+no);
		System.out.println("msg = "+msg);
		System.out.println("userid = "+userid);
		ChatRoomVO crVO = new ChatRoomVO();
		int inResult = 0;
		String name = "";
		try {
			int result = service.applyInviteApproveUpdate(aiVO);
			// 승인 완료 후 
			if(result>0) {
				//채팅방 insert 
				HouseWriteVO hwVO = service.chatHouseSelect(no);
				name = hwVO.getHousename() +" ("+userid+")";
				if(msg.equals("takeApply")) {
					//받은신청// 신청 승낙했다. 세션 에있는 아이디가 나 (=글쓴이) , 신청햇던사람은 현재userid
					String chatuser1 = (String)session.getAttribute("logId");
					// DB에 있는 정보인지 확인
					crVO = service.chatCheck(chatuser1, userid);
					try {
						if(crVO.getNo() != 0) {
							//받은 신청에 이미 채팅방이 있다
							service.chatCheckName(hwVO.getHousename(), chatuser1, userid);
							if(service.chatCheckName(hwVO.getHousename(), chatuser1, userid)>0) {
								//이미 들어가있는 이름. 
								inResult = 200;
							}else {
								//없다 이름 합쳐서 업데이트 
								String crVO_name = crVO.getName();
								String chatName = crVO_name.substring(0, crVO_name.indexOf("("+userid+")")-1);
								name = chatName+", "+hwVO.getHousename() +" ("+userid+")";
								crVO.setName(name);
								int up = service.chatUpdate(crVO);
								if(up>0) {
									inResult = 200;
								}else {
									System.out.println("name update 에러");
									inResult = -1; 
								}
							}
						}
					} catch (NullPointerException e) {
						//채팅방이 없다 -> 개설한다. 
						//1. name 받아오기,   2.chatuser1 = 수락한사람, 3.chatuser2 = 신청한사람 (나머지 디폴트 = 0)
						//name 은 하우스글 이름
						// no를 이용해서 해당유저아이디, 해당 하우스네임 가져오기 . 
													//	 housewrite글쓴이,  신청자(메이트) 
						inResult = service.chatInsert(name, chatuser1, userid);
					}
				}else if(msg.equals("takeInvite")) {
					crVO = service.chatCheck(hwVO.getUserid(), userid);
					try {
						if(crVO.getNo() != 0) {
							System.out.println("crVO.getNo = " + crVO.getNo());
							//받은 초대에 이미 채팅방이 있다
							service.chatCheckName(hwVO.getHousename(), hwVO.getUserid(), userid);
							if(service.chatCheckName(hwVO.getHousename(), hwVO.getUserid(), userid)>0) {
								//이미 들어가있는 이름. 
								inResult = 200;
							}else {
								//없다 이름 합쳐서 업데이트 
								String crVO_name = crVO.getName();
								String chatName = crVO_name.substring(0, crVO_name.indexOf("("+userid+")")-1);
								name = chatName+", "+hwVO.getHousename() +" ("+userid+")";
								crVO.setName(name);
								int up = service.chatUpdate(crVO);
								if(up>0) {
									inResult = 200;
								}else {
									System.out.println("name update 에러");
									inResult = -1; 
								}
							}
						}
					} catch (NullPointerException e) {
						// 널값일경우 (채팅방이 없는 경우) 
						//채팅방이 없다 -> 개설한다. 
						//받은 초대// 초대를 승낙했다. 승낙한사람 = 현재 userid,  승낙한 글번호 = no -> no를 이용하여 해당유저아이디 셀렉트 
						//1. 글번호의 userid 가져오기     //본인 초대한하우스   	 //하우스글쓴이      메이트본인 	
						inResult = service.chatInsert(name, hwVO.getUserid(), userid);
					}
				}//end else if(msg.equals("takeInvite")) {
			}else {
				System.out.println("??? 왜 업데이트부터 오류납니까 ?");
			}
		}catch (Exception e) {
			e.printStackTrace();
			//초대, 신청 승낙 및 채팅방 insert 에러 발생 
			System.out.println("초대, 신청 승낙 및 채팅방 insert 에러 발생 ");
			inResult = -1; 
		}
		return inResult;
	}
	//매칭완료 
	@RequestMapping("/stateComplete")
	@ResponseBody
	public int stateComplete(int no, HttpSession session) {
		String userid = (String)session.getAttribute("logId");
		//noConfirmHouseOrMate 
		int result = 0;
		if(service.noConfirmHouseOrMate(no, "houseWrite")>0) {
			// no가 하우스글 인 경우 
			// state를 매칭완료료 변경한다. 
			result = service.stateCompleteUpdate("houseWrite", "houseState", Integer.toString(no), userid);

		}else if(service.noConfirmHouseOrMate(no, "mateWrite")>0) {
			result = service.stateCompleteUpdate("mateWrite", "houseState", Integer.toString(no), userid);
		}else {
			result=200;
		}
		return result;
	}
	//찜 등록
	@RequestMapping("/likemarkInsert")
	@ResponseBody
	public int likemarkInsert(int no, String userid, String category) {
		return service.likemarkInsert(no, userid, category);
	}
	//찜 삭제
	@RequestMapping("/likemarkDelete")
	@ResponseBody
	public int likemarkDelete(int no, String userid) {
		int result =  service.likemarkDelete(no, userid);
		return result;
	}
	// 인덱스 / 하우스 / 메이트에 들어가면 내가 찜한 글인지 확인 처리
	@RequestMapping("/likemarkCheck")
	@ResponseBody
	public Object likemarkCheck(String userid) {
		Map<String, String[]> likeMarkMap = new HashMap<String, String[]>();
		
		//로그인한 사용자의 글은 별 버튼 없애기 용
		String[] housePosts = service.getUsersHouseWriteNum(userid);//하우스글번호 가져오기
		if(housePosts != null) {
			likeMarkMap.put("houseNum", housePosts);
		}
		String[] matePosts = service.getUsersMateWriteNum(userid);//메이트글번호 가져오기
		if(matePosts != null) {
			likeMarkMap.put("mateNum", matePosts);
		}
		//사용자가 찜한 글 번호 다 가져오기 -> 로그인후 찜한 글 별 on 만들기용
		String[] userNum = service.getLikedNumber(userid);
		likeMarkMap.put("userLikeNum", userNum);
		
//		Gson gson = new Gson();
//		return gson.toJson(userNum);
		return likeMarkMap;
	}
	//마이페이지 결제내역 확인 페이지
	@RequestMapping(value="/payDetailList", method={RequestMethod.POST, RequestMethod.GET})
	public ModelAndView payDetailList(HttpSession session, PagingVO pagingVO, PayVO pVO) {
		ModelAndView mav = new ModelAndView();
		
		String userid = (String)session.getAttribute("logId");
		pVO.setUserid(userid);
		
		pagingVO.setTotalPage(service.payRecordCnt(userid));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pVO", pVO);
		map.put("pagingVO", pagingVO);
		mav.addObject("payList", service.payList(map));
		if(pagingVO.getPageNum()>pagingVO.getTotalPage()) {
			pagingVO.setPageNum(pagingVO.getTotalPage());
		}
		if(pagingVO.getPageNum()==0) {
			pagingVO.setPageNum(1);
		}
		if(pagingVO.getTotalPage()==0) {
			pagingVO.setTotalPage(1);
		}
		mav.addObject("pVO", pVO);
		mav.addObject("pagingVO", pagingVO);
		
		mav.setViewName("mypage/payDetailList");
		return mav;
	}
	//houseView, mateView에서 찜하기 등록. 
	@RequestMapping("/likemarkerInsert")
	@ResponseBody
	public int likemarkerInsert(int no, String userid, String msg) {
		// 1.house넘버, mate의 유저아이디 select 해서 있는지 확인. 
		int check = 0;
		int result = 0;
		check = service.likemarkerSelect(no, userid, msg);
		System.out.println("check ?"+check);
		if(check > 0) {
			// 찜한내역이 있음
			result = 0; 
		}else if(check==0){
			//찜한내역이 없음 insert 한다. 
			try {
				result=service.likemarkInsert(no, userid, msg);
				System.out.println("result ?"+result);
				if(result > 0) {
					//찜등록 완료
					result = 1;
				}else {
					//찜 등록실패 
					result=-1;
				}
			} catch (Exception e) {
				result= 2;
			}
		}
		return result;
	}
}
