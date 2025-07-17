package com.attendance.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.attendance.dao.AppDAO;
import com.attendance.service.AppService;

@WebServlet("/UpdatePassword")
public class UpdatePassword extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String email=(String) request.getSession().getAttribute("username");
		String oldpassword=request.getParameter("oldpassword");
		String newpassword=request.getParameter("newpassword");
		
		System.out.println("inservlet ");

		String role=AppDAO.getRoleByUserName(email);

		String status=AppService.updatePassword(email, oldpassword,newpassword);

		if(role.equals("admin"))
		{
			response.sendRedirect("adminchangepassword.jsp?status="+status);
		}
		else
		{
			if(role.equals("faculty"))
			{
				response.sendRedirect("facultychangepassword.jsp?status="+status);
			}
			else
			{
				if(role.equals("student"))
				{
					response.sendRedirect("studentchangepassword.jsp?status="+status);
				}
			}
		}
	}

}
