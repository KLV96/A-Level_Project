<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="styles.css" > 
<link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - Receipt </title>

<%
if session("Username") = ""  then
  response.redirect("index.asp")
end if

dim Con, rs1, sql1, rs2, sql2
GetSubmitButton = request.form("Submit")
GetCancelButton = request.form("cancel")

Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")
'Set rs2 = Server.CreateObject("ADODB.Recordset")
OrderID = session("OrderID")
Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))



'sql1 = "SELECT ItemID,Quantity FROM ItemOrder WHERE OrdererID = '" & session("OrderID") & "'"
sql = "SELECT ItemOrder.OrderID, ItemOrder.ItemID,  Item.ItemName, ItemOrder.Quantity, Item.Price FROM Item INNER JOIN ItemOrder ON Item.ItemID = ItemOrder.ItemID WHERE ItemOrder.OrderID="&session("OrderID")

rs.Open sql, Con
'rs1.close

'sql2 = "SELECT ItemName,price FROM Item WHERE ItemID = '" & rs1("ItemID") & "'"
'rs2.Open sq2, Con


sql2 = "SELECT Price FROM Item where "




If GetSubmitButton <> "" then 
    response.Redirect("addorder.asp")
End if 


IF GetCancelButton <> "" then 
  SNT = Minute(time)  
  differeceOftime = SNT - session("Time") 
  IF differeceOftime > 2 then 
    msg = "<center><b><span style=""color:#F00""> The order is already made. Sorry, you cannot cancel the order now  </span></b></center>"
  Else 
    dim Con2

    Set Con2 = Server.CreateObject("ADODB.Connection")

    Con2.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
    sql3 = "DELETE * From ItemOrder where OrderID =" &session("OrderID")
    sql4 = "DELETE * From tblOrder where OrderID =" &session("OrderID")
    con2.execute(sql3)
    con2.execute(sql4)
    response.Redirect("addorder.asp")
  End if 
  
End if 


%>



</head>

<body>

<div class="container">
  <div class="content">
  <center><img src="images/logo.png" /></center>
    <hr />
   <center><font size ="5"> <a href="AddOrder.asp"> Make an Order</a> | <a href="MyOrders.asp">My Orders </a> | <a href="DisplayProfile.asp">Profile</a> | <a href="index.asp">Logout</a> </font></center>
    <hr />
    <h1>Receipt</h1>
    <table width="300" border="1" align="center">
      <tr>
        <td align="center"><strong>Item Name</strong></td>
        <td align="center"><strong>Quantity</strong></td>
        <td align="center"><strong>Price </strong></td>
        <td align="center"><strong>Amount </strong></td>
      </tr>
      <% While not rs.EOF %>
      <tr>
        <td align="center" bgcolor="#FFFF99"><%=rs("ItemName")%></td>
        <td align="center" bgcolor="#FFFF99"><%=rs("Quantity")%></td>
        <td align="center" bgcolor="#FFFF99"><%=(FormatCurrency(rs("Price")))%></td>
        <td align="center" bgcolor="#FFFF99"><%=(FormatCurrency(rs("Price") * rs("Quantity")))%></td>
        
      </tr>
    
       <%
       sum = FormatCurrency(sum + (rs("Price") * rs("Quantity")))
	  rs.movenext
	  wend  
	   
	  %>
       
 <td colspan="4" align="center" bgcolor="#FFFF99"><strong>Total = <%response.Write(sum)%></strong></td>
    <tr>
      <td colspan="4" align="center" bgcolor="#FFFF99"><form name="form1" method="post" action="">
        <input type="submit" name="Cancel" id="Cancel" value="Cancel"> 
        <input type="submit" name="submit" id="submit" value="Submit">
      </form></td>
    </table>
    
    <blockquote>
      <p>&nbsp;</p>
      <p><%response.Write(msg)%></p>
    </blockquote> 
  </div>
</div>
</body>
</html>
