package com.mycompany.myapp.advice;

import org.springframework.stereotype.Component;

public class logTestAdvice {
	public logTestAdvice() {
		System.out.println("=======================================");
		System.out.println("=======================================");
		System.out.println("=======================================");
		System.out.println("=======================================");
		System.out.println("=======================================");		
		System.out.println("������ ��ü ����");
	}
	public void printLog() {
		System.out.println("=======================================");
		System.out.println("aop test");
		System.out.println("servlet-context.xml�� <aop:config> ȯ�� ����");
		System.out.println();
		System.out.println("adressSearch(..)");
		System.out.println("keywordSearch(..)");
		System.out.println("categorySearch(..)");
		System.out.println("�޼ҵ尡 ���ɶ�");
		System.out.println("�ֿܼ� log ���");
		System.out.println("aop test");
		System.out.println("aop test");
		System.out.println("aop test");
		System.out.println("=======================================");
	}
}