<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <!-- Linking to the Css page which is named styles -->
        <link rel="stylesheet" type="text/css" href="styles.css" >
         <!--Changeging the icon to the restaurant's icon -->  
        <link rel="icon" href="Images/favicon.ico"> 
         <!-- Changing the website's title --> 
        <title>Rojava restaurant - Profile</title>
<%

' 'Declare variables
dim Updatebutton, Con, rs, sql
'requesting the value of the Update button and assignin it in the Editbutton variable
Updatebutton = request.form("Updatebutton")

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

' IF the customer pressed the update button then he/She will be redirected to the DisplayProfile page where the customer will be able to edit the personal details
If Updatebutton <> "" then 
	response.Redirect("UpdateRecord.asp")
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
         <!-- The form tag is connected with the UpdateRecod where any changes the cutomer makes on the Profile page will be used in the UpdateRecod page -->
        <form name="form1" method="post" action="updateRecord.asp">
              
         <!-- creating a table of eight rows where each row has a text field except the last row which holds the update button -->
        <table width="400" border="2" align="center">
          <tr>
            <td width="300" bgcolor="#33CC66">First Name</td>
            <!-- The recodset holds the First name of that specific customer and used to be displayed -->
            <td width="141" align="center" bgcolor="#33CC66"><input type="text" name="FN" id="FN" value="<%=rs("FN")%>"></td>
            </tr>
          <tr>
          <!-- The recodset holds the Surname of that specific customer and used to be displayed -->
            <td width="300" bgcolor="#FFFF99">Surname</td>
            <td align="center" bgcolor="#FFFF99"><input type="text" name="SN" id="SN" value="<%=rs("SN")%>"></td>
            </tr>
          <tr>
           <!-- The recodset holds the contact number of that specific customer and used to be displayed -->
            <td width="300" bgcolor="#33CC66">Contact Number</td>
            <td align="center" bgcolor="#33CC66"><input type="text" name="CN" id="CN" value="<%=rs("CN")%>"></td>
            </tr>
          <tr>
          <!-- The recodset holds the Address of that specific customer and used to be displayed -->
            <td width="300" bgcolor="#FFFF99">Address </td>
            <td align="center" bgcolor="#FFFF99"><input type="text" name="AD" id="AD" value="<%=rs("AD")%>"></td>
            </tr>
             <!-- The recodset holds the Email of that specific customer and used to be displayed -->
               <td width="300" bgcolor="#33CC66">Email</td>
            <td align="center" bgcolor="#33CC66"><input type="text" name="Email" id="Email" value="<%=rs("Email")%>"></td>
            </tr>
          <tr>
           <!-- The recodset holds the Password of that specific customer and used to be displayed -->
            <td width="300" bgcolor="#FFFF99">Password</td>
            <td align="center" bgcolor="#33CC66"><input type="text" name="PA" id="PA" value="<%=rs("PA")%>"></td>
            </tr>
          <tr>
           <!-- The recodset holds the Password of that specific customer and used to be displayed -->
            <td width="300" height="26" bgcolor="#33CC66">Re-Enter Password</td>
            <td align="center" bgcolor="#FFFF99"><input type="text" name="REPA" id="REPA" value="<%=rs("PA")%>"></td>
          </tr>
          <tr>
            <td height="26" colspan="2" align="center" bgcolor="#FFFF99"><input type="submit" name="Updatebutton" id="Updatebutton" value="Update"></td>
            </tr>
        </table>
          </form>
        <p>&nbsp;</p>
       <center></center>
       </div>
     </div>
    </body>
</html>
