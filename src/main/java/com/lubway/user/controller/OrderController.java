package com.lubway.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lubway.user.menu.BreadVO;
import com.lubway.user.menu.service.UserOptionService;

@Controller
public class OrderController {
	
	@Autowired
	private UserOptionService service;

	@GetMapping("orderStep03.do")
	public String orderStep03(Model model) {
		
		System.out.println("orderSelect - 페이지 이동");
		
		model.addAttribute("breadList", service.getBreadList());
		model.addAttribute("cheeseList", service.getCheeseList());
		model.addAttribute("meatList", service.getMeatAddList());
		model.addAttribute("sauceList", service.getSauceList());
		model.addAttribute("toppingList", service.getToppingAddList());
		model.addAttribute("vegeList", service.getVegetableList());
		
		List<BreadVO> list = service.getBreadList();
		
		System.out.println(list.get(0).toString());
		
		return "order/orderDetail";
	}
	
	@RequestMapping("order03.do")
	public String order03() {
		return "order/orderDetail";
	}
	
	
}
