package com.mycompany.myapp.dao;

import java.util.List;

import com.mycompany.myapp.model.Place;
import com.mycompany.myapp.model.Route;
import com.mycompany.myapp.model.RouteM;
import com.mycompany.myapp.model.RouteS;
import com.mycompany.myapp.model.stationXY;

public interface MapDAO {
	public stationXY getRcm_station(String subname) throws Exception;

	public int insertData(Route route);
	
	public RouteM routeSearch(String id);

//	public int idCheck(String id);

	public int insertRouteM(RouteM rm);

	public int insertRouteS(RouteS rs);

	public List<RouteM> getRouteList(RouteM r);

}
