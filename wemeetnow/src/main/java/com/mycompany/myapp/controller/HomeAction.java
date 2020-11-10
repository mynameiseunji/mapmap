package com.mycompany.myapp.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.mycompany.myapp.json.JsonParsing;
import com.mycompany.myapp.model.Place;
import com.mycompany.myapp.model.RouteM;
import com.mycompany.myapp.model.RouteS;
import com.mycompany.myapp.naver.DrivingAPI;
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
	
	//ajax호출
	@RequestMapping("geoJson.do")
	@ResponseBody
	public String geoJson(HttpSession session, Place endplace, Model model) throws InterruptedException, ExecutionException {
		List<Place> startPlaceList = (List<Place>)session.getAttribute("startPlaceList");
		
		// geoJson 생성 // 경로 그리기
		JSONArray[] pathArr= ms.getPolyPathArr(startPlaceList, endplace);//출발지들에서 중심 좌표까지 polyline을 그리기 위한 경로배열 데이터 요청 및 세팅
		JSONObject jsonObject = jsonparser.createGeoJson();//javascript에서 사용할 geojson형태로 변환
		JSONArray arr = (JSONArray) jsonObject.get("features");
		for(JSONArray path : pathArr) {
			jsonparser.addFeature(arr, path, "red");
		}
		return jsonObject.toString();
	}
	
	@RequestMapping("publicDataService.do")
	@ResponseBody
	public String publicDataService(HttpSession session, Place endplace, Model model) throws InterruptedException, ExecutionException, JsonProcessingException {
		List<Place> startPlaceList = (List<Place>)session.getAttribute("startPlaceList");
		// 각 후보지에 대해서 소요시간 보여주기.		
		// 공공데이터포털에서 경로 찾아오기
		// 필요한 정보 : 출발지 정보, 도착 후보지 정보
		List<RouteS> jsonPath = ms.getPublicDataPath(startPlaceList, endplace);
		return jsonparser.josonParsing(jsonPath);
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
		request.getSession().setAttribute("startPlaceList", startPlaceList);
		
		return "map/home";
	}
	
	@RequestMapping("sendAddr2.do")
	public String sendAddr2(HttpServletRequest request, @ModelAttribute Place place, Model model) throws Exception {
		
		
		ArrayList<Place> startPlaceList = (ArrayList<Place>) place.getPlaces();
		// 추후에 쿠키로 변경해볼것.
		HttpSession session = request.getSession();
		session.setAttribute("startPlaceList", startPlaceList);		
		
		//---------------------------------중점 좌표 get--------------------------------
		Place center = ms.getCenter(startPlaceList);		
		
		// geoJson 생성 // 경로 그리기
		JSONArray[] pathArr= ms.getPolyPathArr(startPlaceList, center); //출발지들에서 중심 좌표까지 polyline을 그리기 위한 경로배열 데이터 요청 및 세팅
		JSONObject jsonObject = jsonparser.createGeoJson(); //javascript에서 사용할 geojson형태로 변환
		JSONArray arr = (JSONArray) jsonObject.get("features");
		for(JSONArray list : pathArr) {
			jsonparser.addFeature(arr, list, "red");
		}
		model.addAttribute("centerPath", jsonObject.toString());
		
		
		//--------------------------------가까운 지하철역 5개 get-------------------------------
		// category_group_code:SW8(지하철), page:1, size:15(기본값), radius:2000 으로 제한하여 요청
		String option = "x/" + center.getX() + "/y/" + center.getY() + "/page/1/radius/2000";
		List<Place> endplaceList = ms.categorySearch("SW8", option);
		
		endplaceList.add(0,	center);//중심 좌표 추가.	
		
		// js에서 사용하기 편하게  json형식으로 변환.
		model.addAttribute("jsonEpl", jsonparser.josonParsing(endplaceList));// 추천지역 json 변환 08.29
		model.addAttribute("jsonSpl", jsonparser.josonParsing(startPlaceList));// 출발지역 json 변환08.29
		
		return "map/foundplace2";
	}
	@RequestMapping("category.do")
	public String categorySelect(Place place, Model model, HttpSession session) {

		if(session.getAttribute("startPlaceList")==null) {
			return "member/sessionResult";
		}
		model.addAttribute("place", place);

		//-------------------- 카테고리별 추천 장소 5개 ----- 08/05 김가을  --------------------
		String option = "x/" + place.getX() + "/y/" + place.getY() + "/page/1/size/5/radius/2000";
		
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
	public String route(String status, HttpSession session, Place place, RouteM rm, Model model) throws JsonProcessingException, InterruptedException {
		//지하철,버스,
		//경로 db에 저장된 정보 있는지 체크.
		RouteM r = ms.routeSearch(rm.getId());
		
		//비성장 접근 체크
		if(status==null && r == null) {
			return "map/routeResult";	
		}

		if(r == null ) {
			//session.setAttribute("id", id);
			Place endPlace = place;
			List<Place> startPlaceList =(List<Place>) session.getAttribute("startPlaceList");		
			ms.finalDBSetting(startPlaceList,endPlace,rm);
			r = ms.routeSearch(rm.getId());
			
		}
		List<RouteS> routeList = ms.getRouteList(r);
		model.addAttribute("routelist", routeList);
		model.addAttribute("endPlace",r);
		model.addAttribute("end",jsonparser.josonParsing(r));

		return "map/route";
	}
	
}
