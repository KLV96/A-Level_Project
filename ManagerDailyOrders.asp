<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="styles.css" > 
<!--Changeging the icon to the restaurant's icon -->        
<link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - Daily Orders</title>
<style type="text/css" >
 		
	.col2
	{
		
		color: red;
	}
	
	.margin
	{
		margin-TOP: 300px;
		color: Green;
		
	}	
	
		.FTB
{
	float: left;
	margin-left: 200px;
	position: absolute;
	display: inline-block;
	left: -36px;
	top: 438px;
	border-collapse: collapse;
	
}
		
		.SCT
{
	float: left;
	margin-left: 700px;
	position: absolute;
	display: inline-block;
	left: -180px;
	top: -4px;
	border-collapse: collapse;
}		
		
</style>
<%

today = date
if session("Username") = ""  then
  response.redirect("index.asp")
end if

dim Con, rs, sql

Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs2 = Server.CreateObject("ADODB.Recordset")
Set rs3 = Server.CreateObject("ADODB.Recordset")
Set rs4 = Server.CreateObject("ADODB.Recordset")
Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))

 sql = "SELECT  TypeOfOrder, tblOrder.OrderID, ItemOrder.ItemID,Quantity, Itemname,Price, tableNo, OrderDate, OrderTime, tblOrder.UN, tblOrder.SUN FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID And Item.ItemID = ItemOrder.ItemID AND OrderDate = '"& Today & "' AND TypeOfOrder = 'PO' "

rs.Open sql, Con


 sql2 = "SELECT  TypeOfOrder, tblOrder.OrderID, ItemOrder.ItemID,Quantity, Itemname,Price, tableNo, OrderDate, OrderTime, tblOrder.UN, tblOrder.SUN FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID And Item.ItemID = ItemOrder.ItemID AND Item.ItemID =  ItemOrder.ItemID AND OrderDate = '"& Today & "' AND TypeOfOrder = 'WO' "
  

rs2.Open sql2, Con


	  sql3 = "SELECT OrderID FROM tblOrder WHERE Orderdate = '"& Today & "' AND TypeOfOrder = 'PO' "

rs3.Open sql3, Con

  While not rs3.EOF 

	   counting1 = counting1 + 1
  rs3.movenext
  wend  
	  

 sql4 = "SELECT OrderID FROM tblOrder WHERE Orderdate = '"& Today & "' AND TypeOfOrder = 'WO' "

rs4.Open sql4, Con

 While not rs4.EOF 

	   counting2 = counting2 + 1
  rs4.movenext
  wend  

%>
</head>

<body>

<div class="container">
  <div class="content">
  <center><img src="images/logo.png" /></center>
    <hr />
          <center><font size ="5"><a href="ManagerDailyOrders.asp">Daily Orders</a> | <a href="ManagerMonthlyOrders.asp">Monthly Orders</a> | <a href="ManagerCalculateProfit.asp">Calculate Profit</a> | <a href="ManagerMonthlyAnalysis.asp">Chart Order Analysis</a> | <a href="ManagerOrderAnalysis.asp">Monthly Orders Analysis</a> |<a href="ManagerDisplayMembers.asp"> Cancel Members</a> | <a href="ManagerChangeMenu.asp">Change Menu</a> | <a href="ManagerAddstaff.asp">Add staff</a> | <a href="ManagerChangePasswords.asp">Change passwords</a> |<a href="index.asp"> Log Out </a></font></center>    <hr />
    <h1>Daily Orders</h1>
	
    <p>&nbsp;</p>
    <p>&nbsp;</p>
   
    <table width="300px" border="3" align="left"  class="FTB"  >
      <tr align="center" bgcolor="#FFFF99">
        <td colspan="5"><strong>Online Orders</strong></td>
      </tr>
      <tr bgcolor="#FFFFCC"><td><strong>Username</strong></td>
        <td><table width="400" border="3" align="left" class = "SCT"  >
            <tr align="center">
              <td colspan="5" bgcolor="#FFFF99"><strong>Orders taken in the restaurant</strong></td>
            </tr>
            <tr bgcolor="#FFFFCC">
              <td><strong>Waiter's name</strong></td>
              <td><strong>Order ID</strong></td>
              <td><strong>Order Time</strong></td>
              <td><strong>Item Ordered</strong></td>
              <td><strong>Table number </strong></td>
            </tr>
            <% While not rs2.EOF %>
            <tr align="center">
              <td><strong><%=rs2("SUN")%></strong></td>
              <td><strong><%=rs2("OrderID")%></strong></td>
              <td><strong><%=rs2("OrderTime")%></strong></td>
              <td><strong><%=rs2("ItemID")%></strong></td>
              <td><strong><%=rs2("TableNo")%></strong></td>
            </tr>
            
            <%
	   sum2 = FormatCurrency(sum2 + (rs2("Price") * rs2("Quantity")))
	  rs2.movenext
	  wend  
	  %>
          </table><strong>Order ID</strong></td>
        <td><strong>Order Time</strong></td>
        <td><strong>Item Ordered</strong></td>
        
      </tr>
      <% While not rs.EOF %>
      <tr align="center">
        <td><strong><%=rs("UN")%></strong></td>
        <td><strong><%=rs("OrderID")%></strong></td>
        <td><strong><%=rs("OrderTime")%></strong></td>
        <td><strong><%=rs("ItemID")%></strong></td>
        
      </tr>
      
      <%
	   sum1 = FormatCurrency(sum1 + (rs("Price") * rs("Quantity")))
	  rs.movenext
	  wend  
	  %>
    </table>
    
     <p class="margin"><strong> Today's Income From Online Order : <span class="col2"> <%response.Write(Sum1)%> </span></strong></p> <p><strong>Number of Online Orders: <span class="col2"> <%response.Write(counting1)%> </span>  <hr /></strong></p>
      
	 <p ><strong> Orders taken in the restaurant : <span class="col2"><%response.Write(Sum2)%> </span></strong></p> 
     <p><strong>Number of Face to Face Orders: <span class="col2"> <%response.Write(counting2)%> </span><hr /></strong></p>
    <p>&nbsp;</p>
  </div>
 </div>
</body>
</html>
