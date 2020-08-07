package com.mycompany.myapp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.myapp.model.FriendBean;
import com.mycompany.myapp.model.MemberBean;
import com.mycompany.myapp.service.FriendServiceImpl;
import com.mycompany.myapp.service.MemberServiceImpl;

@Controller
public class FriendAction {

	@Autowired
	private MemberServiceImpl memberService;
	@Autowired	
	private FriendServiceImpl friendService;
	
	//search friend
		
	@RequestMapping(value = "/friend_search.do", method = RequestMethod.POST)
	@ResponseBody
	public MemberBean member_friendSearch(@RequestParam("email") String email, Model model) throws Exception {
		System.out.println("도착");
		MemberBean m = memberService.userCheck(email);
		System.out.println("m:"+m);
		System.out.println("email:"+m.getEmail());
		System.out.println("nickname:"+m.getNickname());;

		return m;
	}
			
	//add friend
	@RequestMapping(value = "/friend_add.do")
	public String add_friend(FriendBean friend, Model model) throws Exception {

		Map<String, String> m = new HashMap<String, String>();
		m.put("email1", friend.getEmail1());
		m.put("email2", friend.getEmail2());
		
		int result = friendService.addFriend(m);
		System.out.println("result: " + result);
		
		return "member/main";
	}
	
	//친구 삭제 --------------------------------------------------
		//delete friend
		@RequestMapping(value = "/friend_del.do")
		public String delete_friend(FriendBean friend, HttpServletRequest request, String email,
									HttpSession session, Model model) throws Exception {
			System.out.println();
			System.out.println("email: " +email);
			
			String email1 = (String) session.getAttribute("email");
			//---------------------------------------------
			MemberBean mem = memberService.userCheck(email1);
			String nickname = mem.getNickname();
			model.addAttribute("nickname", nickname);
			//---------------------------------------------
				
			System.out.println("email1: " +email1);
				
			Map m = new HashMap();
			m.put("email1", email1);
			m.put("email2", email);
			
			int result = friendService.delFriend(m);
			System.out.println("result: " + result);
			
//			String email2 = friend.getEmail2();
//			model.addAttribute("email2", email2);
//			
//			friendService.addFriend(friend);
			
			System.out.println("del friend");
				
			return "member/main";
		}
		//친구 삭제 --------------------------------------------------
}
