package egovframework.openlink.home.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.openlink.home.service.BoardService;
import egovframework.openlink.home.service.BoardVO;
import egovframework.openlink.home.service.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("boardService")
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {
	@Resource(name="boardMapper")
	private BoardMapper boardDAO;
	
	//로그인체크
	@Override
	public String selectLoginCheck(UserVO userVO) {
		return boardDAO.selectLoginCheck(userVO);
	}

	//주간업무 조회
	@Override
	public List<BoardVO> searchWeeklyReport(BoardVO boardVO) {
		return boardDAO.searchWeeklyReport(boardVO);
	}

	//주간업무 작성자 조회
	@Override
	public List<BoardVO> searchWeeklyReportWriter(BoardVO boardVO) {
		return boardDAO.searchWeeklyReportWriter(boardVO);
	}

	//참여중인프로젝트 조회
	@Override
	public List<BoardVO> searchProjectList(UserVO userVO) {
		return boardDAO.searchProjectList(userVO);
	}

	//지난주 주간업무 조회
	@Override
	public String searchLastWeeklyReport(BoardVO boardVO) {
		return boardDAO.searchLastWeeklyReport(boardVO);
	}

	//주간업무 작성
	@Override
	public void insertReport(BoardVO boardVO) {
		boardDAO.insertReport(boardVO);
	}

	//주간업무 작성 (전주)
	@Override
	public void insertReport_lastweek(BoardVO boardVO) {
		if(boardDAO.insertReport_lastweek_check(boardVO) == 0) {
			boardDAO.insertReport_lastweek(boardVO);
		}
	}

	//주간업무 작성 확인(이번주)
	@Override
	public int alreadyWeeklyReport(BoardVO boardVO) {
		return boardDAO.alreadyWeeklyReport(boardVO);
	}

	//수정페이지 조회
	@Override
	public List<BoardVO> searchReportList(BoardVO boardVO) {
		return boardDAO.searchReportList(boardVO);
	}

	//수정항목 작성 프로젝트 조회
	@Override
	public List<BoardVO> searchReportProject(BoardVO boardVO) {
		return boardDAO.searchReportProject(boardVO);
	}

	//수정항목 업무보고 블러오기
	@Override
	public List<BoardVO> loadReport(BoardVO boardVO) {
		return boardDAO.loadReport(boardVO);
	}

	//업무보고 수정
	@Override
	public void updateWeeklyReport(BoardVO boardVO) {
		boardDAO.updateWeeklyReport(boardVO);
	}

	//주간업무 삭제(주별)
	@Override
	public void deleteReportGroup(BoardVO boardVO) {
		boardDAO.deleteReportGroup(boardVO);
	}

	//자동로그인 체크
	@Override
	public String autoLoginCheck(UserVO userVO) {
		return boardDAO.autoLoginCheck(userVO);
	}

}
