package com.attendance.util;

import java.util.Date;

public class Test {

	public static void main(String[] args) {
		
		Date d=new Date();
		
		System.out.println(d.getDate()+"\t"+(d.getMonth()+1)+"\t"+(d.getYear()+1900));
	}

}
