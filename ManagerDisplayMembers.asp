<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="styles.css" > 
<!--Changeging the icon to the restaurant's icon -->        
<link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - About</title>
<style type="text/css">

.col
{
	color:Red
}

</style>

<%

dim Con, rs, sql
CNButton = request.Form("CM")
Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")

Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))

sql = "SELECT * FROM Customer"

rs.Open sql, Con

If CNButton <> "" then 
response.Redirect("ManagerCancelMembers.asp")
End if




%>
</head>

<body>

<div class="container">
  <div class="content">
  <center><img src="images/logo.png" /></center>
    <hr />
               <center><font size ="5"><a href="ManagerDailyOrders.asp">Daily Orders</a> | <a href="ManagerMonthlyOrders.asp">Monthly Orders</a> | <a href="ManagerCalculateProfit.asp">Calculate Profit</a> | <a href="ManagerMonthlyAnalysis.asp">Chart Order Analysis</a> | <a href="ManagerOrderAnalysis.asp">Monthly Orders Analysis</a> |<a href="ManagerDisplayMembers.asp"> Cancel Members</a> | <a href="ManagerChangeMenu.asp">Change Menu</a> | <a href="ManagerAddstaff.asp">Add staff</a> | <a href="ManagerChangePasswords.asp">Change passwords</a> |<a href="index.asp"> Log Out </a></font></center>
    <hr />
    <h1>Cancel Members</h1>
    <table width="200" border="3" align="center">
      <tr align="center" bgcolor="#FFFF99">
        <td><strong>Username</strong></td>
        <td><strong>First Name </strong></td>
        <td><strong>Surname</strong></td>
        <td><strong>Contact Number</strong></td>
        <td><strong>Email</strong></td>
        <td><strong>Address</strong></td>
      </tr>
      <% While not rs.EOF %>
      <tr bgcolor="#FFFFCC">
        <td><%=rs("UN")%></td>
        <td><%=rs("FN")%></td>
        <td><%=rs("SN")%></td>
        <td><%=rs("CN")%>;</td>
        <td><%=rs("Email")%></td>
        <td><%=rs("AD")%></td>
      </tr>
      <tr bgcolor="#FFFFCC">
       
      </tr>
        <%
	  rs.movenext
	  wend  
	  %>
       <td height="28" colspan="6" align="center"><form name="form" method="post" action="ManagerDisplayMembers.asp">
          <input type="submit" name="CM" id="Cancel Members" value="Cancel Members">
        </form></td>
    </table>
    <p>&nbsp;</p> 
 
   </div>
 </div>
</body>
</html>
