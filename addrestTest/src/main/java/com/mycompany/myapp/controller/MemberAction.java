package com.mycompany.myapp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.myapp.model.MemberBean;
import com.mycompany.myapp.service.Memberservice;




@Controller
public class MemberAction {

	@Autowired
	private Memberservice memberService;

	//email duplicate check ajax
	@RequestMapping(value = "/member_emailcheck.do", method = RequestMethod.POST)
	public String member_emailcheck(@RequestParam("mememail") String email, Model model) throws Exception {

		int result = memberService.checkMemberEmail(email);
		model.addAttribute("result", result);

		return "jsp/member/emailcheckResult";
	}
	
	//sign in form
	@RequestMapping(value = "/member_login.do")
	public String member_login() {
		return "jsp/member/member_login";
	}

//	//password forget
//	@RequestMapping(value = "/pwd_find.lm")
//	public String pwd_find() {
//		return "member/pwd_find";
//	}

	//sign up form
	@RequestMapping(value = "/member_join.do")
	public String member_join() {
		return "jsp/member/member_join";
	}
	
//	//password find
//	@RequestMapping(value = "/pwd_find_ok.lm", method = RequestMethod.POST)
//	public String pwd_find_ok(@ModelAttribute MemberBean mem, HttpServletResponse response, Model model)
//			throws Exception {
//		response.setContentType("text/html;charset=UTF-8");
//		PrintWriter out = response.getWriter();
//
//		MemberBean member = memberService.findpwd(mem);
//
//		if (member == null) {
//			return "member/pwdResult";
//		} else {
//
//			//mail server
//			String charSet = "utf-8";
//			String hostSMTP = "smtp.naver.com";
//			String hostSMTPid = "rkfeen@naver.com";
//			String hostSMTPpwd = "!1Elephant";
//
//			//sender
//			String fromEmail = "rkfeen@naver.com";
//			String fromName = "admin";
//			String subject = "password";
//
//			//reciever
//			String mail = member.getJoin_email();
//
//			try {
//				HtmlEmail email = new HtmlEmail();
//				email.setDebug(true);
//				email.setCharset(charSet);
//				email.setSSL(true);
//				email.setHostName(hostSMTP);
//				email.setSmtpPort(587);
//
//				email.setAuthentication(hostSMTPid, hostSMTPpwd);
//				email.setTLS(true);
//				email.addTo(mail, charSet);
//				email.setFrom(fromEmail, fromName, charSet);
//				email.setSubject(subject);
//				email.setHtmlMsg("<p align = 'center'>password</p><br>" + "<div align='center'> 비밀번호 : "
//						+ member.getJoin_pwd() + "</div>");
//				email.send();
//			} catch (Exception e) {
//				System.out.println(e);
//			}
//
//			model.addAttribute("pwdok", "전자우편으로 비밀번호 전송");
//			return "member/pwd_find";
//		}
//	}


	//member information save
	@RequestMapping(value = "/member_join_ok.do", method = RequestMethod.POST)
	public String member_join_ok(@ModelAttribute MemberBean member) throws Exception {
	
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
			
			return "jsp/member/loginResult";
			
		} else {			//member exists
			if (m.getPwd().equals(pwd)) {	//correct password
				session.setAttribute("email", email);

				String nickname = m.getNickname();

				model.addAttribute("nickname", nickname);

				return "jsp/member/main";
				
			} else {		//incorrect password
				result = 2;
				model.addAttribute("result", result);
				
				return "jsp/member/loginResult";				
			}
		}
	}

	//member information update form
	@RequestMapping(value = "/member_edit.do")
	public String member_edit(HttpSession session, Model model) throws Exception {

		String email = (String) session.getAttribute("email");

		MemberBean editm = memberService.userCheck(email);
				
		model.addAttribute("editm", editm);
		
		return "jsp/member/member_edit";
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

		return "jsp/member/member_logout";
	}
	
	//member deletion form
	@RequestMapping(value = "/member_del.do")
	public String member_del(HttpSession session, Model dm) throws Exception {

		String email = (String) session.getAttribute("email");
		MemberBean deleteM = memberService.userCheck(email);
		dm.addAttribute("d_email", email);
		dm.addAttribute("d_nname", deleteM.getNickname());

		return "jsp/member/member_del";
	}

	//member deletion completed
	@RequestMapping(value = "/member_del_ok.do", method = RequestMethod.POST)
	public String member_del_ok(@RequestParam("pwd") String pass, 
							    HttpSession session) throws Exception {

		String email = (String) session.getAttribute("email");
		MemberBean member = this.memberService.userCheck(email);

		if (!member.getPwd().equals(pass)) {

			return "jsp/member/deleteResult";
			
		} else {	//correct password
			
			
			MemberBean delm = new MemberBean();
			delm.setEmail(email);

			memberService.deleteMember(delm);

			session.invalidate();

			return "redirect:member_login.do";
		}
	}

}
