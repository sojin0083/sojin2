package egovframework.openlink.home.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.openlink.home.service.BoardService;
import egovframework.openlink.home.service.UserVO;

@Controller
public class LoginController {
	@Resource(name = "boardService")
	private BoardService boardService;
	
	//로그인페이지 이동
	@RequestMapping(value = "/loginPage.do")
	public String loginPage(ModelMap model) throws Exception {
		System.out.println("로그인페이지");
		return "home/loginPage";
	}
	
	//로그인 액션
	@RequestMapping(value = "/loginAction.do")
	public String loginAction(HttpServletRequest request,
			HttpServletResponse response, 
			@RequestParam("user_id") String user_id, 
			@RequestParam("user_pw") String user_pw) throws Exception {
		System.out.println("로그인액션");
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		//이번연도,주
		int this_year = cal.get(Calendar.YEAR);
		int this_week = cal.get(Calendar.WEEK_OF_YEAR);
		
		UserVO userVO = new UserVO();
		userVO.setUser_id(user_id);
		userVO.setUser_pw(user_pw);
		
		
		String user_name = "";
		
		try {
			user_name = boardService.selectLoginCheck(userVO);
			
			//자동로그인 체크
			if(request.getParameter("AUTO_LOGIN") != null) {
				Cookie infoId = new Cookie("user_id", user_id);
				infoId.setMaxAge(30*24*60*60);		// 쿠키의 유효기간을 30일로 설정한다.30*24*60*60
				infoId.setPath("/");				// 쿠키의 유효한 디렉토리를 "/" 로 설정한다.
				response.addCookie(infoId);			// 클라이언트 응답에 쿠키를 추가한다.
				System.out.println("쿠키저장");
			}else {
				//체크해제시 쿠키 삭제, 유효시간 0으로 삭제
				Cookie[] cookies = request.getCookies(); // 요청정보로부터 쿠키를 가져온다.
				//삭제
				for(int i = 0; i < cookies.length; i++) {
					cookies[i].setMaxAge(0); // 특정 쿠키를 더 이상 사용하지 못하게 하기 위해서는 쿠키의 유효시간을 만료시킨다.
					cookies[i].setPath("/");
					response.addCookie(cookies[i]); // 해당 쿠키를 응답에 추가(수정)한다.
				}
			}
		}catch(Exception e) {
			System.out.println("에러 : " + e);
			request.setAttribute("msg", e);
			return "home/main";
		}		
		
		if(user_name != null && !"".equals(user_name)) {
			request.getSession().setAttribute("user_id", user_id);
			request.getSession().setAttribute("user_name", user_name);
		}else {
			request.getSession().setAttribute("user_id", "");
			request.getSession().setAttribute("user_name", "");
			request.setAttribute("msg", "사용자정보가 올바르지 않습니다.");
		}
		System.out.println("user_name확인 : " + user_name);
		
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
	
	//로그아웃
	@RequestMapping(value = "/logout.do")
	public String view(ModelMap model,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.getSession().invalidate();
		//체크해제시 쿠키 삭제, 유효시간 0으로 삭제
		Cookie[] cookies = request.getCookies(); // 요청정보로부터 쿠키를 가져온다.
		//삭제
		for(int i = 0; i < cookies.length; i++) {
			cookies[i].setMaxAge(0); // 특정 쿠키를 더 이상 사용하지 못하게 하기 위해서는 쿠키의 유효시간을 만료시킨다.
			cookies[i].setPath("/");
			response.addCookie(cookies[i]); // 해당 쿠키를 응답에 추가(수정)한다.
		}
		return "home/main";
	}
}