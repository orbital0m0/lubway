package com.lubway.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.lubway.user.service.UserMenuService;

@Controller
public class UserMenuController {

	@Autowired
	private UserMenuService userMenuService;
	
	/**	메뉴 페이지(샌드위치) */
	@GetMapping("/menuSandwich.do")
	public String menuSandwich(Model model) {	
		model.addAttribute("select", "menuSandwich.do");
		model.addAttribute("list", userMenuService.getSandwichList());
		model.addAttribute("calList", userMenuService.getSandwichCalList());
		return "menu/menuSandwich";
	}
	
	/**	메뉴 페이지(랩) */
	@GetMapping("/menuWrap.do")
	public String menuWrap(Model model) {
		model.addAttribute("select", "menuWrap.do");
		model.addAttribute("list", userMenuService.getWrapList());
		model.addAttribute("calList", userMenuService.getWrapCalList());
		return "menu/menuWrap";
	}
	
	/**	메뉴 페이지(찹샐러드) */
	@GetMapping("/menuSalad.do")
	public String menuSalad(Model model) {
		model.addAttribute("select", "menuSalad.do");
		model.addAttribute("list", userMenuService.getSaladList());
		model.addAttribute("calList", userMenuService.getSaladCalList());
		return "menu/menuSalad";
	}
	
	/**	메뉴 페이지(아침메뉴) */
	@GetMapping("/menuMorning.do")
	public String menuMorning(Model model) {
		model.addAttribute("select", "menuMorning.do");
		model.addAttribute("list", userMenuService.getMorningList());
		model.addAttribute("calList", userMenuService.getMorningCalList());
		return "menu/menuMorning";
	}
	
	/**	메뉴 페이지(스마일 웨이) */
	@GetMapping("/menuSmileWay.do")
	public String menuSmileWay(Model model) {
		model.addAttribute("select", "menuSmileWay.do");
		model.addAttribute("list", userMenuService.getSmileWayCookieList());
		model.addAttribute("calList", userMenuService.getSmileWayCookieCalList());
		model.addAttribute("list2", userMenuService.getSmileWayWASList());
		model.addAttribute("calList2", userMenuService.getSmileWayWASCalList());
		return "menu/menuSmileWay";
	}
	
	/**	메뉴 상세 페이지 */
	@PostMapping("menuDetail.do")
	public String menuDetail(Model model, String select, String code) {
		System.out.println(code);
		System.out.println(select);
		model.addAttribute("select", select);
		return "menu/menuDetail";
	}
	

}
