package egovframework.openlink.home.web;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.openlink.home.service.CateVO;
import egovframework.openlink.home.service.HRMService;
import egovframework.openlink.home.service.HRMVO;

@Controller
public class HRMController {
	@Resource(name = "hrmService")
	private HRMService hrmService;
	
	//메세지처리
	String msg = null, url = null;
	
	//프로필 조회화면
	@RequestMapping(value = "/profileList.do")
	public String profileList(HttpServletRequest request,
			@RequestParam("CT_ID") String ctId) throws Exception {
		System.out.println("프로필 조회화면");
		
		List<CateVO> cateList = null;
		List<HRMVO> HRMList = null;
		try {
			//검색파라미터 profile, evidence, form
			String param = "profile";
			cateList = hrmService.getCate(param);
			
			if(ctId.equals("") || ctId == null) {
				ctId = "all";
			}
			if(ctId.equals("all")) {
				HRMList = hrmService.getProList();
			}else {
				HRMList = hrmService.getProListFilter(ctId);
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "조회중 에러가 발생되었습니다.";
			url = "profileList.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
				
		request.setAttribute("cateList", cateList);
		request.setAttribute("HRMList", HRMList);
		
		return "home/HRM/profile_list";
	}
	
	//프로필 세부화면
	@RequestMapping(value = "/profileDetail.do")
	public String profileDetail(HttpServletRequest request,
			HttpSession session,
			@RequestParam("PRO_CD") String proCd) throws Exception {
		System.out.println("프로필 세부화면");
		
		List<HRMVO> HRMList = null;
		List<HRMVO> DocList = null;
		try {
			HRMList = hrmService.getProfile(proCd);
			DocList = hrmService.getDockList(proCd);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "조회중 에러가 발생되었습니다.";
			url = "profileList.do?CT_ID=all";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
				
		request.setAttribute("HRMList", HRMList);
		request.setAttribute("DocList", DocList);
		
		return "home/HRM/profile_detail";
	}
	
	//프로필 입력화면
	@RequestMapping(value = "/profileInsert.do")
	public String profileInsert(HttpServletRequest request,
			HttpSession session) throws Exception {
		System.out.println("프로필 입력화면");
		
		int cnt_proCdNum;
		String str_proCdNum;
		String str_proCd;
		List<CateVO> cateList = null;
		try {
			cnt_proCdNum = hrmService.getProCdNum();
			str_proCdNum = String.format("%03d", cnt_proCdNum + 1);
			str_proCd = "OP-PRO-" + str_proCdNum;
			
			//검색파라미터 profile, evidence, form
			String param = "profile";
			cateList = hrmService.getCate(param);
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "초기화중 에러가 발생하였습니다.";
			url = "profileList.do?CT_ID=all";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
		
		request.setAttribute("str_proCd", str_proCd);
		request.setAttribute("cateList", cateList);
		
		return "home/HRM/profile_insert";
	}
	
//	//프로필구분 관리화면
//	@RequestMapping(value = "/profileManager.do")
//	public String profileManager(HttpServletRequest request,
//			HttpSession session) throws Exception {
//		System.out.println("프로필구분 관리화면");
//		
//		int cnt_proCdNum;
//		String str_proCdNum;
//		String str_proCd;
//		List<CateVO> cateList = null;
//		try {
//			cnt_proCdNum = hrmService.getProCdNum();
//			str_proCdNum = String.format("%03d", cnt_proCdNum + 1);
//			str_proCd = "OP-PRO-" + str_proCdNum;
//			
//			//검색파라미터 profile, evidence, form
//			String param = "profile";
//			cateList = hrmService.getCate(param);
//			
//		}catch(Exception e) {
//			e.printStackTrace();
//			System.out.println("에러 : " + e);
//			msg = "초기화중 에러가 발생하였습니다.";
//			url = "profileList.do?CT_ID=all";
//			request.setAttribute("msg", msg);
//			request.setAttribute("url", url);
//			return "message";	
//		}
//		
//		request.setAttribute("str_proCd", str_proCd);
//		request.setAttribute("cateList", cateList);
//		
//		return "home/HRM/profile_insert";
//	}
	
	//프로필 입력OK
	@RequestMapping(value = "/profileInsertOk.do", method=RequestMethod.POST)
	@ResponseBody
	public void profileInsertOk(HttpServletRequest request,
			HttpSession session,
			@RequestParam("PRO_CD") String proCd,
			@RequestParam("PRO_NAME") String proName,
			@RequestParam("DEP") String dep,
			@RequestParam("CT_ID") String ctId,
			@RequestParam("STAT") String stat,
			@RequestParam("REG_DATE") String regDate,
			@RequestParam("RMK") String rmk) throws Exception {
		System.out.println("프로필 입력OK");
		
		HRMVO hrmVO = new HRMVO();
		hrmVO.setProCd(proCd);
		hrmVO.setCtId(ctId);
		hrmVO.setProName(proName);
		hrmVO.setDep(dep);
		hrmVO.setStat(stat);
		hrmVO.setRegDate(regDate);
		hrmVO.setRmk(rmk);
		
		try {
			hrmService.profileInsert(hrmVO);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
		}		
	}
		
	//프로필 문서업로드OK
		@ResponseBody
		@RequestMapping(value = "/docUploadOk.do", method=RequestMethod.POST)
		public void docUploadOk(HttpServletRequest request,
				MultipartHttpServletRequest multiRequest,
				@RequestParam("PARAM") String param,
				@RequestParam("PRO_CD") String proCd) throws Exception {
			System.out.println("프로필 문서업로드OK");
					
			HttpSession session = request.getSession();
			String path;
			MultipartFile file;
			if(param.equals("pro")) {
				path = session.getServletContext().getRealPath("/resources/document/profile/pro_profile");
				file = multiRequest.getFile("FILENAME_" + param);
			}else if(param.equals("cer")) {
				path = session.getServletContext().getRealPath("/resources/document/profile/pro_certification");
				file = multiRequest.getFile("FILENAME_" + param);
			}else if(param.equals("con")) {
				path = session.getServletContext().getRealPath("/resources/document/profile/pro_confirmation");
				file = multiRequest.getFile("FILENAME_" + param);
			}else {
				path = session.getServletContext().getRealPath("/resources/document/profile/pro_etc");
				file = multiRequest.getFile("FILENAME_" + param);
			}
			
			String filename = file.getOriginalFilename();
			
			File doc = new File(path, filename);
			file.transferTo(doc);
			 
			System.out.println("filename : " + filename);
			System.out.println("경로 : " + path);
			
			HRMVO hrmVO = new HRMVO();
			hrmVO.setProCd(proCd);
			hrmVO.setProType(param);
			hrmVO.setDocName(filename);
			hrmVO.setLoca(path);
			
			try {
				hrmService.profileDocUpload(hrmVO);
			}catch(Exception e) {
				e.printStackTrace();
				System.out.println("에러 : " + e);
			}
		}
	
	//프로필 삭제OK
	@RequestMapping(value = "/deleteProfileOK.do")
	public String deleteProfileOK(HttpServletRequest request,
			HttpSession session,
			@RequestParam("PRO_CD") String proCd) throws Exception {
		System.out.println("프로필 삭제OK");
		
		HRMVO hrmVO = new HRMVO();
		hrmVO.setProCd(proCd);
		
		try {
			hrmService.profileDelete(hrmVO);
			hrmService.proDocDelete(hrmVO);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "삭제중 에러가 발생하였습니다.";
			url = "profileList.do?CT_ID=all";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
		msg = "프로필이 삭제되었습니다.";
		url = "profileList.do?CT_ID=all";
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "message";	
	}
	
	//프로필 문서 한개삭제
	@RequestMapping(value = "/deleteProfileDocOK.do", method=RequestMethod.POST)
	@ResponseBody
	public void deleteProfileDocOK(HttpServletRequest request,
			HttpSession session,
			@RequestParam("PRO_CD") String proCd,
			@RequestParam("DOC_NAME") String docName) throws Exception {
		System.out.println("프로필 문서한개 삭제OK");
		
		HRMVO hrmVO = new HRMVO();
		hrmVO.setProCd(proCd);
		hrmVO.setDocName(docName);
		
		try {
			hrmService.proOneDocDelete(hrmVO);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
		}
	}
	
	//프로필 수정화면
	@RequestMapping(value = "/profileUpdate.do")
	public String profileUpdate(HttpServletRequest request,
			HttpSession session,
			@RequestParam("PRO_CD") String proCd) throws Exception {
		System.out.println("프로필 수정화면");
		
		List<HRMVO> HRMList = null;
		List<CateVO> cateList = null;
		List<HRMVO> DocList = null;
		
		try {
			HRMList = hrmService.getProfile(proCd);
			//검색파라미터 profile, evidence, form
			String param = "profile";
			cateList = hrmService.getCate(param);
			DocList = hrmService.getDockList(proCd);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "조회중 에러가 발생되었습니다.";
			url = "profileList.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
				
		request.setAttribute("HRMList", HRMList);
		request.setAttribute("cateList", cateList);
		request.setAttribute("DocList", DocList);
		
		return "home/HRM/profile_update";
	}
	
	//프로필 수정OK
	@RequestMapping(value = "/profileUpdateOk.do", method=RequestMethod.POST)
	@ResponseBody
	public void profileUpdateOk(HttpServletRequest request,
			HttpSession session,
			@RequestParam("PRO_CD") String proCd,
			@RequestParam("PRO_NAME") String proName,
			@RequestParam("DEP") String dep,
			@RequestParam("CT_ID") String ctId,
			@RequestParam("STAT") String stat,
			@RequestParam("RMK") String rmk) throws Exception {
		System.out.println("프로필 입력OK");
		
		HRMVO hrmVO = new HRMVO();
		hrmVO.setProCd(proCd);
		hrmVO.setCtId(ctId);
		hrmVO.setProName(proName);
		hrmVO.setDep(dep);
		hrmVO.setStat(stat);
		hrmVO.setRmk(rmk);
		
		try {
			hrmService.profileUpdate(hrmVO);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
		}		
	}
	
	//서식 조회화면
	@RequestMapping(value = "/formList.do")
	public String formList(HttpServletRequest request,
			@RequestParam("CT_ID") String ctId) throws Exception {
		System.out.println("서식 조회화면");
		
		List<CateVO> cateList = null;
		List<HRMVO> HRMList = null;
		try {
			//검색파라미터 profile, evidence, form
			String param = "form";
			cateList = hrmService.getCate(param);
			
			if(ctId.equals("") || ctId == null) {
				ctId = "all";
			}
			if(ctId.equals("all")) {
				HRMList = hrmService.getFormList();
			}else {
				HRMList = hrmService.getFormFilter(ctId);
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "조회중 에러가 발생되었습니다.";
			url = "profileList.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
				
		request.setAttribute("cateList", cateList);
		request.setAttribute("HRMList", HRMList);
		
		return "home/HRM/form_list";
	}
	
	//서식 입력화면
	@RequestMapping(value = "/formInsert.do")
	public String formInsert(HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("서식 입력화면");
		
		int cnt_formCdNum;
		String str_formCdNum;
		String str_formCd;
		List<CateVO> cateList = null;
		try {
			cnt_formCdNum = hrmService.getFormCdNum();
			str_formCdNum = String.format("%03d", cnt_formCdNum + 1);
			str_formCd = "OP-FORM-" + str_formCdNum;
			
			//검색파라미터 profile, evidence, form
			String param = "form";
			cateList = hrmService.getCate(param);
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "초기화중 에러가 발생하였습니다.";
			url = "formList.do?CT_ID=all";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
		
		request.setAttribute("str_formCd", str_formCd);
		request.setAttribute("cateList", cateList);
		
		return "home/HRM/form_insert";
	}
	
	//서식 입력OK
	@RequestMapping(value = "/formInsertOk.do", method=RequestMethod.POST)
	@ResponseBody
	public void formInsertOk(HttpServletRequest request,HttpSession session,
			@RequestParam("FORM_CD") String formCd,
			@RequestParam("FORM_NAME") String formName,
			@RequestParam("REG_DATE") String regDate,
			@RequestParam("CT_ID") String ctId,
			@RequestParam("REG_USER") String regUser,
			@RequestParam("RMK") String rmk) throws Exception {
		System.out.println("서식 입력OK");
		
		HRMVO hrmVO = new HRMVO();
		hrmVO.setFormCd(formCd);
		hrmVO.setCtId(ctId);
		hrmVO.setFormName(formName);
		hrmVO.setRegUser(regUser);
		hrmVO.setRegDate(regDate);
		hrmVO.setRmk(rmk);
		
		try {
			hrmService.formInsert(hrmVO);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
		}		
	}
	
	//서식 세부화면
	@RequestMapping(value = "/formDetail.do")
	public String formDetail(HttpServletRequest request, HttpSession session, @RequestParam("FORM_CD") String formCd) throws Exception {
		System.out.println("서식 세부화면");
		
		List<HRMVO> HRMList = null;
		List<HRMVO> DocList = null;
		try {
			HRMList = hrmService.getForm(formCd);
			DocList = hrmService.getDockList(formCd);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "조회중 에러가 발생되었습니다.";
			url = "formList.do?CT_ID=all";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
				
		request.setAttribute("HRMList", HRMList);
		request.setAttribute("DocList", DocList);
		
		return "home/HRM/form_detail";
	}
	
	//서식 수정화면
	@RequestMapping(value = "/formUpdate.do")
	public String formUpdate(HttpServletRequest request,
			HttpSession session,
			@RequestParam("FORM_CD") String formCd) throws Exception {
		System.out.println("서식 수정화면");
		
		List<HRMVO> HRMList = null;
		List<CateVO> cateList = null;
		List<HRMVO> DocList = null;
		
		try {
			HRMList = hrmService.getForm(formCd);
			//검색파라미터 profile, evidence, form
			String param = "form";
			cateList = hrmService.getCate(param);
			DocList = hrmService.getDockList(formCd);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "조회중 에러가 발생되었습니다.";
			url = "formList.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
				
		request.setAttribute("HRMList", HRMList);
		request.setAttribute("cateList", cateList);
		request.setAttribute("DocList", DocList);
		
		return "home/HRM/form_update";
	}
	
	//서식 수정OK
	@RequestMapping(value = "/formUpdateOk.do", method=RequestMethod.POST)
	@ResponseBody
	public void formUpdateOk(HttpServletRequest request,
			HttpSession session,
			@RequestParam("FORM_CD") String formCd,
			@RequestParam("FORM_NAME") String formName,
			@RequestParam("REG_USER") String regUser,
			@RequestParam("REG_DATE") String regDate,
			@RequestParam("CT_ID") String ctId,
			@RequestParam("RMK") String rmk) throws Exception {
		System.out.println("서식 입력OK");
		
		HRMVO hrmVO = new HRMVO();
		hrmVO.setFormCd(formCd);
		hrmVO.setFormName(formName);
		hrmVO.setRegUser(regUser);
		hrmVO.setRegDate(regDate);
		hrmVO.setCtId(ctId);
		hrmVO.setRmk(rmk);
		
		try {
			hrmService.formUpdate(hrmVO);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
		}		
	}

	//서식 문서업로드OK
	@ResponseBody
	@RequestMapping(value = "/formUploadOk.do", method=RequestMethod.POST)
	public void formUploadOk(HttpServletRequest request,
			MultipartHttpServletRequest multiRequest,
			@RequestParam("PARAM") String param,
			@RequestParam("FORM_CD") String formCd) throws Exception {
		System.out.println("서식업로드OK");
				
		HttpSession session = request.getSession();
		String path;
		MultipartFile file;
		if(param.equals("form")) {
			path = session.getServletContext().getRealPath("/resources/document/profile/pro_profile");
			file = multiRequest.getFile("FILENAME_" + param);
		}else if(param.equals("cer")) {
			path = session.getServletContext().getRealPath("/resources/document/profile/pro_certification");
			file = multiRequest.getFile("FILENAME_" + param);
		}else if(param.equals("con")) {
			path = session.getServletContext().getRealPath("/resources/document/profile/pro_confirmation");
			file = multiRequest.getFile("FILENAME_" + param);
		}else {
			path = session.getServletContext().getRealPath("/resources/document/profile/pro_etc");
			file = multiRequest.getFile("FILENAME_" + param);
		}
		
		String filename = file.getOriginalFilename();
		
		File doc = new File(path, filename);
		file.transferTo(doc);
		 
		System.out.println("filename : " + filename);
		System.out.println("경로 : " + path);
		
		HRMVO hrmVO = new HRMVO();
		hrmVO.setFormCd(formCd);
		hrmVO.setDocName(filename);
		hrmVO.setLoca(path);
		
		try {
			hrmService.formDocUpload(hrmVO);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
		}
	}
	
	//서식 삭제OK
	@RequestMapping(value = "/deleteFormOK.do")
	public String deleteFormOK(HttpServletRequest request,
			HttpSession session,
			@RequestParam("FORM_CD") String formCd) throws Exception {
		System.out.println("서식 삭제OK");
		
		HRMVO hrmVO = new HRMVO();
		hrmVO.setFormCd(formCd);
		
		try {
			hrmService.formDelete(hrmVO);
			hrmService.formDocDelete(hrmVO);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "삭제중 에러가 발생하였습니다.";
			url = "formList.do?CT_ID=all";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
		msg = "서식이 삭제되었습니다.";
		url = "formList.do?CT_ID=all";
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "message";	
	}
	
	//증빙자료 조회화면
	@RequestMapping(value = "/evidenceList.do")
	public String evidenceList(HttpServletRequest request,
			@RequestParam("CT_ID") String ctId) throws Exception {
		System.out.println("증빙자료 조회화면");
		
		List<CateVO> cateList = null;
		List<HRMVO> HRMList = null;
		try {
			//검색파라미터 profile, evidence, form
			String param = "evidence";
			cateList = hrmService.getCate(param);
			
			if(ctId.equals("") || ctId == null) {
				ctId = "all";
			}
			if(ctId.equals("all")) {
				HRMList = hrmService.getEviList();
			}else {
				HRMList = hrmService.getEviListFilter(ctId);
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "조회중 에러가 발생되었습니다.";
			url = "evidenceList.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
				
		request.setAttribute("cateList", cateList);
		request.setAttribute("HRMList", HRMList);
		
		return "home/HRM/evidence_list";
	}
	
	//증빙자료 입력화면
	@RequestMapping(value = "/evidenceInsert.do")
	public String evidenceInsert(HttpServletRequest request,
			HttpSession session) throws Exception {
		System.out.println("증빙자료 입력화면");
		
		int cnt_eviCdNum;
		String str_eviCdNum;
		String str_eviCd;
		List<CateVO> cateList = null;
		try {
			cnt_eviCdNum = hrmService.getEviCdNum();
			str_eviCdNum = String.format("%03d", cnt_eviCdNum + 1);
			str_eviCd = "OP-EVI-" + str_eviCdNum;
			
			//검색파라미터 profile, evidence, form
			String param = "evidence";
			cateList = hrmService.getCate(param);
			System.out.println("값 : " + cateList);
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "초기화중 에러가 발생하였습니다.";
			url = "evidenceList.do?CT_ID=all";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
		
		request.setAttribute("str_eviCd", str_eviCd);
		request.setAttribute("cateList", cateList);
		
		return "home/HRM/evidence_insert";
	}
	
	//증빙자료 입력OK
	@RequestMapping(value = "/evidenceInsertOk.do", method=RequestMethod.POST)
	@ResponseBody
	public void evidenceInsertOk(HttpServletRequest request,
			HttpSession session,
			@RequestParam("EVI_CD") String eviCd,
			@RequestParam("EVI_NAME") String eviName,
			@RequestParam("REG_USER") String regUser,
			@RequestParam("REG_DATE") String regDate,
			@RequestParam("EXP_DATE") String expDate,
			@RequestParam("CT_ID") String ctId,
			@RequestParam("RMK") String rmk) throws Exception {
		System.out.println("증빙자료 입력OK");
		
		HRMVO hrmVO = new HRMVO();
		hrmVO.setEviCd(eviCd);
		hrmVO.setEviName(eviName);
		hrmVO.setRegUser(regUser);
		hrmVO.setRegDate(regDate);
		hrmVO.setExpDate(expDate);
		hrmVO.setCtId(ctId);
		hrmVO.setRmk(rmk);
		
		try {
			hrmService.evidenceInsert(hrmVO);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
		}		
	}
	
	//증빙자료 문서업로드OK
	@ResponseBody
	@RequestMapping(value = "/eviUploadOk.do", method=RequestMethod.POST)
	public void eviUploadOk(HttpServletRequest request,
			MultipartHttpServletRequest multiRequest,
			@RequestParam("PARAM") String param,
			@RequestParam("EVI_CD") String eviCd) throws Exception {
		System.out.println("증빙자료 문서업로드OK");
				
		HttpSession session = request.getSession();
		String path = null;
		MultipartFile file = null;
		if(param.equals("doc")) {
			path = session.getServletContext().getRealPath("/resources/document/evidence");
			file = multiRequest.getFile("FILENAME_" + param);
			}else {
			System.out.println("에러 : " + path);
			}
				
		String filename = file.getOriginalFilename();
		
		File doc = new File(path, filename);
		file.transferTo(doc);
		
		System.out.println("filename : " + filename);
		System.out.println("경로 : " + path);
		
		HRMVO hrmVO = new HRMVO();
		hrmVO.setEviCd(eviCd);
		hrmVO.setEviType(param);
		hrmVO.setDocName(filename);
		hrmVO.setLoca(path);
		
		try {
			hrmService.evidenceDocUpload(hrmVO);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
		}
	}
	
	//증빙자료 세부화면
	@RequestMapping(value = "/evidenceDetail.do")
	public String evidenceDetail(HttpServletRequest request,
			HttpSession session,
			@RequestParam("EVI_CD") String eviCd) throws Exception {
		System.out.println("증빙자료 세부화면");
		
		List<HRMVO> HRMList = null;
		List<HRMVO> DocList = null;
		try {
			HRMList = hrmService.getEvidence(eviCd);
			DocList = hrmService.getDockList(eviCd);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "조회중 에러가 발생되었습니다.";
			url = "evidenceList.do?CT_ID=all";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
				
		request.setAttribute("HRMList", HRMList);
		request.setAttribute("DocList", DocList);
		
		return "home/HRM/evidence_detail";
	}
	
	//증빙자료 수정화면
	@RequestMapping(value = "/evidenceUpdate.do")
	public String evidenceUpdate(HttpServletRequest request,
			HttpSession session,
			@RequestParam("EVI_CD") String eviCd) throws Exception {
		System.out.println("증빙자료 수정화면");
		
		List<HRMVO> HRMList = null;
		List<CateVO> cateList = null;
		List<HRMVO> DocList = null;
		
		try {
			HRMList = hrmService.getEvidence(eviCd);
			//검색파라미터 profile, evidence, form
			String param = "evidence";
			cateList = hrmService.getCate(param);
			DocList = hrmService.getDockList(eviCd);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "조회중 에러가 발생되었습니다.";
			url = "profileList.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
				
		request.setAttribute("HRMList", HRMList);
		request.setAttribute("cateList", cateList);
		request.setAttribute("DocList", DocList);
		
		return "home/HRM/evidence_update";
	}
	
	//증빙자료 수정OK
	@RequestMapping(value = "/evidenceUpdateOk.do", method=RequestMethod.POST)
	@ResponseBody
	public void evidenceUpdateOk(HttpServletRequest request,
			HttpSession session,
			@RequestParam("EVI_CD") String eviCd,
			@RequestParam("EVI_NAME") String eviName,
			@RequestParam("CT_ID") String ctId,
			@RequestParam("REG_USER") String regUser,
			@RequestParam("REG_DATE") String regDate,
			@RequestParam("EXP_DATE") String expDate,
			@RequestParam("RMK") String rmk) throws Exception {
		System.out.println("증빙자료 입력OK");
		
		HRMVO hrmVO = new HRMVO();
		hrmVO.setEviCd(eviCd);
		hrmVO.setCtId(ctId);
		hrmVO.setEviName(eviName);
		hrmVO.setRegUser(regUser);
		hrmVO.setRegDate(regDate);
		hrmVO.setExpDate(expDate);
		hrmVO.setRmk(rmk);
		
		try {
			hrmService.evidenceUpdate(hrmVO);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
		}		
	}
	
	//증빙자료 삭제OK
	@RequestMapping(value = "/deleteEvidenceOK.do")
	public String deleteEvidenceOK(HttpServletRequest request,
			HttpSession session,
			@RequestParam("EVI_CD") String eviCd) throws Exception {
		System.out.println("증빙자료 삭제OK");
		
		HRMVO hrmVO = new HRMVO();
		hrmVO.setEviCd(eviCd);
		
		try {
			hrmService.evidenceDelete(hrmVO);
			hrmService.evidenceDocDelete(hrmVO);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("에러 : " + e);
			msg = "삭제중 에러가 발생하였습니다.";
			url = "evidenceList.do?CT_ID=all";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "message";	
		}
		msg = "증빙자료가 삭제되었습니다.";
		url = "evidenceList.do?CT_ID=all";
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "message";	
	}
	
}
