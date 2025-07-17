package com.attendance.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.attendance.form.FacultyForm;
import com.attendance.form.StudentForm;
import com.attendance.service.AppService;

public class AppDAO {

	static Connection con=MyConnection.getConnection();

	public static String isValidUser(String username,String password)
	{
		String result="";

		try {

			ResultSet rs=con.createStatement().executeQuery("select * from login where username='"+username+"' and password='"+password+"'");

			while (rs.next()) {

				result=rs.getString("role");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	public static int isUserRegistred(String username)
	{
		int result=0;

		try {

			ResultSet rs=con.createStatement().executeQuery("select count(*) from login where username='"+username+"'");

			while (rs.next()) {

				result=rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}
	public static int studentRegistration(StudentForm studentInfo)
	{
		int result=0;

		String role1="student";

		try
		{
			if(isUserRegistred(studentInfo.getRno())==0)
			{	

				String studentPassword=AppService.getGeneratedPassword();

				con.createStatement().executeUpdate("insert into login values('"+studentInfo.getRno()+"','"+studentPassword+"','"+role1+"')");

				String key="username :"+studentInfo.getRno()+"\t password :"+studentPassword;
			
				PreparedStatement ps=con.prepareStatement("insert into student values(?,?,?,?,?,?,?,?,?,?,?,?)");

				ps.setString(1,studentInfo.getRno());
				ps.setString(2,studentInfo.getName());

				SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
				Date date=sdf.parse(studentInfo.getDob());

				ps.setDate(3,new java.sql.Date(date.getTime()));

				ps.setString(4,studentInfo.getEmail());
				ps.setString(5,studentInfo.getPno());
				ps.setString(6,studentInfo.getAddress());
				ps.setString(7,studentInfo.getPhoto());
				ps.setString(8,studentInfo.getRegulation());
				ps.setString(9,studentInfo.getYearOfJoin());
				ps.setString(10,studentInfo.getCurrentSem());
				ps.setString(11,studentInfo.getBranch());
				ps.setString(12,studentInfo.getParrentEmail());

				result=ps.executeUpdate();
				
				try {
					System.out.println("before sending email");
					AppService.mailsend(key,studentInfo.getEmail());
					System.out.println("after email sent");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		} catch (Exception e) {

			e.printStackTrace();
		}

		return result;
	}

	public static int updateStudent(StudentForm studentForm)
	{
		int result=0;

		String sql="update student set pno=?,address=?,regulation=?,currentsem=?,photo=? where email=?";

		try {

			PreparedStatement ps=con.prepareStatement(sql);


			ps.setString(1,studentForm.getPno());
			ps.setString(2,studentForm.getAddress());
			ps.setString(3,studentForm.getRegulation());
			ps.setString(4,studentForm.getCurrentSem());
			ps.setString(5,studentForm.getPhoto());
			ps.setString(6,studentForm.getEmail());

			result=ps.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return result;
	}

	public static int facultyRegistration(FacultyForm facultyForm)
	{
		int result=0;

		System.out.println("in dao");


		try {

			if(isUserRegistred(facultyForm.getEmail())==0)
			{
				con.createStatement().executeUpdate("insert into login(username,password,role) values('"+facultyForm.getEmail()+"','"+facultyForm.getPassword()+"','"+facultyForm.getRole()+"')");

				PreparedStatement ps=con.prepareStatement("insert into faculty values(?,?,?,?,?,?,?)");

				ps.setString(1,facultyForm.getEmail());
				ps.setString(2,facultyForm.getFirstName());
				ps.setString(3,facultyForm.getLastName());
				ps.setString(4,facultyForm.getQualification());
				ps.setString(5,facultyForm.getExperienceDetails());
				ps.setString(6,facultyForm.getPhoneNumber());
				ps.setString(7,facultyForm.getDescription());

				result=ps.executeUpdate();
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return result;
	}

	public static int updateFaculty(FacultyForm facultyForm)
	{
		int result=0;

		String sql="update faculty set qualification=?,experiencedetails=?,phone=?,description=? where email=?";

		try {

			PreparedStatement ps=con.prepareStatement(sql);

			ps.setString(1,facultyForm.getQualification());
			ps.setString(2,facultyForm.getExperienceDetails());
			ps.setString(3,facultyForm.getPhoneNumber());
			ps.setString(4,facultyForm.getDescription());
			ps.setString(5,facultyForm.getEmail());

			result=ps.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return result;
	}

	public static String getRoleByUserName(String userName)
	{
		String role="";

		try {

			ResultSet rs=con.createStatement().executeQuery("select role from login where username='"+userName+"'");

			if (rs.next()) {

				role=rs.getString("role");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return role;
	}

	public static List<FacultyForm> getListOfFacultys()
	{
		List<FacultyForm> facultys=new ArrayList<FacultyForm>();

		try {

			ResultSet rs=con.createStatement().executeQuery("select * from faculty");

			while (rs.next()) {

				FacultyForm facultyForm=new FacultyForm();

				facultyForm.setFirstName(rs.getString("firstname"));
				facultyForm.setLastName(rs.getString("lastname"));
				facultyForm.setQualification(rs.getString("qualification"));
				facultyForm.setExperienceDetails(rs.getString("experiencedetails"));
				facultyForm.setPhoneNumber(rs.getString("phone"));
				facultyForm.setDescription(rs.getString("description"));
				facultyForm.setEmail(rs.getString("email"));

				facultys.add(facultyForm);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return facultys;
	}

	public static FacultyForm getFacultyByEmail(String email)
	{
		FacultyForm facultyForm=new FacultyForm();

		try {

			ResultSet rs=con.createStatement().executeQuery("select * from faculty where email='"+email+"'");

			if (rs.next()) {

				facultyForm.setFirstName(rs.getString("firstname"));
				facultyForm.setLastName(rs.getString("lastname"));
				facultyForm.setQualification(rs.getString("qualification"));
				facultyForm.setExperienceDetails(rs.getString("experiencedetails"));
				facultyForm.setPhoneNumber(rs.getString("phone"));
				facultyForm.setDescription(rs.getString("description"));
				facultyForm.setEmail(rs.getString("email"));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return facultyForm;
	}
	
	
	public static List<FacultyForm> getFacultyList()
	{
		List<FacultyForm> facultyForms=new ArrayList<FacultyForm>();

		try {

			ResultSet rs=con.createStatement().executeQuery("select * from faculty");

			while (rs.next()) {

				FacultyForm facultyForm=new FacultyForm();
				
				facultyForm.setFirstName(rs.getString("firstname"));
				facultyForm.setLastName(rs.getString("lastname"));
				facultyForm.setQualification(rs.getString("qualification"));
				facultyForm.setExperienceDetails(rs.getString("experiencedetails"));
				facultyForm.setPhoneNumber(rs.getString("phone"));
				facultyForm.setDescription(rs.getString("description"));
				facultyForm.setEmail(rs.getString("email"));
				
				facultyForms.add(facultyForm);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return facultyForms;
	}


	public static int deleteFaculty(String email)
	{
		int result=0;
		int result1=0;

		try {
			result1=con.createStatement().executeUpdate("delete from login where username='"+email+"'");

			PreparedStatement ps=con.prepareStatement("delete from faculty where email=?");
			ps.setString(1,email);

			result=ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		if(result==1 && result1==1)
		{
			return 1;
		}

		return 0;
	}

	public static int deleteStudent(String email)
	{
		int result=0;
		int result1=0;

		try {
			result1=con.createStatement().executeUpdate("delete from login where username='"+email+"'");

			PreparedStatement ps=con.prepareStatement("delete from student where email=?");
			ps.setString(1,email);

			result=ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		if(result==1 && result1==1)
		{
			return 1;
		}

		return 0;
	}

	public static int updatePassword(String email,String oldPassword,String newPassword)
	{
		int result=0;

		System.out.println(email+oldPassword+newPassword);

		try {
			PreparedStatement ps=con.prepareStatement("update login set password=? where username=? and password=?");
			ps.setString(1,newPassword);
			ps.setString(2,email);
			ps.setString(3,oldPassword);

			result=ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	public static StudentForm getStudentByRollNumber(String rollno)
	{
		StudentForm studentForm=new StudentForm();

		try {

			ResultSet rs=con.createStatement().executeQuery("select * from student where rollno='"+rollno+"'");

			while (rs.next()) {


				studentForm.setRno(rs.getString(1));
				studentForm.setName(rs.getString(2));
				studentForm.setDob(rs.getString(3));

				studentForm.setEmail(rs.getString(4));
				studentForm.setPno(rs.getString(5));
				studentForm.setAddress(rs.getString(6));
				studentForm.setPhoto(rs.getString(7));

				studentForm.setRegulation(rs.getString(8));
				studentForm.setYearOfJoin(rs.getString(9));
				studentForm.setCurrentSem(rs.getString(10));
				studentForm.setBranch(rs.getString(11));
				studentForm.setParrentEmail(rs.getString(12));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return studentForm;
	}

	public static List<StudentForm> getStudentByName(String name)
	{
		List<StudentForm> studentForms=new ArrayList<StudentForm>();

		System.out.println("in dao name is \t"+name);

		String sql="SELECT * FROM student WHERE name LIKE '%"+name+"%'";

		try {

			ResultSet rs=con.createStatement().executeQuery(sql);

			while (rs.next()) {

				System.out.println("in dao while");

				StudentForm studentForm=new StudentForm();

				studentForm.setRno(rs.getString(1));
				studentForm.setName(rs.getString(2));
				studentForm.setDob(rs.getString(3));

				studentForm.setEmail(rs.getString(4));
				studentForm.setPno(rs.getString(5));
				studentForm.setAddress(rs.getString(6));
				studentForm.setPhoto(rs.getString(7));

				studentForm.setRegulation(rs.getString(8));
				studentForm.setYearOfJoin(rs.getString(9));
				studentForm.setCurrentSem(rs.getString(10));
				studentForm.setBranch(rs.getString(11));
				studentForm.setParrentEmail(rs.getString(12));


				studentForms.add(studentForm);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		System.out.println("dao size is :\t"+studentForms.size());
		return studentForms;
	}

	public static List<StudentForm> getStudentByYear(int year)
	{
		List<StudentForm> studentForms=new ArrayList<StudentForm>();


		try {

			ResultSet rs=con.createStatement().executeQuery("SELECT * FROM student WHERE yearofjoin='"+year+"'");

			while (rs.next()) {

				StudentForm studentForm=new StudentForm();

				studentForm.setRno(rs.getString(1));
				studentForm.setName(rs.getString(2));
				studentForm.setDob(rs.getString(3));

				studentForm.setEmail(rs.getString(4));
				studentForm.setPno(rs.getString(5));
				studentForm.setAddress(rs.getString(6));
				studentForm.setPhoto(rs.getString(7));

				studentForm.setRegulation(rs.getString(8));
				studentForm.setYearOfJoin(rs.getString(9));
				studentForm.setCurrentSem(rs.getString(10));
				studentForm.setBranch(rs.getString(11));
				studentForm.setParrentEmail(rs.getString(12));


				studentForms.add(studentForm);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return studentForms;
	}
	public static List<StudentForm> getStudentByBranch(String branch)
	{
		List<StudentForm> studentForms=new ArrayList<StudentForm>();

		try {

			ResultSet rs=con.createStatement().executeQuery("SELECT * FROM student WHERE branch='"+branch+"'");

			while (rs.next()) {

				StudentForm studentForm=new StudentForm();

				studentForm.setRno(rs.getString(1));
				studentForm.setName(rs.getString(2));
				studentForm.setDob(rs.getString(3));

				studentForm.setEmail(rs.getString(4));
				studentForm.setPno(rs.getString(5));
				studentForm.setAddress(rs.getString(6));
				studentForm.setPhoto(rs.getString(7));

				studentForm.setRegulation(rs.getString(8));
				studentForm.setYearOfJoin(rs.getString(9));
				studentForm.setCurrentSem(rs.getString(10));
				studentForm.setBranch(rs.getString(11));
				studentForm.setParrentEmail(rs.getString(12));

				studentForms.add(studentForm);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return studentForms;
	}
	
	public static List<StudentForm> getStudentList()
	{
		List<StudentForm> studentForms=new ArrayList<StudentForm>();

		try {

			ResultSet rs=con.createStatement().executeQuery("SELECT * FROM student");

			while (rs.next()) {

				StudentForm studentForm=new StudentForm();

				studentForm.setRno(rs.getString(1));
				studentForm.setName(rs.getString(2));
				studentForm.setDob(rs.getString(3));

				studentForm.setEmail(rs.getString(4));
				studentForm.setPno(rs.getString(5));
				studentForm.setAddress(rs.getString(6));
				studentForm.setPhoto(rs.getString(7));

				studentForm.setRegulation(rs.getString(8));
				studentForm.setYearOfJoin(rs.getString(9));
				studentForm.setCurrentSem(rs.getString(10));
				studentForm.setBranch(rs.getString(11));
				studentForm.setParrentEmail(rs.getString(12));

				studentForms.add(studentForm);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return studentForms;
	}

	public static int isSubjectAdded(String subject)
	{
		int result=0;

		try {

			ResultSet rs=con.createStatement().executeQuery("select count(*) from subjects where subject='"+subject+"'");

			while (rs.next()) {

				result=rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	public static int addSubject(String subject)
	{
		int result=0;

		String stauts="no";

		try {
			if(isSubjectAdded(subject)==0)
			{
				return con.createStatement().executeUpdate("insert into subjects values('"+subject+"','"+stauts+"','"+stauts+"','"+stauts+"')");
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return result;
	}

	public static List<String> getSubjectsList()
	{
		List<String> subjects=new ArrayList<String>();

		try {

			ResultSet rs=con.createStatement().executeQuery("select subject from subjects");

			while(rs.next())
			{
				subjects.add(rs.getString("subject"));
			}


		} catch (Exception e) {

			e.printStackTrace();
		}

		return subjects;
	}

	public static int isSubjectAddedToSemester(String subject,String semester)
	{
		int result=0;

		try {

			ResultSet rs=con.createStatement().executeQuery("select count(*) from subjects where subject='"+subject+"' and semester='"+semester+"'");

			while (rs.next()) {

				result=rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		System.out.println("dao checking count");

		return result;
	}

	public static int addSubjectToSemister(String subject,String semester)
	{
		int result=0;

		String status="no";

		try {

			if(isSubjectAddedToSemester(subject, semester)==0)
			{
				return con.createStatement().executeUpdate("insert into subjects values('"+subject+"','"+semester+"','"+status+"','"+status+"')");
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return result;
	}


	public static List<String> getNonAssignedSemesterSubjectsList(String semester)
	{
		List<String> subjects=new ArrayList<String>();

		try {

			ResultSet rs=con.createStatement().executeQuery("select subject from subjects where semester!='"+semester+"'");

			while(rs.next())
			{
				subjects.add(rs.getString("subject"));
			}


		} catch (Exception e) {

			e.printStackTrace();
		}

		return subjects;
	}


	public static List<String> getNonAssignedSemesterSubjectsToFacultyList(String semester)
	{
		List<String> subjects=new ArrayList<String>();

		String status="no";
		try {

			ResultSet rs=con.createStatement().executeQuery("select subject from subjects where semester='"+semester+"' and facultyid='"+status+"'");

			while(rs.next())
			{
				subjects.add(rs.getString("subject"));
			}


		} catch (Exception e) {

			e.printStackTrace();
		}

		return subjects;
	}

	public static int isSubjectAssinged(String subject,String semester)
	{
		int result=0;

		String status="yes";

		try {

			ResultSet rs=con.createStatement().executeQuery("select count(*) from subjects where subject='"+subject+"' and semester='"+semester+"' and status='"+status+"'");

			while (rs.next()) {

				result=rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}
	public static int assingSubjectsToFaculty(String subject,String semester,String faultyId)
	{
		int result=0;

		String status="yes";

		try {

			if(isSubjectAssinged(subject, semester)==0)
			{
				return con.createStatement().executeUpdate("update subjects set facultyid='"+faultyId+"',status='"+status+"' where subject='"+subject+"' and semester='"+semester+"'");
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return result;
	}

	public static List<String> getSubjectsByFaculty(String facultyId)
	{
		List<String> subjects=new ArrayList<String>();

		String status="yes";

		try {

			ResultSet rs=con.createStatement().executeQuery("select distinct subject from subjects where facultyid='"+facultyId+"' and status='"+status+"'");
			
			subjects.add("");
			while(rs.next())
			{
				subjects.add(rs.getString("subject"));
			}


		} catch (Exception e) {

			e.printStackTrace();
		}

		return subjects;
	}


	public static List<String> getSemestersBySubject(String subject)
	{
		List<String> semesters=new ArrayList<String>();

		String status="yes";

		try {

			ResultSet rs=con.createStatement().executeQuery("select semester from subjects where subject='"+subject+"' and status='"+status+"'");

			while(rs.next())
			{
				semesters.add(rs.getString("semester"));
			}


		} catch (Exception e) {

			e.printStackTrace();
		}

		return semesters;
	}
	
	public static List<String> getRollNumbersBySubject(String subject)
	{
		List<String> rollNumbers=new ArrayList<String>();

		String status="yes";
		
		
		System.out.println("subject is :\t"+subject);
		
		try {
			
			String semester="";
			
			ResultSet rs=con.createStatement().executeQuery("select semester from subjects where subject='"+subject+"' and status='"+status+"'");

			if(rs.next())
			{
				semester=rs.getString("semester");
			}
			
			System.out.println("semester is :\t"+semester);
			
			ResultSet rs1=con.createStatement().executeQuery("select rollno from student where currentsem='"+semester+"'");

			while(rs1.next())
			{
				rollNumbers.add(rs1.getString("rollno"));
				
				System.out.println("roll number is :\t"+rollNumbers);
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return rollNumbers;
	}
	
	public static int deleteSubjectsToFaculty(String subject,String semister,String faultyId)
	{
		int result=0;

		String fId="no";
		String status="no";

		try {

			return con.createStatement().executeUpdate("update subjects set facultyid='"+fId+"',status='"+status+"' where subject='"+subject+"' and semester='"+semister+"' and facultyid='"+faultyId+"'");

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return result;
	}

	public static Map<String,String> getSubjectsBySemester(String semester)
	{
		System.out.println("semester is :\t"+semester);

		Map<String,String> subjects=new HashMap<String, String>();

		String status="yes";

		try {

			ResultSet rs=con.createStatement().executeQuery("select * from subjects where semester='"+semester+"' and status='"+status+"'");

			while(rs.next())
			{
				subjects.put(rs.getString("subject"),rs.getString("facultyid"));
			}


		} catch (Exception e) {

			e.printStackTrace();
		}

		return subjects;
	}
	
	public static List<String> getSubjectsByStudent(String rollNumber)
	{
		List<String> subjects=new ArrayList<String>();

		String status="yes";

		try {
			
			ResultSet rs=con.createStatement().executeQuery("select * from subjects where semester='"+getStudentByRollNumber(rollNumber).getCurrentSem()+"' and status='"+status+"'");

			while(rs.next())
			{
				subjects.add(rs.getString("subject"));
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return subjects;
	}
	
	public static int addAttendence(String[] roolNumbers,String subject)
	{
		int result=0;
		
		try {
			
			List<String> al=AppDAO.getRollNumbersBySubject(subject);
			
			PreparedStatement ps=con.prepareStatement("insert into attendancestatus values(?,?)");
			
			ps.setString(1,subject);
			
			Date d=new Date();
			
			ps.setString(2,d.getDate()+" "+(d.getMonth()+1)+" "+(d.getYear()+1900));
			
			ps.executeUpdate();
			
			for(String number : roolNumbers)
			{
				PreparedStatement ps1=con.prepareStatement("insert into attendance values(null,?,?,?,?)");
				
				ps1.setString(1,subject);
				ps1.setDate(2,new java.sql.Date(new Date().getTime()));
				ps1.setString(3,number);
				
				if(al.contains(number))
				{
					ps1.setInt(4,1);
				}
				else
				{
					ps1.setInt(4,0);
				}
				
				ps1.executeUpdate();
				
			}
			
			result=1;
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return result;
	}
	
	public static String isAttendanceSubmitted(String subject)
	{
		String status="no";
		
		try {
			
			PreparedStatement ps=con.prepareStatement("select count(*) from attendancestatus where subject=? and attendacedate=?");
			
			ps.setString(1,subject);
			
			Date d=new Date();
			ps.setString(2,d.getDate()+" "+(d.getMonth()+1)+" "+(d.getYear()+1900));
			
			ResultSet rs=ps.executeQuery();
			
			int count=0;
			
			while(rs.next())
			{
				count=rs.getInt(1);
			}
			
			if(count==1)
			{
				status="yes";
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return status;
	}
	
	public static float getStudentAttendancePercentage(String roolNumber)
	{
		float percentage=0;
		
		try
		{
			ResultSet rs=con.createStatement().executeQuery("select count(*) from attendance where rno='"+roolNumber+"'");
			
			int noOfTotalSessions=0;
			
			while(rs.next())
			{
				noOfTotalSessions=rs.getInt(1);
			}
			
			int present=1;
			
			ResultSet rs1=con.createStatement().executeQuery("select count(*) from attendance where rno='"+roolNumber+"' and status='"+present+"'");
			
			int noOfTotalAttendSessions=0;
			
			while(rs1.next())
			{
				noOfTotalAttendSessions=rs1.getInt(1);
			}
			
			
			System.out.println("no of total sessions :\t"+noOfTotalSessions);
			System.out.println("no of total attended sessions :\t"+noOfTotalAttendSessions);
			
			if(noOfTotalSessions!=0)
			{
				percentage=(noOfTotalAttendSessions/noOfTotalSessions)*100;
			}
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return percentage;
	}
	
	
	public static float getStudentAttendancePercentageBySubject(String roolNumber,String subject)
	{
		float percentage=0;
		
		System.out.println(subject+"\t"+roolNumber);
		
		try
		{
			ResultSet rs=con.createStatement().executeQuery("select count(*) from attendance where rno='"+roolNumber+"' and subject='"+subject+"'");
			
			int noOfTotalSessions=0;
			
			while(rs.next())
			{
				noOfTotalSessions=rs.getInt(1);
			}
			
			int present=1;
			
			ResultSet rs1=con.createStatement().executeQuery("select count(*) from attendance where rno='"+roolNumber+"' and status='"+present+"' and subject='"+subject+"'");
			
			int noOfTotalAttendSessions=0;
			
			while(rs1.next())
			{
				noOfTotalAttendSessions=rs1.getInt(1);
			}
			
			System.out.println("no of total subject sessions :\t"+noOfTotalSessions);
			System.out.println("no of total subject attended sessions :\t"+noOfTotalAttendSessions);
			
			if(noOfTotalSessions!=0)
			{
				percentage=(noOfTotalAttendSessions/noOfTotalSessions)*100;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return percentage;
	}
	
}
