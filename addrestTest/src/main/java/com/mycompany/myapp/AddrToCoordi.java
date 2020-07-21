package com.mycompany.myapp;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

import javax.xml.crypto.Data;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.myapp.json.JsonParsing;
import com.mycompany.myapp.service.service;
@Service
public class AddrToCoordi implements service {
	@Autowired
	private JsonParsing par = new JsonParsing();
	public String getCoordi(String location) {
	    HttpURLConnection conn = null;
	    StringBuilder sb = new StringBuilder();
	    try {
	        //URL 설정
//	    	location = new String(location.getBytes("UTF-8"));
	        URL url = new URL("https://dapi.kakao.com/v2/local/search/address.json?query="+URLEncoder.encode(location, "utf-8"));
	        
	        conn = (HttpURLConnection) url.openConnection();
	        //Request 형식 설정
	        conn.setRequestMethod("GET");
//	        conn.setRequestProperty("query", location);
	        conn.setRequestProperty("Authorization", "KakaoAK "+"cdca325d6efe88cfb6c48440908a80c2");
	        

	        //보내고 결과값 받기
	        int responseCode = conn.getResponseCode();
	        System.out.println(responseCode);
	        if (responseCode == 400) {
	            System.out.println("400:: 해당 명령을 실행할 수 없음 (실행할 수 없는 상태일 때, 엘리베이터 수와 Command 수가 일치하지 않을 때, 엘리베이터 정원을 초과하여 태울 때)");
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
	    return par.getCoordi(sb.toString());
	}

}
