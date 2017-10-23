<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="styles.css" > 
<!--Changeging the icon to the restaurant's icon -->        
<link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - Home</title>

</head>

  <%

' Delcaring the variabels and connecting to the databse 
dim Con, rs, sql

Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")

Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))	
	
' The sql statement selects all the Items in the Item tabel in the databse 
sql = "SELECT * FROM Item Order By ItemID"
' A recordset is opened using the sql query
rs.Open sql, Con
	
	%>
<body>

<div class="container">
  <div class="content">
    <center><img src="images/logo.png" /></center>
    <hr />
       <center><font size ="5"><a href="ManagerDailyOrders.asp">Daily Orders</a> | <a href="ManagerMonthlyOrders.asp">Monthly Orders</a> | <a href="ManagerCalculateProfit.asp">Calculate Profit</a> | <a href="ManagerMonthlyAnalysis.asp">Chart Order Analysis</a> | <a href="ManagerOrderAnalysis.asp">Monthly Orders Analysis</a> |<a href="ManagerDisplayMembers.asp"> Cancel Members</a> | <a href="ManagerChangeMenu.asp">Change Menu</a> | <a href="ManagerAddstaff.asp">Add staff</a> | <a href="ManagerChangePasswords.asp">Change passwords</a> |<a href="index.asp"> Log Out </a></font></center>
    <h1>  Change Menu </h1>
    <p>&nbsp;</p>
    
     <!-- A tabel of six columns is used -->
   <center><table width="500" border="1" cellpadding="0" cellspacing="0">
      <tr bgcolor="#FFFF99">
        <td align="center"><strong><p> Item ID </p></strong></td>
        <td align="center"><strong><p> Item Name </p></strong></td>
        <td align="center"><strong><p> Ingredient </p></strong></td>
        <td align="center"><strong><p> Price </p></strong></td>
        <td align="center"><strong><p> Edit Item</p></strong></td>
        <td align="center"><strong><p> Delete Item</p></strong></td>
      </tr>
      <!-- A while not recordset end of file loop is used to display all the items in the recordset -->
      <!-- In the tabel the number of the rows is depending on the number of Items in the Item tabel in the databse -->
      <% while not rs.EOF%>
      <tr align="center" bgcolor="#FFFFCC">
      	<!-- Displaying the Item ID  -->
        <td><strong><%=rs("ItemID")%></strong></td>
        <!-- Displaying the Item Name  -->
        <td><strong><%=rs("ItemName")%></strong></td>
        <!-- Displaying the Ingredient  -->
        <td><strong><%=rs("Ingredient")%></strong></td>
        <!-- Displaying the Price in the form of currency in order for the pound symbol to be displayed as well as the fraction part of the price to 2 decimal places  -->
        <td><strong><%=(FormatCurrency(rs("Price")))%></strong></td>
        <td><A HREF="MenuEdit.asp?ItemID=<%=rs("ItemID")%>">Edit</A></td>
        <td><A HREF="MenuDelete.asp?ItemID=<%=rs("ItemID")%>">Delete</A></td>
      </tr>	
      <%
	  ' Moving to the next record in the recordset
	  rs.movenext
	   ' End of the while loop 
	  wend
	  %>
    </table> 
    </center>
    
  
  </div>
</div>
</body>
</html>
 