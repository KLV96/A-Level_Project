<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META HTTP-EQUIV=Refresh CONTENT="30">

<link rel="stylesheet" type="text/css" href="styles.css" > 
<!--changing the icon to the restaurant's icon --> 
        <link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - View Orders</title>


<%  
if session("Username") = ""  then
  response.redirect("index.asp")
end if



dim Con, rs, sql

Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")
Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))

sql = "SELECT * FROM ItemOrder"

rs.Open sql, Con


if request.form<>"" then
	'sql statment update prepared to true where oid = rqoid and iID = rpiID
	sql2 = "UPDATE ItemOrder SET Prepared=TRUE WHERE OrderID= "&request.form("OrderID")&" AND ItemID= '"&request.form("ItemID")&"'"
	
	con.execute(sql2)
	
end if

%>
</head>

<body>

<div class="container">
  <div class="content">
  <center><img src="images/logo.png" /></center>
   <hr />
     <center>
     <font size ="5"><a href="ChefAllOrders.asp"> Display Orders </a> | <a href="index.asp">Logout</a> </font>
    </center>
    <hr />
    <h1>All Orders</h1>
    <table width="500" border="1" align="center">
      <tr>
        <td colspan="4" align="center" bgcolor="#66FF66"><strong><a href="ChefAllOrders.asp">Refresh To view all orders</a></strong></td>
      </tr>
      <tr>
        <td height="26" align="center" bgcolor="#FFFF66"><strong>Order ID</strong></td>
        <td align="center" bgcolor="#FFFF66"><strong>Item ID</strong></td>
        <td align="center" bgcolor="#FFFF66"><strong>Quantity</strong></td>
        <td align="center" bgcolor="#FFFF66"><strong>Prepared</strong></td>
      </tr>
      <% While not rs.EOF
	  if rs("prepared") = False then
	  %>
      
      <tr align="center">
        <td height="24"><%=rs("OrderID")%></td>
        <td><%=rs("ItemID")%></td>
        <td><%=rs("Quantity")%></td>
        <td height="20" valign="middle"><form name="form1" method="post" action="ChefAllOrders.asp"><input type="hidden" name="OrderID" value="<%=rs("OrderID")%>"><input type="hidden" name="ItemID" value="<%=rs("ItemID")%>">
          <input type="submit" value="Complete">
          <label for="Done"></label>
        </form></td>
      </tr>
      <%
	  End If
	  rs.movenext
	  wend  
	  
	  %>
    </table>
    <p>&nbsp;</p> 
 
   </div>
 </div>
</body>
</html>
