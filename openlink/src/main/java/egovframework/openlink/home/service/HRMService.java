package egovframework.openlink.home.service;

import java.util.List;

public interface HRMService {

	//카테고리 조회
	List<CateVO> getCate(String param);

	//프로필 등록 조회
	List<HRMVO> getProList();
	
	//프로필 검색필터
	List<HRMVO> getProListFilter(String ctId);

	//개인프로필 조회
	List<HRMVO> getProfile(String proCd);

	//프로필코드 갯수조회
	int getProCdNum();

	//개인프로필 등록
	void profileInsert(HRMVO hrmVO);

	//문서정보 등록
	void profileDocUpload(HRMVO hrmVO);

	//문서정보 불러오기
	List<HRMVO> getDockList(String proCd);

	//개인프로필 삭제
	void profileDelete(HRMVO hrmVO);

	//문서정보 삭제
	void proDocDelete(HRMVO hrmVO);

	//문저정보 한개삭제
	void proOneDocDelete(HRMVO hrmVO);

	//프로필 수정
	void profileUpdate(HRMVO hrmVO);

	//서식 등록 조회
	List<HRMVO> getFormList();

	//서식 검색 필터
	List<HRMVO> getFormFilter(String ctId);

	//서식코드 갯수 조회
	int getFormCdNum();

	// 서식 insert
	void formInsert(HRMVO hrmVO);

	// 서식 상세보기
	List<HRMVO> getForm(String formCd);
	
	// 서식 정보 불러오기
	List<HRMVO> getFormDocList(String formcd);

	//서식 삭제
	void formDelete(HRMVO hrmVO);

	//서식 문서 삭제
	void formDocDelete(HRMVO hrmVO);

	//서식 등록
	void formDocUpload(HRMVO hrmVO);

	//증빙자료 조회
	List<HRMVO> getEviList();

	//증빙자료 검색 필터
	List<HRMVO> getEviListFilter(String ctId);

	//증빙자료 갯수
	int getEviCdNum();

	//증빙자료 등록
	void evidenceInsert(HRMVO hrmVO);

	//증빙자료 문서 등록
	void evidenceDocUpload(HRMVO hrmVO);

	//증빙자료 세부화면
	List<HRMVO> getEvidence(String eviCd);

	//증빙자료수정
	void evidenceUpdate(HRMVO hrmVO);

	//증빙자료 삭제ok
	void evidenceDelete(HRMVO hrmVO);

	//증빙자료삭제
	void evidenceDocDelete(HRMVO hrmVO);

	//서식 수정
	void formUpdate(HRMVO hrmVO);
	

}
