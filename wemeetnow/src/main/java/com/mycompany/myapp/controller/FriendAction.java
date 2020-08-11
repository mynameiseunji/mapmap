package com.mycompany.myapp.controller;

import java.util.HashMap;
import java.util.List;
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

	// search friend

	@RequestMapping(value = "/friend_search.do", method = RequestMethod.POST)
	@ResponseBody
	public MemberBean member_friendSearch(@RequestParam("email") String email, Model model) throws Exception {
		System.out.println();
		MemberBean m = memberService.userCheck(email);
		if (m == null)
			return m;
		System.out.println("m:" + m);
		System.out.println("email:" + m.getEmail());
		System.out.println("nickname:" + m.getNickname());
		;

		return m;
	}

	// add friend
	@RequestMapping(value = "/friend_add.do", method = RequestMethod.POST)
	@ResponseBody
	public int add_friend(@RequestParam("email") String email, HttpSession session, Model model) throws Exception {
		String myEmail = (String) session.getAttribute("email");

		Map<String, String> m = new HashMap<String, String>();
		m.put("email1", myEmail);
		m.put("email2", email);

		int resultc = friendService.checkFriend(m);

		if (resultc == -1) {

			return resultc;

		} else {

			int result = friendService.addFriend(m);

			System.out.println("result: " + result);
			System.out.println("add friend");

			return result;
		}
	}

	// 친구 삭제 --------------------------------------------------
	// delete friend
	@RequestMapping(value = "/friend_del.do")
	public String delete_friend(HttpServletRequest request, HttpSession session) throws Exception {

		String email = (String) session.getAttribute("email");
		int fno = Integer.parseInt(request.getParameter("fno"));

		FriendBean bean = new FriendBean();
		bean.setFno(fno);
		bean.setEmail1(email);

		int result = friendService.delFriend(bean);

		System.out.println("result: " + result);

		System.out.println("del friend");

		return "redirect:friendlist.do";
	}

	// 친구 리스트 --------------------------------------------------
	@RequestMapping(value = "/friendlist.do")
	public String friendList(HttpSession session, Model model) {
		String email = (String) session.getAttribute("email");
//			String email = "1@1.qq";
		List<FriendBean> list = friendService.list(email);
		System.out.println(list);
		model.addAttribute("list", list);
		return "member/friend";
	}
}
