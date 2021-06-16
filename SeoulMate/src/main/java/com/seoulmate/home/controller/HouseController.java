package com.seoulmate.home.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.seoulmate.home.service.AdminService;
import com.seoulmate.home.service.HomeService;
import com.seoulmate.home.service.HouseService;
import com.seoulmate.home.service.ListService;
import com.seoulmate.home.service.MemberService;
import com.seoulmate.home.vo.HouseMatePagingVO;
import com.seoulmate.home.vo.HouseRoomVO;
import com.seoulmate.home.vo.HouseWriteVO;
import com.seoulmate.home.vo.ListVO;
import com.seoulmate.home.vo.MemberVO;
import com.seoulmate.home.vo.PropensityVO;

@Controller
public class HouseController {
	@Inject
	HouseService service;
	@Inject
	MemberService memService;
	@Inject
	ListService listService;
	@Inject
	HomeService HomeService;
	@Inject
	AdminService aService;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	@RequestMapping("/houseIndex")
	public ModelAndView houseIndex(HttpSession session, String addr, String rent, String deposit, String m_gen, String pageNum) {
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
		
		int m_genInt=0;
		if(m_gen!=null && !m_gen.equals("")) {
			m_genInt=Integer.parseInt(m_gen);
		}
		
		int pageNumInt=1;
		if(pageNum!=null && !pageNum.equals("")) {
			pageNumInt=Integer.parseInt(pageNum);
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
							HouseRoomVO phhrVO = new HouseRoomVO();
							for (ListVO phVO : phList) {
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
        
        HouseMatePagingVO pVO=new HouseMatePagingVO();
        
        pVO.setAddr(addr);
        pVO.setRent(rentInt);
        pVO.setDeposit(depositInt);
        pVO.setM_gen(m_genInt);
        pVO.setPageNum(pageNumInt);
        pVO.setTotalRecode(service.HouseTotalRecode(pVO));
        
        // 쉐어하우스 최신리스트 구하기
		int MyMpnoCnt=0;
		if(session.getAttribute("logId")!=null) {
			if(listService.myMatePnoCheck(userid)>0) {
				MyMpnoCnt=listService.myMatePnoCheck(userid);
			}
		}
		
		List<HouseWriteVO> nhList = service.getNewIndexHouse(pVO); // 1. homeService 함수는 row<=3이고, HouseService는 row<=9
		HouseRoomVO hrVO = new HouseRoomVO();
		for (HouseWriteVO hwVO : nhList) {
			// 각 쉐어하우스의 제일 저렴한 월세 가져오기
			hrVO = HomeService.getDesposit(hwVO.getNo()); // 2. 이건 같아서 HomeService꺼 그대로 가져다 씀
			
			if(session.getAttribute("logId")!=null) {
				if((Integer)session.getAttribute("logGrade")==2) {
					if(MyMpnoCnt>0) {
						ListVO scoreVO=listService.premiumHouseScore(userid, hwVO.getPno());
						hwVO.setScore(scoreVO.getScore());
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
		mav.addObject("pVO", pVO); // addr, rent, deposit, m_gen
		mav.setViewName("house/houseIndex");
	return mav;
	}
	
	@RequestMapping("/houseView")
	public ModelAndView houseView(int no, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String userid = (String)session.getAttribute("logId");
		
		HouseWriteVO hVO = service.houseSelect2(no); //HouseWriteVO 값 가져오기
		List<HouseRoomVO> rVO_List = service.roomListSelect(no); //HouseRoomVO 값 가져오기
		PropensityVO pVO = service.propHouseSelect2(hVO.getPno()); //PropensityVO 값 가져오기
		String memProfilePic = service.memberProfile(hVO.getUserid());
		if(userid!=null) {
			// pcase 가 m 인건 1개뿐. 
			PropensityVO pVO_log = memService.propMateSelect(userid); //로그인한 사용자의 mate PropensityVO값 가져오기. (매칭용) 
			if(pVO_log!=null){
				// mate 등록 성향이 있는 경우 
				PropensityVO graph_matching = service.getMatchingSelect(pVO.getPno(), pVO_log.getPno());
				PropensityVO scoreVO = service.getMatchingScore(pVO.getPno(), pVO_log.getPno());
				graph_matching.setScore(scoreVO.getScore());
				mav.addObject("graph_matching", graph_matching);
			}
			MemberVO mVO_log = memService.memberSelect(userid);//로그인한 사용자의 정보
			mav.addObject("pVO_log", pVO_log);
			mav.addObject("mVO_log", mVO_log);
		}
		// 하우스 pno, housename ,  메이트 pno  => 계산된 vo로 받아오기 . 
		mav.addObject("hVO", hVO);
		mav.addObject("rVO_List", rVO_List);
		mav.addObject("pVO", pVO);
		mav.addObject("memProfilePic", memProfilePic);
		
		mav.setViewName("house/houseView");
		
		return mav;
	}
	
	//하우스 글 등록
	@RequestMapping("/houseWrite")
	public ModelAndView houseWirte(HttpSession session, PropensityVO pVO, HouseWriteVO hVO) {
		ModelAndView mav = new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		pVO = service.propHouseSelect(userid, pVO.getPno());
		hVO = service.houseSelect(hVO.getNo(), userid);
		
		mav.addObject("hVO", hVO);
		mav.addObject("pVO", pVO);
		int pcaseH = memService.propPcaseH(userid);
		int houseCheck = service.houseCheck(userid);
		
		//프리미엄 가입자인지 확인 grade : 2 -> 프리미엄 일 경우 등록한 글 갯수 확인 -> 최대 3개까지 가능
		//일반 grade : 1 -> 1개만 등록 가능
		int grade = service.gradeCheck(userid); //등급 확인
		int hwCnt = service.houseWriteCheck(userid); //하우스글 작성 개수 확인
		int hsCnt = service.houseStateCheck(userid); //하우스 글 중 모집중인 글 확인
		
		if(grade==1) { //일반 등급 -> 무조건 1개 글 등록
			if(hsCnt<1) { //모집중인 하우스 글이 없을 경우
				System.out.println("하우스 글 등록 가능");
				if(houseCheck<1) { //하우스 등록 안했을 경우(가입할때 성향은 존재, 하우스 글 등록x)
					int housePno = service.housePnoCheck(userid); //pno(성향테이블 no) 값 가져오기
					mav.addObject("housePno", housePno);
				}else {
					mav.addObject("housePno", 0); //하우스 글이 없을경우 pno 에 0 값을 넣어줌
				}
				if(pcaseH>0) {
					mav.addObject("list", service.getPropInfo(userid)); //사용자가 등록해 놓은 성향 이름 불러오기
				}
				mav.setViewName("house/houseWrite");
								
			}else {
				System.out.println("모집중인 하우스 글 1개 초과"); //추가 글 등록 불가능
				mav.addObject("bCnt", "Y");
				mav.setViewName("redirect:houseIndex");
			}
		}else { //프리미엄 등급 -> 모집중인 글이 3개까지 등록 가능
			if(hsCnt>3) {
				System.out.println("모집중인 하우스 글 등록 3개 초과"); //글 작성 불가능
				mav.addObject("pCnt", "Y");
				mav.setViewName("redirect:houseIndex");
			}else {
				System.out.println("모집중인 하우스 글 등록 3개 미만"); //글 작성 가능
				if(houseCheck<1) { //하우스 등록 안했을 경우(가입할때 성향은 존재, 하우스 글 등록x)
					int housePno = service.housePnoCheck(userid); //pno(성향테이블 no) 값 가져오기
					mav.addObject("housePno", housePno);
				}else {
					mav.addObject("housePno", 0); //하우스 글이 없을경우 pno 에 0 값을 넣어줌
				}
				if(pcaseH>0) {
					mav.addObject("list", service.getPropInfo(userid)); //사용자가 등록해 놓은 성향 이름 불러오기
				}
				mav.setViewName("house/houseWrite");
				
			}
		}
		
		return mav;
		
	}
	//하우스 등록시 선택한 성향 불러오기
	@RequestMapping("/getPropensity")
	@ResponseBody
	public PropensityVO getPropensity(PropensityVO pVO, String userid, int pno){
		System.out.println(pno);
		return service.getFullPropensity(userid, pno); //불러온 이름중에서 선택한 성향 값 가져오기
	}
	//하우스 글 등록 확인
	@RequestMapping(value="/houseWriteOk", method = RequestMethod.POST)
	@Transactional(rollbackFor= {Exception.class, RuntimeException.class})
	public ModelAndView houseWriteOk(HouseWriteVO hVO, HouseRoomVO rVO, PropensityVO pVO, HttpSession session ,HttpServletRequest req) {
		
		System.out.println(pVO.getPno());
		String userid=(String)session.getAttribute("logId");
		
		System.out.println(rVO.getRoomVOList().get(0).getDeposit()+"?????????????");
		
		hVO.setUserid(userid);
//		rVO.setUserid(userid);
		pVO.setUserid(userid);
		pVO.setPcase("h");
		
//		System.out.println("hVO"+hVO.getPno());
//		System.out.println("pVO"+pVO.getPno());
		
		//사진 업로드		
		String path = req.getSession().getServletContext().getRealPath("/housePic"); //파일 저장위치 절대경로 구하기

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
		
		hVO.setHousepic1(uploadFilename.get(0)); //uploadFilename 에서 0번째 -> filename1
		
		if(uploadFilename.size()==2) {
			hVO.setHousepic2(uploadFilename.get(1));
		}
		if(uploadFilename.size()==3) {
			hVO.setHousepic3(uploadFilename.get(2));
		}
		if(uploadFilename.size()==4) {
			hVO.setHousepic4(uploadFilename.get(3));
		}
		if(uploadFilename.size()==5) {
			hVO.setHousepic5(uploadFilename.get(4));
		}
		
		ModelAndView mav = new ModelAndView();
		
		DefaultTransactionDefinition def=new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED); // 트랜잭션 호출
		TransactionStatus status=transactionManager.getTransaction(def);
		
		try {
			int result1 = 0;
			//수정부분=============== 하우스 등록시에는 성향은 항상 insert가 되어야한다.
			result1 = service.propInsert(pVO);
			pVO.setPno(service.proPnoCheck(userid));
			//수정부분===============
			//=========기존코드 시작===========
//			System.out.println("0->"+pVO.getPno());
//			if(pVO.getPno()==0) { //성향 테이블이 존재하지 않음 -> 성향 등록
//				System.out.println("1->"+pVO.getPno());
//				result1 = service.propInsert(pVO);
//				pVO.setPno(service.proPnoCheck(userid));
//				System.out.println("2->"+pVO.getPno());
//				System.out.println("성향 등록 시도");
//			}else { //성향 테이블이 이미 존재 -> 성향 업데이트
//				System.out.println("3->"+pVO.getPno());
//				result1 = service.propHouseUpdate(pVO);
//				System.out.println("성향 업데이트 시도");
//			}
			//=========기존코드 끝===========			
			System.out.println("성향 insert 값 확인->"+result1);
			System.out.println("아이디:"+pVO.getUserid());
			System.out.println("케이스 확인:"+pVO.getPcase());
			System.out.println("4 p넘버:"+pVO.getPno());
			if(result1>0) { //성향 등록 
				System.out.println("성향 등록 성공");
				System.out.println("hVO="+hVO.getHousename());
				hVO.setPno(pVO.getPno());
				int result2 = service.houseInsert(hVO);
				
				if(result2>0) { //집(house) 등록 
					System.out.println("하우스 등록 성공");
					//System.out.println("하우스 등록 시도 에러 확인"+pVO.getPno());
					
					String houseName = hVO.getHousename(); //성향의 housename을 housewrite의 테이블의 housename의 값으로 설정
					System.out.println("하우스확인"+houseName);
					int houseUpdate = service.housenameUpdate(houseName, pVO.getPno()); 
					
					if(houseUpdate>0) {
						System.out.println("하우스네임 업데이트 성공");
						//test=================================================================================================================
						int result3 = 0;
						System.out.println("방 갯수 : "+rVO.getRoomVOList().size());
						System.out.println("방 1 : "+rVO.getRoomVOList().get(0).getRent());
						for(int i=0; i<rVO.getRoomVOList().size(); i++) {
							System.out.println(i+"여기야");
							if(rVO.getRoomVOList().get(i).getRoomName() != null && !rVO.getRoomVOList().get(i).getRoomName().equals("")) {
								rVO.getRoomVOList().get(i).setUserid(userid);
								result3 = service.roomInsert(rVO.getRoomVOList().get(i));
							}
						}
						//test=================================================================================================================	
							if(result3>0) {
								System.out.println("방 등록 성공");
								
								transactionManager.commit(status);
								mav.setViewName("redirect:houseIndex");
							}else {
								System.out.println("방 등록 실패");
							}
					}else {
						System.out.println("하우스네임 업데이트 실패");
					}
				}else {
					System.out.println("하우스 등록 실패");
				}
			}else {
//				if(realName!=null) {
//					File f = new File(path, realName);
//					f.delete();
//				}
				for(String delFile : uploadFilename) {//파일삭제
					File del = new File(path, delFile);
					del.delete();
				}
				System.out.println("성향 등록 실패");
				mav.setViewName("redirect:houseWrite");
			}
		}catch(Exception e) {
			System.out.println("쉐어하우스 글 등록 에러 발생 (트랜잭션)");
			e.printStackTrace();
			try { //파일업로드 트랜잭션
//				File dFileObj = new File(path, realName);
//				dFileObj.delete();
				for(String delFile : uploadFilename) {//파일삭제
					File del = new File(path, delFile);
					del.delete();
				}
			}catch(Exception ee) {
				System.out.println("파일업로드 실패 (트랜잭션) 실행");
				ee.printStackTrace();				
			}
			mav.setViewName("redirect:houseWrite");
		}
		
		return mav;
	};
	
	
	//하우스 등록 수정
	@RequestMapping("/houseEdit")
	public ModelAndView houseEdit(@RequestParam(value="no") int no, HouseWriteVO hVO, HouseRoomVO rVO, PropensityVO pVO, HttpSession session, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String userid = (String)session.getAttribute("logId");

		System.out.println(rVO.getEnterdate());
		
		hVO.setUserid(userid);
		rVO.setUserid(userid);
		pVO.setUserid(userid);
		pVO.setPcase("h");
		System.out.println("hVO id->"+hVO.getUserid());

		System.out.println(no); 
		hVO = service.houseSelect(no, userid);

		rVO.setNo(hVO.getNo());
		System.out.println("rVO no-> "+rVO.getNo());
		
		//test=======================================================================================================================
		List<HouseRoomVO> rVO_List = service.roomListSelect(no); //HouseRoomVO 값 가져오기
		mav.addObject("list", service.getPropInfo(userid));
		//test=======================================================================================================================		
		
		pVO = service.propHouseSelect(userid, hVO.getPno());
		System.out.println("hVO Pno-> "+hVO.getPno());
		
		
		
		System.out.println(hVO.getUserid());
		System.out.println("하우스 no "+hVO.getNo());
		System.out.println("성향 번호 "+hVO.getPno());
		System.out.println("방 no "+rVO.getNo());
		System.out.println("방의 hno "+rVO.getHno());
		System.out.println("방 이름"+rVO.getRoomName());
		System.out.println("성향 소음:"+pVO.getH_noise());
		
		System.out.println("Str-> "+hVO.getPublicfacilityStr());	
		System.out.println("공용-> "+hVO.getPublicfacility());
		
		System.out.println(rVO_List.size()+"++++++++++++++++++++++++++++++++++++++");
		mav.addObject("hVO", hVO);
		mav.addObject("rVO_List", rVO_List);
		mav.addObject("rVO_ListSize", rVO_List.size());
		mav.addObject("pVO", pVO);
		
		mav.setViewName("house/houseEdit");
		return mav;
	}
	
	
	
	//하우스 수정 확인
	@RequestMapping(value="/houseEditOk", method = RequestMethod.POST)
	@Transactional(rollbackFor= {Exception.class, RuntimeException.class})
	public ModelAndView houseEditOk(HouseWriteVO hVO, HouseRoomVO rVO, PropensityVO pVO, HttpServletRequest req,
			@RequestParam("filename") MultipartFile filename) {
		ModelAndView mav = new ModelAndView();
		String userid = (String)req.getSession().getAttribute("logId");
		hVO.setUserid(userid);
		rVO.setUserid(userid);
		pVO.setUserid(userid);
		//test====================================================================================================
		//사진 수정
	    String path = req.getSession().getServletContext().getRealPath("/housePic");
		String[] fileName = service.houseProfilePic(userid, hVO.getNo());
		      System.out.println("파일 네임 확인-> "+fileName[0]);
		      //DB의 파일명을 가져온다
		      List<String> selFile = new ArrayList<String>();
	
		      for(int i=0; i<fileName.length; i++) {
		         if(fileName[i]!=null && !fileName[i].equals("")) {
		            selFile.add(fileName[i]);
		         }
		      } 
		      for(int i=0; i<selFile.size(); i++) {
			         System.out.println("selFile 확인=> "+selFile.get(i));
			      }
	
		//삭제한 파일 가져오기
		String delFile[] = req.getParameterValues("delFile"); //파일 수정하여 삭제한 파일을 배열로 받아온다
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
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
//		      System.out.println(Arrays.toString(delFile));
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
		      System.out.println("하우스픽1 확인-> "+hVO.getHousepic1());
			      if(orgFile.size()>0) { //filename1 있을 경우
			      	hVO.setHousepic1(orgFile.get(0));
			      }

		         if(orgFile.size()>1) { //filename2 있을 경우
		            hVO.setHousepic2(orgFile.get(1));
		         }
		         
		         if(orgFile.size()>2) { //filename3 있을 경우
		            hVO.setHousepic3(orgFile.get(2));
		         }
		         
		         if(orgFile.size()>3) { //filename4 있을 경우
		            hVO.setHousepic4(orgFile.get(3));
		         }
		         
		         if(orgFile.size()>4) { //filename5 있을 경우
		            hVO.setHousepic5(orgFile.get(4));
		         }
		         else if(orgFile.size()==1) {
		        	 hVO.setHousepic1(orgFile.get(0));
		         }
		         else {
		        	 hVO.setHousepic1(selFile.get(0)); //변경된 파일이 없으면 기존파일로 housepic1 설정
		         }
		          System.out.println("하우스픽1 확인-> "+hVO.getHousepic1());
		      for(int i=0; i<orgFile.size(); i++) {
		         System.out.println(orgFile.get(i));
		      }
		//test====================================================================================================
		
		
		System.out.println(hVO.getHousepic1());
		System.out.println(hVO.getHousepic2());
		System.out.println(hVO.getHousepic3());
		System.out.println(hVO.getHousepic4());
		System.out.println(hVO.getHousepic5());
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED); // 트랜잭션 호출
		TransactionStatus status=transactionManager.getTransaction(def);
		
		try {
			System.out.println("하우스테이블 no 1확인:"+hVO.getNo());
			hVO.setPno(pVO.getPno());
			System.out.println("하우스테이블 no 2확인:"+hVO.getNo());
			System.out.println("하우스 테이블 pno 확인:"+hVO.getPno());
			pVO.setPno(hVO.getPno());
			//test====================================================================================================
			System.out.println(hVO.getNo()+"=======================================no");
			System.out.println(hVO.getPno()+"=======================================pno");
			System.out.println(hVO.getUserid()+"=======================================userid");
			System.out.println(hVO.getAddr()+"=======================================addr");
			System.out.println(hVO.getHousename()+"=======================================housename");
			System.out.println(hVO.getRoom()+"=======================================room");
			System.out.println(hVO.getBathroom()+"=======================================bathroom");
			System.out.println(hVO.getNowpeople()+"=======================================nowppl");
			System.out.println(hVO.getSearchpeople()+"=======================================searchppl");
			System.out.println(hVO.getPublicfacilityStr()+"=======================================publicfac");
			//test====================================================================================================			
			int result1 = service.houseUpdate(hVO);
			if(result1>0) {
				if(delFile!=null ) { //삭제한 파일 지우기
					for(String dFile : delFile) {
						try {
							File dFileObj = new File(path, dFile);
							dFileObj.delete();
						}catch(Exception e) {
							System.out.println("파일명 추가 에러");
							e.printStackTrace();
							System.out.println("삭제 파일-> "+delFile.length);
						}
					}
				}
				System.out.println("하우스 업데이트 성공");
				System.out.println(hVO.getNo());
				rVO.setNo(hVO.getNo()); //houseWrite의 no을 houseRoom의 no(하우스번호)로 서정
				//test========================================================================================
				int result2 = 0;
//				for(int i=0; i<rVO.getRoomVOList().size(); i++) {
				for(int i=0; i<rVO.getRoomVOList().size(); i++) {
					rVO.getRoomVOList().get(i).setUserid(userid);
					rVO.getRoomVOList().get(i).setNo(hVO.getNo());
					result2 = service.roomUpdate(rVO.getRoomVOList().get(i));
					System.out.println(rVO.getRoomVOList().get(i).getNo()+"------------------------no");
					System.out.println(rVO.getRoomVOList().get(i).getHno()+"------------------------hno");
					System.out.println(rVO.getRoomVOList().get(i).getUserid()+"------------------------userid");
					System.out.println(rVO.getRoomVOList().get(i).getRoomName()+"------------------------roomname");
					System.out.println(rVO.getRoomVOList().get(i).getDeposit()+"------------------------deposit");
					System.out.println(rVO.getRoomVOList().get(i).getRent()+"------------------------rent");
					System.out.println(rVO.getRoomVOList().get(i).getEnterdate()+"------------------------enterdate");
					System.out.println(rVO.getRoomVOList().get(i).getMinStay()+"------------------------minstay");
					System.out.println(rVO.getRoomVOList().get(i).getMaxStay()+"------------------------max");
					System.out.println(rVO.getRoomVOList().get(i).getRoomPeople()+"------------------------roompeople");
					System.out.println(rVO.getRoomVOList().get(i).getFurniture()+"------------------------fur");
					System.out.println(rVO.getRoomVOList().get(i).getIncFurniture()+"------------------------incfur");
				}
				//test========================================================================================	
				if(result2>0) {
					System.out.println("방 수정 성공");
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
					pVO.setPno(hVO.getPno());
					System.out.println(pVO.getPno()+"========================================pno UPDATE");
					int result3 = service.propHouseUpdate(pVO);
					
					if(result3>0) {
						System.out.println("성향 수정 성공");
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
						mav.setViewName("redirect:houseIndex");
						
					}else {
						System.out.println("성향 수정 실패");
						
						mav.setViewName("redirect:houseEdit");
					}
				}else {
					System.out.println("방 수정 실패");
				}
			}else {
				System.out.println("하우스 업데이트 실패");
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
				mav.setViewName("redirect:houseEdit");
			}
		}catch(Exception e) {
			System.out.println("하우스+방 수정 실패 (트랜잭션)");
			e.printStackTrace();
			//사진 수정 트랜잭션 작성부분
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
			mav.setViewName("redirect:houseEdit");

//		}
		} //filename 종료
		return mav;
	}
	
	
	//하우스 삭제 -> 성향은 제외하고 houseWrite, houseRoom 만 삭제, Propensity 의 housename을 null 로 업데이트
	@RequestMapping("/houseDel")
	public ModelAndView houseDel(int no, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String userid = (String)req.getSession().getAttribute("logId");
//		hVO.setUserid(userid);
//		rVO.setUserid(userid);
//		pVO.setUserid(userid);
		
		HouseWriteVO hVO = service.houseSelect(no, userid);
		//test===============================================================================================
		HouseRoomVO rVO = new HouseRoomVO(); 
		rVO.setRoomVOList(service.roomListSelect(no));
		//test===============================================================================================
		PropensityVO pVO = service.propHouseSelect(userid, hVO.getPno());
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED); // 트랜잭션 호출
		TransactionStatus status=transactionManager.getTransaction(def);
		
		try {
			int result1 = service.houseDel(no, userid);
			if(result1>0) {
				System.out.println("하우스 삭제 성공");
				// 하우스 / 메이트 / 채팅에도 들어가야하는 부분=========================0527추가===========================
				// 삭제하기 전에 신고테이블에 있는 먼저 조회한다
				String reportNum[] = aService.getNumFromReport(no); //신고를 여러번 당했을 수 있어서 배열로 세팅
				if(reportNum!=null) {
					//글이 삭제되면 신고 테이블에서 상태 '삭제됨'으로 업데이트
					for(int i=0; i<reportNum.length; i++) {
						aService.reportStateUpdate(Integer.parseInt(reportNum[i]), "삭제됨");
					}
				}
				//==============================================================================
				
				//test===============================================================================================
				int result2 = 0;
				for(int i=0; i<rVO.getRoomVOList().size(); i++) {
					result2 = service.roomDel(rVO.getRoomVOList().get(i).getNo(), userid,rVO.getRoomVOList().get(i).getHno());
				}
				//test===============================================================================================
				if(result2>0) {
					System.out.println("룸 삭제 성공");
					
					pVO.setPno(hVO.getPno());
					int result3 = service.ProHouseNameUpdate(pVO);
					if(result3>0) {
						System.out.println("하우스네임 업데이트 성공");
						transactionManager.commit(status);
						mav.setViewName("redirect:houseIndex");
						
					}else {
						System.out.println("하우스네임 업데이트 실패");
						mav.addObject("no", no);
						mav.setViewName("redirect:houseView");
					}
				}else {
					System.out.println("룸 삭제 실패");
				}
			}else {
				System.out.println("하우스 삭제 실패");
			}
			
		}catch(Exception e) {
			System.out.println("하우스 + 룸 삭제 실패");
			e.printStackTrace();
			mav.setViewName("redirect:houseView");
		}
		return mav;
	}
	
	@RequestMapping("/houseMatching")
	public ModelAndView houseMatching(HttpSession session, String addr, String rent, String deposit, String m_gen, String pageNum) {
		ModelAndView mav=new ModelAndView();
		String userid=(String)session.getAttribute("logId");
		HouseMatePagingVO pVO=new HouseMatePagingVO();
		
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
		
		int pageNumInt=1;
		if(pageNum!=null && !pageNum.equals("")) {
			pageNumInt=Integer.parseInt(pageNum);
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
					
					pVO.setUserid(userid);
			        pVO.setAddr(addr);
			        pVO.setRent(rentInt);
			        pVO.setDeposit(depositInt);
			        pVO.setM_gen(m_genInt);
			        pVO.setM_gender(m_gender);
			        pVO.setPageNum(pageNumInt);
			        pVO.setTotalRecode(service.houseMatchTotal(pVO));
					// 쉐어하우스 매칭 리스트 구하기
					List<ListVO> phList = service.HouseMatchList(pVO); // PremiumHouseList
					
					if(phList.size()>0) {
						if(phList.get(0)!=null){ // else if(phList!=null)
							HouseRoomVO phhrVO = new HouseRoomVO();
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
        
        mav.addObject("pVO", pVO);
        mav.setViewName("house/houseMatching");
        
        return mav;
	}
	
	
}
