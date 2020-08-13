package com.mycompany.myapp.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.ArrayList;
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
import com.mycompany.myapp.model.FriendConfirm;
import com.mycompany.myapp.model.MemberBean;
import com.mycompany.myapp.service.FriendService;
import com.mycompany.myapp.service.MemberServiceImpl;

@Controller
public class FriendAction {

	@Autowired
	private MemberServiceImpl memberService;
	@Autowired
	private FriendService friendService;

	// search friend

	@RequestMapping(value = "/friend_search.do", method = RequestMethod.POST)
	@ResponseBody
	public MemberBean member_friendSearch(@RequestParam("email") String email, Model model) throws Exception {
		
		MemberBean m = memberService.userCheck(email);
		if (m == null)
			return m;
		

		return m;
	}
	@RequestMapping(value = "/friend_accept.do", method = RequestMethod.POST)
	@ResponseBody
	public String member_friendAccept(HttpServletRequest request,FriendConfirm fc, Model model) throws Exception {
		fc.setInvitee((String)request.getSession().getAttribute("email"));
		int result =0;
		if(fc.getStatus()==1)
			result = friendService.accept(fc);
		else
			result = friendService.reject(fc);
		
		return "결과";
	}

	// add friend
	@RequestMapping(value = "/friend_add.do", method = RequestMethod.POST)
	@ResponseBody
	public int add_friend(@RequestParam("email") String email, HttpSession session, Model model) throws Exception {
		String myEmail = (String) session.getAttribute("email");
		System.out.println(myEmail);
		System.out.println(email);
		Map<String, String> m = new HashMap<String, String>();
		m.put("inviter", myEmail);
		m.put("invitee", email);

		int resultc = friendService.checkFriend(m);
		System.out.println(resultc);
		if (resultc == -1) {

			return resultc;

		} else {
			int result =friendService.checkFriendConfirm(m);
			if(result==-2)
				return result;
			result = friendService.addFriend(m);
			return result;
		}
	}

	// 친구 삭제 --------------------------------------------------
	// delete friend
	@RequestMapping(value = "/friend_del.do")
	public String delete_friend(HttpServletRequest request, String email, Model model) throws Exception {
		
		String myEmail = (String) request.getSession().getAttribute("email");
		System.out.println(myEmail);
		Map<String, String> m = new HashMap<String, String>();
		m.put("email1", myEmail);
		m.put("email2", email);
		int result = friendService.delFriend(m);
		model.addAttribute("result",result);
		return "member/fr_delResult";
	}

	// 친구 리스트 --------------------------------------------------
	@RequestMapping(value = "/friendlist.do")
	public String friendList(HttpSession session, Model model) throws Exception {
		String email = (String) session.getAttribute("email");
//			String email = "1@1.qq";
		List<FriendBean> list = friendService.list(email);
		List<MemberBean> friendList = new ArrayList<MemberBean>();	            
        for(FriendBean fb : list) {
           friendList.add(memberService.userCheck(fb.getEmail2()));
        }
        
		model.addAttribute("list", friendList);
        //model.addAttribute("list", list);
		
		//친구 요청 보낸 목록 보여주기
		List<FriendConfirm> invitationList = friendService.invite(email);
		model.addAttribute("invite",invitationList);
		
		//추천 친구 리스트
        List<FriendBean> recommend = friendService.recommend(email);
        session.setAttribute("fr_recommend",recommend);
        
		return "member/friend";
	}
}
