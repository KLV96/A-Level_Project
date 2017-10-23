<html>
    <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            <!--Linking to the css page --> 
            <link rel="stylesheet" type="text/css" href="styles.css" > 
            <!--changing the icon to the restaurant's icon --> 
            <link rel="icon" href="Images/favicon.ico"> 
            <title>Rojava restaurant - About</title>
<%



' Declaring variabels and connecting to the databse 
dim Con, rs, sql, GetUpdateB, vare
Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")
Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))	

' The value of the Update button is sotred into the GetUpdateB variable
GetUpdateB = request.Form("SA")
' The Variabel stores the Item ID of the Item that the admin has chosen to be editted 
vare = request.QueryString("ItemID")
' The sql statement selects all the Items in the Item tabel where the Item ID is the same as the Item ID of the Item that the admin chossed 
sql = "SELECT * FROM Item where ItemID='"&vare&"'"
'Opening the recordset using the sql query 
rs.Open sql, Con

' If the user has pressed the Update button the page will be redirected to the ManuUpdate page
IF GetUpdateB <> "" then 
response.Redirect("MenuUpdate.asp")
End IF 


%>
	</head>

	<body>

        <div class="container">
          <div class="content">
          <center><img src="images/logo.png" /></center>
            <hr />
          <center><font size ="5"><a href="ManagerDailyOrders.asp">Daily Orders</a> | <a href="ManagerMonthlyOrders.asp">Monthly Orders</a> | <a href="ManagerCalculateProfit.asp">Calculate Profit</a> | <a href="ManagerMonthlyAnalysis.asp">Chart Order Analysis</a> | <a href="ManagerOrderAnalysis.asp">Monthly Orders Analysis</a> |<a href="ManagerDisplayMembers.asp"> Cancel Members</a> | <a href="ManagerChangeMenu.asp">Change Menu</a> | <a href="ManagerAddstaff.asp">Add staff</a> | <a href="ManagerChangePasswords.asp">Change passwords</a> |<a href="index.asp"> Log Out </a></font></center>
            <hr />
            <h1>Edit Menu</h1>
            <!-- A form has been used which includes a tabel  --> 
            <form name="Form" method="post" action="MenuUpdate.asp?ItemID=<%=rs("ItemID")%>">
            <!-- A tabel of six rows and one column has been made --> 
          <table width="350" border="1" cellspacing="0" align="center">
             
              <tr bgcolor="#FFFF99"><td colspan="2"> 
              	<!-- The fist rows hold the title of the tabel --> 
                <div align="center"><b><a href="ManagerChangeMenu.asp">Display Menu</a></b></div>
              </td>
          </tr>
          <tr bgcolor="#FFFFCC"> 
              <td width="137"><strong><p><strong>Item ID</strong></p></strong></td>
              <td width="203"> 
              	<!-- The second row has the Item ID text field of the value that is been selected form the databse using the recordset --> 
                <input type="text" name="ItemID" value=<%=rs("ItemID")%> >
        
            </td>
             <tr bgcolor="#FFFFCC"> 
              <td width="137"><strong>
                <p><strong>Item Name</strong></p></strong></td>
              <td width="203"> 
            	<!-- The Third row has the Item Name text field of the value that is been selected form the databse using the recordset -->  
                <input type="text" name="ItemName" value=<%=rs("ItemName")%> >
        
            </td>
             <tr bgcolor="#FFFFCC"> 
              <td width="137"><strong>
                <p>Ingredient</p>
              </strong></td>
              <td width="203"> 
              <!-- The second row has the Ingredient text field of the value that is been selected form the databse using the recordset --> 
                <input type="text" name="Ingredient" value=<%=rs("Ingredient")%> >
        
            </td>
          </tr>
          <tr bgcolor="#FFFFCC"> 
              <td width="137"><strong>
                <p><strong>Price</strong></p>
              </strong></td>
              <td width="203"> 
              	 <!-- The second row has the Price text field of the value that is been selected form the databse using the recordset -->  
                <input type="text" name="Price" value=<%=rs("Price")%> >
            </td>
          </tr>
           <tr bgcolor="#FFFF99"> 
             <td colspan="2"> 
               <div align="center">
               	<!-- The last row holds the Price of the Item  --> 
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
