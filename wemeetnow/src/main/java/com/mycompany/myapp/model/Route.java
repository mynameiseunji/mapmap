package com.mycompany.myapp.model;

public class Route {
	private String id;
	private String departure;
	private String bus_route;
	private String complex_route;
	private String bus_time;
	private String complex_time;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDeparture() {
		return departure;
	}
	public void setDeparture(String departure) {
		this.departure = departure;
	}
	public String getBus_route() {
		return bus_route;
	}
	public void setBus_route(String bus_route) {
		this.bus_route = bus_route;
	}
	public String getComplex_route() {
		return complex_route;
	}
	public void setComplex_route(String complex_route) {
		this.complex_route = complex_route;
	}
	public String getBus_time() {
		return bus_time;
	}
	public void setBus_time(String bus_time) {
		this.bus_time = bus_time;
	}
	public String getComplex_time() {
		return complex_time;
	}
	public void setComplex_time(String complex_time) {
		this.complex_time = complex_time;
	}
}
