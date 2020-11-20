package egovframework.openlink.home.service.impl;

import java.util.List;

import egovframework.openlink.home.service.BoardVO;
import egovframework.openlink.home.service.UserVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper")
public interface BoardMapper {
	//로그인체크
	String selectLoginCheck(UserVO userVO);

	//주간업무 조회
	List<BoardVO> searchWeeklyReport(BoardVO boardVO);

	//주간업무 작성자 조회
	List<BoardVO> searchWeeklyReportWriter(BoardVO boardVO);

	//참여중인프로젝트 조회
	List<BoardVO> searchProjectList(UserVO userVO);

	//지난주 주간업무 조회
	String searchLastWeeklyReport(BoardVO boardVO);

	//주간업무 작성
	void insertReport(BoardVO boardVO);

	//전주 작성됬는지 확인
	int insertReport_lastweek_check(BoardVO boardVO);

	//주간업무 작성확인(전주)
	void insertReport_lastweek(BoardVO boardVO);

	//주간업무 작성확인(이번주)
	int alreadyWeeklyReport(BoardVO boardVO);

	//수정페이지 조회
	List<BoardVO> searchReportList(BoardVO boardVO);

	//수정항목 작성 프로젝트 조회
	List<BoardVO> searchReportProject(BoardVO boardVO);

	//수정항목 업무보고 블러오기
	List<BoardVO> loadReport(BoardVO boardVO);

	//업무보고 수정
	void updateWeeklyReport(BoardVO boardVO);

	//주간업무 삭제(주별)
	void deleteReportGroup(BoardVO boardVO);

	//자동로그인 체크
	String autoLoginCheck(UserVO userVO);
}
