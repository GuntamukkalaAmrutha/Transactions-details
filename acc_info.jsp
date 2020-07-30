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
<title>Account Info</title>
</head>
<body>
<% String url = "jdbc:mysql://localhost:3306/bank";
String username = "root";
String password = "root";
try
{
Class.forName("com.mysql.jdbc.Driver");
}
catch (Exception e)
{

e.printStackTrace();
}
%>
<table align="center" border = "1" bgcolor = "">
<tr>
<td>Credit</td>
<td>Debit</td>
<td>Transaction id</td>
<td>Balance</td>

</tr>
<%
try
{
Connection con = DriverManager.getConnection(url,username,password);
PreparedStatement ps = con.prepareStatement("select coalesce(credit,0) as credit,coalesce(debit,0) as debit,trans_id, balance from acc_trans order by trans_id desc limit 5");
ResultSet rs = ps.executeQuery();
PreparedStatement ps2 = con.prepareStatement("select balance from account_transactions order by trans_id desc limit 1");
ResultSet res = ps2.executeQuery();
while(rs.next()){
%>
<tr>

<td> <%=rs.getString("credit") %> </td>
<td> <%=rs.getString("debit") %> </td>
<td> <%=rs.getString("trans_id") %></td>
<td> <%=rs.getString("balance") %></td>
</tr>

<% 
}
rs.close();
if(res.next()){
%>
<h3 align = "center">Balance: <%= res.getInt("balance") %></h3>
<%
}
Integer bal = (Integer)res.getInt("balance");
res.close();
con.close();
HttpSession session = request.getSession();
session.setAttribute("balance", bal);
//RequestDispatcher dispatcher = request.getRequestDispatcher("debit.jsp");
//dispatcher.forward(request, response);
//System.out.print(bal);
}
catch (Exception e)
{

e.printStackTrace();
}
%>
</table><br><br>
<div style="text-align:center">
<form action = "debit.jsp" method = "get">
<button type="submit">Debit</button>
</form>

</div>
</body>
</html>
