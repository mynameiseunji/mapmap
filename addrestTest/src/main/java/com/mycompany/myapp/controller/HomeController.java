package com.mycompany.myapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.myapp.model.Coordinate;
import com.mycompany.myapp.model.stationXY;
import com.mycompany.myapp.service.MapService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private MapService ms;

	@RequestMapping("test.do")
	public String home() {
		return "home1";
	}

	@RequestMapping("sendAddr.do")
	public String sendAddr(HttpServletRequest request, Model model) {
		String[] name = request.getParameterValues("name");
		System.out.println(name.length);
		String[] addr = request.getParameterValues("addr_name");
		String[] x = request.getParameterValues("x");
		String[] y = request.getParameterValues("y");

		// 세션
		HttpSession session = request.getSession();
		session.setAttribute("_name", name);
		session.setAttribute("_addr", addr);
		session.setAttribute("_x", x);
		session.setAttribute("_y", y);

		model.addAttribute("addr", addr);
		model.addAttribute("x", x);
		model.addAttribute("y", y);

		// 은지님
		Coordinate coor = ms.getCenter(x, y);
		List<stationXY> stationList = ms.getStationCoord(coor);
		model.addAttribute("stationList", stationList);
		model.addAttribute("center", coor);

		return "foundplace";
	}

}
