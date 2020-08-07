package com.mycompany.myapp.service;

public class SearchMethodTest {

	public static void main(String[] args) {
		MapServiceImpl ms = new MapServiceImpl();
		System.out.println(ms.addressSearch("공항대로 58가길16").toString());
	}
}
