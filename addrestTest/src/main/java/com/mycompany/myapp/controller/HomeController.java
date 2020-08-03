package com.mycompany.myapp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.myapp.model.Coordinate;
import com.mycompany.myapp.model.Place;
import com.mycompany.myapp.model.stationXY;
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
	public String sendAddr(HttpServletRequest request, Model model) throws Exception {
		// home1.jsp로부터 넘어온 출발지 정보 저장
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

		//---------------------------------중점 좌표 get--------------------------------
		Coordinate center_coor = ms.getCenter(arr_x, arr_y);

		//--------------------------------------------------------------------------
		
		
		//--------------------------------가까운 지하철역 5개 get-------------------------------
		// 중점좌표 기준 station 데이터를 API에 요청 (물리적으로 가까운 순)
		// category_group_code:SW8(지하철), page:1, size:5(5개만 가져오기), radius:2000 으로 제한하여 요청
		String option = "x/" + center_coor.getX() + "/y/" + center_coor.getY() + "/page/1/size/5/radius/2000";
		List<Place> placeList = ms.categorySearch("SW8", option);

		//--------------------------------------------------------------------------------
		
		
		//---------------------------08/03 권은지 : 추천역 DB로부터 가져오기 ------------------------------------	
		// 중점좌표 기준 모든 station 데이터를 API에 요청 (radius:2000 동일)
		String rcm_option = "x/" + center_coor.getX() + "/y/" + center_coor.getY() + "/radius/2000";
		
		// rcm_placeList : 검색된 모든 지하철 객체(Place DTO)를 리스트로 반환받음
		List<Place> rcm_placeList = ms.categorySearch("SW8", rcm_option);
		
		// rcm_stationList : foundPlace.jsp 페이지에 넘길 추천역(stationXY DTO) 리스트
		List<stationXY> rcm_stationList = new ArrayList<stationXY>();
		
		//검색된 리스트에서 역 이름(p.getName()) 하나씩 꺼내와 DB에 존재하는지 비교
		for (Place p : rcm_placeList) {
			String subName = p.getName().trim();			
			stationXY st = ms.getRcm_station(subName);  // 역 이름으로 selectOne(조회)하여 매칭되는 객체 가져오기(DB에 없으면 NULL)
			if (rcm_stationList.size() > 5) { // 사이즈 5개 넘어가지 않도록
				break;
			} else {
				if (st != null) {
					rcm_stationList.add(st); // 검색 된 객체가 있다면 객체 리스트에 추가
				}
			}
		}
		
		//--------------------------------------------------------------------------


		// 중심좌표 return
		model.addAttribute("center", center_coor);

		// 가까운 역 순 5개 리스트 return
		model.addAttribute("stationList", placeList);
		
		// DB에서 검색결과 return
		model.addAttribute("rcm_stationList", rcm_stationList);

		/*
		 * 
		 * 각 후보지에 대해서 소요시간 보여주기.
		 * 
		 */

		return "foundplace";
	}

	@RequestMapping("category.do")
	public String categorySelect(Place place, Model model) {

		System.out.println(place.getX());
		System.out.println(place.getY());
		System.out.println(place.getName());

		model.addAttribute("place", place);

		return "category";
	}

}
