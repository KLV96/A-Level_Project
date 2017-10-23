<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="styles.css" > 
<!--Changeging the icon to the restaurant's icon -->        
<link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - About</title>
<style type="text/css" >
 	
	.col
	{
		color: red;
	}
	
	.col2
	{
		color: Green;
	}
	
</style>
	
<%  

'if session("Username") = ""  then
' response.redirect("index.asp")
'end if
Tmonth = month(date)
dim Con, rs, sql

Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs2 = Server.CreateObject("ADODB.Recordset")
Set rs3 = Server.CreateObject("ADODB.Recordset")
Set rs4 = Server.CreateObject("ADODB.Recordset")
Set rs5 = Server.CreateObject("ADODB.Recordset")

Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
  sql= "SELECT SUM(Quantity) AS Quan, Itemname FROM(SELECT Quantity , Itemname FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID AND Item.ItemID = ItemOrder.ItemID AND Month (OrderDate) = '"&Tmonth&"' AND TypeOfOrder = 'PO' UNION ALL SELECT Quantity , Itemname FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID And Item.ItemID = ItemOrder.ItemID AND Item.ItemID = ItemOrder.ItemID AND Month (OrderDate) = '"&Tmonth&"' AND TypeOfOrder = 'WO')GROUP BY Itemname"


rs.Open sql, Con

sql2 = "SELECT tOP 1 Itemname AS LeastName,Quan AS LeastQuant FROM(SELECT SUM(Quantity) AS Quan, Itemname FROM (SELECT Quantity , Itemname FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID AND Item.ItemID = ItemOrder.ItemID AND Item.ItemID = ItemOrder.ItemID AND Month (OrderDate) = '"&Tmonth&"' AND TypeOfOrder = 'PO' UNION ALL SELECT Quantity , Itemname FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID AND Item.ItemID = ItemOrder.ItemID AND Item.ItemID = ItemOrder.ItemID AND Month (OrderDate) = '"&Tmonth&"' AND TypeOfOrder = 'WO') GROUP BY Itemname ORDER BY SUM(Quantity))"

rs2.Open sql2, Con

sql3 = "SELECT top 1 Itemname AS MostName, Quan AS MostQuant FROM(SELECT SUM(Quantity) AS Quan, Itemname FROM (SELECT Quantity , Itemname FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID AND Item.ItemID = ItemOrder.ItemID AND Item.ItemID = ItemOrder.ItemID AND Month (OrderDate) = '"&Tmonth&"' AND TypeOfOrder = 'PO' UNION ALL SELECT Quantity , Itemname FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID AND Item.ItemID = ItemOrder.ItemID AND Month (OrderDate) = '"&Tmonth&"' AND TypeOfOrder = 'WO') GROUP BY Itemname ORDER BY SUM(Quantity) DESC)"

rs3.Open sql3, Con


NAmeOFLeast= rs2("LeastName")
QuantityOfLeast = rs2("LeastQuant")
NAmeOFMost = rs3("MostName")
QuantityOfMost = rs3("MostQuant")
%>
</head>

<body>

<div class="container">
  <div class="content">
  <center><img src="images/logo.png" /></center>
    <hr />
        <center><font size ="5"><a href="ManagerDailyOrders.asp">Daily Orders</a> | <a href="ManagerMonthlyOrders.asp">Monthly Orders</a> | <a href="ManagerCalculateProfit.asp">Calculate Profit</a> | <a href="ManagerMonthlyAnalysis.asp">Chart Order Analysis</a> | <a href="ManagerOrderAnalysis.asp">Monthly Orders Analysis</a> |<a href="ManagerDisplayMembers.asp"> Cancel Members</a> | <a href="ManagerChangeMenu.asp">Change Menu</a> | <a href="ManagerAddstaff.asp">Add staff</a> | <a href="ManagerChangePasswords.asp">Change passwords</a> |<a href="index.asp"> Log Out </a></font></center>
    <hr />
    <h1>Monthly Order Analysis</h1>
    <table width="200" border="3" align="center">
      <tr bgcolor="#FFFF99">
        <td align="center" class= "col"><strong>Order Name </strong></td>
        <td align="center" class= "col"><strong>Quantity </strong></td>
      </tr>
      <% While not rs.EOF %>
      <tr bgcolor="#FFFFCC">
        <td align="center"><strong><%=rs("Itemname")%></strong></td>
        <td align="center"><strong><%=rs("Quan")%></strong></td>
      </tr>
        <%
	
	  rs.movenext
	  wend  
	  %>
    </table>
    <p class="col"><strong><% response.Write(NameOFMost)%> <span class="col2">is most Ordered with</span> <%response.Write(QuantityOfMost)%> Orders</strong></p>
    <p class="col"><strong><% response.Write(NAmeOFLeast)%> <span class="col2">is Least Ordered with</span> <%response.Write(QuantityOfLeast)%> Orders</strong></p>
   <center></center>
   </div>
 </div>
</body>
</html>
