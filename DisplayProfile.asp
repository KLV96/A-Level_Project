<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <!-- Linking to the Css page which is named styles -->
        <link rel="stylesheet" type="text/css" href="styles.css" > 
        <!--Changeging the icon to the restaurant's icon -->  
        <link rel="icon" href="Images/favicon.ico"> 
        <!-- Changing the website's title -->  
        <title>Rojava restaurant - Display Orders</title>
<%

''Declare variables
dim Editbutton, Con, rs, sql
'requesting the value of the button and assignin it in the Editbutton variable
Editbutton = request.form("Editbutton")

' If the user tries to enter this page without signing in they will be redirected to the index page where they need to enter the login details 
if session("Username") = ""  then
  response.redirect("index.asp")
end if

'Connecting to the databse and setting a recordset
Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")
Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))

' The sql selects all the customer's personal details using the username that he/she signed in with
sql = "SELECT * FROM Customer WHERE UN = '" & session("username") & "'"

' Opening the recordset
rs.Open sql, Con


' IF the customer pressed the edit button then he/She will be redirected to the Profile page where the customer will be able to edit the personal details
If Editbutton <> "" then 
	response.Redirect("Profile.asp")
End if 

%>
</head>

<body>

<div class="container">
  <div class="content">
  <center><img src="images/logo.png" /></center>
    <hr />
   <center><font size ="5"> <a href="AddOrder.asp"> Make an Order</a> | <a href="MyOrders.asp">My Orders </a> | <a href="Profile.asp">Profile</a> | <a href="index.asp">Logout</a> </font></center>


    <hr />
    <h1>My Profile</h1> 
    <form name="form" method="post" action="DisplayProfile.asp">
          
      
    <table width="400" border="2" align="center">
      <tr>
        <td width="300" bgcolor="#33CC66">First Name</td>
        <td width="141" align="center" bgcolor="#33CC66"><strong><%=rs("FN")%></strong></td>
        </tr>
      <tr>
        <td width="300" bgcolor="#FFFF99">Surname</td>
        <td align="center" bgcolor="#FFFF99"><strong><%=rs("SN")%></strong></td>
        </tr>
      <tr>
        <td width="300" bgcolor="#33CC66">Contact Number</td>
        <td align="center" bgcolor="#33CC66"><strong><%=rs("CN")%></strong></td>
        </tr>
      <tr>
        <td width="300" bgcolor="#FFFF99">Address </td>
        <td align="center" bgcolor="#FFFF99"><strong><%=rs("AD")%></strong></td>
        </tr>
           <td width="300" bgcolor="#33CC66">Email</td>
        <td align="center" bgcolor="#33CC66"><strong><%=rs("Email")%></strong></td>
        </tr>
      <tr>
        <td width="300" bgcolor="#FFFF99">Password</td>
        <td align="center" bgcolor="#FFFF99"><strong><%=rs("PA")%></strong></td>
        </tr>
      <tr>
        <td height="26" colspan="2" align="center" bgcolor="#33CC66"><input type="submit" name="Editbutton" id="Editbutton" value="Edit"></td>
      </tr>
    </table>
      </form>
    <p>&nbsp;</p>
   <center></center>
   </div>
 </div>
</body>
</html>
