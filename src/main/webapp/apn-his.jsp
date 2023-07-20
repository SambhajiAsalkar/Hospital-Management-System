
<!DOCTYPE html>
<%@page import="org.apache.tomcat.dbcp.dbcp2.PStmtKey"%>
<%@page import="java.sql.PreparedStatement"%>
<html lang="en">
	<head>
		<title>Appointments</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta content="" name="description" />
		<meta content="" name="author" />
		<link href="http://fonts.googleapis.com/css?family=Lato:300,400,400italic,600,700|Raleway:300,400,500,600,700|Crete+Round:400italic" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="vendor/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="vendor/themify-icons/themify-icons.min.css">
		<link href="vendor/animate.css/animate.min.css" rel="stylesheet" media="screen">
		<link href="vendor/perfect-scrollbar/perfect-scrollbar.min.css" rel="stylesheet" media="screen">
		<link href="vendor/switchery/switchery.min.css" rel="stylesheet" media="screen">
		<link href="vendor/bootstrap-touchspin/jquery.bootstrap-touchspin.min.css" rel="stylesheet" media="screen">
		<link href="vendor/select2/select2.min.css" rel="stylesheet" media="screen">
		<link href="vendor/bootstrap-datepicker/bootstrap-datepicker3.standalone.min.css" rel="stylesheet" media="screen">
		<link href="vendor/bootstrap-timepicker/bootstrap-timepicker.min.css" rel="stylesheet" media="screen">
		<link rel="stylesheet" href="assets/css/styles.css">
		<link rel="stylesheet" href="assets/css/plugins.css">
		<link rel="stylesheet" href="assets/css/themes/theme-1.css" id="skin_color" />
	</head>
	<body style="background-image:url(https://www.elegantthemes.com/blog/wp-content/uploads/2013/09/bg-9-full.jpg)">
	<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
String driverName = "oracle.jdbc.driver.OracleDriver";
String connectionUrl = "jdbc:oracle:thin:@localhost:1521:orcl";
String userId = "mydb6pm";
String password = "sam";
String sql="";
String del="DELETE FROM apn_info where pname=?";
Connection connection = null;
PreparedStatement pstmt = null;
ResultSet resultSet = null;
try {
  Class.forName(driverName);
  connection = DriverManager.getConnection(connectionUrl, userId, password);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
int id=Integer.parseInt(request.getParameter("id"));
if(id==1)
{ 
sql ="SELECT * FROM apn_info";
pstmt = connection.prepareStatement(sql);
}
else if(id==2){
	String name=(String)session.getAttribute("Name");
	sql ="SELECT * FROM apn_info where dname=?";
	pstmt=connection.prepareStatement(sql);
	pstmt.setString(1,name);
}
else {
	String name=(String)session.getAttribute("Name");
	sql ="SELECT * FROM apn_info where pname=?";
	pstmt=connection.prepareStatement(sql);
	pstmt.setString(1,name);
}

%>
		<div id="app">		
			<div class="app-content">
				
						
				<!-- end: TOP NAVBAR -->
				<div class="main-content" >
					<div class="wrap-content container" id="container">
						<!-- start: PAGE TITLE -->
						<section id="page-title">
							<div class="row">
								<div class="col-sm-8">
									<h1 class="mainTitle">Manage Appointments</h1>
																	</div>
						</div>
						</section>
						<!-- end: PAGE TITLE -->
						<!-- start: BASIC EXAMPLE -->
						<div class="container-fluid container-fullw bg-white">
						
							<div class="row">
								<div class="col-md-12">
									<h5 class="over-title margin-bottom-15">Appointments <span class="text-bold">History</span></h5>
									<p style="color:red;">
									<table class="table table-hover" id="sample-table-1">
										<thead>
											<tr>
											
											
	<th><b>Patient Name</b></th>				
	<th><b>Doctor Name</b></th>
	<th><b>Specialization</b></th>	
	<th><b>Date</b></th>	
	<th><b>Time</b></th>
	
											</tr>
<%
try{ 
	
resultSet = pstmt.executeQuery();
while(resultSet.next()){
%>
</thead>
<tbody>
<tr>

<td><%=resultSet.getString("pname") %></td>
<td><%=resultSet.getString("dname") %></td>
<td><%=resultSet.getString("spec") %></td>
<td><%=resultSet.getString("apdate") %></td>
<td><%=resultSet.getString("aptime")%></td>
<td><a href="delptnt.jsp?uname='<%=resultSet.getString("pname")%>'">Delete</a></td>							
</tr>
<% 
}

} catch (Exception e) {
e.printStackTrace();
System.out.println("asasdf");
}
%>
											
										</tbody>
									</table>
								</div>
							</div>
								</div>
							</div>
						</div>
						
					</div>
				</div>
			</div>
		
	</body>
</html>
