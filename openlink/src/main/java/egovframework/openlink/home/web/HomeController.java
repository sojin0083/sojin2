package egovframework.openlink.home.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.openlink.home.service.BoardService;
import egovframework.openlink.home.service.BoardVO;
import egovframework.openlink.home.service.UserVO;

@Controller
public class HomeController {
	@Resource(name = "boardService")
	private BoardService boardService;

	//메인화면
	@RequestMapping(value = "/main.do")
	public String main(HttpServletRequest request) throws Exception {
		System.out.println("메인화면");
		
		try {
			//쿠키로그인
			Cookie[] cookies = request.getCookies();
			if(cookies != null) {		//java.lang.NullPointerException 방지
				//쿠키값 확인
//				System.out.println("쿠키갯수 : " + cookies.length);
//				for (int i = 0; i < cookies.length; i++) {								// 쿠키 배열을 반복문으로 돌린다.
//					System.out.println(i + "번째 쿠키 이름 : " + cookies[i].getName()); 		// 쿠키의 이름을 가져온다.
//					System.out.println(i + "번째 쿠키에 설정된 값 : " + cookies[i].getValue()); // 쿠키의 값을 가져온다.
//				}
				for(int i = 0; i < cookies.length; i++) {
					if(cookies[i].getName().equals("user_id")) {
						UserVO userVO = new UserVO();
						userVO.setUser_id(cookies[i].getValue());
						String user_name = boardService.autoLoginCheck(userVO);
						
						request.getSession().setAttribute("user_id", cookies[i].getValue());
						request.getSession().setAttribute("user_name", user_name);
					}
				}
			}
		}catch(Exception e) {
			request.setAttribute("msg", "쿠키오류 : " + e);
			return "home/main";
		}
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		//이번연도,주
		int this_year = cal.get(Calendar.YEAR);
		int this_week = cal.get(Calendar.WEEK_OF_YEAR);
		
		ArrayList<Integer> term_year_list = new ArrayList<Integer>();
		ArrayList<Integer> term_week_list = new ArrayList<Integer>();
		
		for(int i = 2019; i < 2031; i++) {
			term_year_list.add(i);
		}
		for(int i = 0; i < 52; i++) {
			term_week_list.add(i+1);
		}
		request.setAttribute("term_year_list", term_year_list);
		request.setAttribute("term_week_list", term_week_list);
		request.setAttribute("this_year", Integer.toString(this_year));
		request.setAttribute("this_week", Integer.toString(this_week));
		
		return "home/main";
	}
	
	//조회화면
	@RequestMapping(value = "/search.do")
	public String search(HttpServletRequest request) throws Exception {
		System.out.println("조회화면");
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		//이번연도,주
		int this_year = cal.get(Calendar.YEAR);
		int this_week = cal.get(Calendar.WEEK_OF_YEAR);
		
		ArrayList<Integer> term_year_list = new ArrayList<Integer>();
		ArrayList<Integer> term_week_list = new ArrayList<Integer>();
		
		for(int i = 2019; i < 2031; i++) {
			term_year_list.add(i);
		}
		for(int i = 0; i < 52; i++) {
			term_week_list.add(i+1);
		}
		request.setAttribute("term_year_list", term_year_list);
		request.setAttribute("term_week_list", term_week_list);
		request.setAttribute("this_year", Integer.toString(this_year));
		request.setAttribute("this_week", Integer.toString(this_week));
		
		return "home/report/search";
	}
	
	//주간업무 조회
	@RequestMapping(value = "/search_weekly.do")
	public String search_weekly(HttpServletRequest request, @RequestParam("term_year") String term_year, @RequestParam("term_week") String term_week) throws Exception {
		System.out.println("검색화면");
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		//이번연도,주
		int this_year = cal.get(Calendar.YEAR);
		int this_week = cal.get(Calendar.WEEK_OF_YEAR);
		
		BoardVO boardVO = new BoardVO();
		boardVO.setTerm_year(term_year);
		boardVO.setTerm_week(term_week);
		
		List<BoardVO> weeklyReport = null;
		List<BoardVO> weeklyReportWriter = null;
		try {
			weeklyReport = boardService.searchWeeklyReport(boardVO);
			weeklyReportWriter = boardService.searchWeeklyReportWriter(boardVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "등록된 업무보고가 없습니다.");
		}
		
		request.setAttribute("weeklyReport", weeklyReport);
		request.setAttribute("weeklyReportWriter", weeklyReportWriter);
		request.setAttribute("term_year", term_year);
		request.setAttribute("term_week", term_week);
		
		ArrayList<Integer> term_year_list = new ArrayList<Integer>();
		ArrayList<Integer> term_week_list = new ArrayList<Integer>();
		
		for(int i = 2019; i < 2031; i++) {
			term_year_list.add(i);
		}
		for(int i = 0; i < 52; i++) {
			term_week_list.add(i+1);
		}
		request.setAttribute("term_year_list", term_year_list);
		request.setAttribute("term_week_list", term_week_list);
		request.setAttribute("this_year", Integer.toString(this_year));
		request.setAttribute("this_week", Integer.toString(this_week));
		
		return "home/report/search";
	}
	
