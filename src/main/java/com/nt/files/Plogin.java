package com.nt.files;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class Plogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String connectionUrl = "jdbc:oracle:thin:@localhost:1521:orcl";
		String userId = "mydb6pm";
		String password = "sam";
		String pwdd=null;
		String pname=request.getParameter("uname");
		String psswd=request.getParameter("pwd");
		String name=null;
		PrintWriter pw=response.getWriter();
		try {
			Class.forName(driverName);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		try {
			String sql = "SELECT password FROM patients_info WHERE name = ?";
			Connection con = DriverManager.getConnection(connectionUrl, userId, password);
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1,pname);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
			    pwdd = rs.getString("password");
			}
		if(psswd.equalsIgnoreCase(pwdd))
		{	
			session.setAttribute("Name",pname);
			request.getRequestDispatcher("patientpage.jsp").forward(request, response);
		}
	
		else {
			request.setAttribute("error", "Invalid username/password.");
			request.getRequestDispatcher("plogin.jsp").forward(request, response);
	}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}

}
