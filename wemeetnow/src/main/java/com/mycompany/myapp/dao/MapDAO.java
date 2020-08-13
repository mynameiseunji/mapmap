package com.mycompany.myapp.dao;

import com.mycompany.myapp.model.Route;
import com.mycompany.myapp.model.stationXY;

public interface MapDAO {
	public stationXY getRcm_station(String subname) throws Exception;

	public int insertData(Route route);
	
	public Route routeSearch(String id);

}
