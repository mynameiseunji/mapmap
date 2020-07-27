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
	private JsonParsing par;
	//= new JsonParsing();

	// REST API�� ��û�ؼ� json ���� ������ �޾ƿ� �κ�
	@Override
	public List<stationXY> getStationCoord(Coordinate coor) {
		HttpURLConnection conn = null;
		StringBuilder sb = new StringBuilder();
		try {
			// URL ����
//	    	location = new String(location.getBytes("UTF-8"));
//			URL url = new
//			URL("https://dapi.kakao.com/v2/local/search/address.json?query="+URLEncoder.encode(location, "utf-8"));

			String base_url = "https://dapi.kakao.com/v2/local/search/category.json";
			String Authorization = "KakaoAK " + "cdca325d6efe88cfb6c48440908a80c2";
			String category_group_code = "SW8"; // ����ö �� ī�װ��� �˻��ϱ� ���� �ڵ�
			String x = coor.getX();
			String y = coor.getY();
			String page = "1"; //������ �� ����
			String size ="10"; //�������� �˻� ���� ����
			String radius = "2000"; // �˻� �ݰ� ���Ƿ� ����(0~2000���� ��������)

			String findStationList = base_url + "?category_group_code=" + category_group_code + "&x=" + x + "&y=" + y
					+ "&radius=" + radius+ "&page="+page+"&size="+size+"&sort=distance";
			//�ּ� Ȯ�ο� ����� �ڵ�
			System.out.println(findStationList);
			URL url = new URL(findStationList);
			conn = (HttpURLConnection) url.openConnection();
			// Request ���� ����
			conn.setRequestMethod("GET");
			// Ű �Է�
			conn.setRequestProperty("Authorization", Authorization);

			// ������ ����� �ޱ�
			// ��� ���� Ȯ�� �ڵ�.
			int responseCode = conn.getResponseCode();
			System.out.println(responseCode);
			if (responseCode == 400) {
				System.out.println(
						"400:: �ش� ����� ������ �� ���� (������ �� ���� ������ ��, ���������� ���� Command ���� ��ġ���� ���� ��, ���������� ������ �ʰ��Ͽ� �¿� ��)");
			} else if (responseCode == 401) {
				System.out.println("401:: X-Auth-Token Header�� �߸���");
			} else if (responseCode == 500) {
				System.out.println("500:: ���� ����, ���� �ʿ�");
			} else { // ���� �� ���� JSON �����͹ޱ�
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
	
	//�߽� ��ǥ ���ϱ�.
	// ����� ��ǥ ���� ���.
	public Coordinate getCenter(String[] x, String[] y) {
		Coordinate coor = new Coordinate();
		double n = (double)x.length;
		double sumX =0;
		double sumY =0;
		for(int i=0; i<x.length; i++) {
			sumX+=Double.parseDouble(x[i]);
			sumY+=Double.parseDouble(y[i]);
		}
		coor.setX(Double.toString(sumX/n));
		coor.setY(Double.toString(sumY/n));
		return coor;
	}
}
