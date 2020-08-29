package com.mycompany.myapp.service;

import java.util.List;

import com.mycompany.myapp.model.Coordinate;
import com.mycompany.myapp.model.Place;
import com.mycompany.myapp.model.Route;
import com.mycompany.myapp.model.stationXY;

public interface MapService {
	public List<Place> categorySearch(String categoryCode);

	public List<Place> categorySearch(String categoryCode, String option);

	public List<Place> keywordSearch(String query);

	public List<Place> keywordSearch(String query, String option);

	public List<Place> addressSearch(String address);

	public List<Place> addressSearch(String address, String option);

	public List<Place> getStationCoord(String url_, String options);

	public Place getCenter(List<Place> placeList);

	public stationXY getRcm_station(String subName) throws Exception;
	
	public String getPathInfo(List<Place> startPlaceList, List<Place> endPlaceList,String transport);
	public String getFinalPath(List<Place> startPlaceList, Place endPlace, String transport);

	public int finalDBSetting(List<Place> startPlaceList, Place endPlace, String id);

	public Route routeSearch(String id);

	public String[] parsingRoute(String bus_route);

	public void createId(List<Place> list, String spl);

	public boolean idCheck(String id);
}
