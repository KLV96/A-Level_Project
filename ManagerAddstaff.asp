<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="styles.css" >
<!--Changeging the icon to the restaurant's icon -->        
		<link rel="icon" href="Images/favicon.ico">  
<title>Rojava restaurant - Add staff</title>
<%

AddButton = request.Form("Add")
TOS = request.Form("TOS")
Username = request.Form("Username")
Password = request.Form("Password")
Repassword = request.Form("RePassword")

 dim Con1, rs1, sql1
		Set Con1 = Server.CreateObject("ADODB.Connection")
		Set rs1 = Server.CreateObject("ADODB.Recordset")
		Con1.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
		sql1 = "SELECT SUN FROM staff"
		rs1.Open sql1, Con1
		
	While not rs1.EOF
		IF rs1("SUN") = Username then 
		Exist = True 
		End IF
	rs1.movenext
	wend 
	
  
IF AddButton = "Add" then 

	IF Username = "" then 
		msg = "<center><b><span style=""color:#F00""> Please type in the username</span></b></center>"
	Elseif exist = True then 
		msg = "<center><b><span style=""color:#F00""> Username already exist, Please type in different username</span></b></center>"
	Elseif Password = "" then
		msg = "<center><b><span style=""color:#F00""> Please type in the Password</span></b></center>"
	Elseif RePassword = "" then 
		msg = "<center><b><span style=""color:#F00""> Please type in the Repassword</span></b></center>"
	Elseif 	len(Username) > 10 then
	msg = "<center><b><span style=""color:#F00""> Please make sure that the username is less than 10 characters</span></b></center>"
	Elseif len(Password) > 15 then 
		msg = "<center><b><span style=""color:#F00""> Please make sure that the password is less than 15 characters</span></b></center>" 
	Elseif Instr(1, Password, "@", 1) <2 then 
		msg ="<center><b><span style=""color:#F00"">Please make sure that the Password contains @ sign</span></b></center>"
	Elseif instr(lcase(Password), lcase(Username))>0 then
		msg ="<center><b><span style=""color:#F00"">Username cannot be contained fully within the Password</span></b></center>"
	Elseif Password <> RePassword then 
		msg ="<center><b><span style=""color:#F00"">Please make sure that the password and the Re-password matches</span></b></center>"
	Else
		dim Con, rs, sql
		Set Con = Server.CreateObject("ADODB.Connection")
		Set rs = Server.CreateObject("ADODB.Recordset")
		Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
		' The following sql inserts the data that has been entered by the admin (username, password and type of user) into the staff tabel in the databse  
		sql = "INSERT INTO staff (Sun,PA,TOU) VALUES ('"&Username&"','"&Password&"','"&TOS&"')"
		rs.Open sql, Con
		msg ="<center><b><span style=""color:#F00""> New member has been added</span></b></center>"
	End if 
END IF 



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
    <h1>Add staff</h1>
    <form name="form" method="post" action="ManagerAddstaff.asp">
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
        <td><strong>Password</strong></td>
        <td><input type="text" name="Password" id="Password"></td>
      </tr>
      <tr bgcolor="#FFFFCC">
        <td><strong>Re-password</strong></td>
        <td><input type="text" name="RePassword" id="RePassword"></td>
      </tr>
      <tr bgcolor="#FFFF99">
        <td height="28" colspan="2" align="center">
          <input type="submit" name="Add" id="Add" value="Add">
       </td>
      </tr>
      
    </table>
    </form>
    <% response.Write(msg) %>
  </div>
 </div>
</body>
</html>
