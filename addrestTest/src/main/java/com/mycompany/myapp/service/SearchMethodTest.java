package com.mycompany.myapp.service;

public class SearchMethodTest {

	public static void main(String[] args) {
		MapServiceImpl ms = new MapServiceImpl();
		System.out.println(ms.addressSearch("서울 중구 회현동2가 86").toString());

	}

}
