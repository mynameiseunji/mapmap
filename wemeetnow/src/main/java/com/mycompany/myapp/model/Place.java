package com.mycompany.myapp.model;

import java.io.Serializable;
import java.util.List;

public class Place implements Serializable{
	private String name;
	private String x;
	private String y;
	private String address;
	
	//출발지 주소 받아올때 controller에서 
	//리스트로 매핑받기 위해 필요함
	private List<Place> places;
	
	public List<Place> getPlaces() {
		return places;
	}
	public void setPlaces(List<Place> places) {
		this.places = places;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getX() {
		return x;
	}
	public void setX(String x) {
		this.x = x;
	}
	public String getY() {
		return y;
	}
	public void setY(String y) {
		this.y = y;
	}
	@Override
	public String toString() {
		return "Place [name=" + name + ", x=" + x + ", y=" + y + ", address=" + address + "]";
	}
	
	
	
}
