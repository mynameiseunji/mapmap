package meetnow.service;

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

import meetnow.json.JsonParsing;
import meetnow.model.Coordinate;
import meetnow.model.stationXY;

@Service
public class MapServiceImpl implements MapService {

	@Autowired
	private JsonParsing par = new JsonParsing();

	// REST API�� ��û�ؼ� json ���� ������ �޾ƿ� �κ�
	@Override
	public List<stationXY> getStationCoord(Coordinate coor) {
		HttpURLConnection conn = null;
		StringBuilder sb = new StringBuilder();
		try {
			// URL ����
//	    	location = new String(location.getBytes("UTF-8"));
			// URL url = new
			// URL("https://dapi.kakao.com/v2/local/search/address.json?query="+URLEncoder.encode(location, "utf-8"));

			String base_url = "https://dapi.kakao.com/v2/local/search/keyword.json";
			String Authorization = "KakaoAK " + "cdca325d6efe88cfb6c48440908a80c2";
			String query = "��"; //�ʼ�
			String category_group_code = "SW8"; // ����ö �� ī�װ��� �˻��ϱ� ���� �ڵ�
			String x = coor.getX();
			String y = coor.getY();
			String radius = "20000"; // �˻� �ݰ� ���Ƿ� ����(0~20000���� ��������)

			String findStationList = base_url + "?query="+URLEncoder.encode(query, "utf-8")+"&category_group_code=" + category_group_code + "&x=" + x + "&y=" + y
					+ "&radius=" + radius;
			//�ּ� Ȯ�ο� ����� �ڵ�
			System.out.println(findStationList);
			URL url = new URL(findStationList);
			conn = (HttpURLConnection) url.openConnection();
			// Request ���� ����
			conn.setRequestMethod("GET");
			// Ű �Է�
			conn.setRequestProperty("Authorization", Authorization);

			// ������ ����� �ޱ�
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

}
