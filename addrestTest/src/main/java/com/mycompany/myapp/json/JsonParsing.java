package com.mycompany.myapp.json;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.mycompany.myapp.model.Coordinate;
import com.mycompany.myapp.model.InputAddrs;

@Service("jsonParsing")
public class JsonParsing {
	private Coordinate coor = null;
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
}
