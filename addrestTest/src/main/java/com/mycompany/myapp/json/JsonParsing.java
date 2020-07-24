package com.mycompany.myapp.json;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import com.mycompany.myapp.model.Coordinate;
import com.mycompany.myapp.model.stationXY;

@Service("jsonParsing")
public class JsonParsing {
	private Coordinate coor = null;
	private stationXY stcoor = null;
	public Coordinate getCoordi(String jsonData) {
		try {
			JSONParser jsonParser = new JSONParser();
			
			JSONObject jsonOb = (JSONObject) jsonParser.parse(jsonData);
			
			JSONArray docArray =  (JSONArray) jsonOb.get("documents");
			coor = new Coordinate();
			for(int i=0; i<docArray.size(); i++) {
				JSONObject docOb = (JSONObject) docArray.get(0);
				coor.setX((String)docOb.get("x"));
				coor.setY((String)docOb.get("y"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return coor;
	}
	public List<stationXY> getStationCoordi(String jsonData) {
		List<stationXY> stationList = new ArrayList<stationXY>();
		try {
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonOb = (JSONObject) jsonParser.parse(jsonData);
			JSONArray docArray = (JSONArray) jsonOb.get("documents");

			for (int i = 0; i < docArray.size(); i++) {
				JSONObject docOb = (JSONObject) docArray.get(i);
				stcoor = new stationXY();
				stcoor.setSubName((String) docOb.get("place_name"));
				stcoor.setXs((String) docOb.get("x"));
				stcoor.setYs((String) docOb.get("y"));
				stationList.add(stcoor);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return stationList;
	}
}
