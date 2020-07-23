package meetnow.service;

import java.util.List;

import meetnow.model.Coordinate;
import meetnow.model.stationXY;

public interface MapService {

	List<stationXY> getStationCoord(Coordinate coor);

}
