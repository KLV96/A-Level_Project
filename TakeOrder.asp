<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="styles.css" > 
<link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - Waiter</title>
<style type="text/css">
.DNS
{
	
	float: left;
	margin-left: 100px;
	position: absolute;

}
.DS
{
	float: right;
	margin-right: 20px;
}
.popup {
	zoom:1.0;
	position:relative;
	text-decoration:none;
}
.popup span {
	position:absolute;
	top:0px;
	left:400px;
	width:350px;
	padding:10px;
	border:10px solid #000;
	border-radius:10px;
	left:-999em;
	z-index:990;
        
}
.popup:hover {visibility:visible}
.popup:hover span {left:200px;}
* html .popup span {position:absolute;}
</style>
  <%

 Dim MyDate, Mytime, TimeMB, TimeHB, AddItem, MakeanOrder, FinishOrder, TableNum, ItemID, ItemQuantity, con, sql1, sql2, sql3, sql4, rs1, rs2, rs3, rs4, msg, exist, exist2, OrderID, FMT
 MyDate = Date
 ' Stores the time in hours and minutes 
 Mytime = FormatDateTime(now(),vbshorttime)
 ' Stores the time in minutes 
 TimeMB = minute(time)
 ' Stores the time in hours 
 TimeHB = hour(time)
 ' Publicise the variable TimeHB
 session("TimeHB") = TimeHB
 ' Publicise the variable TimeMB
 session("TimeMB") = TimeMB
 AddItem = request.form("AddItem")
 MakeanOrder = request.form("MakeanOrder")
 FinishOrder = request.form("FinishOrder")
 TableNum = request.form("TableNu")
 ItemID = request.form("OrderID")
 ItemQuantity  = request.form("Quant")
 
If session("Username") = ""  then
  response.redirect("index.asp")
end if


  Set Con = Server.CreateObject("ADODB.Connection")
  Set rs1 = Server.CreateObject("ADODB.Recordset")
  set rs2 = Server.CreateObject("ADODB.Recordset")
  set rs3 = Server.CreateObject("ADODB.Recordset")
  set rs4 = Server.CreateObject("ADODB.Recordset")

  Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb")) 
  

  sql1 = "SELECT * FROM Item Order By ItemID"

  rs1.Open sql1, Con

IF MakeanOrder  <>  "" then 

	If TableNum = "" then
	msg="<center><b><span style=""color:#F00""> Please write the Table Number </span></b></center>"
	Else
	sql2 = "INSERT INTO tblOrder (SUN,Orderdate,OrderTime,TableNo,TypeOfOrder) VALUES ('"&session("Username")&"','"&MyDate&"',    '"&Mytime&"' , "&TableNum&", 'WO' )"
	con.execute(sql2)
	End if 
End if

If AddItem <> "" then 
	
	if ItemID = "" then 
	msg="<center><b><span style=""color:#F00""> Please enter the Item ID </span></b></center>"
	elseif len(ItemID) > 3 then 
	msg="<center><b><span style=""color:#F00""> Please enter a valid Item ID  </span></b></center>"
	Elseif  ItemQuantity = "" then 
	msg="<center><b><span style=""color:#F00""> Please enter the Quantity </span></b></center>"
	elseif ItemQuantity > 21 then 
	msg="<center><b><span style=""color:#F00""> Please enter a quantity less than or equal to 20  </span></b></center>"
	elseif ItemQuantity = 0 then 
	msg="<center><b><span style=""color:#F00""> Please make sure that the quantity cannot  be zero </span></b></center>"
	Else  
	sql3 = "SELECT TOP 1 (OrderID) FROM tblOrder WHERE SUN='"& Session("Username")&"' AND TypeOfOrder='WO' ORDER BY OrderID DESC"
	 rs2.open sql3, con
	OrderID = rs2("OrderID")
	session("WOrderID") = OrderID
	rs2.close
	
	sql4 = "SELECT ItemID from ItemOrder WHERE 	OrderID ="& OrderID
	
	rs3.open sql4, con

  exist = False
  exist2 = False

	While not rs3.EOF 
	IF ItemID = rs3("ItemID") then 
	exist = True
	End IF 
	rs3.movenext
	wend  
	
	rs4.Open sql1, Con
	
	while not rs4.EOF AND not exist2 
		If rs4("ItemID") = ItemID then 
		exist2 = TRUE
		End if 
	rs4.movenext
	wend

