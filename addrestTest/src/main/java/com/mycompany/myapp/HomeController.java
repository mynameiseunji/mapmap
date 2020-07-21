package com.mycompany.myapp;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	
	
	@RequestMapping("test.do")
	public String home(Model model) {
		
		return "home";
	}
	
	@RequestMapping("sendAddr.do")
	public String sendAddr(String address, Model model) {
		model.addAttribute(address);
		//서비스 클래스삽입 
		String wow =new AddrToCoordi().getCoordi(address);
		
		model.addAttribute("wow",wow);
		
		System.out.println(wow);
		//주소로 좌표 받아오기
		return "sendAddr";
	}
	
}
