package com.mycompany.myapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.myapp.model.Coordinate;
import com.mycompany.myapp.model.Place;
import com.mycompany.myapp.service.MapServiceImpl;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private MapServiceImpl ms;

	@RequestMapping("test.do")
	public String home() {
		return "home1";
	}

	@RequestMapping("sendAddr.do")
	public String sendAddr(HttpServletRequest request, Model model) {
		String[] name = request.getParameterValues("name");
		System.out.println(name.length);
		String[] addr = request.getParameterValues("addr_name");
		String[] arr_x = request.getParameterValues("x");
		String[] arr_y = request.getParameterValues("y");

		// 세션
		HttpSession session = request.getSession();
		session.setAttribute("_name", name);
		session.setAttribute("_addr", addr);
		session.setAttribute("_x", arr_x);
		session.setAttribute("_y", arr_y);

		// 은지님
		Coordinate center_coor = ms.getCenter(arr_x, arr_y);
		
		
		
		//옵션 값 형식
		String option ="x/"+center_coor.getX()+"/y/"+center_coor.getY()+"/page/1/size/10/radius/2000";
		
		// 지하철 category_group_code ="SW8"
		List<Place> placeList =ms.categorySearch("SW8", option);		
		model.addAttribute("stationList", placeList);
		/*
		
		 각 후보지에 대해서 소요시간 보여주기.
		 
		 */
		model.addAttribute("center", center_coor);

		return "foundplace";
	}

}
