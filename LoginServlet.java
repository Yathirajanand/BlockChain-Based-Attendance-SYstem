package com.attendance.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.attendance.dao.AppDAO;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String email=request.getParameter("email");

		String status=AppDAO.isValidUser(email,request.getParameter("password"));

		request.getSession().setAttribute("username",email);

		if(status.equals("admin"))
		{
			response.sendRedirect("adminhome.jsp");
		}
		else
		{
			if(status.equals("faculty"))
			{
				response.sendRedirect("facultyhome.jsp");
			}
			else
			{
				if(status.equals("student"))
				{
					response.sendRedirect("studenthome.jsp");
				}

				else
				{
					response.sendRedirect("index.jsp?status=Invalid Username and Password");
				}
			}
		}
	}
}
