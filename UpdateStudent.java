package com.attendance.servlet;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.attendance.form.StudentForm;
import com.attendance.service.AppService;
import com.attendance.util.AppUtil;

@WebServlet("/updatestudent")
public class UpdateStudent extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
  
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		StudentForm studentForm=new StudentForm();
		
		boolean isUploaded = false;
	
		// Check that we have a file upload request
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	
		if(isMultipart) {
			// Create a factory for disk-based file items
			FileItemFactory factory = new DiskFileItemFactory();
		
			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
	
			try {
				
					// Parse the request
					List<FileItem> items = upload.parseRequest(request);
					
					for (FileItem item : items)
					{
					// processes only fields that are not form fields
					
						if (!item.isFormField()) {
						//this will be true if file field is found in the List
						
							studentForm.setPhoto(item.getName());
							
							try {
								 File savedFile = new File(AppUtil.IMAGE_PATH+studentForm.getPhoto());
								 item.write(savedFile);
								 isUploaded = true;
							} catch(Exception e) {
								e.printStackTrace();
								isUploaded = false;
						    }
						}
						else
						{
							String fieldname = item.getFieldName();
							//System.out.print("FieldName : "+fieldname);
							String fieldvalue = item.getString();
							//System.out.println(" Value: "+fieldvalue);
							
							
							Method[] methods=StudentForm.class.getDeclaredMethods();
							
							for(Method method : methods)
							{
								String methodName=method.getName();
								
								if(methodName.equalsIgnoreCase("set"+fieldname))
								{
									try {
										method.setAccessible(true);
										method.invoke(studentForm,fieldvalue);
									} catch (IllegalAccessException e) {
										e.printStackTrace();
									} catch (IllegalArgumentException e) {
										e.printStackTrace();
									} catch (InvocationTargetException e) {
										e.printStackTrace();
									}
								}
							}
						}
					}
			}//try
			catch (FileUploadException e) {
					e.printStackTrace();
			} 
			
			if(isUploaded)
			{
				response.sendRedirect("studenteditprofile.jsp?status="+AppService.updateStudent(studentForm));
			}
			else
			{
				response.sendRedirect("studenteditprofile.jsp?status=going wrong while uploading file");
			}
	    }
	}

}
