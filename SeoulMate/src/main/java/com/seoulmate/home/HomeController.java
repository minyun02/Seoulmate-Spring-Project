package com.seoulmate.home;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.seoulmate.home.service.HomeService;
import com.seoulmate.home.service.ListService;
import com.seoulmate.home.service.MemberService;
import com.seoulmate.home.vo.HouseRoomVO;
import com.seoulmate.home.vo.HouseWriteVO;
import com.seoulmate.home.vo.ListVO;
import com.seoulmate.home.vo.MateWriteVO;
import com.seoulmate.home.vo.MemberVO;
import com.seoulmate.home.vo.PropensityVO;

@Controller
public class HomeController {
	
	@Inject
	HomeService service;
	@Inject
	MemberService memberService;
	@Inject
	ListService listService;
	
	
	/*
	 * @RequestMapping("/chat") public ModelAndView chat() { ModelAndView mav = new
	 * ModelAndView(); mav.setViewName("chat/chatting"); return mav; }
	 */	
	@SuppressWarnings("null")
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(HttpSession session, String addr, String area, String rent, String deposit, String m_gen, String gender) {
		ModelAndView mav = new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		
		// home에는 월세 필터가 없어서
		int rentInt=0;
		if(rent!=null && !rent.equals("")) {
			rentInt=Integer.parseInt(rent);
		}
		
		int depositInt=0;
		if(deposit!=null && !deposit.equals("")) {
			depositInt=Integer.parseInt(deposit);
		}
		
		int m_genInt=0;
		if(m_gen!=null && !m_gen.equals("")) {
			m_genInt=Integer.parseInt(m_gen);
		}
		
		int genderInt=0;
		if(gender!=null && !gender.equals("")) {
			genderInt=Integer.parseInt(gender);
		}
		
		// 로그인전 하우스 맵 정보 구하기
	      List<ListVO> houseMapList = service.getHouseMap();
	      if(houseMapList.get(0)!=null){ // else if(phList!=null)
	         HouseRoomVO hrVO = new HouseRoomVO();
	         for (ListVO hwVO : houseMapList) {
	            // 각 쉐어하우스의 제일 저렴한 월세 가져오기
	            hrVO = service.getDesposit(hwVO.getNo());
	            
	            hwVO.setDeposit(hrVO.getDeposit());
	            hwVO.setRent(hrVO.getRent());
	            
	            int index=hwVO.getAddr().indexOf(" ");
				String ad=hwVO.getAddr().substring(index+1); // XX구 XX동 XX-XX XX
				
				int guIdx=ad.indexOf("구 ");
				
				String gu=ad.substring(0, guIdx+2); // 'XX구 ' 
				String gu1=ad.substring(guIdx+2); // 'XX동 XX-XX XX'
				
				int dongIdx=gu1.indexOf(" ");
				
				String dong=gu1.substring(0, dongIdx); // 'XX동'
				//hwVO.setAddr(gu+dong);
				
				hwVO.setShort_addr(gu+dong);
	         }
	         mav.addObject("houseMapList", houseMapList);
	      }
		
		// 로그인전 메이트 맵 정보 구하기
		String[] getMateList = service.getMateMap();
		String[] mateListArr = null;
		String[] mateMapList = null;
		String arr = "";
		
		for (int i = 0; i < getMateList.length; i++) {
			mateListArr = getMateList[i].split("/");
			for (String j : mateListArr) {
				arr += "'" + j + "',";
			}
		}
		mateMapList = arr.split(",");
		arr = Arrays.toString(mateMapList);
		mav.addObject("mateMapList",arr);
		
		//////////////////////////////////////////////////
		
		if(session.getAttribute("logId")!=null) {
			MemberVO memberVO = new MemberVO();
			memberVO = memberService.memberSelect((String)session.getAttribute("logId"));
			mav.addObject("memberVO", memberVO);
		}
		
		if(session.getAttribute("logId")!=null) {
			int logGrade=(Integer)session.getAttribute("logGrade");
			// 프리미엄일 때만
			if(logGrade==2) {
				// 메이트의 희망 성별 가져오기
				int matePnoCheck=listService.myMatePnoCheck(userid);
				
				mav.addObject("matePnoCheck", matePnoCheck); // 메이트 번호의 갯수를 반환한다.
				
				if(matePnoCheck>0) { // 메이트 성향이 있을 때만 매칭된 하우스 목록을 띄워준다.
					int m_gender=listService.mate_m_gender(userid);
					
					// 쉐어하우스 매칭 리스트 구하기
					List<ListVO> phList = listService.premiumHouseList(userid, m_gender, addr, rentInt, depositInt, m_genInt); // PremiumHouseList
					if(phList.size()>0) {
						if(phList.get(0)!=null){ // else if(phList!=null)
	//						HouseRoomVO phhrVO = new HouseRoomVO();
							for (ListVO phVO : phList) {
								// 하우스 구, 동 띄우기
								int index=phVO.getAddr().indexOf(" ");
								String ad=phVO.getAddr().substring(index+1); // XX구 XX동 XX-XX XX
								
								int guIdx=ad.indexOf("구 ");
								
								String gu=ad.substring(0, guIdx+2); // 'XX구 ' 
								String gu1=ad.substring(guIdx+2); // 'XX동 XX-XX XX'
								
								int dongIdx=gu1.indexOf(" ");
								
								String dong=gu1.substring(0, dongIdx); // 'XX동'
								phVO.setAddr(gu+dong);
							}
							mav.addObject("phList", phList);
						}
					}
				}
				
			}
		}
		
		/////////////////////////////////////////////////////////////////////////
		Calendar cal = Calendar.getInstance();
        int y  = cal.get(Calendar.YEAR);
        int m = cal.get(Calendar.MONTH) + 1;
        int d   = cal.get(Calendar.DAY_OF_MONTH);
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        String today = format.format(cal.getTime());
        
		// 내 하우스 성향 가져오기
		if(session.getAttribute("logId")!=null) {
			int myHousePnoCnt=listService.myHousePnoCount(userid);
			mav.addObject("myHousePnoCnt", myHousePnoCnt);
			if(myHousePnoCnt>0) { // 하우스 성향이 있는 경우
				List<PropensityVO> myHousePnoList=listService.myHousePno(userid);
				mav.addObject("myHousePno", myHousePnoList);
			}
		}
		
		
		// 매칭
		if(session.getAttribute("logId")!=null) {
			int logGrade=(Integer)session.getAttribute("logGrade");
			// 프리미엄일 때만
			if(logGrade==2) {
				// 메이트의 희망 성별 가져오기
				int housePnoCheck=listService.myHousePnoCount(userid);
				
				mav.addObject("housePnoCheck", housePnoCheck); // 하우스 번호의 갯수를 반환한다.(하우스 성향이 없는 사람이 있기 때문에)
				
				if(session.getAttribute("hPno")!=null) {
					int pno=(Integer)session.getAttribute("hPno"); // 로그인 후에 세션에 저장된 하우스 성향 번호를 가져온다.
					
					if(housePnoCheck>0) { // 메이트 성향이 있을 때만 매칭된 하우스 목록을 띄워준다.
						int m_gender=listService.house_m_gender(userid, pno);
						// 메이트 매칭 리스트 구하기
						List<ListVO> pmList = listService.premiumMateList(userid, pno, m_gender, area, rentInt, depositInt, genderInt);
						if(pmList.size()>0) {
							if(pmList.get(0)!=null) {
								for(ListVO pmVO : pmList) {
									MemberVO mVO=service.getDetail(pmVO.getUserid());
									pmVO.setGender(mVO.getGender());
									
									// 생년월일을 받아서 만 나이로 처리
									String b=mVO.getBirth();
									int i=b.indexOf(" 00");
									b=b.substring(0, i+1);
									String birth[]= b.split("-");
									int bYear=Integer.parseInt(birth[0]);
									int bMonth=Integer.parseInt(birth[1]);
									int bDay=Integer.parseInt(birth[2].replace(" ", ""));
									int age=(y-bYear);
									
									// 생일이 안 지난 경우 -1
									if(bMonth * 100 + bDay > m * 100 + d) {
										age--;
									}
									String BrithAge=age+"";
									pmVO.setBirth(BrithAge);
									
									// 입주 디데이 0일때 즉시 문자열 처리
									String e =pmVO.getEnterdate();
									int ee = e.indexOf(" ");
									e = e.substring(0, ee+1);
									e = e.replace(" ", "");
									String enterNum = e.replace("-", "");
									
									Date enterDate = null;
									Date todayDate = null;
									try {
										enterDate = format.parse(enterNum);
										todayDate=format.parse(today);
									} catch (ParseException e1) {
										e1.printStackTrace();
									}
									
									long calDate = enterDate.getTime() - todayDate.getTime();
									int calDateDays = Math.round(calDate / (24*60*60*1000));
									
									String enterDay = "";
									if (calDateDays >= 0 && calDateDays <=7) {
										enterDay = "즉시";
									}else {
										enterDay = (calDateDays) + "일";
									}
									pmVO.setEnterdate(enterDay);
								}
								mav.addObject("pmList", pmList);
							}
						}
						
					}
				}
			}
		}
		
		// 쉐어하우스 최신리스트 구하기
		int MyMpnoCnt=0;
		if(session.getAttribute("logId")!=null) {
			if(listService.myMatePnoCheck(userid)>0) {
				MyMpnoCnt=listService.myMatePnoCheck(userid);
			}
		}
		
		
//		int MyMpnoCnt=listService.myMatePnoCheck(userid); // 내 메이트 성향 갯수 가져오기
		List<HouseWriteVO> nhList = service.getNewHouse(addr);
		HouseRoomVO hrVO = new HouseRoomVO();
		for (HouseWriteVO hwVO : nhList) {
			// 각 쉐어하우스의 제일 저렴한 월세 가져오기
			hrVO = service.getDesposit(hwVO.getNo());
			
			if(session.getAttribute("logId")!=null) {
				if((Integer)session.getAttribute("logGrade")==2) {
					if(MyMpnoCnt>0) {
						ListVO scoreVO=listService.premiumHouseScore(userid, hwVO.getPno());
//						if(scoreVO!=null) {
							hwVO.setScore(scoreVO.getScore());
//						}
					}
				}
			}
			
			hwVO.setDeposit(hrVO.getDeposit());
			hwVO.setRent(hrVO.getRent());
			
			// 하우스 구, 동 띄우기
            int index=hwVO.getAddr().indexOf(" ");
			String ad=hwVO.getAddr().substring(index+1); // XX구 XX동 XX-XX XX
			
			int guIdx=ad.indexOf("구 ");
			
			String gu=ad.substring(0, guIdx+2); // 'XX구 ' 
			String gu1=ad.substring(guIdx+2); // 'XX동 XX-XX XX'
			
			int dongIdx=gu1.indexOf(" ");
			
			String dong=gu1.substring(0, dongIdx); // 'XX동'
			hwVO.setAddr(gu+dong);
		}
		
		mav.addObject("newHouseListCnt", nhList.size());
		mav.addObject("newHouseList", nhList);
		
		// 하우스메이트 최신리스트 구하기
		List<MateWriteVO> nmList = service.getNewMate(area);
		for (MateWriteVO mwVO : nmList) {
			// 각 하우스 메이트의 성별, 나이 구하기
			MemberVO mVO = service.getDetail(mwVO.getUserid());
			mwVO.setGender(mVO.getGender());
//			System.out.println("희망지역 : "+mwVO.getArea());
			if(session.getAttribute("hPno")!=null) {
				if(session.getAttribute("logId")!=null) {
					if((Integer)session.getAttribute("logGrade")==2) {
						ListVO scoreVO=listService.premiumMateScore(userid, (Integer)session.getAttribute("hPno"), mwVO.getPno());
						mwVO.setScore(scoreVO.getScore());
					}
				}
			}	 
			// 생년월일을 받아서 만 나이로 처리
			String b = mVO.getBirth();
			int i = b.indexOf(" 00");
			b = b.substring(0, i+1);
			String[] birth = b.split("-");
			int bYear = Integer.parseInt(birth[0]); 
			int bMonth = Integer.parseInt(birth[1]);
			int bDay = Integer.parseInt(birth[2].replace(" ",""));
			int age = (y - bYear); 
	        // 생일 안 지난 경우 -1
	        if (bMonth * 100 + bDay > m * 100 + d) {
	        	age--;
	        }
	        String BirthAge = age+"";
			mwVO.setBirth(BirthAge);
			
			// 입주 디데이 0일때 즉시 문자열 처리
			String e = mwVO.getEnterdate();
			int ee = e.indexOf(" ");
			e = e.substring(0, ee+1);
			e = e.replace(" ", "");
			String enterNum = e.replace("-", "");
			
			Date enterDate = null;
			Date todayDate = null;
			try {
				enterDate = format.parse(enterNum);
				todayDate=format.parse(today);
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
			
			long calDate = enterDate.getTime() - todayDate.getTime();
			int calDateDays = Math.round(calDate / (24*60*60*1000));
			
			String enterDay = "";
			if (calDateDays >= 0 && calDateDays <=7) {
				enterDay = "즉시";
			}else {
				enterDay = (calDateDays) + "일";
			}
			
			mwVO.setEnterdate(enterDay);
			
			ListVO listVO=new ListVO();
			listVO.setArea(mwVO.getArea());
			mwVO.setListVO(listVO);
		}
		mav.addObject("newMateListCnt", nmList.size()); // 필터에 맞는 최신 목록의 메이트가 없을 때
		mav.addObject("newMateList", nmList);
		
		mav.setViewName("home");
		return mav;
	}
	
	@RequestMapping(value = "/hpnoDefault", method = RequestMethod.GET)
	public ModelAndView hpnoDefault(HttpSession session, int pno) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		
		// 내 하우스 성향의 갯수를 구한다.(프리미엄인 하우스에게 메이트 매칭 목록을 띄워주기 위해)
		int myHousePnoCnt=listService.myHousePnoCount(userid);
		if(myHousePnoCnt>0) {
			session.setAttribute("hPno", pno);
		}
		mav.setViewName("redirect:/");
		
		return mav;
	}
}
