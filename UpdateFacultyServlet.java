package com.attendance.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.attendance.form.FacultyForm;
import com.attendance.service.AppService;


@WebServlet("/UpdateFacultyServlet")
public class UpdateFacultyServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		FacultyForm facultyForm=new FacultyForm();
				
		facultyForm.setQualification(request.getParameter("qualification"));
		facultyForm.setExperienceDetails(request.getParameter("experience"));
		facultyForm.setPhoneNumber(request.getParameter("phone"));
		facultyForm.setDescription(request.getParameter("description"));
		
		response.sendRedirect("updatefaculty.jsp?status="+AppService.updateFaculty(facultyForm));
	}
}
