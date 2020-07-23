package com.mycompany.myapp;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.myapp.model.Coordinate;
import com.mycompany.myapp.model.InputAddrs;
import com.mycompany.myapp.service.AddrArray;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private AddrToCoordi atc;
	
	@RequestMapping("test.do")
	public String home(Model model) {
		
		return "home1";
	}
	
	@RequestMapping("sendAddr.do")
	public String sendAddr(HttpServletRequest request, Model model) {
		
		String[] addr = request.getParameterValues("addr_name");
		String[] x = request.getParameterValues("x");
		String[] y = request.getParameterValues("y");
		
		model.addAttribute("addr",addr);
		model.addAttribute("x",x);
		model.addAttribute("y",y);
		
		
//		String[] strArr = new AddrArray().toArray(address);
//		
//		model.addAttribute("address",strArr);
//		
//		
//		Coordinate[] coor = new Coordinate[address.getCnt()];
//		
//		for(int i=0; i<address.getCnt(); i++) {
//			
//			coor[i]= atc.getCoordi(strArr[i]);
//			
//		}
//		model.addAttribute("coor",coor);
		return "sendAddr";
	}
	
}