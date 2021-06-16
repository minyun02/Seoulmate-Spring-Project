package com.seoulmate.home.vo;

public class PropensityVO {
	private int pno; //성향번호 
	private String userid; 
	private String pcase;  //분류  h: 하우스, m : 메이트 
	private String housename; //하우스일 경우 하우스 이름.. 
	private int h_noise;  //하우스 생활 소음 1:매우조용함, 2:보통, 3:조용하지 않음
	private int h_pattern; //하우스 생활 시간 1:주행성, 3:야행성
	private int h_pet;	//하우스 애완 동물 1:없음, 3있음 
	private int h_petwith; // 하우스 애완동물 동반 입실 1:불가능, 3가능
	private int h_smoke; // 하우스 흡연  1:비흡연, 2:실외흡연, 3:실내흡연
	private int h_mood; // 하우스 분위기 1: 화목함, 2:보통, 3:독립적 
	private int h_communication; // 하우스 소통방식 1:메신저, 2:기타, 3:대화 
	private int h_party; //하우스 모임빈도 1:없음, 2:상관없음, 3:있음 
	private int h_enter; // 하우스 모임참가 의무  1: 없음, 2: 상관없음, 3:있음 
	private String h_support[];  // 1:공용공간청소, 2:공용생필품, 3:기본식품 
	private String h_supportStr="";
	
	//private String h_support;
	
	private String h_etc[]; // 1: 보증금 조절가능, 3:즉시입주가능 
	private String h_etcStr="";
	
	private int m_pattern;	// 메이트 생활시간  1:주행성, 2:야행성 
	private int m_personality; //메이트 성격 1:내향적, 2:상관없음, 3:외향적
	private int m_pet; // 메이트 애완동물 1:긍정적, 3부정적 
	private int m_smoke; // 메이트 흡연여부 1:비흡연, 2:상관없음, 3:흡연
	private int m_age;  //메이트 나이대   1: 20~30대 , 2:상관없음, 3:40대 이상 
	private int m_gender; // 메이트 성별  1: 여성전용, 2:상관없음, 3:남성전용 
	private int m_global; // 메이트 외국인입주 가능여부 1:불가능, 3:가능 
	private int m_now; //메이트 즉시입주 가능여부 1: 가능, 3:불가능 
	private String pdate;  //성향 등록일 
	
	//그래프용 데이터
	// 생활 : noise(생활소음), h_pattern(생활방식), m_pattern,m_age,  m_global
	// 반려동물 : h_pet, h_petwith, m_pet
	// 소통,모임 : h_mood, h_communication, h_party, h_enter, 
	// 흡연 : h_smoke, m_smoke, 
	// 성격 : m_personality, 
	// 입주 : m_now
	private int life;
	private int pet;
	private int communicate;
	private int smoke;
	private int personality;
	private int etc;
	private int now;
	
	private int score;
	
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPcase() {
		return pcase;
	}
	public void setPcase(String pcase) {
		this.pcase = pcase;
	}
	public String getHousename() {
		return housename;
	}
	public void setHousename(String housename) {
		this.housename = housename;
	}
	public int getH_noise() {
		return h_noise;
	}
	public void setH_noise(int h_noise) {
		this.h_noise = h_noise;
	}
	public int getH_pattern() {
		return h_pattern;
	}
	public void setH_pattern(int h_pattern) {
		this.h_pattern = h_pattern;
	}
	public int getH_pet() {
		return h_pet;
	}
	public void setH_pet(int h_pet) {
		this.h_pet = h_pet;
	}
	public int getH_petwith() {
		return h_petwith;
	}
	public void setH_petwith(int h_petwith) {
		this.h_petwith = h_petwith;
	}
	public int getH_smoke() {
		return h_smoke;
	}
	public void setH_smoke(int h_smoke) {
		this.h_smoke = h_smoke;
	}
	public int getH_mood() {
		return h_mood;
	}
	public void setH_mood(int h_mood) {
		this.h_mood = h_mood;
	}
	public int getH_communication() {
		return h_communication;
	}
	public void setH_communication(int h_communication) {
		this.h_communication = h_communication;
	}
	public int getH_party() {
		return h_party;
	}
	public void setH_party(int h_party) {
		this.h_party = h_party;
	}
	public int getH_enter() {
		return h_enter;
	}
	public void setH_enter(int h_enter) {
		this.h_enter = h_enter;
	}
	// 하우스 내 지원 서비스 ///////////////
	public String[] getH_support() {
		return h_support;
	}
	public void setH_support(String[] h_support) {
		this.h_support = h_support;
		
		// 배열의 값을 문자열로
		for(String i:h_support) {
			h_supportStr+=i+"/";
		}
	}
	public String getH_supportStr() {
		return h_supportStr;
	}
	public void setH_supportStr(String h_supportStr) {
		this.h_supportStr = h_supportStr;
		
		h_support=h_supportStr.split("/");
	}
	
	
	
	////////////////////////////////////
	// 기타 /////////////////////////////
	public String[] getH_etc() {
		return h_etc;
	}
	public void setH_etc(String[] h_etc) {
		this.h_etc = h_etc;
		
		for(String i:h_etc) {
			h_etcStr+=i+"/";
		}
	}
	public String getH_etcStr() {
		return h_etcStr;
	}
	public void setH_etcStr(String h_etcStr) {
		this.h_etcStr = h_etcStr;
		
		h_etc=h_etcStr.split("/");
	}
	////////////////////////////////////
	public int getM_pattern() {
		return m_pattern;
	}
	public void setM_pattern(int m_pattern) {
		this.m_pattern = m_pattern;
	}
	public int getM_personality() {
		return m_personality;
	}
	public void setM_personality(int m_personality) {
		this.m_personality = m_personality;
	}
	public int getM_pet() {
		return m_pet;
	}
	public void setM_pet(int m_pet) {
		this.m_pet = m_pet;
	}
	public int getM_smoke() {
		return m_smoke;
	}
	public void setM_smoke(int m_smoke) {
		this.m_smoke = m_smoke;
	}
	public int getM_age() {
		return m_age;
	}
	public void setM_age(int m_age) {
		this.m_age = m_age;
	}
	public int getM_gender() {
		return m_gender;
	}
	public void setM_gender(int m_gender) {
		this.m_gender = m_gender;
	}
	public int getM_global() {
		return m_global;
	}
	public void setM_global(int m_global) {
		this.m_global = m_global;
	}
	public int getM_now() {
		return m_now;
	}
	public void setM_now(int m_now) {
		this.m_now = m_now;
	}
	public String getPdate() {
		return pdate;
	}
	public void setPdate(String pdate) {
		this.pdate = pdate;
	}
	public int getLife() {
		return life;
	}
	public void setLife(int life) {
		this.life = life;
	}
	public int getPet() {
		return pet;
	}
	public void setPet(int pet) {
		this.pet = pet;
	}
	public int getCommunicate() {
		return communicate;
	}
	public void setCommunicate(int communicate) {
		this.communicate = communicate;
	}
	public int getSmoke() {
		return smoke;
	}
	public void setSmoke(int smoke) {
		this.smoke = smoke;
	}
	public int getPersonality() {
		return personality;
	}
	public void setPersonality(int personality) {
		this.personality = personality;
	}
	public int getEtc() {
		return etc;
	}
	public void setEtc(int etc) {
		this.etc = etc;
	}
	public int getNow() {
		return now;
	}
	public void setNow(int now) {
		this.now = now;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	
	
	
	////////////////////
//	public String getH_support() {
//		return h_support;
//	}
//	public void setH_support(String h_support) {
//		this.h_support = h_support;
//	}
	
	
	
	
}
