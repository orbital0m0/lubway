package com.lubway.user.order.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lubway.admin.menu.CookieVO;
import com.lubway.admin.menu.DrinkVO;
import com.lubway.admin.menu.NutrientVO;
import com.lubway.admin.menu.SaladVO;
import com.lubway.admin.menu.SandwichVO;
import com.lubway.admin.menu.WedgeAndSoupVO;
import com.lubway.admin.menu.WrapVO;
import com.lubway.admin.menu.service.MenuService;
import com.lubway.admin.service.CouponService;
import com.lubway.user.UserCouponVO;
import com.lubway.user.UserVO;
import com.lubway.user.menu.service.UserOptionService;
import com.lubway.user.service.UserCouponService;
import com.lubway.user.service.UserMenuService;
import com.lubway.user.service.UserService;

@Controller
public class OrderController {
	
	@Autowired
	private UserOptionService service;
	
	@Autowired
	private UserMenuService userMenuService;
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private UserCouponService couponService;
	
	@Autowired
	private UserService userService;

	/** 메뉴 선택 페이지 */
	@PostMapping("/orderStep02.do")
	public String orderStep02(Model model, String franchiseNo ,String whatWay,String fullAddr) {
		System.out.println("orderStep02 - 페이지 이동");
		System.out.println("OrderController - franchiseNo : " + franchiseNo);
		System.out.println("OrderController - whatWay : " + whatWay);
		System.out.println("OrderController - fullAddr : " + fullAddr);
		
		model.addAttribute("whatWay",whatWay);
		model.addAttribute("franchiseNo",franchiseNo);
		model.addAttribute("fullAddr", fullAddr);
		
		return "order/orderStep02";
	}

	/** 메뉴 페이지에서 탭 눌렀을 때 카테고리 바꾸는 Ajax */
	@PostMapping("/changeCategory.do")
	@ResponseBody
	public List<Object> changeCategory(String select) {
		System.out.println("Ajax 통신 - changeCategory");
		System.out.println("select : " + select);

		List<Object> totalList = new ArrayList<Object>();
		List<String> nutrientList = new ArrayList<String>();

		switch (select) {

		case "sandwich" : System.out.println("switch - sandwich");
						  List<SandwichVO> sandwichList = userMenuService.getSandwichList();
						  nutrientList = userMenuService.getSandwichCalList();

						  totalList.add(sandwichList);
						  totalList.add(nutrientList);
						  
						  return totalList;

		case "wrap"     : System.out.println("switch - wrap");
						  List<WrapVO> wrapList = userMenuService.getWrapList();
						  nutrientList = userMenuService.getWrapCalList();
						  
						  totalList.add(wrapList);
						  totalList.add(nutrientList);
						  
						  return totalList;

		case "salad"    : System.out.println("switch - salad");
						  List<SaladVO> saladList = userMenuService.getSaladList();
						  nutrientList = userMenuService.getSaladCalList();
						  
						  totalList.add(saladList);
						  totalList.add(nutrientList);
						  
						  return totalList;

		case "side"     : System.out.println("switch - side");
						  List<CookieVO> cookieList = userMenuService.getSmileWayCookieList();
						  List<WedgeAndSoupVO> WASList = userMenuService.getSmileWayWASList();
						  List<DrinkVO> drinkList = userMenuService.getSmileWayDrinkList();
						  nutrientList = userMenuService.getSmileWayCookieCalList();
						  List<String> nutrientList2 = userMenuService.getSmileWayWASCalList();

						  totalList.add(cookieList);
						  totalList.add(WASList);
						  totalList.add(drinkList);
						  totalList.add(nutrientList);
						  totalList.add(nutrientList2);
						  
						  return totalList;
		}
		return totalList;
		
	}
	
	/** 메뉴 상세 페이지 
	 *  hideNum : 1 - 다 가리기 , 2 - 영양성분표만 보여주기, 3 - 영양성분표&세트만 보여주기 , 4 - 빵이랑 빵 길이만 가리기, 5 - 샌드위치 빵길이 30
	 * */
	@PostMapping("orderStep03.do")
	public String orderStep03(Model model,
			String franchiseNo,String whatWay,String code,String selected,
			CookieVO cvo, SandwichVO Svo, WrapVO wvo, WedgeAndSoupVO wasvo, 
			SaladVO svo, DrinkVO dvo, NutrientVO nvo) {
		
		System.out.println("orderStep03 - 페이지 이동");
		System.out.println("orderStep03 - franchiseNo : " + franchiseNo);
		System.out.println("orderStep03 - whatWay : " + whatWay);
		System.out.println("orderStep03 - code : " + code);
		System.out.println("orderStep03 - selected : " + selected);
		
		//영양성분표 설정
		model.addAttribute("nutrient", menuService.selectNutrient(nvo));
		
		switch (selected) {
		case "sandwich":	// 다 있어 - hideNum 해당 안됨
			model.addAttribute("menu", menuService.selectSandwich(Svo));
			model.addAttribute("hideNum", 5);
			break;
		case "wrap":	//영양성분표&세트만 있어 - 3
			model.addAttribute("menu", menuService.selectWrap(wvo));
			model.addAttribute("hideNum", 3);
			break;
		case "salad":	//빵이랑 빵 길이 빼고 다 있어 
			model.addAttribute("menu", menuService.selectSalad(svo));
			model.addAttribute("hideNum", 4);
			break;
		case "side":	//쿠키,웻지&스프,드링크 -> 다 가리고 성분표 있어 - 2
			if(code.length() > 6) {
				char cod = code.charAt(6);
				System.out.println(cod);
				if (cod == 'C') {
					model.addAttribute("menu", menuService.selectCookie(cvo));
				} else if (cod == 'W') {
					model.addAttribute("menu", menuService.selectWAS(wasvo));
				}
				model.addAttribute("hideNum", 2);
			}else {
				model.addAttribute("menu", menuService.selectDrink(dvo));
				model.addAttribute("hideNum", 1); // 다 가리기 - 1
			}
			break;
		}
		
		//모달 선택에 필요한 요소 설정
		model.addAttribute("breadList", service.getBreadList());
		model.addAttribute("cheeseList", service.getCheeseList());
		model.addAttribute("meatList", service.getMeatAddList());
		model.addAttribute("sauceList", service.getSauceList());
		model.addAttribute("toppingList", service.getToppingAddList());
		model.addAttribute("vegeList", service.getVegetableList());
		model.addAttribute("cookieList", service.getCookieList());
		model.addAttribute("wedgeList", service.getWedgeList());
		
		return "order/orderStep03";
	}
	
	
	/** 주문 확인, 결제하기  페이지 */
	@RequestMapping("/orderStep04.do")
	public String orderStep04(Model model, UserCouponVO vo, HttpSession session) {
		System.out.println("주문 및 결제하기 페이지로 이동");
		// 사용 가능한 쿠폰 리스트 띄우기
		UserVO userVO = (UserVO) session.getAttribute("user");
		UserVO getInfo = userService.getUserInfo(userVO);
		session.setAttribute("userInfo", getInfo);
		vo.setId(userVO.getId());
		
		int couponTotal = couponService.getCouponTotal();
		int useCouponTotal = couponService.getUseCouponTotal();
		List<UserCouponVO> couponList = couponService.getUserCouponList(vo);
		
		model.addAttribute("couponList", couponList);
		model.addAttribute("couponTotal", couponTotal);
		model.addAttribute("useCouponTotal", useCouponTotal);
		
		return "order/orderStep04";
	}

}
