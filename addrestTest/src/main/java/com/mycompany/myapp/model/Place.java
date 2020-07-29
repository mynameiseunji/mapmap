package com.mycompany.myapp.model;

public class Place {
	private String name;
	private String x;
	private String y;
	private String adress;
	
	public String getAdress() {
		return adress;
	}
	public void setAdress(String adress) {
		this.adress = adress;
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
		return "Place [name=" + name + ", x=" + x + ", y=" + y + ", adress=" + adress + "]";
	}
	
	
	
}
