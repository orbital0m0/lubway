package com.lubway.user.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lubway.admin.board.EventVO;
import com.lubway.admin.board.Pagination;
import com.lubway.store.StoreInfoVO;
import com.lubway.store.service.StoreService;
import com.lubway.user.UserCouponVO;
import com.lubway.user.UserVO;
import com.lubway.user.menu.ToppingAddVO;
import com.lubway.user.order.OrderCodeVO;
import com.lubway.user.order.OrderListVO;
import com.lubway.user.order.service.BasketService;
import com.lubway.user.order.service.OrderService;
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
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private BasketService basketService;
	
	@Autowired
	private StoreService storeService;
	
	//마이웨이 페이지로 이동
	@RequestMapping("/myway.do")
	public String myWay(HttpSession session, Model model, UserCouponVO cvo, OrderCodeVO ovo) {
		// 쿠폰 조회할 사용자 아이디 세팅
		System.out.println("마이웨이 페이지로 이동");
		UserVO userVo = (UserVO) session.getAttribute("user");
		cvo.setId(userVo.getId());
		ovo.setId(userVo.getId());
		
		// 남은 쿠폰 개수 보여주기
		int countUseCoupon = couponService.countUseCoupon(cvo);
		// 주문내역 리스트 개수 보여주기
		int countOrder = orderService.countOrderList(ovo);

		model.addAttribute("countCoupon", countUseCoupon);
		model.addAttribute("countOrder", countOrder);
		
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
		UserVO userVo = (UserVO) session.getAttribute("user");
		vo.setId(userVo.getId());
		
		List<UserCouponVO> couponList = couponService.getUserCouponList(vo);
		
		model.addAttribute("couponList", couponList);
		
		return "myway/coupon";
	}
	
	//주문내역 페이지로 이동
	@RequestMapping("/orderList.do")
	public String orderList(OrderCodeVO vo, Model model, HttpSession session, StoreInfoVO svo,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range) {
		System.out.println("사용자 주문내역 조회 페이지 이동");
		UserVO userVo = (UserVO) session.getAttribute("user");
		vo.setId(userVo.getId());
		
		List<OrderCodeVO> orderInfo = orderService.orderCodeList(vo);
		int countOrder = orderService.countOrderList(vo);
		
		/** 전체 게시글 개수 */
		int listCnt = orderService.getOrderPageListCnt();
		
		// 최종 결제 금액 연산
		for(int i =0; i <orderInfo.size(); i++) {
			int price = orderInfo.get(i).getTotal_price();
			int point = orderInfo.get(i).getUse_point();
			int coupon = orderInfo.get(i).getUse_coupon();
			
			int total = 0;
			
			total = price - point - coupon;
			
			if(orderInfo.get(i).getOrder_type().equals("배달")) {
				total += 3900;
				orderInfo.get(i).setFinalPrice(total);
			}else {
				orderInfo.get(i).setFinalPrice(total);
			}
		}
		
		/** Pagination */
		Pagination pagination = new Pagination();
		pagination.PageInfoEvent(page, range, listCnt);
		System.out.println(pagination.getListSize());
		
		List<OrderCodeVO> pageList = orderService.getOrderPageList(pagination);

		model.addAttribute("pagination", pagination);
		model.addAttribute("orderList", pageList);
		model.addAttribute("countOrder", countOrder);
		model.addAttribute("order", orderInfo);
		
		return "myway/orderList";
	}
	
	// Fast-Way / Home-Way 각각 보기
	@PostMapping("/orderListTab.do")
	public String selectOrderList(Model model, String select, OrderCodeVO vo, HttpSession session, String finalPrice) {
		UserVO userVo = (UserVO) session.getAttribute("user");
		vo.setId(userVo.getId());
		
		List<OrderCodeVO> orderInfo = orderService.orderCodeList(vo);
		List<OrderCodeVO> homeway = orderService.selectHomeway(vo);
		List<OrderCodeVO> fastway = orderService.selectFastway(vo);
		int countOrder = orderService.countOrderList(vo);
		
		model.addAttribute("countOrder", countOrder);
		model.addAttribute("select", select);
		System.out.println(select);
		
		if(select.equals("")) {
			model.addAttribute("order", orderInfo);
		}else if(select.equals("homeway")) {
			model.addAttribute("order", homeway);
		}else if(select.equals("fastway")) {
			model.addAttribute("order", fastway);
		}
		
		return "myway/orderList";
	}
	
	//주문내역 상세 페이지 이동
	@RequestMapping("/orderListDetail.do")
	public String orderListDetail(Model model, OrderCodeVO cvo, OrderListVO vo, HttpSession session) {
		System.out.println("주문내역 상세페이지 이동");
		UserVO userVo = (UserVO) session.getAttribute("user");
		cvo.setId(userVo.getId());
		
		List<OrderListVO> orderList = orderService.orderList(vo);
		List<ToppingAddVO> total = new ArrayList<ToppingAddVO>();
		
		
		for(OrderListVO list : orderList) {
			if(list.getAdd_topping() != null) {
				if(list.getAdd_topping().split(",").length > 1) {
					String[] toppingList = list.getAdd_topping().split(",");
					for(String topping : toppingList) {
						ToppingAddVO addMany = orderService.getToppingByName(topping.trim());
						total.add(addMany);
					}
					list.setCount(toppingList.length);
				}else {
					ToppingAddVO addOne = orderService.getToppingByName(list.getAdd_topping());
					list.setCount(1);
					total.add(addOne);
				}
			}
		}
		
		//주문했던 매장 주소 설정
		OrderCodeVO orderCode = orderService.getOrderListDetail(cvo);
		System.out.println(orderCode.toString());
		StoreInfoVO storeInfo = storeService.getstoreinfo(orderCode.getStore_name());
		String storeAddr = storeInfo.getAddress_road();
		
		int price = orderCode.getTotal_price();
		int point = orderCode.getUse_point();
		int coupon = orderCode.getUse_coupon();
		int finalPrice = price - point - coupon;
		if(orderCode.getOrder_type().equals("배달")) {
			finalPrice += 3900;
			orderCode.setFinalPrice(finalPrice);
		}else {
			orderCode.setFinalPrice(finalPrice);
		}
		
		model.addAttribute("storeAddr", storeAddr);
		model.addAttribute("price", total);
		model.addAttribute("orderC", orderCode);
		model.addAttribute("orderL", orderList);
		
		return "myway/orderListDetail";
	}
	
}
