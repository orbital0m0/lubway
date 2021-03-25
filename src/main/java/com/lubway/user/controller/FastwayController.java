package com.lubway.user.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lubway.store.StoreInfoVO;
import com.lubway.user.service.FastwayService;

/** 패스트웨이 주문 컨트롤러 */
@Controller
@RequestMapping("/fastway/")
public class FastwayController {
	
	@Autowired
	FastwayService fastwayService;
	
	/** 패스트웨이 step01 - 매장 찾기 및 선택 페이지 이동 */
	@GetMapping("step01.do")
	public String fastwayView(HttpSession session) {
//		if(session.getAttribute("user")==null) return "login";
		return "fastway";
	}
	
	/** 패스트웨이가 가능한 매장 리스트 추출하여 배열로 리턴 */
	@PostMapping("searchStore.do")
	@ResponseBody
	public StoreInfoVO[] fastwayStore(String keyword) {
		
		List<StoreInfoVO> info = fastwayService.fastwayStore(keyword);
		
		StoreInfoVO[] arr = new StoreInfoVO[info.size()];
		for(int i=0; i<arr.length; i++) {
			arr[i] = info.get(i);
			System.out.println(arr[i].toString());
		}
		
		return arr;
	}
	
	/** 주문하기 시작 */
	@PostMapping("orderStart.do")
	public String order(String franchiseNo,String whatWay, Model model) {
		System.out.println("FastwayController - franchiseNo : " + franchiseNo);
		System.out.println("FastwayController - whatWay : " + whatWay);
		model.addAttribute("franchiseNo", franchiseNo);
		model.addAttribute("whatWay", whatWay);
		//이렇게 가면  orderStep02에서 파라미터로 받습니다...
		return "redirect:/orderStep02.do";
	}
	
	
}
