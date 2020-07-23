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

	// �߰� xy��ǥ ������
	@RequestMapping("getXY.do")
	public String getXY(Model model) {
		Coordinate coor = new Coordinate();
		coor.setX("33.450701");
		coor.setY("126.570667");
		model.addAttribute("coor", coor);
		return "showxy";
	}
	
	//DTO ����Ʈ ���·� ��ȯ (��� �׽�Ʈ��)
	//����� ����ö �� ����Ʈ ��������
	@RequestMapping("getstationcoord.do")
	public String getStationCoord(@ModelAttribute Coordinate coor, Model model) {
		System.out.println("�Դ�!"+coor.getX()+", "+coor.getY());
		List<stationXY> stationList = ms.getStationCoord(coor);
		model.addAttribute("stationList", stationList);
		return "foundplace";
	}

}
