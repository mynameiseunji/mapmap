package com.mycompany.myapp.model;

public class Place {
	private String subName;
	private String xs;
	private String ys;
	private String adress;
	
	public String getAdress() {
		return adress;
	}
	public void setAdress(String adress) {
		this.adress = adress;
	}
	public String getSubName() {
		return subName;
	}
	public void setSubName(String subName) {
		this.subName = subName;
	}
	public String getXs() {
		return xs;
	}
	public void setXs(String xs) {
		this.xs = xs;
	}
	public String getYs() {
		return ys;
	}
	public void setYs(String ys) {
		this.ys = ys;
	}
	@Override
	public String toString() {
		return "Place [subName=" + subName + ", xs=" + xs + ", ys=" + ys + ", adress=" + adress + "]";
	}
	
	
}
