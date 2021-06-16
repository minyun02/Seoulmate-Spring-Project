package com.seoulmate.home.controller;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
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

import com.seoulmate.home.service.HomeService;
import com.seoulmate.home.service.HouseService;
import com.seoulmate.home.service.ListService;
import com.seoulmate.home.service.MateService;
import com.seoulmate.home.service.MemberService;
import com.seoulmate.home.vo.HouseMatePagingVO;
import com.seoulmate.home.vo.ListVO;
import com.seoulmate.home.vo.MateWriteVO;
import com.seoulmate.home.vo.MemberVO;
import com.seoulmate.home.vo.PropensityVO;

@Controller
public class MateController {
	@Inject
	MateService service;
	@Inject
	MemberService memService;
	@Inject
	HouseService hService;
	@Inject
	ListService listService;
	@Inject
	HomeService HomeService;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	
	// 메이트 프리미엄 매칭 리스트 
	@RequestMapping("/mateMatching")
	public ModelAndView mateMatching(HttpSession session, String area, String rent, String deposit, String gender, String pageNum) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		HouseMatePagingVO pVO = new HouseMatePagingVO();
		
		int rentInt=0;
		if(rent!=null && !rent.equals("")) {
			rentInt=Integer.parseInt(rent);
		}
		
		int depositInt=0;
		if(deposit!=null && !deposit.equals("")) {
			depositInt=Integer.parseInt(deposit);
		}
		
		int genderInt=0;
		if(gender!=null && !gender.equals("")) {
			genderInt=Integer.parseInt(gender);
		}
		
		int pageNumInt=1;
		if(pageNum!=null && !pageNum.equals("")) {
			pageNumInt=Integer.parseInt(pageNum);
		}
		
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
						
						pVO.setArea(area);
						pVO.setRent(rentInt);
						pVO.setDeposit(depositInt);
						pVO.setGender(genderInt); // 필터 성별
						pVO.setM_gender(m_gender); // 하우스의 희망성별
						pVO.setPno(pno);
						pVO.setUserid(userid);
						pVO.setPageNum(pageNumInt);
						pVO.setTotalRecode(service.mateMatchTotal(pVO));
						System.out.println("userid : "  + pVO.getUserid());
						System.out.println("pno : "  + pVO.getPno());
						System.out.println("m_gender : "  + pVO.getM_gender());
						System.out.println("area : " + pVO.getArea());
						System.out.println("rent : " + pVO.getRent());
						System.out.println("deposit : " + pVO.getDeposit());
						System.out.println("gender : " + pVO.getGender());
						System.out.println("total : " + pVO.getTotalRecode());
						
						// 메이트 매칭 리스트 구하기
						List<ListVO> pmList = service.mateMatchList(pVO);
						
