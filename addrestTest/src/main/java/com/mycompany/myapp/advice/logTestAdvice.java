package com.mycompany.myapp.advice;

import org.springframework.stereotype.Component;

public class logTestAdvice {
	public logTestAdvice() {
		System.out.println("=======================================");
		System.out.println("=======================================");
		System.out.println("=======================================");
		System.out.println("=======================================");
		System.out.println("=======================================");		
		System.out.println("무사히 객체 생성");
	}
	public void printLog() {
		System.out.println("=======================================");
		System.out.println("aop test");
		System.out.println("servlet-context.xml에 <aop:config> 환경 설정");
		System.out.println();
		System.out.println("adressSearch(..)");
		System.out.println("keywordSearch(..)");
		System.out.println("categorySearch(..)");
		System.out.println("메소드가 사용될때");
		System.out.println("콘솔에 log 출력");
		System.out.println("aop test");
		System.out.println("aop test");
		System.out.println("aop test");
		System.out.println("=======================================");
	}
}
