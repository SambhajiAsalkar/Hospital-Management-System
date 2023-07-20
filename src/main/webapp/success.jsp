<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>S.U.C.C.E.S.S</title>
</head>
<body>
    <%
        String pswd = request.getParameter("pwd");
        String country = request.getParameter("country");
        String aadhar = request.getParameter("aadhar");
        String locality = request.getParameter("area");
        String street = request.getParameter("street");
        String pemail = request.getParameter("pemail");
        String pno = request.getParameter("pno");
        String state = request.getParameter("state");
        String name = request.getParameter("name");

        try {
            String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:orcl";
            String dbUser = "mydb6pm";
            String dbPassword = "sam";
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Use prepared statement to avoid SQL injection
            String sql = "INSERT INTO patients_info (name, pemail, pno, street, locality, aadhar, state, country, pswd) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, pemail);
            ps.setString(3, pno);
            ps.setString(4, street);
            ps.setString(5, locality);
            ps.setString(6, aadhar);
            ps.setString(7, state);
            ps.setString(8, country);
            ps.setString(9, pswd);

            int rowsInserted = ps.executeUpdate();
            ps.close();
            con.close();

            if (rowsInserted > 0) {
    %>
            <b><center>Success</center></b><br>
    <%
            } else {
    %>
            <b><center>Failed to insert data.</center></b><br>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
    %>
            <b><center><b style="color: red;">Please fill all fields</b></center></b><br>
    <%
        }
    %>
        <center><a href="newuser.html">Back</a></center><br>
    <center><a href="index.jsp">Home</a></center>
</body>
</html>
