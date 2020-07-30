<%@ page language="java" session="false" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import = "java.sql.DriverManager" %>
    <%@ page import = "java.sql.Connection" %>
    <%@ page import = "java.sql.PreparedStatement" %>
    <%@ page import = "java.sql.ResultSet" %>
    <%@ page import = "java.lang.String" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Success</title>
</head>
<body>
<% String url = "jdbc:mysql://localhost:3306/bank";
String username = "root";
String password = "root";
HttpSession session = request.getSession();
int bal = (int)session.getAttribute("balance");
try
{
if(bal>0)
bal = bal-1000;
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(url,username,password);
PreparedStatement ps = con.prepareStatement("insert into account_transactions(debit,credit,balance) values(?,?,?)");
ps.setInt(1, 1000);
ps.setInt(2,0);
ps.setInt(3,bal);
ps.executeUpdate();
con.close();
}

catch (Exception e)
{

e.printStackTrace();
}
finally
{
response.sendRedirect("acc_info.jsp");
}
//System.out.print();
%>
<table align="center" border = "1" bgcolor = "">
<tr>
<td><%= session.getAttribute("balance") %></td>
</tr>
</table>
</body>
</html>
