package egovframework.openlink.home.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.openlink.home.service.CateVO;
import egovframework.openlink.home.service.HRMService;
import egovframework.openlink.home.service.HRMVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("hrmService")
public class HRMServiceImpl extends EgovAbstractServiceImpl implements HRMService {
	@Resource(name="hrmMapper")
	private HRMMapper hrmDAO;

	//카테고리 조회
	@Override
	public List<CateVO> getCate(String param) {
		if(param.equals("profile")) {
			return hrmDAO.getCateProfile();
		}else if(param.equals("evidence")) {
			return hrmDAO.getCateEvidence();
		}else if(param.equals("form")){
			return hrmDAO.getCateForm();
		}
		return null;
	}

	//프로필 등록조회
	@Override
	public List<HRMVO> getProList() {
		return hrmDAO.getProList();
	}
	
	//프로필 검색필터
	@Override
	public List<HRMVO> getProListFilter(String ctId) {
		return hrmDAO.getProListFilter(ctId);
	}
	

	//개인프로필 조회
	@Override
	public List<HRMVO> getProfile(String proCd) {
		return hrmDAO.getProfile(proCd);
	}

	//프로필코드 갯수조회
	@Override
	public int getProCdNum() {
		return hrmDAO.getProCdNum();
	}

	//개인프로필 등록
	@Override
	public void profileInsert(HRMVO hrmVO) {
		hrmDAO.profileInsert(hrmVO);
	}

	//문서정보 등록
	@Override
	public void profileDocUpload(HRMVO hrmVO) {
		hrmDAO.profileDocUpload(hrmVO);
	}

	//문서정보 불러오기
	@Override
	public List<HRMVO> getDockList(String proCd) {
		return hrmDAO.getDockList(proCd);
	}

	//개인프로필 삭제
	@Override
	public void profileDelete(HRMVO hrmVO) {
		hrmDAO.profileDelete(hrmVO);
	}

	//문서정보 삭제
	@Override
	public void proDocDelete(HRMVO hrmVO) {
		hrmDAO.proDocDelete(hrmVO);
	}

	//문서정보 한개삭제
	@Override
	public void proOneDocDelete(HRMVO hrmVO) {
		hrmDAO.proOneDocDelete(hrmVO);
	}

	//프로필수정
	@Override
	public void profileUpdate(HRMVO hrmVO) {
		hrmDAO.profileUpdate(hrmVO);
	}

	//서식 등록 조회
	@Override
	public List<HRMVO> getFormList() {
		return hrmDAO.getFormList();
	}

	//서식 검색 필터
	@Override
	public List<HRMVO> getFormFilter(String ctId) {
		return hrmDAO.getFormFilter(ctId);
	}

	//서식 코드 갯수 조회
	@Override
	public int getFormCdNum() {
		return hrmDAO.getFormCdNum();
	}

	//서식 insert
	@Override
	public void formInsert(HRMVO hrmVO) {
		hrmDAO.formInsert(hrmVO);
	}

	// 서식 상세 보기
	public List<HRMVO> getForm(String formCd) {
		return hrmDAO.getForm(formCd);
	}

	// 서식 
	public List<HRMVO> getFormDocList(String formcd) {
		return hrmDAO.getFormDocList(formcd);
	}

	//서식 삭제
	@Override
	public void formDelete(HRMVO hrmVO) {
		hrmDAO.formDelete(hrmVO);
	}

	//서식 문서 삭제
	@Override
	public void formDocDelete(HRMVO hrmVO) {
		hrmDAO.formDocDelete(hrmVO);
	}

	@Override
	public void formDocUpload(HRMVO hrmVO) {
		hrmDAO.formDocUpload(hrmVO);
		
	}

	//증빙자료 조회
	@Override
	public List<HRMVO> getEviList() {
		return hrmDAO.getEviList();
	}

	//증빙자료 검색 핉터
	@Override
	public List<HRMVO> getEviListFilter(String ctId) {
		return hrmDAO.getEviListFilter(ctId);
	}

	//증빙자료 갯수 조회
	@Override
	public int getEviCdNum() {
		return hrmDAO.getEviCdNum();
	}

	//증빙자료 등록
	@Override
	public void evidenceInsert(HRMVO hrmVO) {
		hrmDAO.evidenceInsert(hrmVO);

	}

	//증빙자료 문서 등록
	@Override
	public void evidenceDocUpload(HRMVO hrmVO) {
		hrmDAO.evidenceDocUpload(hrmVO);
	}

	//증빙자료 세부 화면
	@Override
	public List<HRMVO> getEvidence(String eviCd) {
		return hrmDAO.getEvidence(eviCd);
	}

	//증빙자료 수정
	@Override
	public void evidenceUpdate(HRMVO hrmVO) {
		hrmDAO.evidenceUpdate(hrmVO);
	}

	//증빙자료 삭제
	@Override
	public void evidenceDelete(HRMVO hrmVO) {
		hrmDAO.evidenceDelete(hrmVO);
	}

	//증빙자료 문서 삭제
	@Override
	public void evidenceDocDelete(HRMVO hrmVO) {
		hrmDAO.evidenceDocDelete(hrmVO);
	}

	//서식 수정
	@Override
	public void formUpdate(HRMVO hrmVO) {
		hrmDAO.formUpdate(hrmVO);
		}
}