' Checks if the Item already does not exists in the Order (ItemOrder) and Checks if the Item added is in the menu ( Item tabel ). Otherwise it adds the Item to the order 
	If not exist then 
		IF  exist2 then 
	 
		sql9 = "INSERT INTO ItemOrder (OrderID,ItemID,Quantity) VALUES ("&OrderID&",'"&ItemID&"',"&ItemQuantity&")"
		con.execute(sql9)
	
		else
		msg="<center><b><span style=""color:#F00""> Please enter a valid Item ID from the menu </span></b></center>"
		End if 
	else
	msg = "<center><b><span style=""color:#F00""> Item ID already exist ( You have ordered this item )</span></b></center>" 
	End IF
End if 
End IF

If FinishOrder <> "" then 
	session("WTime") = TimeMB
	response.redirect("WaiterReceipt.asp")
End if 

%>

    
</head>

<body>

 <div class="container">
  <div class="content">
  <center><img src="images/banner.jpg" width="1200" height="100" /></center>
   <hr />
     <center>
     <font size ="5"><a href="TakeOrder.asp"> Take an Order</a>  |<a href="AddAndDelete.asp"> Edit orders </a>|<a href="index.asp"> Logout</a> </font>
   </center>

    <hr />
     <h1> Take an Order</h1>
     <p>&nbsp;</p>
     <form name="form1" method="post" action="TakeOrder.asp">
    <table width="434" border="1" align="center">
     <tr>
         <td colspan="2" valign="bottom" bgcolor="#FFFFCC"><strong>Table Number</strong>
           <input type="text" name="TableNu" id="textfield" size="30">           
             <input type="submit" name="MakeanOrder" id="button" value="Make an Order" class="DS" size="15" ></td>
       </tr>
       <tr>
         <td width="209" align="center" bgcolor="#66FF66"><strong>Item ID </strong></td>
         <td width="209" align="center" bgcolor="#66FF66"><strong>Quantity</strong></td>
       </tr>
       <tr>
         <td><input name="OrderID" type="text" id="OrderID" size="34"></td>
         <td><input name="Quant" type="text" id="Quant" size="34"></td>
       </tr>
       <tr>
         <td colspan="2" align="center" valign="bottom" bgcolor="#66FF66">
           <input type="submit" name="AddItem" id="AddItem" value="Add Item to the order">
              <input type="submit" name="FinishOrder" id="FinishOrder" value="Finish the Order">
         </td>
       </tr>
     </table>
     </form>
    <%response.Write(msg)%>
     <div class="container">
  <div class="content">
    
    
  
    <hr />
    <h1> Menu </h1>
    <hr />
    </div>
    <center><table class="DNS" width="500" border="1" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center"><strong><p> Item ID </p></strong></td>
        <td align="center"><strong><p> Item Name </p></strong></td>
        <td align="center"><strong><p> Ingredient </p></strong></td>
        <td align="center"><strong><p> Price </p></strong></td>
        <td align="center"><strong><p> Image </p></strong></td>
      </tr>
      <% while not rs1.EOF%>
      <tr align="center">
        <td><strong><%=rs1("ItemID")%></strong></td>
        <td><strong><%=rs1("ItemName")%></strong></td>
        <td><strong><%=rs1("Ingredient")%></strong></td>
        <td><strong><%=(FormatCurrency(rs1("Price")))%></strong></td>
        <td><a class="popup" href="#">Image<span><img src="<%=rs1("Image")%>"></span></a></td>
      </tr>
      <%
	  
	  rs1.movenext
	  wend
	  %>
    </table> </center>
    
  
  </div>
</div>
<p>&nbsp;</p>
     <p>&nbsp;</p>
     <p>&nbsp;</p>
     <p>&nbsp;</p>
     <p>&nbsp;</p>
     <p>&nbsp;</p>	
   </div>
 </div>
</body>
</html>
