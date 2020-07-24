package com.mycompany.myapp.service;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.myapp.json.JsonParsing;
import com.mycompany.myapp.model.Coordinate;
import com.mycompany.myapp.model.stationXY;



@Service
public class MapServiceImpl implements MapService {

	@Autowired
	private JsonParsing par = new JsonParsing();

	// REST API에 요청해서 json 형식 데이터 받아올 부분
	@Override
	public List<stationXY> getStationCoord(Coordinate coor) {
		HttpURLConnection conn = null;
		StringBuilder sb = new StringBuilder();
		try {
			// URL 설정
//	    	location = new String(location.getBytes("UTF-8"));
			// URL url = new
			// URL("https://dapi.kakao.com/v2/local/search/address.json?query="+URLEncoder.encode(location, "utf-8"));

			String base_url = "https://dapi.kakao.com/v2/local/search/category.json";
			String Authorization = "KakaoAK " + "cdca325d6efe88cfb6c48440908a80c2";
			String category_group_code = "SW8"; // 지하철 역 카테고리만 검색하기 위한 코드
			String x = coor.getX();
			String y = coor.getY();
			String page = "1"; //페이지 수 설정
			String size ="10"; //페이지당 검색 개수 설정
			String radius = "2000"; // 검색 반경 임의로 설정(0~2000까지 설정가능)

			String findStationList = base_url + "?category_group_code=" + category_group_code + "&x=" + x + "&y=" + y
					+ "&radius=" + radius+ "&page"+page+"&size"+size+"&sort=distance";
			//주소 확인용 디버깅 코드
			System.out.println(findStationList);
			URL url = new URL(findStationList);
			conn = (HttpURLConnection) url.openConnection();
			// Request 형식 설정
			conn.setRequestMethod("GET");
			// 키 입력
			conn.setRequestProperty("Authorization", Authorization);

			// 보내고 결과값 받기
			// 통신 상태 확인 코드.
			int responseCode = conn.getResponseCode();
			System.out.println(responseCode);
			if (responseCode == 400) {
				System.out.println(
						"400:: 해당 명령을 실행할 수 없음 (실행할 수 없는 상태일 때, 엘리베이터 수와 Command 수가 일치하지 않을 때, 엘리베이터 정원을 초과하여 태울 때)");
			} else if (responseCode == 401) {
				System.out.println("401:: X-Auth-Token Header가 잘못됨");
			} else if (responseCode == 500) {
				System.out.println("500:: 서버 에러, 문의 필요");
			} else { // 성공 후 응답 JSON 데이터받기
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

		List<stationXY> stationList = par.getStationCoordi(sb.toString());

		return stationList;
	}
	
	//중심 좌표 구하기.
	// 출발지 좌표 값의 평균.
	public Coordinate getCenter(String[] x, String[] y) {
		Coordinate coor = new Coordinate();
		float n = (float)x.length;
		float sumX =0;
		float sumY =0;
		for(int i=0; i<x.length; i++) {
			sumX+=Float.parseFloat(x[i]);
			sumY+=Float.parseFloat(y[i]);
		}
		coor.setX(Float.toString(sumX/n));
		coor.setY(Float.toString(sumY/n));
		return coor;
	}
}
