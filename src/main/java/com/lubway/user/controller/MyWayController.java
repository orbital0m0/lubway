package com.lubway.user.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lubway.user.UserCouponVO;
import com.lubway.user.UserVO;
import com.lubway.user.service.UserCouponService;
import com.lubway.user.service.UserService;

@Controller
public class MyWayController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private UserCouponService couponService;
	
	@Inject
	BCryptPasswordEncoder passEncoder;
	
	//마이웨이 페이지로 이동
	@RequestMapping("/myway.do")
	public String myWay(HttpSession session, Model model) {
		// 사용자별 정보 가져오기
		System.out.println("마이웨이 페이지로 이동");
		UserVO vo = (UserVO) session.getAttribute("user");
		UserVO getinfo = userService.getUserInfo(vo);
		session.setAttribute("userInfo", getinfo);
		
		// 남은 쿠폰 개수 보여주기
		int countUseCoupon = couponService.countUseCoupon();
		
		model.addAttribute("countCoupon", countUseCoupon);
		
		return "myway/myway";
	}
	
	//비밀번호 입력 페이지로 이동
	@RequestMapping("/checkpwd.do")
	public String checkPwd() {
		System.out.println("비밀번호 확인 페이지로 이동");
		return "myway/checkpwd";
	}
	
	//비밀번호 확인
	@RequestMapping("/checkpwdproc.do")
	public String checkPwdProc(@RequestParam("pw") String pw,HttpSession session,HttpServletResponse response) throws IOException {
		System.out.println("비밀번호 확인");
		
		UserVO vo = (UserVO) session.getAttribute("user");
		boolean check = passEncoder.matches(pw, vo.getPassword());
		
		if(pw==null || !check) {
			System.out.println("비밀번호 틀림 : " + check);
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('비밀번호를 확인해주세요.'); history.go(-1); </script>");
			out.flush();
			out.close();
			return null;
		}
		System.out.println("비밀번호 일치 : " + check);
		return "myway/updateinfo";			
	}
	
	//정보변경 페이지로 이동
	@RequestMapping("/updateinfo.do")
	public String updateInfo() {
		System.out.println("정보 변경 입력 페이지로 이동");
		return "myway/updateinfo";
	}
	
	//정보변경
	@RequestMapping("/resultmod.do")
	public String resultMod(@RequestParam("pw") String pw, @RequestParam("sms_recep") boolean sms, @RequestParam("email_recep") boolean email, HttpSession session) {
		UserVO user = (UserVO) session.getAttribute("user");
		System.out.println(user.toString());
		
		if(pw != "") {
			String securityPwd = passEncoder.encode(pw);
			user.setPassword(securityPwd);
		}
		
		user.setSms_usable(sms);
		user.setEmail_usable(email);
		
		userService.updateUser(user);
		System.out.println(user.toString());
		System.out.println("정보 변경 완료");
		return "myway/updateinfo";
	}
	
	//내 포인트 페이지로 이동
	@RequestMapping("/point.do")
	public String point() {
		return "myway/point";
	}
	
	//회원탈퇴
	@RequestMapping("/withdrawal.do")
	public String withdrwal(HttpSession session) {
		System.out.println("컨트롤러 - withdrawal 실행");
		UserVO vo = (UserVO) session.getAttribute("user");
		userService.deleteUser(vo);
		session.invalidate();
		return "main";
	}
	
	//내 쿠폰 페이지로 이동
	@RequestMapping("/coupon.do")
	public String getCouponList(Model model, UserCouponVO vo, HttpSession session) {
		System.out.println("유저 쿠폰 목록 요청 처리");
		UserVO userVo = (UserVO) session.getAttribute("userInfo");
		vo.setId(userVo.getId());
		System.out.println(vo.toString());
		List<UserCouponVO> couponList = couponService.getUserCouponList(vo);
		
		model.addAttribute("couponList", couponList);
		
		return "myway/coupon";
	}
}
