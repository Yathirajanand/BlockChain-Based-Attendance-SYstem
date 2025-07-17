package com.attendance.service;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.attendance.dao.AppDAO;
import com.attendance.form.FacultyForm;
import com.attendance.form.StudentForm;

public class AppService {

	public static String studentRegistration(StudentForm studentForm)
	{
		String status="";
		
		int result=AppDAO.studentRegistration(studentForm);

		if(result==1)
		{	
			status="Success";
		}
		else
		{
			status="registration failed";
			
		}
		
		return status;
	}
	
	public static void mailsend(String key, String email ) throws MessagingException
	{
		System.out.println("in email");
		
		String host = "smtp.gmail.com";
		String from = "yathirajananda@gmail.com";
		String pass = "rexnfbzwcscfikko";

		Properties props = System.getProperties();

		props.put("mail.smtp.starttls.enable", "true"); // added this line
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.user", from);
		props.put("mail.smtp.password", pass);
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");

		String[] to = {email}; // added this line

		Session session = Session.getDefaultInstance(props, null);
		MimeMessage message = new MimeMessage(session);
		message.setFrom(new InternetAddress(from));

		InternetAddress[] toAddress = new InternetAddress[to.length];

		// To get the array of addresses

		for( int i=0; i < to.length; i++ ) 
		{ 
			// changed from a while loop
			toAddress[i] = new InternetAddress(to[i]);
		}
		
		for( int i=0; i < toAddress.length; i++)
		{ 
			// changed from a while loop
			message.addRecipient(Message.RecipientType.TO, toAddress[i]);
		}

		message.setSubject("Authentication Details of Attendance Application");
		message.setText("You access details \t:"+key);

		Transport transport = session.getTransport("smtp");

		transport.connect(host, from, pass);
		transport.sendMessage(message, message.getAllRecipients());

		transport.close();
	}
	
	public static String getGeneratedPassword()
	{
		Random r=new Random();
		String s="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
		return ""+s.charAt(r.nextInt(61))+s.charAt(r.nextInt(61))+s.charAt(r.nextInt(61))+s.charAt(r.nextInt(61))+s.charAt(r.nextInt(61));
	}
	
	public static  String facultyRegistration(FacultyForm facultyForm)
	{
		String status="";
		
		int result=AppDAO.facultyRegistration(facultyForm);
		
		if(result==1)
		{
			String key="username :"+facultyForm.getEmail()+"\t password :"+facultyForm.getPassword();
			try {
				System.out.println("mail sending...");
				mailsend(key,facultyForm.getEmail());
				System.out.println("mail sent");
			} catch (MessagingException e) {
				status="sending mail failed";
			}
			
			status="Success";
		}
		else
		{
			status="registration failed";
			
		}
		
		return status;

	}
		
	public static String updatePassword(String email,String oldPassword,String newPassword)
	{
		return AppDAO.updatePassword(email, oldPassword, newPassword)==1?"success":"enter valid password";
	}
	
	
	public static String updateFaculty(FacultyForm facultyForm)
	{
		return AppDAO.updateFaculty(facultyForm)==1?"success":"failed";
	}
	
	public static String updateStudent(StudentForm studentForm)
	{
		return AppDAO.updateStudent(studentForm)==1?"success":"failed";
	}
	
}
