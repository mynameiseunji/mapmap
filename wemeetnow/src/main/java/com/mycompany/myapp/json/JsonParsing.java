package com.mycompany.myapp.json;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.myapp.model.Place;

@Service
public class JsonParsing {
	private Place stcoor = null;	
	
	public List<Place> getPlaceInfo(String jsonData) {
		List<Place> stationList = new ArrayList<Place>();
		
		try {
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonOb = (JSONObject) jsonParser.parse(jsonData);
			JSONArray docArray = (JSONArray) jsonOb.get("documents");
			//지하철역 중복 체크 위한 hashset
			Set<String> set = new HashSet<String>();
			for (int i = 0; i < docArray.size(); i++) {
				if(set.size()==5)break;
				JSONObject docOb = (JSONObject) docArray.get(i);
				stcoor = new Place();
				//String pname = docO
				stcoor.setName((String) docOb.get("place_name"));
					//중복 지하철 제거
					String stationName = stcoor.getName().split(" ")[0];
					if(set.contains(stationName))continue;
					set.add(stationName);
					
				stcoor.setX((String) docOb.get("x"));
				stcoor.setY((String) docOb.get("y"));
				stcoor.setAddress((String) docOb.get("address_name"));
				stcoor.setPhone((String) docOb.get("phone"));
				stcoor.setPlace_url((String) docOb.get("place_url"));
				stationList.add(stcoor);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return stationList;
	}
	
	//20.08.29 view-controller 데이터 전달 개선
	public String josonParsing(List<?> list) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		return jsonText;
	}
	//20.08.29 view-controller 데이터 전달 개선
	public String josonParsing(Object o) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(o);
		return jsonText;
	}
}
