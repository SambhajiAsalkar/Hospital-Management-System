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


public class Doclogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String connectionUrl = "jdbc:oracle:thin:@localhost:1521:orcl";
		String userId = "mydb6pm";
		String password = "sam";
		String pwdd=null;
		String dname=request.getParameter("uname");
		String psswd=request.getParameter("pwd");
		String name=null;
		
		try {
			Class.forName(driverName);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		try {
			String sql = "SELECT * FROM doc_info WHERE dname = ?";
			Connection con = DriverManager.getConnection(connectionUrl, userId, password);
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dname);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
			    pwdd = rs.getString(3);
			    name = rs.getString(1);
			}
		if(psswd.equalsIgnoreCase(pwdd)&&dname.equalsIgnoreCase(name))
		{	session.setAttribute("Name",dname);
			request.getRequestDispatcher("docpage.jsp").forward(request, response);
		}
	
		else {
			request.setAttribute("error", "Invalid username/password.");
			request.getRequestDispatcher("Doclogin.jsp").forward(request, response);
	}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}

}
