package com.mycompany.myapp.service;

import com.mycompany.myapp.model.InputAddrs;

public class AddrArray {
	public int getCnt(InputAddrs ipa) {
		if(ipa.getAddr1()==null)
			return 0;
		if(ipa.getAddr2()==null)
			return 1;
		if(ipa.getAddr3()==null)
			return 2;
		if(ipa.getAddr4()==null)
			return 3;
		if(ipa.getAddr5()==null)
			return 4;
		if(ipa.getAddr6()==null)
			return 5;
		if(ipa.getAddr7()==null)
			return 6;
		if(ipa.getAddr8()==null)
			return 7;
		if(ipa.getAddr9()==null)
			return 8;
		if(ipa.getAddr10()==null)
			return 9;
		return 10;
	}
	public String[] toArray(InputAddrs ipa) {
		int len ;
		ipa.setCnt(len=this.getCnt(ipa));
		String[] strArr = new String[len];
		if(ipa.getAddr1()!=null)
			strArr[0] = ipa.getAddr1();
		if(ipa.getAddr2()!=null)
			strArr[1] = ipa.getAddr2();
		if(ipa.getAddr3()!=null)
			strArr[2] = ipa.getAddr3();
		if(ipa.getAddr4()!=null)
			strArr[3] = ipa.getAddr4();
		if(ipa.getAddr5()!=null)
			strArr[4] = ipa.getAddr5();
		if(ipa.getAddr6()!=null)
			strArr[5] = ipa.getAddr6();
		if(ipa.getAddr7()!=null)
			strArr[6] = ipa.getAddr7();
		if(ipa.getAddr8()!=null)
			strArr[7] = ipa.getAddr8();
		if(ipa.getAddr9()!=null)
			strArr[8] = ipa.getAddr9();
		if(ipa.getAddr10()!=null)
			strArr[9] = ipa.getAddr10();
		
		return strArr;
	}
}