	//주간업무 작성메뉴
	@RequestMapping(value = "/write.do")
	public String write(HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("주간업무작성 페이지");
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		//이번연도,주
		int this_year = cal.get(Calendar.YEAR);
		int this_week = cal.get(Calendar.WEEK_OF_YEAR);
		
		ArrayList<Integer> term_year_list = new ArrayList<Integer>();
		ArrayList<Integer> term_week_list = new ArrayList<Integer>();
		
		for(int i = 2019; i < 2031; i++) {
			term_year_list.add(i);
		}
		for(int i = 0; i < 52; i++) {
			term_week_list.add(i+1);
		}
		
		//참가중인 프로젝트 검색
		String user_id = (String) session.getAttribute("user_id");
		UserVO userVO = new UserVO();
		userVO.setUser_id(user_id);
		
		List<BoardVO> projectList = null;
		try {
			projectList = boardService.searchProjectList(userVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "조회중 에러가 발생했습니다.");
			return "home/main";
		}
		

		request.setAttribute("term_year_list", term_year_list);
		request.setAttribute("term_week_list", term_week_list);
		request.setAttribute("this_year", Integer.toString(this_year));
		request.setAttribute("this_week", Integer.toString(this_week));
		request.setAttribute("projectList", projectList);
		
		return "home/report/write_form";
	}
		
	//주간업무 작성조회
	@RequestMapping(value = "/select_project.do")
	public String select_date(HttpServletRequest request, HttpSession session, 
			@RequestParam("select_project") String select_project,
			@RequestParam("term_year") String term_year, 
			@RequestParam("term_week") String term_week) throws Exception {
		System.out.println("주간업무작성 날짜선택");
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		//이번연도,주
		int this_year = cal.get(Calendar.YEAR);
		int this_week = cal.get(Calendar.WEEK_OF_YEAR);
		
		ArrayList<Integer> term_year_list = new ArrayList<Integer>();
		ArrayList<Integer> term_week_list = new ArrayList<Integer>();
		
		for(int i = 2019; i < 2031; i++) {
			term_year_list.add(i);
		}
		for(int i = 0; i < 52; i++) {
			term_week_list.add(i+1);
		}
		
		String weeklyReport = "";
		BoardVO boardVO = new BoardVO();
		int today_year = Integer.parseInt(term_year);
		int today_week = Integer.parseInt(term_week);
		int last_year = 0;
		int last_week = 0;
		String user_id = (String) session.getAttribute("user_id");
		if(today_week == 1) {
			last_year = today_year - 1;
			last_week = 52;
		}else {
			last_year = today_year;
			last_week = today_week - 1;
		}
		
		//참가중인 프로젝트 검색
		UserVO userVO = new UserVO();
		userVO.setUser_id(user_id);
		
		List<BoardVO> projectList = null;
		try {
			projectList = boardService.searchProjectList(userVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "조회중 에러가 발생했습니다.");
			return "home/report/write_form";
		}
		
		boardVO.setTerm_year(term_year);
		boardVO.setTerm_week(term_week);
		boardVO.setLast_term_year(Integer.toString(last_year));
		boardVO.setLast_term_week(Integer.toString(last_week));
		boardVO.setProject_code(select_project);
		boardVO.setUser_id(user_id);
		
		try {
			int weeklyReport_check = boardService.alreadyWeeklyReport(boardVO);
			if(weeklyReport_check > 0) {
				request.setAttribute("term_year_list", term_year_list);
				request.setAttribute("term_week_list", term_week_list);
				request.setAttribute("term_year", term_year);
				request.setAttribute("term_week", term_week);
				request.setAttribute("select_project", "");
				request.setAttribute("projectList", projectList);
				request.setAttribute("msg", "이미 업무보고가 있습니다.");
				return "home/report/write_form";
			}
			weeklyReport = boardService.searchLastWeeklyReport(boardVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "등록된 업무보고가 없습니다.");
		}

		request.setAttribute("term_year_list", term_year_list);
		request.setAttribute("term_week_list", term_week_list);
		request.setAttribute("term_year", term_year);
		request.setAttribute("term_week", term_week); 
		request.setAttribute("this_year", Integer.toString(this_year));
		request.setAttribute("this_week", Integer.toString(this_week));
		request.setAttribute("select_project", select_project);
		request.setAttribute("projectList", projectList);
		request.setAttribute("weeklyReport", weeklyReport);
		
		return "home/report/write_form";
	}
	
