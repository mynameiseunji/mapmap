package com.mycompany.myapp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.myapp.model.Coordinate;
import com.mycompany.myapp.model.Place;
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
		return "map/home1";
	}

	@RequestMapping("sendAddr.do")
	public String sendAddr(HttpServletRequest request, @ModelAttribute Place place, Model model) throws Exception {
		System.out.println("진입");
		ArrayList<Place> startPlaceList = (ArrayList<Place>) place.getPlaces();
		
		/*
		 * // home1.jsp로부터 넘어온 출발지 정보 저장 String[] name =
		 * request.getParameterValues("name"); //System.out.println(name.length);
		 * String[] addr = request.getParameterValues("address"); String[] arr_x =
		 * request.getParameterValues("x"); String[] arr_y =
		 * request.getParameterValues("y");
		 */

		// 세션
		HttpSession session = request.getSession();
		session.setAttribute("startPlaceList", startPlaceList);
		
		for(Place p : startPlaceList ) {
			System.out.println(p.toString());
		}
		
		//---------------------------------중점 좌표 get--------------------------------
		Coordinate center_coor = ms.getCenter(startPlaceList);

		//--------------------------------------------------------------------------
		
		
		//--------------------------------가까운 지하철역 5개 get-------------------------------
		// 중점좌표 기준 station 데이터를 API에 요청 (물리적으로 가까운 순)
		// category_group_code:SW8(지하철), page:1, size:5(5개만 가져오기), radius:2000 으로 제한하여 요청
		String option = "x/" + center_coor.getX() + "/y/" + center_coor.getY() + "/page/1/size/5/radius/2000";
		List<Place> endplaceList = ms.categorySearch("SW8", option);

		//--------------------------------------------------------------------------------
		
		
		//---------------------------08/03 권은지 : 추천역 DB로부터 가져오기 ------------------------------------	
		// 중점좌표 기준 모든 station 데이터를 API에 요청 (radius:2000 동일)
//		String rcm_option = "x/" + center_coor.getX() + "/y/" + center_coor.getY() + "/radius/2000";
//		
//		// rcm_placeList : 검색된 모든 지하철 객체(Place DTO)를 리스트로 반환받음
//		List<Place> rcm_placeList = ms.categorySearch("SW8", rcm_option);
//		
//		// rcm_stationList : foundPlace.jsp 페이지에 넘길 추천역(stationXY DTO) 리스트
//		List<stationXY> rcm_stationList = new ArrayList<stationXY>();
//		
//		//검색된 리스트에서 역 이름(p.getName()) 하나씩 꺼내와 DB에 존재하는지 비교
//		for (Place p : rcm_placeList) {
//			String subName = p.getName().trim();			
//			stationXY st = ms.getRcm_station(subName);  // 역 이름으로 selectOne(조회)하여 매칭되는 객체 가져오기(DB에 없으면 NULL)
//			if (rcm_stationList.size() > 5) { // 사이즈 5개 넘어가지 않도록
//				break;
//			} else {
//				if (st != null) {
//					rcm_stationList.add(st); // 검색 된 객체가 있다면 객체 리스트에 추가
//				}
//			}
//		}
		
		//--------------------------------------------------------------------------
		
		
		
		
		
		// 중심좌표 return
		model.addAttribute("center", center_coor);

		// 가까운 역 순 5개 리스트 return
		//javascript에서 사용하기 편하게하기위해
		//구분차 '#'를 사용해서 문자열로 형태 변환
		StringBuilder sb = new StringBuilder();
		for(Place p : endplaceList) {
			sb.append(p.getName()).append("#").append(p.getX()).append("#").append(p.getY()).append("#");
		}
		
		model.addAttribute("endPlaceList", sb.toString());
		
		int epl_num = endplaceList.size();
		model.addAttribute("epl_num", epl_num);
		// DB에서 검색결과 return
//		model.addAttribute("rcm_stationList", rcm_stationList);
//		System.out.println(rcm_stationList.size());
		
		// 각 후보지에 대해서 소요시간 보여주기.		
		// 공공데이터포털에서 경로 찾아오기
		// 필요한 정보 : 친구들 출발지 정보, 도착 후보지 정보
		String pathInfo = ms.getPathInfo(startPlaceList, endplaceList);
		System.out.println(pathInfo);
		model.addAttribute("pathInfo",pathInfo);
		model.addAttribute("x_num",startPlaceList.size());
		
		return "map/foundplace";
	}

	@RequestMapping("category.do")
	public String categorySelect(Place endPlace, Model model) {

		System.out.println(endPlace.getX());
		System.out.println(endPlace.getY());
		System.out.println(endPlace.getName());

		model.addAttribute("place", endPlace);

		return "map/category";
	}
}
