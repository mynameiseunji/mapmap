package com.mycompany.myapp.dao;

import com.mycompany.myapp.model.stationXY;

public interface MapDAO {
	public stationXY getRcm_station(String subname) throws Exception;

}
