package com.attendance.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.attendance.dao.AppDAO;
import com.google.gson.Gson;


@WebServlet("/GetFacultySubjectAutoCompleteServlet")
public class GetFacultySubjectAutoCompleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String semesterName = request.getParameter("semesterName");
		
		System.out.println("semester name :\t"+semesterName);
		
		List<String> list = AppDAO.getSubjectsByFaculty(semesterName);
		
		System.out.println(list);
		
		String json = new Gson().toJson(list);
		
		response.setContentType("application/json");
		
		response.getWriter().write(json);
	}
}

