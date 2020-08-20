package com.mycompany.myapp.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Random;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.myapp.dao.MapDAO;
import com.mycompany.myapp.json.JsonParsing;
import com.mycompany.myapp.model.Coordinate;
import com.mycompany.myapp.model.Place;
import com.mycompany.myapp.model.Route;
import com.mycompany.myapp.model.stationXY;

@Service
public class MapServiceImpl implements MapService {

	@Autowired
	private MapDAO md;
	@Autowired
	private JsonParsing par;

	private final String URL_HOME = "https://dapi.kakao.com";
	private final String URL_CATEGORY = "/v2/local/search/category.json";
	private final String URL_KEYWORD = "/v2/local/search/keyword.json";
	private final String URL_ADRESS = "/v2/local/search/address.json";

	@Override
	public List<Place> categorySearch(String categoryCode) {
		String url = URL_HOME + URL_CATEGORY + "?";
		String options = "category_group_code/" + categoryCode;
		return getStationCoord(url, options);
	}

	@Override
	public List<Place> categorySearch(String categoryCode, String option) {
		String url = URL_HOME + URL_CATEGORY + "?";
		String options = "category_group_code/" + categoryCode + "/" + option;
		return getStationCoord(url, options);
	}

	@Override
	public List<Place> keywordSearch(String query) {
		String url = URL_HOME + URL_KEYWORD + "?";
		String options = null;
		try {
			options = "query/" + URLEncoder.encode(query, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return getStationCoord(url, options);
	}

	@Override
	public List<Place> keywordSearch(String query, String option) {
		String url = URL_HOME + URL_KEYWORD + "?";
		String options = null;
		try {
			options = "query/" + URLEncoder.encode(query, "utf-8") + "/" + option;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return getStationCoord(url, options);
	}

	@Override
	public List<Place> addressSearch(String address) {
		String url = URL_HOME + URL_ADRESS + "?";
		String options = null;
		try {
			options = "query/" + URLEncoder.encode(address, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return getStationCoord(url, options);
	}

	@Override
	public List<Place> addressSearch(String address, String option) {
		String url = URL_HOME + URL_ADRESS + "?";
		String options = null;
		try {
			options = "query/" + URLEncoder.encode(address, "utf-8") + "/" + option;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return getStationCoord(url, options);
	}

	// REST API에 요청해서 json 형식 데이터 받아올 부분
	@Override
	public List<Place> getStationCoord(String url_, String options) {
		HttpURLConnection conn = null;
		StringBuilder sb = null;
		try {
			sb = new StringBuilder();
			sb.append(url_);
			StringTokenizer st = new StringTokenizer(options, "/");
			String Authorization = "KakaoAK " + "cdca325d6efe88cfb6c48440908a80c2";
			while (st.hasMoreTokens()) {
				sb.append(st.nextToken()).append("=").append(st.nextToken()).append("&");
			}

			// 주소 확인용 디버깅 코드
			String final_request_url = sb.toString();
			URL url = new URL(final_request_url);

			conn = (HttpURLConnection) url.openConnection();
			// Request 형식 설정
			conn.setRequestMethod("GET");
			// 키 입력
			conn.setRequestProperty("Authorization", Authorization);

			// 보내고 결과값 받기
			// 통신 상태 확인 코드.
			int responseCode = conn.getResponseCode();
			if (responseCode == 400) {
				System.out.println("kakao connection :: 400 error");
			} else if (responseCode == 401) {
				System.out.println("401:: Wrong X-Auth-Token Header");
			} else if (responseCode == 500) {
				System.out.println("500:: kakao server error");
			} else { // 성공 후 응답 JSON 데이터받기
				sb = new StringBuilder();
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

				String line = "";
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}
				br.close();
			}

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return par.getPlaceInfo(sb.toString());
	}

	// 중심 좌표 구하기.
	// 출발지 좌표 값의 평균.
	@Override
	public Coordinate getCenter(List<Place> placeList) {
		Coordinate coor = new Coordinate();
		float n = placeList.size();
		float sumX = 0;
		float sumY = 0;
		for (int i = 0; i < n; i++) {
			sumX += Float.parseFloat(placeList.get(i).getX());
			sumY += Float.parseFloat(placeList.get(i).getY());
		}
		coor.setX(Float.toString(sumX / n));
		coor.setY(Float.toString(sumY / n));
		return coor;
	}

	@Override
	public stationXY getRcm_station(String subName) throws Exception {
		return md.getRcm_station(subName);
	}
	
	//공공데이터포털에서 경로와 시간 구해오는 메소드
	//리턴 형식은 '/'와 '#' 를 구분자로하는 문자열 타입
	//각 경로는 '/'로 구분
	//하나의 경로에서 시간 거리 출발지 도착지 등 정보는 '#'로 구분
	public String getPathInfo(List<Place> startPlaceList, List<Place> endPlaceList,String transport) {
		StringBuilder sb = new StringBuilder();
		for(int i=0; i<endPlaceList.size(); i++) {
			PublicDataService pds = new PublicDataService();
			for(int j=0; j<startPlaceList.size(); j++) {
				
				sb.append(pds.getPath(
						startPlaceList.get(j).getX(),
						startPlaceList.get(j).getY(),
						endPlaceList.get(i).getX(),
						endPlaceList.get(i).getY(),
						transport)).append("/");
			}
		}
		return sb.toString();
	}
	public String getFinalPath(List<Place> startPlaceList, Place endPlace, String transport) {
		StringBuilder sb = new StringBuilder();
		for(int i=0; i<startPlaceList.size(); i++) {
			PublicDataService pds = new PublicDataService();				
			sb.append(pds.getPath(
					startPlaceList.get(i).getX(),
					startPlaceList.get(i).getY(),
					endPlace.getX(),
					endPlace.getY(),
					transport)).append("/");
		}
		return sb.toString();
	}
	
	//마지막 페이지에 필요한 정보(출발지, 경로1, 경로2, 시간1, 시간2)
	@Override
	public int finalDBSetting(List<Place> startPlaceList, Place endPlace, String id){
			
		String BUS = getFinalPath(startPlaceList, endPlace,"Bus");
		String BNS = getFinalPath(startPlaceList, endPlace,"BusNSub");
				
		StringBuilder DEPARTURE = new StringBuilder();
		
		for(int i=0; i<startPlaceList.size(); i++) {
			DEPARTURE.append(startPlaceList.get(i).getAddress()).append("/");
		}
		
		//데이터 파싱
		// 인서트
		Route route = new Route();
		route.setId(id);
		route.setBus_route(BUS);
		route.setComplex_route(BNS);
		route.setDeparture(DEPARTURE.toString());		
		int result = md.insertData(route);
		//프라이머리키 리턴
		return result;
	}
	@Override
	public Route routeSearch(String id) {
		
		Route r = md.routeSearch(id);
		
		return r;
	}
	@Override
	public String[] parsingRoute(String bus_route) {
		String[] pieces= bus_route.split("#");
		return null;
	}
	public void createId(List<Place> list, String spl) {		
		Collections.sort(list, new Comparator<Place>() {
			public int compare(Place o1, Place o2) {
				return o1.getAddress().compareTo(o2.getAddress());
			};
		});
		for(Place p : list) {
			StringBuilder sb = new StringBuilder();
			sb.append(spl);
			sb.append(p.getPlace_url());
			int id = sb.toString().hashCode();
			p.setId(id+"");
			
		}
	}
	
	@Override
	public boolean idCheck(String id) {
		if(md.idCheck(id)==1)
			return true;
		else
			return false;
		
	}
}

