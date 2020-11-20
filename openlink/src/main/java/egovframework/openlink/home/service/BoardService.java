package egovframework.openlink.home.service;

import java.util.List;

public interface BoardService {
	//로그인 체크
	String selectLoginCheck(UserVO vo);

	//주간업무 조회
	List<BoardVO> searchWeeklyReport(BoardVO boardVO);

	//주간업무 작성자 조회
	List<BoardVO> searchWeeklyReportWriter(BoardVO boardVO);

	//참여중인 프로젝트조회
	List<BoardVO> searchProjectList(UserVO userVO);

	//지난주 주간업무 조회
	String searchLastWeeklyReport(BoardVO boardVO);

	//주간업무 작성
	void insertReport(BoardVO boardVO);

	//주간업무 작성 확인(전주)
	void insertReport_lastweek(BoardVO boardVO);

	//주간업무 작성 확인(이번주)
	int alreadyWeeklyReport(BoardVO boardVO);

	//수정페이지 조회
	List<BoardVO> searchReportList(BoardVO boardVO);

	//수정항목 작성 프로젝트 조회
	List<BoardVO> searchReportProject(BoardVO boardVO);

	//수정항목 업무보고 블러오기
	List<BoardVO> loadReport(BoardVO boardVO);

	//수정완료
	void updateWeeklyReport(BoardVO boardVO);

	//주간업무 삭제(주별)
	void deleteReportGroup(BoardVO boardVO);

	//자동로그인 체크
	String autoLoginCheck(UserVO userVO);
}