						if(pmList.size()>0) {
							if(pmList.get(0)!=null) {
								for(ListVO pmVO : pmList) {
									MemberVO mVO=HomeService.getDetail(pmVO.getUserid());
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
									
									// 입주 디데이 9일 때 즉시 문자열 처리
//									String e=pmVO.getEnterdate();
//									int ee=e.indexOf(" ");
//									
//									e=e.substring(0, ee+1);
//									e=e.replace(" ", "");
//									int enterNum=Integer.parseInt(e.replace("-", ""));
//									
//									String enterDay="";
//									if(enterNum - today > 0 && enterNum - today <= 7) {
//										enterDay="즉시";
//									}else {
//										enterDay=(enterNum-today) + "일";
//									}
									
									// 입주 디데이 0일때 즉시 문자열 처리
									String e = pmVO.getEnterdate();
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
		
		
		mav.addObject("rent", rentInt);
		mav.addObject("deposit", depositInt);
		mav.addObject("gender", genderInt);
		mav.addObject("area", area); // 검색을 하고 페이지를 다시 띄워줄 때 입력한 값이 뭔지 알려주려고
		//mav.addObject("newMateListCnt", nmList.size()); // 필터에 맞는 최신 목록의 메이트가 없을 때
		//mav.addObject("newMateList", nmList);
		mav.addObject("pVO", pVO); // 페이징 vo
		mav.setViewName("mate/mateMatching");
	return mav;
	}
	
	
	@RequestMapping("/mateIndex")
	public ModelAndView mateIndex(HttpSession session, String area, String rent, String deposit, String gender, String pageNum) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		
		int rentInt=0;
		if(rent!=null && !rent.equals("")) {
			rentInt=Integer.parseInt(rent);
		}
		
		int depositInt=0;
		if(deposit!=null && !deposit.equals("")) {
			depositInt=Integer.parseInt(deposit);
		}
		
		int genderInt=0;
		if(gender!=null && !gender.equals("")) {
			genderInt=Integer.parseInt(gender);
		}
		
		int pageNumInt=1;
		if(pageNum!=null && !pageNum.equals("")) {
			pageNumInt=Integer.parseInt(pageNum);
		}
		
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
									MemberVO mVO=HomeService.getDetail(pmVO.getUserid());
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
									
									// 입주 디데이 9일 때 즉시 문자열 처리
//									String e=pmVO.getEnterdate();
//									int ee=e.indexOf(" ");
//									
//									e=e.substring(0, ee+1);
//									e=e.replace(" ", "");
//									int enterNum=Integer.parseInt(e.replace("-", ""));
//									
//									String enterDay="";
//									if(enterNum - today > 0 && enterNum - today <= 7) {
//										enterDay="즉시";
//									}else {
//										enterDay=(enterNum-today) + "일";
//									}
									
									// 입주 디데이 0일때 즉시 문자열 처리
									String e = pmVO.getEnterdate();
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
		
		HouseMatePagingVO pVO = new HouseMatePagingVO();
		pVO.setArea(area);
		pVO.setRent(rentInt);
		pVO.setDeposit(depositInt);
		pVO.setGender(genderInt);
		pVO.setPageNum(pageNumInt);
		pVO.setTotalRecode(service.mateTotalRecord(pVO));
		
		// 하우스메이트 최신리스트 구하기
		List<MateWriteVO> nmList = service.getNewIndexMate(pVO); // 1. homeService 함수는 row<=3이고, MateService는 row<=9
		//List<MateWriteVO> nmList = service.getNewIndexMate(area, rentInt, depositInt, genderInt); // 1. homeService 함수는 row<=3이고, MateService는 row<=9
	    
		for (MateWriteVO mwVO : nmList) {
			// 각 하우스 메이트의 성별, 나이 구하기
			MemberVO mVO = HomeService.getDetail(mwVO.getUserid());
			mwVO.setGender(mVO.getGender());
			
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
		
		//mav.addObject("rent", rentInt);
		//mav.addObject("deposit", depositInt);
		//mav.addObject("gender", genderInt);
		//mav.addObject("area", area); // 검색을 하고 페이지를 다시 띄워줄 때 입력한 값이 뭔지 알려주려고
		mav.addObject("newMateListCnt", nmList.size()); // 필터에 맞는 최신 목록의 메이트가 없을 때
		mav.addObject("newMateList", nmList);
		mav.addObject("pVO", pVO); // 페이징 vo
		mav.setViewName("mate/mateIndex");
	return mav;
	}

	@RequestMapping("/mateView")
	public ModelAndView houseSearch(int no, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String userid = (String)session.getAttribute("logId");
		
		MateWriteVO mVO = service.mateSelect2(no);
		PropensityVO pVO = service.propMateSelect2(mVO.getPno());
		String memProfilePic = hService.memberProfile(mVO.getUserid());
		
		if(userid!=null) {
			List<PropensityVO> pVO_log = memService.housePropensityList(userid);
			
	System.out.println(pVO_log.size() +"pVO_log 사이즈");
	
			MemberVO mVO_log = memService.memberSelect(userid);
			
			List<PropensityVO> graph_matching_List = new ArrayList<PropensityVO>();
			List<PropensityVO> score_List = new ArrayList<PropensityVO>();
			PropensityVO matchingCheckPvo = new PropensityVO();
			for (int i = 0; i < pVO_log.size(); i++) {
				try {
					matchingCheckPvo = hService.getMatchingSelect(pVO_log.get(i).getPno(), pVO.getPno());
					if(matchingCheckPvo.getHousename()==null) {
						matchingCheckPvo.setHousename(pVO_log.get(i).getPdate()+"등록 성향");
						pVO_log.get(i).setHousename(pVO_log.get(i).getPdate()+"등록 성향");
			
					}
					graph_matching_List.add(matchingCheckPvo);
				} catch (Exception e) {
					//널이당 .. 
				}
				System.out.println(pVO_log.get(i).getHousename());
				score_List.add(hService.getMatchingScore(pVO_log.get(i).getPno(), pVO.getPno()));
			}
			mav.addObject("graph_matching_List", graph_matching_List);
			mav.addObject("score_List", score_List);
			mav.addObject("pVO_log", pVO_log);
			mav.addObject("mVO_log", mVO_log);
		}
		mav.addObject("mVO", mVO);
		mav.addObject("pVO", pVO);
		mav.addObject("memProfilePic", memProfilePic);
		
		mav.setViewName("mate/mateView");
		
		return mav;
	}
	
	//메이트 글 등록
	@RequestMapping("/mateWrite")
	public ModelAndView mateWrite(HttpSession session) {
		String userid = (String)session.getAttribute("logId");
		ModelAndView mav = new ModelAndView();
//		PropensityVO pVO = service.mateSelect(userid); //메이트 성향
		PropensityVO pVO = new PropensityVO();
		
		int result1 = service.mateCount(userid); //메이트글 몇개인지 카운트
		if(result1>0) {
			mav.setViewName("redirect:mateIndex");
			System.out.println("이미 메이트 글 존재");
		}
		else {
		
			pVO=memService.propMateSelect(userid);	
		// 구
		String guArr[]=memService.gu();
		
		MemberVO vo=memService.memberSelect(userid);
		
		/* 구, 동 start */
		String[] area1=vo.getArea1().split(" "); // 희망 지역 1의 구
		String[] area2=null;
		String[] area3=null;
		if(vo.getArea2()!=null) {
			area2=vo.getArea2().split(" "); // 희망 지역 2의 구
			mav.addObject("selDong2", memService.dong(area2[0]));
		}
		if(vo.getArea3()!=null) {
			area3=vo.getArea3().split(" "); // 희망 지역 3의 구
			mav.addObject("selDong3", memService.dong(area3[0]));
		}
		mav.addObject("guArr", guArr); // 구
		mav.addObject("selDong1", memService.dong(area1[0]));
		/* 구, 동 end */
	
		mav.addObject("vo", memService.memberSelect(userid));
		
		if(pVO==null) { //메이트 성향이 없을 경우?
		mav.setViewName("redirect:memberProEdit"); //성향수정 페이지로 이동
		}else { //메이트 성향이 있을 경우 id 기준으로 값 가져감
		MemberVO mVO = memService.memberSelect(userid);
		System.out.println(mVO.getGender());
				
		mav.setViewName("mate/mateWrite");
		mav.addObject("pVO",pVO);
		mav.addObject("mVO", mVO);
		
		}
//		System.out.println(pVO.getH_supportStr());
		}
		return mav;
	}
	
	//메이트 글 등록 확인
	@RequestMapping(value = "/mateWriteOk", method = RequestMethod.POST)
	@Transactional(rollbackFor= {Exception.class, RuntimeException.class})
	public ModelAndView mateWriteOk(MateWriteVO mVO, PropensityVO pVO, HttpSession session, HttpServletRequest req) {
		String userid = (String)session.getAttribute("logId");
		mVO.setUserid(userid);
		pVO.setUserid(userid);
		pVO.setPcase("m");
		//사진 업로드
		
			String path = req.getSession().getServletContext().getRealPath("/matePic"); //파일 저장위치 절대경로 구하기

			MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
			
			//mr객체에서 업로드파일 목록을 구한다
			List<MultipartFile> files = mr.getFiles("filename"); //
			
			List<String> uploadFilename = new ArrayList<String>();
			if(files.size()>0) { //첨부파일의 갯수가 0보다 클 경우 -> 첨부파일이 있을 경우
				
				for (MultipartFile mf : files){//첨부파일 갯수만큼 반복
					String orgFilename = mf.getOriginalFilename(); //원 파일명 구하기
					
					if(!orgFilename.equals("")) { //filename1,2의 name이 둘다 filename이기 때문에 if를 두번 해줘야함
					File f = new File(path, orgFilename);
					int i = 1;
					while(f.exists()) { //파일이 존재하면 true / 존재하지 않으면 false
						int point = orgFilename.lastIndexOf("."); // 마지막 . 의 위치
						String name = orgFilename.substring(0, point); //파일명 -> 첫 글자부터 마지막 . 의 위치 앞까지 문자열 구하기 (확장자 전의 글자까지 구하기)
						String extName = orgFilename.substring(point+1); //확장자 -> 마지막 . 의 위치 다음부터 문자열 구하기
						
						f = new File(path, name+"_"+ i++ +"."+ extName); // 반복되는 파일명이 있을경우 파일1, 파일2, 파일3... 으로 변경하여 저장해줌
						
					} //while문 종료
					
					//업로드하기
					try { 
						mf.transferTo(f); //업로드
					}catch(Exception e) {
						System.out.println("파일업로드 실패");
						e.printStackTrace();
					}
					uploadFilename.add(f.getName()); //변경된 파일명 -> 위쪽에 설정한 f 의 이름 얻어오기
					
					}//if문 종료
				}//for문 종료
			}//if문 종료
			
			mVO.setMatePic1(uploadFilename.get(0)); //uploadFilename 에서 0번째 -> filename1
			
			if(uploadFilename.size()==2) {
				mVO.setMatePic2(uploadFilename.get(1));
			}
			if(uploadFilename.size()==3) {
				mVO.setMatePic3(uploadFilename.get(2));
			}
			
			
			ModelAndView mav = new ModelAndView();
			
			String a1=mVO.getArea1()+"/";
		      String a2="";
		      String a3="";
		      if(mVO.getArea2()!=null && !mVO.getArea2().equals("")) {
		         a2=mVO.getArea2()+"/";
		      }
		      if(mVO.getArea3()!=null && !mVO.getArea3().equals("")) {
		         a3=mVO.getArea3()+"/";
		      }
		      mVO.setArea(a1+a2+a3);
			
			
			DefaultTransactionDefinition def=new DefaultTransactionDefinition();
			def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED); // 트랜잭션 호출
			TransactionStatus status=transactionManager.getTransaction(def);


			try {
				
					int result2 = service.mateInsert(mVO);
					if(result2>0) {//메이트 등록 
						System.out.println("메이트 등록 성공");
						
						int result3 = service.propMateUpdate(pVO);
						if(result3>0) { //성향 수정 
							System.out.println("메이트 성향 수정 성공");
							
							transactionManager.commit(status);
							mav.setViewName("redirect:mateIndex");
						}else {System.out.println("메이트 성향 수정 실패");
					}
					}else {
						System.out.println("메이트 등록 실패");
					}
				}catch(Exception e) {
					System.out.println("메이트 글 등록 실패");
					try { //파일업로드 트랜잭션
						for(String delFile : uploadFilename) {//파일삭제
							File del = new File(path, delFile);
							del.delete();
						}
					}catch(Exception ee) {
						System.out.println("파일 업로드 실패 (트랜잭션) 실행");
						ee.printStackTrace();
					}
					mav.setViewName("redirect:mateWrite");
				}
			return mav;	
	};
	
	//메이트 수정
	@RequestMapping("/mateEdit")
	public ModelAndView mateEdit(MateWriteVO mVO, PropensityVO pVO, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		String userid = (String)session.getAttribute("logId");
		mVO = service.mateSelect(userid);
		System.out.println("mVO->"+mVO.getUserid());
		
		String a1=mVO.getArea1()+"/";
	      String a2="";
	      String a3="";
	      if(mVO.getArea2()!=null && !mVO.getArea2().equals("")) {
	         a2=mVO.getArea2()+"/";
	      }
	      if(mVO.getArea3()!=null && !mVO.getArea3().equals("")) {
	         a3=mVO.getArea3()+"/";
	      }
	      mVO.setArea(a1+a2+a3);
		
	      
		
		pVO = memService.propMateSelect(userid);
		System.out.println("pVO->"+pVO.getUserid());
		System.out.println("메이트 글 번호 확인:"+mVO.getNo());
		mav.addObject("mVO", mVO);
		mav.addObject("pVO", pVO);
		
		// 구
		String guArr[]=memService.gu();
		
		MemberVO vo=memService.memberSelect(userid);
		
		/* 구, 동 start */
		String[] area1=vo.getArea1().split(" "); // 희망 지역 1의 구
		String[] area2=null;
		String[] area3=null;
		if(vo.getArea2()!=null) {
			area2=vo.getArea2().split(" "); // 희망 지역 2의 구
			mav.addObject("selDong2", memService.dong(area2[0]));
		}
		if(vo.getArea3()!=null) {
			area3=vo.getArea3().split(" "); // 희망 지역 3의 구
			mav.addObject("selDong3", memService.dong(area3[0]));
		}
		mav.addObject("guArr", guArr); // 구
		mav.addObject("selDong1", memService.dong(area1[0]));
		/* 구, 동 end */
	
		mav.addObject("vo", memService.memberSelect(userid));
		
		mav.setViewName("mate/mateEdit");
		return mav;
	}
	
	
	
	//메이트 수정 확인
	@RequestMapping(value = "/mateEditOk", method = RequestMethod.POST)
	@Transactional(rollbackFor= {Exception.class, RuntimeException.class})
	public ModelAndView mateEditOk(MateWriteVO mVO, PropensityVO pVO, HttpServletRequest req, @RequestParam("filename") MultipartFile filename) {
		ModelAndView mav = new ModelAndView();
		String userid = (String)req.getSession().getAttribute("logId");
		mVO.setUserid(userid);
		pVO.setUserid(userid);
		pVO.setPcase("m");
		
		System.out.println("mVO id->"+mVO.getUserid());
		
		System.out.println("지역확인1->"+mVO.getArea1());
		System.out.println("지역확인2->"+mVO.getArea2());
		System.out.println("지역확인3->"+mVO.getArea3());
		
		String a1=mVO.getArea1()+"/";
	      String a2="";
	      String a3="";
	      if(mVO.getArea2()!=null && !mVO.getArea2().equals("")) {
	         a2=mVO.getArea2()+"/";
	      }
	      if(mVO.getArea3()!=null && !mVO.getArea3().equals("")) {
	         a3=mVO.getArea3()+"/";
	      }
	      mVO.setArea(a1+a2+a3);
	      System.out.println("지역-->"+mVO.getArea());
		
		//사진 수정
		String path = req.getSession().getServletContext().getRealPath("/matePic");
		
		String[] fileName = service.MateProfilePic(userid, mVO.getNo()); //아이디, no
		
		System.out.println("파일 네임 확인-> "+fileName[0]);
	      //DB의 파일명을 가져온다
	      List<String> selFile = new ArrayList<String>(); //DB의 존재하는 matePic을 리스트로 받아옴

	      for(int i=0; i<fileName.length; i++) {
	         if(fileName[i]!=null && !fileName[i].equals("")) {
	            selFile.add(fileName[i]);
	         }
	      } 
	      for(int i=0; i<selFile.size(); i++) {
		         System.out.println("selFile 확인=> "+selFile.get(i));
		      }
		
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		
		//삭제한 파일 가져오기
		String delFile[] = req.getParameterValues("delFile"); //파일 수정하여 삭제한 파일을 배열로 받아온다
		
		List<MultipartFile> list = mr.getFiles("filename");//업로드된 파일목록을가져온다
		
		List<String> newUpload = new ArrayList<String>();
	      if(newUpload!=null && list.size()>0) { //새로 수정되어 업로드 된 파일이 있는 경우
	         for(MultipartFile mf : list) {
	            if(mf!=null) {
	               String orgname = mf.getOriginalFilename(); //원(기존)파일명
	               if(orgname!=null && !orgname.equals("")) {
	                  File ff = new File(path, orgname);
	                  int i = 0;
	                  while(ff.exists()) {
	                     int pnt = orgname.lastIndexOf("."); //마지막 . 의 위치 구하기
	                     String firstName = orgname.substring(0, pnt); //파일명 구하기
	                     String extName = orgname.substring(pnt+1); //확장자 구하기
	                     
	                     ff = new File(path, firstName+"("+ ++i +")."+extName);
	                  }
	                  try {
	                     mf.transferTo(ff); //파일 업로드
	                  }catch(Exception e) {
	                     System.out.println("새로 추가 업로드 에러");
	                     e.printStackTrace();
	                  }
	                  newUpload.add(ff.getName());
	              }//if문 종료
	            }//if문 종료
	         }//for문 종료
	      }//if문 종료
		
	      System.out.println(Arrays.toString(delFile));
	      //DB선택파일 목록에서 삭제한 파일 지우기 -> 최종적으로 DB에 올라갈 파일을 제외한 나머지 파일 삭제
	      if(delFile!=null) { //삭제할 파일이 있는 경우
	         for(String delName : delFile) {
	            File f = new File(path, delName);
	            f.delete(); //delName -> 삭제할 파일명
	         }
	      }
	      
	      List<String> orgFile = new ArrayList<String>();
	      
	      //DB선택파일 목록에서 새로 업로드 된 파일명 추가하기
	      for(String newFile : newUpload) {
	         orgFile.add(newFile); //newFile -> 새로 업로드 할 파일명
	         System.out.println("파일명 확인-> "+newFile);
	         System.out.println("sel확인-> "+orgFile.get(0).toString());
	      }
	      
//	      mVO.setMatePic1(orgFile.get(0)); //새로 업로드된 index0번째 파일 -> matePic1 로 설정
	      
	         if(orgFile.size()>1) { //filename2 있을 경우
	            mVO.setMatePic2(orgFile.get(1));
	         }
	         
	         if(orgFile.size()>2) { //filename3 있을 경우
	            mVO.setMatePic3(orgFile.get(2));
	         }
	         else if(orgFile.size()==1) {
	        	 mVO.setMatePic1(orgFile.get(0));
	         }
	         else {
	        	 mVO.setMatePic1(selFile.get(0)); //변경된 파일이 없으면 기존파일로 matePic1 설정
	         }
	          System.out.println("메이트1 확인-> "+mVO.getMatePic1());
	      for(int i=0; i<orgFile.size(); i++) {
	         System.out.println(orgFile.get(i));
	      }
	
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED); // 트랜잭션 호출
		TransactionStatus status=transactionManager.getTransaction(def);
		
		try {
			int result1 = service.mateUpdate(mVO);
			if(result1>0) {
				System.out.println("메이트 글 수정 완료");
				
				pVO.setPno(mVO.getPno());
				int result2 = memService.propMateUpdate(pVO);
				if(result2>0) {
					System.out.println("메이트성향 수정 성공");
					
					int result3 = service.mateAreaUpdate(mVO.getArea(), userid);
					if(result3>0) {
						System.out.println("회원정보 희망지역 수정 완료");
						
						if(delFile!=null ) { //삭제한 파일 지우기
		                     for(String dFile : delFile) {
		                        try {
		                           File dFileObj = new File(path, dFile);
		                           dFileObj.delete();
		                        }catch(Exception e) {
		                           System.out.println("파일명 추가 에러");
		                           e.printStackTrace();
		                           
		                        }
		                     }
		                  }
						
						transactionManager.commit(status);
					
						mav.setViewName("redirect:mateIndex");
						
					}else {
						System.out.println("희망지역 수정 실패");
						if(newUpload.size()>0) { //새로 업로드 하려 했던 파일 지우고 다시 수정form으로 이동
				               for(String newFile : newUpload) {
				                  try {
				                     File dFileObj = new File(path, newFile);
				                     dFileObj.delete();
				                  }catch(Exception e) {
				                     System.out.println("수정 실패");
				                     e.printStackTrace();
				                  }
				               }
				            }
					}
					
					
				}else {
					System.out.println("메이트성향 수정 실패");
					if(newUpload.size()>0) { //새로 업로드 하려 했던 파일 지우고 다시 수정form으로 이동
			               for(String newFile : newUpload) {
			                  try {
			                     File dFileObj = new File(path, newFile);
			                     dFileObj.delete();
			                  }catch(Exception e) {
			                     System.out.println("수정 실패");
			                     e.printStackTrace();
			                  }
			               }
			            }
					mav.setViewName("redirect:mateEdit");
				}
			}else {
				System.out.println("메이트 글 수정 실패");
				
			}
		}catch(Exception e) {
			System.out.println("메이트 글+성향 수정 실패");
			//사진 수정 트랜잭션 실행문
			if(newUpload.size()>0) { //새로 업로드 하려 했던 파일 지우고 다시 수정form으로 이동
	               for(String newFile : newUpload) {
	                  try {
	                     File dFileObj = new File(path, newFile);
	                     dFileObj.delete();
	                  }catch(Exception e2) {
	                     System.out.println("수정 실패");
	                     e2.printStackTrace();
	                  }
	               }
	            }	
		
	}

		
		return mav;
	}
	
	
	//메이트 삭제
	@RequestMapping("/mateDel")
	public ModelAndView mateDel(int no, MateWriteVO mVO, PropensityVO pVO, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		String userid = (String)req.getSession().getAttribute("logId");
		
//		String path = req.getSession().getServletContext().getRealPath("/matePic"); 
//		String[] dbFilename = service.MateProfilePic(userid, no);
		
		
			int result1 = service.mateDel(mVO.getNo(), userid);
			
			if(result1>0) { 
				System.out.println("메이트 삭제 성공"); // 사진 파일 삭제 어떻게?
		
				
				mav.setViewName("redirect:mateIndex");
			}else { 
				mav.addObject("no", no); //삭제 실패하면 no가지고 메이트 글 보기로 넘겨주기
				System.out.println("메이트 삭제 실패");
				mav.setViewName("redirect:mateView");
			}
		
		return mav;
	}
	
	@RequestMapping(value = "/hpnoDefaultMateIndex", method = RequestMethod.GET)
	public ModelAndView hpnoDefaultMateIndex(HttpSession session, int pno) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		
		// 내 하우스 성향의 갯수를 구한다.(프리미엄인 하우스에게 메이트 매칭 목록을 띄워주기 위해)
		int myHousePnoCnt=listService.myHousePnoCount(userid);
		if(myHousePnoCnt>0) {
			session.setAttribute("hPno", pno);
		}
		mav.setViewName("redirect:mateIndex");
		
		return mav;
	}

	
	
}
