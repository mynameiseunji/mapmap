package meetnow.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import meetnow.model.Coordinate;
import meetnow.model.stationXY;
import meetnow.service.MapService;

@Controller
public class MapController {
	@Autowired
	private MapService ms;

	// 중간 xy좌표 얻어오기
	@RequestMapping("getXY.do")
	public String getXY(Model model) {
		Coordinate coor = new Coordinate();
		coor.setX("33.450701");
		coor.setY("126.570667");
		model.addAttribute("coor", coor);
		return "showxy";
	}
	
	//DTO 리스트 형태로 변환 (출력 테스트용)
	//가까운 지하철 역 리스트 가져오기
	@RequestMapping("getstationcoord.do")
	public String getStationCoord(@ModelAttribute Coordinate coor, Model model) {
		System.out.println("왔다!"+coor.getX()+", "+coor.getY());
		List<stationXY> stationList = ms.getStationCoord(coor);
		model.addAttribute("stationList", stationList);
		return "foundplace";
	}

}
