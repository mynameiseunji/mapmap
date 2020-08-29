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

import com.mycompany.myapp.json.JsonParsing;
import com.mycompany.myapp.model.Coordinate;
import com.mycompany.myapp.model.Place;
import com.mycompany.myapp.model.Route;
import com.mycompany.myapp.model.RouteM;
import com.mycompany.myapp.model.stationXY;
import com.mycompany.myapp.service.MapService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeAction {
	
	@Autowired
	private MapService ms;
	@Autowired
	private JsonParsing jsonparser;
	@RequestMapping("test.do")
	public String home_push(HttpSession session, HttpServletRequest request) {
		return "map/home";
	}
	
	@RequestMapping("session_del.do")
	public String testtest(HttpServletRequest request, Place place, Model model) {
		if(place.getName()==null)return "map/home";
		
		ArrayList<Place> startPlaceList = new ArrayList<Place>();
		int n = place.getName().split(",").length;
		for(int i=0; i<n; i++) {
			Place p = new Place();
			p.setAddress(place.getAddress().split(",")[i]);
			p.setName(place.getName().split(",")[i]);
			p.setX(place.getX().split(",")[i]);
			p.setY(place.getY().split(",")[i]);
			startPlaceList.add(p);
		}
		int listSize = startPlaceList.size();
		request.getSession().setAttribute("startPlaceList", startPlaceList);
		
		return "map/home";
	}
	@RequestMapping("sendAddr.do")
	public String sendAddr(HttpServletRequest request, @ModelAttribute Place place, Model model) throws Exception {
		
		
		ArrayList<Place> startPlaceList = (ArrayList<Place>) place.getPlaces();
		

		// 세션
		HttpSession session = request.getSession();
		session.setAttribute("startPlaceList", startPlaceList);
		//resquest.setAttribute("startPlaceList", startPlaceList);
		
		
		//---------------------------------중점 좌표 get--------------------------------
		Place center = ms.getCenter(startPlaceList);

		//--------------------------------------------------------------------------
		
		
		//--------------------------------가까운 지하철역 5개 get-------------------------------
		// 중점좌표 기준 station 데이터를 API에 요청 (물리적으로 가까운 순)
		// category_group_code:SW8(지하철), page:1, size:15(기본값), radius:2000 으로 제한하여 요청
		String option = "x/" + center.getX() + "/y/" + center.getY() + "/page/1/radius/2000";
		List<Place> endplaceList = ms.categorySearch("SW8", option);
		//--------------------------------------------------------------------------------
		
		endplaceList.add(0,	center);//중심 좌표 추가.	
		//tmap api 호출을 위해서  출발,도착지 정보를 js에서 사용해야함
		// js에서 사용하기 편하게  json형식으로 변환.
		String jsonEpl = jsonparser.josonParsing(endplaceList); // 추천지역 json 변환 08.29
		String jsonSpl = jsonparser.josonParsing(startPlaceList); // 출발지역 json 변환08.29
		model.addAttribute("jsonEpl", jsonEpl);
		model.addAttribute("jsonSpl", jsonSpl);
		
		// 각 후보지에 대해서 소요시간 보여주기.		
		// 공공데이터포털에서 경로 찾아오기
		// 필요한 정보 : 출발지 정보, 도착 후보지 정보
		String pathInfo = ms.getPathInfo(startPlaceList, endplaceList,"BusNSub");		
		model.addAttribute("pathInfo",pathInfo);
		model.addAttribute("x_num",startPlaceList.size());
		
		return "map/foundplace";
	}

	@RequestMapping("category.do")
	public String categorySelect(Place place, Model model, HttpSession session) {

		if(session.getAttribute("startPlaceList")==null) {
			return "member/sessionResult";
		}
		model.addAttribute("place", place);

		//-------------------- 카테고리별 추천 장소 5개 ----- 08/05 김가을  --------------------
		String option = "x/" + place.getX() + "/y/" + place.getY() + "/page/1/size/5/radius/2000";
		//String option = "x/" + place.getX() + "/y/" + place.getY() + "/page/1/radius/2000";
		
		StringBuilder sb = new StringBuilder();
		List<Place> startPlaceList = (List<Place>)session.getAttribute("startPlaceList");
		for(Place p : startPlaceList)
			sb.append(p.getAddress());
		// CT1 문화시설
		List<Place> ct1placeList = ms.categorySearch("CT1", option);
		ms.createId(ct1placeList, sb.toString());
		model.addAttribute("ct1placeList", ct1placeList);
		// FD6 음식점
		List<Place> fd6placeList = ms.categorySearch("FD6", option);
		ms.createId(fd6placeList, sb.toString());
		model.addAttribute("fd6placeList", fd6placeList);
		// CE7 카페
		List<Place> ce7placeList = ms.categorySearch("CE7", option);
		ms.createId(ce7placeList, sb.toString());
		model.addAttribute("ce7placeList", ce7placeList);
		// AT4 관광명소
		List<Place> at4placeList = ms.categorySearch("AT4", option);
		ms.createId(at4placeList, sb.toString());
		model.addAttribute("at4placeList", at4placeList);
		//------------------------------------------------------------
		
		return "map/category";
	}
	@RequestMapping("route.do")
	public String route(@ModelAttribute("id") String id,String status, HttpSession session, Place place, Model model) {
		//지하철,버스,
		//공유하기 버튼 분기
//		model.addAttribute("original", 0);
		
		//경로 db에 저장된 정보 있는지 체크.
		RouteM r = ms.routeSearch(id);
		
		//비성장 접근 체크
		if(status==null && r == null) {
			return "map/routeResult";	
		}
		

		if(r == null ) { // && session.getAttribute("id") != null
			//session.setAttribute("id", id);
			Place endPlace = place;
			List<Place> startPlaceList =(List<Place>) session.getAttribute("startPlaceList");			
			
			ms.finalDBSetting(startPlaceList,endPlace,id);
			
//			model.addAttribute("original", 1);
			r = ms.routeSearch(id);
		}
		
		List<RouteM> routeList = ms.getRouteList(r);
		model.addAttribute("routelist", routeList);
		model.addAttribute("endPlace",r);

		return "map/route";
	}
	
}
// 