	//주간업무 작성
	@RequestMapping(value = "/insertReport.do")
	public String insertReport(HttpServletRequest request, HttpSession session, 
			@RequestParam("select_project") String select_project,
			@RequestParam("term_year") String term_year, 
			@RequestParam("term_week") String term_week,
			@RequestParam("etc") String etc,
			@RequestParam("last_week") String last_week,
			@RequestParam("next_week") String next_week) throws Exception {
		System.out.println("주간업무작성 완료");
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		//이번연도,주
		int this_year = cal.get(Calendar.YEAR);
		int this_week = cal.get(Calendar.WEEK_OF_YEAR);
		
		//reg_date 계산
		SimpleDateFormat format1 = new SimpleDateFormat ( "yy.MM.dd.");				
		Date time = new Date();
		String reg_date = format1.format(time);
		
		//년도, 주차 리스트
		ArrayList<Integer> term_year_list = new ArrayList<Integer>();
		ArrayList<Integer> term_week_list = new ArrayList<Integer>();
		
		for(int i = 2019; i < 2031; i++) {
			term_year_list.add(i);
		}
		for(int i = 0; i < 52; i++) {
			term_week_list.add(i+1);
		}
		
		//참가중인 프로젝트 검색
		String user_id = (String) session.getAttribute("user_id");
		UserVO userVO = new UserVO();
		userVO.setUser_id(user_id);
		
		List<BoardVO> projectList = null;
		try {
			projectList = boardService.searchProjectList(userVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "참여프로젝트 조회중 에러가 발생했습니다.");
			return "home/report/write_form";
		}

		int term_year_last = Integer.parseInt(term_year);
		int term_week_last = Integer.parseInt(term_week);
		
		if(Integer.parseInt(term_week) == 1) {
			term_year_last = term_year_last - 1;
			term_week_last = 52;
		}else {
			term_week_last = term_week_last - 1;
		}
		
		BoardVO boardVO = new BoardVO();
		boardVO.setProject_code(select_project);
		boardVO.setTerm_year(Integer.toString(term_year_last));
		boardVO.setTerm_week(Integer.toString(term_week_last));
		boardVO.setEtc(etc);
		boardVO.setUser_id(user_id);
		boardVO.setLast_week(last_week);
		boardVO.setNext_week(next_week);
		boardVO.setReg_date(reg_date);
		
		try {
			//지난주에 주간업무가 등록되었는지?
			boardService.insertReport_lastweek(boardVO);
			//현재연도, 주차설정
			boardVO.setTerm_year(term_year);
			boardVO.setTerm_week(term_week);
			//주간업무 작성
			boardService.insertReport(boardVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "작성중 에러가 발생했습니다.");
			return "home/main";
		}
		
		request.setAttribute("term_year_list", term_year_list);
		request.setAttribute("term_week_list", term_week_list);
		request.setAttribute("term_year", term_year);
		request.setAttribute("term_week", term_week);
		request.setAttribute("select_project", select_project);
		request.setAttribute("projectList", projectList);
		request.setAttribute("msg", "작성이 완료되었습니다.");
		
		return "home/report/write_form";
		
	}
	
	//수정페이지 조회
	@RequestMapping(value = "/update.do")
	public String update(HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("수정리스트화면");
		
		String user_id = (String) session.getAttribute("user_id");
		BoardVO boardVO = new BoardVO();
		boardVO.setUser_id(user_id);
		
		List<BoardVO> reportList = null;
		try {
			reportList = boardService.searchReportList(boardVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "조회중 에러가 발생했습니다.");
			return "home/report/update_list";
		}
		
		request.setAttribute("reportList", reportList);
		
		return "home/report/update_list";
	}
	
	//수정항목 불러오기
	@RequestMapping(value = "/update_form.do")
	public String update_form(HttpServletRequest request, HttpSession session,
			@RequestParam("select_project") String select_project,
			@RequestParam("term_year") String term_year,
			@RequestParam("term_week") String term_week,
			@RequestParam("user_id") String user_id
			) throws Exception {
		System.out.println("수정항목 불러오기");
		
		BoardVO boardVO = new BoardVO();
		boardVO.setUser_id(user_id);
		boardVO.setTerm_year(term_year);
		boardVO.setTerm_week(term_week);
		
		//작성한 업무의 프로젝트명
		List<BoardVO> reportProject = null;
		try {
			reportProject = boardService.searchReportProject(boardVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "조회중 에러가 발생했습니다.");
			return "home/report/update_list";
		}
		
		request.setAttribute("term_year", term_year);
		request.setAttribute("term_week", term_week);
		request.setAttribute("projectList", reportProject);
		request.setAttribute("select_project", select_project);
		
		return "home/report/update_form";
	}
	
