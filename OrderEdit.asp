<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="styles.css" > 
<!--changing the icon to the restaurant's icon --> 
        <link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - Order Edit </title>
 <%

	
dim Con, rs, sql
GetUpdateB = request.Form("SA")
Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")

Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))	
	
vare = request.QueryString("ItemID")
OrderID = session("WOrderID")

sql = "SELECT * FROM ItemOrder where OrderID="&OrderID&" "
'response.Write(sql)


rs.Open sql, Con


IF GetUpdateB <> "" then 
response.Redirect("OrderUpdate.asp")
End IF 


	%>
</head>

<body>

<div class="container">
  <div class="content">
  <center><img src="images/logo.png" /></center>
    <hr />
<center>
     <font size ="5"><a href="TakeOrder.asp"> Take an Order</a>  |<a href="AddAndDelete.asp"> Edit orders </a>|<a href="index.asp"> Logout</a> </font>
   </center>
    <hr />
    <h1>Edit Order</h1>
    
    <form name="Form" method="post" action="OrderUpdate.asp?ItemID=<%=rs("ItemID")%>">
  <table width="350" border="1" cellspacing="0" align="center">
     
      <tr bgcolor="#FFFF99"><td colspan="2"> 
        <div align="center"><b><a href="OrderUpdate.asp">Edit Order</a></b></div>
      </td>
  </tr>
  <tr bgcolor="#FFFFCC"> 
      <td width="137"><strong><p><strong>Item ID</strong></p></strong></td>
      <td width="203"> 
        <input type="text" name="ItemID" value=<%=rs("ItemID")%> >

    </td>
     <tr bgcolor="#FFFFCC"> 
      <td width="137"><strong>
        <p><strong>Quantity</strong></p></strong></td>
      <td width="203"> 
        <input type="text" name="Quantity" value=<%=rs("Quantity")%> >

    </td>
     
   <tr bgcolor="#FFFF99"> 
     <td colspan="2"> 
       <div align="center">
         <input type="submit" name="UPDATEButton" value="UPDATE">
         </div>
       </td>
   </tr>
  </table>
</form>
<center></center>

  </div>
 </div>
</body>
</html>
