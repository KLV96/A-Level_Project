<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="styles.css" > 
<link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - My Orders</title>
<style type="text/css" >
		
		
		.FTB
{
	
	float: left;
	margin-left: 100px;
	position: absolute;
	display: inline-block

}
		
		.SCT
{
	
	float: left;
	margin-left: 700px;
	position: absolute;
	display: inline-block

}		
		
</style>

<%  
if session("Username") = ""  then
  response.redirect("index.asp")
end if


dim Con, rs, sql

Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs2 = Server.CreateObject("ADODB.Recordset")
Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))

sql = "SELECT ItemOrder.ItemID,ItemOrder.OrderID,Quantity, Itemname,Price, tblOrder.UN, OrderDate,Ordertime FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID And Item.ItemID = ItemOrder.ItemID AND Item.ItemID =  ItemOrder.ItemID AND UN= '" & session("Username") & "' ORDER BY ItemOrder.OrderID"
rs.Open sql, Con

sql2 = "Select AllOrders, Sum(amount) AS Total FROM( SELECT tblOrder.OrderID As AllOrders,Item.Price*ItemOrder.Quantity as amount FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = 	ItemOrder.OrderID AND Item.ItemID = ItemOrder.ItemID AND Item.ItemID = ItemOrder.ItemID AND UN= '" & session("Username") & "') Group by AllOrders"

rs2.Open sql2, Con

%>

</head>

<body>

<div class="container">
  <div class="content">
  <center><img src="images/logo.png" /></center>
    <hr />
   <center><font size ="5"> <a href="AddOrder.asp"> Make an Order</a> | <a href="MyOrders.asp">My Orders </a> | <a href="DisplayProfile.asp">Profile</a> | <a href="index.asp">Logout</a> </font></center>
    <hr />
    <h1>My Orders</h1>
  
    <table  width="500" border="5" align="center" class="FTB" >
      <tr bgcolor="#FFFF99">
        <td align="center"><strong><p> Order ID </p></strong></td>
        <td align="center"><strong><p> Date </p></strong></td>
         <td align="center"><strong><p> Time </p></strong></td>
        <td align="center"><strong><p> Item name </p></strong></td>
        <td align="center"><strong><p> Quantity </p> </strong></td>
        <td align="center"><strong><p> Total </p></strong></td>
      </tr>
      <% While not rs.EOF %>
      <tr>
        <td align="center"><strong><%=rs("OrderID")%></strong></td>
        <td align="center"><strong><%=rs("OrderDate")%></strong></td>
         <td align="center"><strong><%=rs("OrderTime")%></strong></td>
        <td align="center"><strong><%=rs("Itemname")%></strong></td>
        <td align="center"><strong><%=rs("Quantity")%></strong></td>
        <td align="center"><strong><%
		total = FormatCurrency(rs("Price") * rs("Quantity"))
		response.Write(total)
		%></strong></td>
      </tr>
      <%
	  rs.movenext
	  wend   
	  %>
    </table>
    <table width="200" border="3" align="center" class="SCT"  >
     <tr bgcolor="#FFFF99">
      <tr>
        <td align="center" bgcolor="#FFFF66"><strong>Order ID </strong></td>
        <td align="center" bgcolor="#FFFF66"><strong>Total of the order</strong></td>
      </tr>
      <% While not rs2.EOF %>
      <tr>
        <td align="center"><strong><%=rs2("AllOrders")%></strong></td>
        <td align="center"><strong>
          <%=FormatCurrency(rs2("Total"))%>
        </strong></td>
      </tr>
      
      <%
	
	  rs2.movenext
	  wend  
	   
	  %>
    </table> 
  </div>
    <p>&nbsp;</p>
 
</div>
</body>
</html>
