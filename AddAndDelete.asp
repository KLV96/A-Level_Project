<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META HTTP-EQUIV=Refresh CONTENT="5">
<link rel="stylesheet" type="text/css" href="styles.css" > 
<link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - About</title>
</head>
<%

' localize the public variable Username and assigned it into waiterN
waiterN = Session("Username")
' localize the public variable TimeMB and assigned it into TimeMB
TimeMB = session("TimeMB")
' Stores the minute of the time that the waiter view the page in order to edit an Item 
TimeMN = minute(time)
' localize the public variable TimeHB and assigned it into TimeHB
TimeHB = session("TimeHB")
' Stores the hour of the time that the waiter view the page in order to edit an Item 
TimeHN = hour(time)
' Stores the date of the day that the page has been viewed 
Today = Date
' The difference between the time in minutes of the waiter making the order and the time in minutes when viewed the addAndDelete page in order to edit an order. The difference is assigned to the variable diff
diff = TimeMB - TimeMN  

' If diff is negative make it possitive  
If diff < 0 then 
diff = -diff
End if 

dim Con, rs , sql
Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")

Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))

' The sql statement selects the OrderID, the ID and name of the item, tableNo, date and time of the order when the Staff username is the same as the username of the waiter who has logged in, The hour of the time of the order being made is the same as the hour that the waiter viewed the page and the same day and the minutes of the order being made is more by 5 minutes  
sql = "SELECT  tblOrder.OrderID, ItemOrder.ItemID,Quantity, Itemname, tableNo, OrderDate, OrderTime FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID And Item.ItemID = ItemOrder.ItemID AND Item.ItemID =  ItemOrder.ItemID AND tblOrder.SUN = '"& waiterN & "' AND HOUR(OrderTime) = '"&TimeHN&"' AND OrderDate = '"& Today &"' AND MINUTE(OrderTime)<= "&TimeMB + 5 &" AND MINUTE(OrderTime)>= "&TimeMB  &""
rs.Open sql, Con

%>
<body>

<div class="container">
  <div class="content">
   <center><img src="images/banner.jpg" width="1200" height="100" /></center>
   <hr />
   <center>
     <font size ="5"><a href="TakeOrder.asp"> Take an Order</a>  |<a href="AddAndDelete.asp"> Edit orders </a>|<a href="index.asp"> Logout</a> </font>
   </center>

    <hr />
     <h1> Edit Orders</h1>
     <p>&nbsp;</p>
     <table width="500" border="3" align="center">
       <tr bgcolor="#FFFF99">
         <td height="30" align="center"><strong>Order ID </strong></td>
         <td align="center"><strong>Table Number </strong></td>
         <td align="center"><strong>Order Date </strong></td>
         <td align="center"><strong>Order Time </strong></td>
         <td align="center"><strong>Item name</strong></td>
         <td align="center"><strong>Quantity</strong></td>
         <td align="center">&nbsp;</td>
       </tr>
       <% while not rs.EOF  %>
       <tr>
         <td align="center"><strong><%=rs("OrderID")%></strong></td>
         <td align="center"><strong><%=rs("tableNo")%></strong></td>
         <td align="center"><strong><%=rs("OrderDate")%></strong></td>
		 <td align="center"><strong><%=rs("OrderTime")%></strong></td>
         <td align="center"><strong><%=rs("Itemname")%></strong></td>
         <td align="center"><strong><%=rs("Quantity")%></strong></td>
		 <td align="center"><A HREF="OrderEdit.asp?ItemID=<%=rs("ItemID")%>">Edit</A></td>
       </tr>
       <%
	   rs.movenext
	   wend
	   %>
     </table>

   </div>
 </div>
</body>
</html>
