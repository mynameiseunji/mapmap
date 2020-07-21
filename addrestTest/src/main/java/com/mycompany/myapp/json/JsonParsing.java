package com.mycompany.myapp.json;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

@Service
public class JsonParsing {
	public String getCoordi(String jsonData) {
		String XY=null;
		try {
			JSONParser jsonParser = new JSONParser();
			
			org.json.simple.JSONObject jsonOb = (JSONObject) jsonParser.parse(jsonData);
			
			JSONArray docArray =  (JSONArray) jsonOb.get("documents");
			
			for(int i=0; i<docArray.size(); i++) {
				JSONObject docOb = (JSONObject) docArray.get(i);
				XY = docOb.get("y") +" "+docOb.get("x");
				System.out.println(XY);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return XY;
	}
}
