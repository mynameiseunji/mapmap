package com.mycompany.myapp.service;


import java.util.List;

import com.mycompany.myapp.model.Coordinate;



public interface MapService {

	List<com.mycompany.myapp.model.stationXY> getStationCoord(Coordinate coor);
	public Coordinate getCenter(String[] x, String[] y);

}
