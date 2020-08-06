package com.mycompany.myapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.myapp.model.FriendBean;
import com.mycompany.myapp.model.MemberBean;
import com.mycompany.myapp.service.FriendServiceImpl;
import com.mycompany.myapp.service.Memberservice;




@Controller
public class MemberAction {

	@Autowired
	private Memberservice memberService;
	@Autowired
	private FriendServiceImpl friendService;

	//email duplicate check ajax
	@RequestMapping(value = "/member_emailcheck.do", method = RequestMethod.POST)
	public String member_emailcheck(@RequestParam("email") String email, Model model) throws Exception {

		int result = memberService.checkMemberEmail(email);
		model.addAttribute("result", result);

		return "member/emailcheckResult";
	}
	
	//sign in form
	@RequestMapping(value = "/member_login.do")
	public String member_login() {
		return "member/member_login";
	}

	//sign up form
	@RequestMapping(value = "/member_join.do")
	public String member_join() {
		return "member/member_join";
	}

	//member information save
	@RequestMapping(value = "/member_join_ok.do", method = RequestMethod.POST)
	public String member_join_ok(@ModelAttribute MemberBean member) throws Exception {
		System.out.println(member.toString());
		memberService.insertMember(member);

		return "redirect:member_login.do";
	}

	
	//sign in verification
	@RequestMapping(value = "/member_login_ok.do", method = RequestMethod.POST)
	public String member_login_ok(@RequestParam("email") String email,
			                      @RequestParam("pwd") String pwd,
			                      HttpSession session, Model model) throws Exception {
		int result=0;		
		MemberBean m = memberService.userCheck(email);

		if (m == null) {	//member not exists
			
			result = 1;
			model.addAttribute("result", result);
			
			return "member/loginResult";
			
		} else {			//member exists
			if (m.getPwd().equals(pwd)) {	//correct password
				session.setAttribute("email", email);

	            String nickname = m.getNickname();
	            /*
	             * db에서 친구 리스트 가져오기*/
	            List<FriendBean> list = friendService.list(email);
	            StringBuffer sb = new StringBuffer();
	            for(FriendBean fb : list) {
	               sb.append(fb.getEmail2()).append("#");
	            }
	            model.addAttribute("nickname", nickname);
	            model.addAttribute("friend_List", sb.toString());
	            
	            //home1.jsp에서 사용
	            session.setAttribute("friend_List", sb.toString());
	            
	            return "member/main";
	            
	            // 프론트엔드 새로 합칠때 사용.
	            //return "map/home1.jsp"
				
			} else {		//incorrect password
				result = 2;
				model.addAttribute("result", result);
				
				return "member/loginResult";				
			}
		}
	}

	//member information update form
	@RequestMapping(value = "/member_edit.do")
	public String member_edit(HttpSession session, Model model) throws Exception {

		String email = (String) session.getAttribute("email");

		MemberBean editm = memberService.userCheck(email);
				
		model.addAttribute("editm", editm);
		
		return "member/member_edit";
	}
	
	//member information update
	@RequestMapping(value = "/member_edit_ok.do", method = RequestMethod.POST)
	public String member_edit_ok( MemberBean member, HttpServletRequest request, 
								  HttpSession session, Model model) throws Exception {
		
		String email = (String) session.getAttribute("email");
		
		String nickname = member.getNickname();
		model.addAttribute("nickname", nickname);
		
		MemberBean editm = this.memberService.userCheck(email);		
			
		member.setEmail(email);
		
		memberService.updateMember(member);

		return "jsp/member/main";
	}
		
	//sign out
	@RequestMapping("/member_logout.do")
	public String logout(HttpSession session) {
		session.invalidate();

		return "member/member_logout";
	}
	
	//member deletion form
	@RequestMapping(value = "/member_del.do")
	public String member_del(HttpSession session, Model dm) throws Exception {

		String email = (String) session.getAttribute("email");
		MemberBean deleteM = memberService.userCheck(email);
		dm.addAttribute("d_email", email);
		dm.addAttribute("d_nname", deleteM.getNickname());

		return "member/member_del";
	}

	//member deletion completed
	@RequestMapping(value = "/member_del_ok.do", method = RequestMethod.POST)
	public String member_del_ok(@RequestParam("pwd") String pass, 
							    HttpSession session) throws Exception {

		String email = (String) session.getAttribute("email");
		MemberBean member = this.memberService.userCheck(email);

		if (!member.getPwd().equals(pass)) {

			return "member/deleteResult";
			
		} else {	//correct password
			
			
			MemberBean delm = new MemberBean();
			delm.setEmail(email);

			memberService.deleteMember(delm);

			session.invalidate();

			return "redirect:member_login.do";
		}
	}

}
