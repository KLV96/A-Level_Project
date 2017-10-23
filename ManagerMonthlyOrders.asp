<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="styles.css" > 
<!--Changeging the icon to the restaurant's icon -->        
<link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - About</title>
<style type="text/css" >
 	
		.col2
	{
		
		color: red;
	}
	
	
	.margin
	{
		margin-TOP: 400px;
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
	}
		
		.SCT
	{
		float: left;
		margin-left: 900px;
		position: absolute;
		display: inline-block;
		left: -180px;
		top: -4px;
	}		
		
</style>
<%

Tmonth = month(date)
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

 sql = "SELECT  Month (OrderDate) AS month , TypeOfOrder, tblOrder.OrderID, ItemOrder.ItemID,Quantity, Itemname,Price, tableNo, OrderDate, OrderTime, tblOrder.UN, tblOrder.SUN FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID AND Item.ItemID = ItemOrder.ItemID AND Month (OrderDate) = '"&Tmonth&"' AND TypeOfOrder = 'PO'"

rs.Open sql, Con

   


 sql2 = "SELECT  Month (OrderDate) AS month ,TypeOfOrder, tblOrder.OrderID, ItemOrder.ItemID,Quantity, Itemname,Price, tableNo, OrderDate, OrderTime, tblOrder.UN, tblOrder.SUN FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID And Item.ItemID = ItemOrder.ItemID AND Item.ItemID =  ItemOrder.ItemID AND Month (OrderDate) = '"& Tmonth & "' AND TypeOfOrder = 'WO' "
  

rs2.Open sql2, Con

   sql3 = "SELECT OrderID FROM tblOrder WHERE Month (OrderDate) = '"& Tmonth & "' AND TypeOfOrder = 'PO' "

rs3.Open sql3, Con

  While not rs3.EOF 

	   counting1 = counting1 + 1
  rs3.movenext
  wend  
	  
'response.Write(counting)

 sql4 = "SELECT OrderID FROM tblOrder WHERE Month (OrderDate) = '"& Tmonth & "' AND TypeOfOrder = 'WO' "

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
    <center><font size ="5"><a href="ManagerDailyOrders.asp">Daily Orders</a> | <a href="ManagerMonthlyOrders.asp">Monthly Orders</a> | <a href="ManagerCalculateProfit.asp">Calculate Profit</a> | <a href="ManagerMonthlyAnalysis.asp">Chart Order Analysis</a> | <a href="ManagerOrderAnalysis.asp">Monthly Orders Analysis</a> |<a href="ManagerDisplayMembers.asp"> Cancel Members</a> | <a href="ManagerChangeMenu.asp">Change Menu</a> | <a href="ManagerAddstaff.asp">Add staff</a> | <a href="ManagerChangePasswords.asp">Change passwords</a> |<a href="index.asp"> Log Out </a></font></center>
    <hr />
    <h1>Monthly Orders</h1>
	
    <p>&nbsp;</p>
    <p>&nbsp;</p>
   
    <table width="400" border="3" align="left"  class="FTB"  >
      <tr align="center" bgcolor="#FFFF99">
        <td colspan="5"><strong>Online Orders</strong></td>
      </tr>
      <tr bgcolor="#FFFFCC"><td align="center"><strong>Username</strong></td>
        <td><table width="500" border="3" align="left" class = "SCT"  >
            <tr align="center">
              <td colspan="6" bgcolor="#FFFF99"><strong>Orders taken in the restaurant</strong></td>
            </tr>
            <tr bgcolor="#FFFFCC">
              <td align="center"><strong>Waiter </strong></td>
              <td align="center"><strong>OrderID</strong></td>
              <td align="center"><strong>Order Time</strong></td>
               <td align="center"><strong>Order Date</strong></td>
              <td align="center"><strong>Item Ordered</strong></td>
              <td align="center"><strong>Table number </strong></td>
            </tr>
            <% While not rs2.EOF %>
            <tr align="center">
              <td><strong><%=rs2("SUN")%></strong></td>
              <td><strong><%=rs2("OrderID")%></strong></td>
              <td><strong><%=rs2("OrderTime")%></strong></td>
              <td><strong><%=rs("OrderDate")%></strong></td>
              <td><strong><%=rs2("ItemID")%></strong></td>
              <td><strong><%=rs2("TableNo")%></strong></td>
            </tr>
            
            <%
	   sum2 = FormatCurrency(sum2 + (rs2("Price") * rs2("Quantity")))
	  rs2.movenext
	  wend  
	  %>
          </table><strong>OrderID</strong></td>
        <td><strong>Order Time</strong></td>
        <td><strong>Order Date</strong></td>
        <td><strong>Item Ordered</strong></td>
        
      </tr>
      <% While not rs.EOF %>
      <tr align="center">
        <td><strong><%=rs("UN")%></strong></td>
        <td><strong><%=rs("OrderID")%></strong></td>
        <td><strong><%=rs("OrderTime")%></strong></td>
        <td><strong><%=rs("OrderDate")%></strong></td>
        <td><strong><%=rs("ItemID")%></strong></td>
        
      </tr>
      
      <%
	   sum1 = FormatCurrency(sum1 + (rs("Price") * rs("Quantity")))
	  rs.movenext
	  wend  
	  %>
    </table>
    <BR>
    <BR>
    <BR>
    <BR>
    <BR>
    <BR>
   <p class="margin"><strong> This Month's Income From Online Order : <span class="col2"> <%response.Write(Sum1)%> </span></strong></p> <p><strong>Number of Online Orders: <span class="col2"> <%response.Write(counting1)%> </span>  <hr /></strong></p>
      
	 <p ><strong> Orders taken in the restaurant : <span class="col2"><%response.Write(Sum2)%> </span></strong></p> 
     <p><strong>Number of Face to Face Orders: <span class="col2"> <%response.Write(counting2)%> </span><hr /></strong></p>
    <p>&nbsp;</p>
  </div>
 </div>
</body>
</html>
