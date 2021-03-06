package com.lubway.user.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.lubway.admin.board.BannerVO;
import com.lubway.admin.board.TermsVO;
import com.lubway.admin.board.service.BannerService;
import com.lubway.admin.board.service.TermsService;
import com.lubway.user.UserPagination;
import com.lubway.user.UserVO;
import com.lubway.user.board.UserNoticeVO;
import com.lubway.user.board.service.UserNoticeService;
import com.lubway.user.service.UserMenuService;
import com.lubway.user.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private UserNoticeService noticeService;
	
	@Autowired
	private UserMenuService userMenuService;
	
	@Autowired
	private BannerService bannerService;

	@Autowired
	private JavaMailSender mailSender;

	@Inject
	private BCryptPasswordEncoder passEncoder;
	
	@Autowired
	TermsService termsService;

	/** Naver Login */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	/**
	 * 로그인 화면 요청 / 소셜 로그인(네이버) 처리
	 */
	@GetMapping("/login.do")
	public String main(HttpSession session, Model model) {

		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		model.addAttribute("url", naverAuthUrl);

		return "login";
	}

	/**
	 * 카카오 로그인
	 */
	@PostMapping("/kakao.do")
	@ResponseBody
	public String kakaoLogin(UserVO vo, String email, HttpSession session, HttpServletResponse response) throws IOException {

		System.out.println(vo.getId());
		System.out.println(vo.getName());
		System.out.println(email);

		UserVO user = userService.getUser(vo.getId());
		
		if(userService.idCheck(vo.getId()) == 0) {
			userService.insertUser(vo);
		} else {
			if(userService.getUser(vo.getId()).getStatus() > 0) return "lock";
		}
		session.setAttribute("user", user);
		session.setAttribute("kuser", new String("1"));
		return "success";
	}

	/**
	 * 카카오 로그아웃
	 */
	@GetMapping("kakaoLogout.do")
	public String kakao_logout(HttpSession session, Model model, BannerVO vo) {
		
		model.addAttribute("banner", bannerService.getBannerListView(vo));
		
		session.invalidate();
		return "main";
	}

	/**
	 * 구글 로그인
	 */
	@PostMapping("/google.do")
	public String googleLogin(UserVO vo, HttpSession session, HttpServletResponse response, Model model,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range, BannerVO bvo) throws IOException {
		System.out.println(vo.toString());

		if(userService.idCheck(vo.getId()) == 0) {
			if(vo.getId() == null) return "login";
			userService.insertUser(vo);
		} else {
			if(userService.getUser(vo.getId()).getTel() != null || userService.getUser(vo.getId()).getPassword() != null) {
				alertView("이미 가입된 계정이 있습니다.", -1, response);
				return null;
			} else if(userService.getUser(vo.getId()).getStatus() > 0) {
				alertView("관리자에 의해 정지된 계정입니다.", -1, response);
				return null;
			}
		}
		
		UserVO user = userService.getUser(vo.getId());
		
		System.out.println("vo : " + vo);
		System.out.println("user : " + user);
		
		int listCnt = noticeService.getUserPageListCnt();
		UserPagination pagination = new UserPagination();
		pagination.pageInfoMain(page, range, listCnt);
		List<UserNoticeVO> pageList = noticeService.getUserPageList(pagination);
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("UserPageList", pageList);
		
		model.addAttribute("select", "menuSandwich.do");
		model.addAttribute("list1", userMenuService.getSandwichList());
		
		model.addAttribute("select1", "menuMorning.do");
		model.addAttribute("list2", userMenuService.getMorningList());
		model.addAttribute("banner", bannerService.getBannerListView(bvo));
		
		session.setAttribute("user", user);
		session.setAttribute("guser", new String("1"));
		return "main";
	}

	/**
	 * 네이버 로그인 처리
	 */
	@GetMapping("/callback.do")
	public String callback(@RequestParam String code, @RequestParam String state, HttpSession session, HttpServletResponse servletResponse, 
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,BannerVO vo, Model model ) throws IOException {

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);

		//로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		System.out.println(apiResult.toString());

		// 내가 원하는 정보 (이름)만 JSON타입에서 String타입으로 바꿔 가져오기 위한 작업 
		JSONParser parser = new JSONParser(); 
		Object obj = null; 

		try { 
			obj = parser.parse(apiResult);
		} catch (ParseException e) {
			e.printStackTrace(); 
		}

		JSONObject jsonobj = (JSONObject) obj; 
		JSONObject response = (JSONObject) jsonobj.get("response");

		String nname = (String) response.get("name");
		String nemail = (String) response.get("email");
		String nmobile = (String) response.get("mobile");

		if(userService.idCheck(nemail) == 0) {
			String mobile = "";

			String[] mobileArray = nmobile.split("-");
			for(String a : mobileArray) mobile += a;

			if(userService.telCheck(mobile) != 0) {
				alertView("이미 가입된 휴대폰 번호입니다.", -1, servletResponse);
				return null;
			}

			UserVO user = new UserVO();
			user.setId(nemail);
			user.setName(nname);
			user.setTel(mobile);

			userService.insertUser(user);

			session.setAttribute("user", user);
			session.setAttribute("nuser", new String("1"));
		} else {
			UserVO user = userService.getUser(nemail);

			if(user.getStatus() > 0) {
				alertView("관리자에 의해 정지된 계정입니다.", -1, servletResponse);
				return null;
			} else if(user.getPassword() != null) {
				alertView("이미 가입된 계정이 있습니다.", -1, servletResponse);
				return null;
			}

			session.setAttribute("user", user);
			session.setAttribute("nuser", new String("1"));
		}
		
		int listCnt = noticeService.getUserPageListCnt();
		UserPagination pagination = new UserPagination();
		pagination.pageInfoMain(page, range, listCnt);
		List<UserNoticeVO> pageList = noticeService.getUserPageList(pagination);
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("UserPageList", pageList);
		
		model.addAttribute("select", "menuSandwich.do");
		model.addAttribute("list1", userMenuService.getSandwichList());
		
		model.addAttribute("select1", "menuMorning.do");
		model.addAttribute("list2", userMenuService.getMorningList());
		
		model.addAttribute("banner", bannerService.getBannerListView(vo));

		return "main";
	}

	/**
	 * 로그인 처리 후 메인 페이지 이동
	 */
	@PostMapping("/main.do")
	public String main(@RequestParam("id") String id, 
			@RequestParam("password") String password, 
			HttpServletResponse response, BannerVO vo,
			HttpServletRequest request, Model model,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,String select, String code) throws IOException {
		System.out.println("메인 화면으로 이동");
		
		int listCnt = noticeService.getUserPageListCnt();
		UserPagination pagination = new UserPagination();
		pagination.pageInfoMain(page, range, listCnt);
		List<UserNoticeVO> pageList = noticeService.getUserPageList(pagination);
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("UserPageList", pageList);
		
		model.addAttribute("select", "menuSandwich.do");
		model.addAttribute("list1", userMenuService.getSandwichList());
		
		model.addAttribute("select1", "menuMorning.do");
		model.addAttribute("list2", userMenuService.getMorningList());
		
		model.addAttribute("banner", bannerService.getBannerListView(vo));
		
		int i = userService.idCheck(id);
		
		UserVO getUser = null;
		boolean check = false;

		if(i > 0) {
			getUser = userService.getUser(id);
			System.out.println(getUser.toString());

			check = passEncoder.matches(password, getUser.getPassword());
		}

		if(getUser == null || !check) {
			alertView("아이디 또는 비밀번호가 틀렸습니다.", -1, response);
			return null;
		} else if(getUser.getStatus() > 0) {
			alertView("관리자에 의해 정지된 계정입니다.", -1, response);
			return null;
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("user", getUser);
			System.out.println("ID, Password 일치");
			System.out.println("로그인 성공");
			
			return "main";
		}
	}

	/**
	 * 로그아웃 처리
	 */
	@GetMapping("/logout.do")
	public String logout(HttpSession session,@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range, Model model,
			String select, String code, BannerVO vo) {
		int listCnt = noticeService.getUserPageListCnt();
		UserPagination pagination = new UserPagination();
		pagination.pageInfoMain(page, range, listCnt);
		List<UserNoticeVO> pageList = noticeService.getUserPageList(pagination);
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("UserPageList", pageList);
		
		model.addAttribute("select", "menuSandwich.do");
		model.addAttribute("list1", userMenuService.getSandwichList());
		
		model.addAttribute("select1", "menuMorning.do");
		model.addAttribute("list2", userMenuService.getMorningList());
		model.addAttribute("banner", bannerService.getBannerListView(vo));
		session.invalidate();
		System.out.println("로그아웃 처리");
		return "main";
	}

	/**
	 * 메인 페이지 이동
	 */
	
	@GetMapping("/main.do")
	public String mainView(HttpSession seesion,Model model, BannerVO vo,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,
			String select, String code) {
		if(seesion.getAttribute("findPwd") != null) seesion.removeAttribute("findPwd");
		
		int listCnt = noticeService.getUserPageListCnt();
		UserPagination pagination = new UserPagination();
		pagination.pageInfoMain(page, range, listCnt);
		List<UserNoticeVO> pageList = noticeService.getUserPageList(pagination);
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("UserPageList", pageList);
		
		model.addAttribute("select", "menuSandwich.do");
		model.addAttribute("list1", userMenuService.getSandwichList());
		
		model.addAttribute("select1", "menuMorning.do");
		model.addAttribute("list2", userMenuService.getMorningList());
		
		model.addAttribute("banner", bannerService.getBannerListView(vo));
		
		return "main";
	}

	/**
	 * 로그인 화면 이동
	 */
	@RequestMapping("/login.do")
	public String login(HttpSession seesion) {
		System.out.println("로그인 화면으로 이동");
		if(seesion.getAttribute("findPwd") != null) seesion.removeAttribute("findPwd");
		return "login";
	}

	/**
	 * 회원가입 페이지 이동
	 */
	@RequestMapping("/step01.do")
	public String termsStep(HttpSession session,Model model) {
		if(session.getAttribute("findId") != null) session.removeAttribute("findId");
		
		List<TermsVO> list = termsService.getAllTerms();
		model.addAttribute("homepage", list.get(0));
		model.addAttribute("privacy", list.get(1));
		model.addAttribute("service", list.get(2));

		return "join/step01";
	}

	/**
	 * 회원가입 페이지 2 - 휴대폰 인증
	 */
	@PostMapping("/step02.do")
	public String phoneStep(@RequestParam("sms") boolean sms, @RequestParam("email") boolean email, HttpSession session) {
		System.out.println("휴대폰 인증 화면으로 이동");	
		session.setAttribute("sms", sms);
		session.setAttribute("email", email);
		return "join/step02";
	}

	/**
	 * 필요했나?
	 */
	@GetMapping("/step02.do")
	public String moveStep() {
		System.out.println("쓰이고 있니 ?");
		return "join/step02";
	}

	/**
	 * 회원가입 페이지 3 - 정보 입력
	 */
	@PostMapping("/step03.do")
	public String joinStep(String tel, Model model, HttpSession session) {
		System.out.println("회원가입 정보입력 화면으로 이동");
		UserVO vo = new UserVO();
		vo.setSms_usable((Boolean) session.getAttribute("sms"));
		vo.setEmail_usable((Boolean) session.getAttribute("email"));
		vo.setTel(tel);
		model.addAttribute("vo", vo);
		return "join/step03";
	}

	/**
	 * 아이디 중복 검증
	 */
	@GetMapping("/idCheck.do")
	@ResponseBody
	public String idCheck(@RequestParam("userId") String id) {
		return String.valueOf(userService.idCheck(id));
	}

	/**
	 * 회원가입 완료 - 이메일 전송 / 비밀번호 암호화 / DB저장
	 */
	@PostMapping("/step04.do")
	public String endStep(UserVO vo, HttpSession session) {
		System.out.println(vo.toString());

		String securityPwd = passEncoder.encode(vo.getPassword());
		vo.setPassword(securityPwd);

		userService.insertUser(vo);
		System.out.println("회원가입 완료 화면으로 이동");
		session.removeAttribute("sms");
		session.removeAttribute("email");
		sendJoinMail(vo);

		return "join/step04";
	}

	/**
	 * 비밀번호 찾기 화면 이동 - 임의 비밀번호 값 사용자 이메일 전송 / 암호화 후 DB 업데이트
	 */
	@RequestMapping("/resultPwd.do")
	public String resultPwd(@RequestParam("tel") String tel, HttpSession seesion, Model model, HttpServletResponse response) throws IOException {
		System.out.println("비밀번호 찾기 화면으로 이동");

		String id = userService.getId(tel);		
		UserVO vo = userService.getUser(id);

		if(vo.getPassword() == null) {
			alertView("소셜 계정입니다. 해당 사이트에 문의해주세요.", -2, response);
			return null;			
		}

		String pwd = getTempPassword(8);
		vo.setPassword(pwd);
		sendPwdMail(vo);

		pwd = passEncoder.encode(pwd);
		vo.setPassword(pwd);

		userService.updatePwd(vo);
		model.addAttribute("getId",id);

		return "findpwd";
	}

	/**
	 * 비밀번호 찾기 기능
	 */
	@GetMapping("/findPwd.do")
	public String findPwd(HttpSession seesion) {
		seesion.setAttribute("findPwd", new String("1"));
		return "join/step02";
	}

	/**
	 * 아이디 찾기 화면 이동
	 */
	@PostMapping("/resultId.do")
	public String resultId(@RequestParam("tel") String tel, HttpSession seesion, HttpServletResponse response) throws IOException {
		System.out.println("아이디 찾기 화면으로 이동");

		String id = userService.getId(tel);
		UserVO user = userService.getUser(id);
		if(user.getPassword() == null) {
			alertView("소셜 계정입니다. 해당 사이트에 문의해주세요.", -2, response);
			return null;
		}
		seesion.setAttribute("findId", id);
		return "findid";
	}

	/**
	 * 아이디 찾기 기능
	 */
	@GetMapping("/findId.do")
	public String findId(HttpSession seesion) {
		seesion.setAttribute("findId", new String("1"));
		return "join/step02";
	}
	/**
	 * 이용약관
	 */
	@GetMapping("/agreement.do")
	public String agreement() {
		return "terms/termsone";
	}
	@GetMapping("/privacy.do")
	public String privacy() {
		return "terms/termstwo";
	}
	/**
	 * 개인정보처리방침
	 */

	/**
	 * 임시 비밀번호 생성 기능
	 */
	public String getTempPassword(int length) {
		int index = 0;
		char[] charArr = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
				'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a',
				'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
				'w', 'x', 'y', 'z' };

		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < length; i++) {
			index = (int) (charArr.length * Math.random());
			sb.append(charArr[index]);
		}
		return sb.toString();
	}

	/**
	 * 회원가입 메일 발송 기능
	 */
	public void sendJoinMail(UserVO vo) {
		String mailTo = vo.getId();
		MimeMessagePreparator preparator = new MimeMessagePreparator() {

			String content = "<p><b><span style=\"font-size: 24pt;  color: #009223;\">환영합니다!</span></b></p><p><b><span style=\"font-size: 24pt;  color: #009223;\">"+ vo.getName() + "님</span></b></p><p><br></p><p>안녕하세요!</p><p>러브웨이 멤버십에 가입해 주셔서 감사합니다.</p>";	

			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				mimeMessage.setFrom(new InternetAddress("lu6way@gmail.com","LUBWAY", "UTF-8")); // 보내는 사람
				mimeMessage.setSubject("LUBWAY에 가입하신것을 환영합니다.", "UTF-8");
				mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(mailTo));
				mimeMessage.setContent(content, "text/html;charset=UTF-8");
				mimeMessage.setReplyTo(InternetAddress.parse(mailTo));
			}
		};
		try {
			mailSender.send(preparator);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 비밀번호 찾기 메일 발송 기능
	 */
	public void sendPwdMail(UserVO vo) {
		String mailTo = vo.getId();
		MimeMessagePreparator preparator = new MimeMessagePreparator() {

			String content = "<p><span style=\"font-size: 10pt; font-family: dotum, sans-serif;\">"
					+ "임시 설정된 비밀번호 입니다.</span></p><p><span style=\"font-size: 10pt; font-family: dotum, sans-serif;\">"
					+ "로그인 후 비밀번호를 재설정 해주시길 바랍니다.</span></p><p><span style=\"font-family: dotum, sans-serif;\"><br>"
					+ "</span></p><p><span style=\"font-family: dotum, sans-serif; font-size: 10pt;\">"
					+ "변경된 비밀번호 : </span><b style=\"font-family: dotum, sans-serif;\"><span style=\"color: rgb(0, 158, 37); "
					+ "font-size: 12pt;\">" + vo.getPassword() + "</span></b></p><p><br></p>";	

			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				mimeMessage.setFrom(new InternetAddress("lu6way@gmail.com","LUBWAY", "UTF-8")); // 보내는 사람
				mimeMessage.setSubject("LUBWAY " + vo.getName() + "님 계정의 임시 비밀번호입니다.", "UTF-8");
				mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(mailTo));
				mimeMessage.setContent(content, "text/html;charset=UTF-8");
				mimeMessage.setReplyTo(InternetAddress.parse(mailTo));
			}
		};
		try {
			mailSender.send(preparator);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * alert 경고창
	 */
	public void alertView(String message, int returnPage, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('" + message + "'); history.go(" + returnPage + "); </script>");
		out.flush();
		out.close();	
	}

}
