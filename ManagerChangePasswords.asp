<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- Links to the css  -->
<link rel="stylesheet" type="text/css" href="styles.css" > 
<!--Changeging the icon to the restaurant's icon -->        
<link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - Add staff</title>
<%

' Declare variables 
Dim Change, TOS , Username , Password, Repassword, con1, sql1, rs1, msg ,Exist 
' The variable AddButton stores the value of the button 
Change = request.Form("Change")
' The variable TOS stores the type of the staff that the passwoed needs to be chagned 
TOS = request.Form("TOS")
' The variable TOS stores the Username of the staff that the password needs to be changed 
Username = request.Form("Username")
' The variable Password stores the new password 
Password = request.Form("Password")
' The variable Repassword stores the re-entering of the new password 
Repassword = request.Form("RePassword")

' connecting to the database 
Set Con1 = Server.CreateObject("ADODB.Connection")
' setting a new recordset 
Set rs1 = Server.CreateObject("ADODB.Recordset")
Con1.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
' the sq1l statenebt sekects the staff usernmae from the staff tabel in the databse 
sql1 = "SELECT SUN FROM staff"
' the recordset is opened 
rs1.Open sql1, Con1

' A while not end of recordset1 loop is used to check in every record of the staff user name to see if the username that the admin has typed exists in the staff tabel in the database 
While not rs1.EOF
	' Checking if the username that the admin has typed in exists or not. If so True is assigned to the variable Exist
	IF rs1("SUN") = Username then 
		Exist = True 
	End IF
	' Moving to the next record in the recordset 
	rs1.movenext
	' End of the while loop
wend 
	
' IF the change Password button has been pressed the the following code will be executed 
IF Change = "Change password"  then 
	' If the username that has been typed in the following code will be executes 
	IF  Exist= True then 
		' Checking if the username field is empty. If so an error message will be displayed 
		IF Username = "" then 
			msg = "<center><b><span style=""color:#F00""> Please type in the username</span></b></center>"
		' Checking if the Password field is empty. If so an error message will be displayed 
		Elseif Password = "" then
			msg = "<center><b><span style=""color:#F00""> Please type in the Password</span></b></center>"
		' Checking if the RePassword field is empty. If so an error message will be displayed 
		Elseif RePassword = "" then 
			msg = "<center><b><span style=""color:#F00""> Please type in the Repassword</span></b></center>"
		'Checking if the length of the username is more than 10 characters.If so an error message will be displayed 	
		Elseif 	len(Username) > 10 then
		msg = "<center><b><span style=""color:#F00""> Please make sure that the username is less than 10 characters</span></b></center>"
		'Checking if the length of the Password is more than 15 characters. If so an error message will be displayed  
		Elseif len(Password) > 15 then 
			msg = "<center><b><span style=""color:#F00""> Please make sure that the password is less than 15 characters</span></b></center>" 
		'Checking if the Password has the @ symbol. If so an error message will be displayed 
		Elseif Instr(1, Password, "@", 1) <2 then 
			msg ="<center><b><span style=""color:#F00"">Please make sure that the Password contains @ sign</span></b></center>"
		'Checking if the username ontained fully within the Password. If so an error message will be displayed 
		Elseif instr(lcase(Password), lcase(Username))>0 then
			msg ="<center><b><span style=""color:#F00"">Username cannot be contained fully within the Password</span></b></center>"
		'The password must be the same as the Repassword. If not an error message will be displayed
		Elseif Password <> RePassword then 
			msg ="<center><b><span style=""color:#F00"">Please make sure that the password and the Re-password matches</span></b></center>"
		Else
			'Else The new password will be updated 
			dim Con, rs, sql
			Set Con = Server.CreateObject("ADODB.Connection")
			Set rs = Server.CreateObject("ADODB.Recordset")
			Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
			sql = "UPDATE staff SET PA='" & Password & "' WHERE SUN ='" & Username & "' AND TOU = '" & TOS & "'"
	
			rs.Open sql, Con
			msg ="<center><b><span style=""color:#F00""> Password has been changed </span></b></center>"
		End if 
	' Otherwise an error message will be displayed to the admin letting them know that the username that has been entered does not exist in the databsae 	
	Else 
	msg ="<center><b><span style=""color:#F00""> Please make sure that the username exist </span></b></center>"
	END IF 
End if 
%>

<style type="text/css">

.col
{
	color:Red
}

</style>


</head>

<body>

<div class="container">
  <div class="content">
  <center><img src="images/logo.png" /></center>
    <hr />
         <center><font size ="5"><a href="ManagerDailyOrders.asp">Daily Orders</a> | <a href="ManagerMonthlyOrders.asp">Monthly Orders</a> | <a href="ManagerCalculateProfit.asp">Calculate Profit</a> | <a href="ManagerMonthlyAnalysis.asp">Chart Order Analysis</a> | <a href="ManagerOrderAnalysis.asp">Monthly Orders Analysis</a> |<a href="ManagerDisplayMembers.asp"> Cancel Members</a> | <a href="ManagerChangeMenu.asp">Change Menu</a> | <a href="ManagerAddstaff.asp">Add staff</a> | <a href="ManagerChangePasswords.asp">Change passwords</a> |<a href="index.asp"> Log Out </a></font></center>
    <hr />
    <h1>Change passwords</h1>
    <form name="form" method="post" action="ManagerChangePasswords.asp">
    <table width="317" border="3" align="center" class>
    <tr bgcolor="#FFFF99">
          <td align="center" bgcolor="#FFFF99" colspan="2"><label for="TOS"></label>
                                <select name="TOS" id="TOS">
                                <option>Waiter</option>
                                <option>Chef</option>
                                <option>Admin</option>
                                </select>
                                </td>
        
      </tr>
      <tr bgcolor="#FFFFCC">
        <td width="148"><strong>Username</strong></td>
        <td width="149">        
          <input type="text" name="Username" id="Username">
        </td>
      </tr>
      <tr bgcolor="#FFFFCC">
        <td><strong>New Password</strong></td>
        <td><input type="text" name="Password" id="Password"></td>
      </tr>
      <tr bgcolor="#FFFFCC">
        <td><strong>Re-password</strong></td>
        <td><input type="text" name="RePassword" id="RePassword"></td>
      </tr>
      <tr bgcolor="#FFFF99">
        <td height="28" colspan="2" align="center">
          <input type="submit" name="Change" id="Add" value="Change password">
       </td>
      </tr>
      
    </table>
    </form>
    <% response.Write(msg) %>
    
 
  </div>
 </div>
</body>
</html>
