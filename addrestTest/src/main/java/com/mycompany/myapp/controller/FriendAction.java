package com.mycompany.myapp.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.myapp.model.MemberBean;
import com.mycompany.myapp.service.Memberservice;




@Controller
public class FriendAction {

	@Autowired
	private Memberservice memberService;
	
	//search friend
		
	@RequestMapping(value = "/friendSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public MemberBean member_friendSearch(@RequestParam("mememail") String email, Model model) throws Exception {
		MemberBean m = null;
		int result = memberService.checkMemberEmail(email);
		if(result == -1) {
			m = memberService.userCheck(email);
			model.addAttribute("m", m);
		}
		
//		model.addAttribute("result", result);

		return m;
	}
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/search_friend.lm")
	public int member_emailcheck(@RequestParam("mememail") String email, Model model) throws Exception {
		
		System.out.println("search friend");
		int result = memberService.checkMemberEmail(email);

		return result;
	}
	
	
	
	//add friend
	@RequestMapping(value = "/add_friend.lm")
	public String add_friend(HttpSession session, Model model) throws Exception {
		
		System.out.println("add friend");
		
		return "member/add_friend";
	}
	
}