	//수정프로젝트 데이터 불러오기
	@RequestMapping(value = "/update_load.do")
	public String update_load(HttpServletRequest request, HttpSession session,
			@RequestParam("select_project") String select_project,
			@RequestParam("term_year") String term_year,
			@RequestParam("term_week") String term_week,
			@RequestParam("user_id") String user_id
			) throws Exception {
		System.out.println("수정항목 불러오기");
		
		BoardVO boardVO = new BoardVO();
		boardVO.setUser_id(user_id);
		boardVO.setTerm_year(term_year);
		boardVO.setTerm_week(term_week);
		boardVO.setProject_code(select_project);
		
		//작성한 업무보고 불러오기
		List<BoardVO> loadReport = null;
		try {
			loadReport = boardService.loadReport(boardVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "조회중 에러가 발생했습니다.");
			return "home/report/update_list";
		}
		
		//작성한 업무의 프로젝트명
		List<BoardVO> reportProject = null;
		try {
			reportProject = boardService.searchReportProject(boardVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "조회중 에러가 발생했습니다.");
			return "home/report/update_list";
		}
		
		request.setAttribute("term_year", term_year);
		request.setAttribute("term_week", term_week);
		request.setAttribute("loadReport", loadReport);
		request.setAttribute("projectList", reportProject);
		request.setAttribute("select_project", select_project);
		
		return "home/report/update_form";
	}

	//주간업무 수정
	@RequestMapping(value = "/updateReport.do")
	public String updateReport(HttpServletRequest request, HttpSession session, 
			@RequestParam("select_project") String select_project,
			@RequestParam("term_year") String term_year, 
			@RequestParam("term_week") String term_week,
			@RequestParam("etc") String etc,
			@RequestParam("last_week") String last_week,
			@RequestParam("next_week") String next_week,
			@RequestParam("user_id") String user_id) throws Exception {
		System.out.println("주간업무수정 완료");
		
		//년도, 주차 리스트
		ArrayList<Integer> term_year_list = new ArrayList<Integer>();
		ArrayList<Integer> term_week_list = new ArrayList<Integer>();
		
		for(int i = 2019; i < 2031; i++) {
			term_year_list.add(i);
		}
		for(int i = 0; i < 52; i++) {
			term_week_list.add(i+1);
		}
		
		BoardVO boardVO = new BoardVO();
		boardVO.setUser_id(user_id);
		boardVO.setTerm_year(term_year);
		boardVO.setTerm_week(term_week);
		boardVO.setProject_code(select_project);
		boardVO.setEtc(etc);
		boardVO.setLast_week(last_week);
		boardVO.setNext_week(next_week);
		
		//업무보고 수정
		try {
			boardService.updateWeeklyReport(boardVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "수정중 에러가 발생했습니다.");
			return "home/report/update_list";
		}
		
		//작성한 업무의 프로젝트명
		List<BoardVO> reportProject = null;
		try {
			reportProject = boardService.searchReportProject(boardVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "조회중 에러가 발생했습니다.");
			return "home/report/update_list";
		}
		
		//작성한 업무보고 불러오기
		List<BoardVO> loadReport = null;
		try {
			loadReport = boardService.loadReport(boardVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "조회중 에러가 발생했습니다.");
			return "home/report/update_list";
		}
		
		request.setAttribute("term_year", term_year);
		request.setAttribute("term_week", term_week);
		request.setAttribute("loadReport", loadReport);
		request.setAttribute("projectList", reportProject);
		request.setAttribute("select_project", select_project);
		request.setAttribute("msg", "수정이 완료되었습니다.");
		
		return "home/report/update_form";
	}
	
	//주간업무 삭제(주별)
	@RequestMapping(value = "/deleteWeekly.do")
	public String deleteWeekly(HttpServletRequest request, HttpSession session, 
			@RequestParam("term_year") String term_year, 
			@RequestParam("term_week") String term_week,
			@RequestParam("user_id") String user_id) throws Exception {
		
		BoardVO boardVO = new BoardVO();
		boardVO.setTerm_year(term_year);
		boardVO.setTerm_week(term_week);
		boardVO.setUser_id(user_id);
		
		try {
			boardService.deleteReportGroup(boardVO);
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", "삭제중 에러가 발생했습니다.");
			return "forward:/update.do";
		}
		
		String msg = term_year + "년" + term_week + "주차 업무보고가 삭제되었습니다.";
		request.setAttribute("msg", msg);
		
		return "forward:/update.do";
	}
}
