package com.mycompany.myapp.service;


import java.util.List;

import com.mycompany.myapp.model.Coordinate;
import com.mycompany.myapp.model.stationXY;



public interface MapService {

	List<stationXY> getStationCoord(Coordinate coor);
	public Coordinate getCenter(String[] x, String[] y);

}
