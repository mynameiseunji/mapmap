package com.mycompany.myapp;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
	
	
	
	@RequestMapping("test.do")
	public String home(Model model) {
		
		return "home";
	}
	
	@RequestMapping("sendAddr.do")
	public String sendAddr(InputAddrs address, Model model) {
		String[] strArr = new AddrArray().toArray(address);
		//System.out.println(strArr[0]+"  99999999 ");
		model.addAttribute(address);
		//서비스 클래스삽입
		
		Coordinate[] coor = new Coordinate[address.getCnt()];
		
		for(int i=0; i<address.getCnt(); i++) {
			//System.out.println("진입");
			coor[i]= new AddrToCoordi().getCoordi(strArr[i]);
			//System.out.println("퇴출");
		}
		//String wow =new AddrToCoordi().getCoordi(address);
		//List<Coordinate> list = new ArrayLiset<Coordinate>();
		
//		System.out.println(coor[0].getX()+"  99999999 ");
//		System.out.println(coor[0].getY()+"  99999999 ");
//		System.out.println(coor[1].getX()+"  99999999 ");
//		System.out.println(coor[1].getY()+"  99999999 ");
		model.addAttribute("coor",coor);
		return "sendAddr";
	}
	
}
