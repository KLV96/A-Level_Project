<!--This is inclufing the file ACN where the function ProtectSQL is held-->
<!--#include file="ACN.asp"-->
<!--Changeging the icon to the restaurant's icon -->        
<link rel="icon" href="Images/favicon.ico"> 
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="styles.css" >
		<!--Changeging the icon to the restaurant's icon -->        
		<link rel="icon" href="Images/favicon.ico"> 
		<title>Rojava restaurant - Home</title>

<%
'Declare variables  
dim IP, getSub, Username, Password, attempt, n, msg, con, rs 
' Assigning the IP address of the user who opened the index page to the variable IP
Ip = Request.ServerVariables("remote_addr")
' Using the function ProtectSQL The value of the button is requested safely 
getSub = ProtectSQL(Request.form("button"))
' Using the function ProtectSQL The text that has been entered in the Username field is being selected safely 
Username= ProtectSQL(request.form("UN"))
' Using the function ProtectSQL The text that has been entered in the Password field is being selected safely 
Password = ProtectSQL(request.form("PA"))
'The variable username which is being declared previously is assigned to a session named username
session("username") = Username
' True is assigned to the variable attempt of type boolean 
attempt = true  

'Subroutine (function) named myDelay witha a parameter Number Of Seconds  
Sub MyDelay(NumberOfSeconds)
Dim DateTimeResume
'DateTimeResume variable stores the function which returns a date to which a specified time interval (seconds) added by the variable NumberofSeconds which is delcread in the end of the ASP code which takes the exponential of the number of failse attempts to sign in. Add it is added to the function now 
DateTimeResume= DateAdd("s", NumberOfSeconds, Now())
' If the function Now is bigger than the variable DatetimeResume It will enter a loop until the DatetimeResume becomes equal to now or more 
Do Until (Now() > DateTimeResume)
Loop
End Sub 


'IF statement is used to allow the waiters and chefs to sign in only when the restaurant is open which is in between the 9 am and 11 pm 
'IF getSub = "LOG IN" AND (request.form("TOU") = "Waiter" OR request.form("TOU") = "Chef" ) AND NOT (time>#09:00AM# AND time < #11:00PM#) then 
	' An error message letting the chef and waiter know that they can only sign in when the restaurant is open 
'	msg = "<center><b><span style=""color:#F00""> Sorry, you can only sign in when the restaurant is open </span></b></center>"

'Else
	' If the Log In button has been pressed the following checking will take place
	IF getSub = "LOG IN" THEN 
		' To check that the username text field cannot be empty
		IF Username = "" THEN
			' If the username field is empty an error message will be displayed letting the user know that they need to type in the username 
			msg = "<center><b><span style=""color:#F00""> Please type in the username</span></b></center>"
			' False will be assigned to the variable attempt which is of type boolean 
			attempt = false
			' The Session object which named attempt and will increment  the session attempt by 1, which means that the session will store how many times the user has failed to sign in  
			session("attempt") = session("attempt") + 1
			' The IP address of the user who is trying to sign in will be assigned to a variable called LoginIP
			LoginIP =  Request.ServerVariables("remote_addr")
			' IF the username is not in between 3 and 10 characters 
		ELSEIF len(Username) > 10 OR len(Username) < 3 THEN 
		' An erroe message will be displayer to the username should be in between 3 and 10 characters  
			msg = "<center><b><span style=""color:#F00""> Please check the length of the username is in between 3 and 10 characters</span></b></center>"
			' False will be assigned to the variable attempt which is of type boolean 
			attempt = false
			' The Session object which named attempt and will increment  the session attempt by 1, which means that the session will store how many times the user has failed to sign in  
			session("attempt") = session("attempt") + 1
			' The IP address of the user who is trying to sign in will be assigned to a variable called LoginIP
			LoginIP =  Request.ServerVariables("remote_addr")
			' To check that the Password text field cannot be empty
		ELSEIF Password= "" THEN
		' If the Password field is empty an error message will be displayed letting the user know that they need to type in the Password 		
			msg = "<center><b><span style=""color:#F00""> Please type in the Password</span></b></center>"
			' False will be assigned to the variable attempt which is of type boolean 			
			attempt = false
			' The Session object which named attempt and will increment  the session attempt by 1, which means that the session will store how many times the user has failed to sign in  			
			session("attempt") = session("attempt") + 1
			' The IP address of the user who is trying to sign in will be assigned to a variable called LoginIP			
			LoginIP =  Request.ServerVariables("remote_addr")
			' To check if the password is in between 8 and 15 characters 
		ELSEIF len(Password) > 15 OR len(Password) < 8 THEN 
			msg = "<center><b><span style=""color:#F00""> Please make sure that the password is in between 8 and 15 characets </span></b></center>"
			' False will be assigned to the variable attempt which is of type boolean 
			attempt = false
			' The Session object which named attempt and will increment  the session attempt by 1, which means that the session will store how many times the user has failed to sign in  	
			session("attempt") = session("attempt") + 1
			' The IP address of the user who is trying to sign in will be assigned to a variable called LoginIP			
			LoginIP =  Request.ServerVariables("remote_addr")
		ELSE
		' Connecting to the databse and setting a recordset 		
		Set con = Server.CreateObject("ADODB.Connection")
		con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
		Set rs = Server.CreateObject("ADODB.Recordset")
		' To check if the type of user is customer 
			IF request.form("TOU") = "Customer" THEN
			' If the type of user is customer the sql statement will run which will select the password of that specific user 			
				sql = "SELECT PA FROM Customer WHERE UN = '" & Username & "'"
			ELSE 
			' IF the user has not selected a customer as a type of user then the sql statement will run which will select the password and type of user from the staff table where the username is the same as the username that the user has typed in 
				sql = "SELECT PA,TOU FROM staff WHERE SUN = '" & Username & "'"
			END IF 
			' The recordset is opened 
		rs.Open sql, con
		' IF the end of file of the recordset is false then 
			IF rs.EOF = false  THEN
			' To check if the recordser of field password is the same as the variable password and to check if the type of user being chosen is customer 
				IF rs("PA") = password AND request.form("TOU") = "Customer" THEN 
				' If the conditional statements is true, the variable username will be assigned to the session username 								
					session("username") = username
					' then it will redirect the customer to the Add order page where they will be able to add orders 
					response.redirect("AddOrder.asp")
					' To check if the recordset of field password is the same as the variable password and to check if the type of user being chosen is Waiter  					
				ELSEIF rs("PA") = password AND request.form("TOU") = "Waiter"  THEN 
				' To check if the recordset TOU is waiter 
					IF rs("TOU") = "Waiter" THEN 
					' If the conditional statements is true,  the variable username will be assigned to the session username 
						session("username") = username
						' The waiter will be redirected to the take order page where they will be able to take the customers' orders 						
						response.redirect("TakeOrder.asp")
					END IF 
				' To check if the recordset of field password is the same as the variable password and to check if the type of user being chosen is Admin  	 					
				ELSEIF rs("PA") = password AND request.form("TOU") = "Admin"  THEN 
					' To check if the recordset TOU is Admin 
					IF rs("TOU") = "Admin" THEN 
						' If the conditional statements is true,  the variable username will be assigned to the session username 					
						session("username") = username
						' The admin then will be redirected to the manager daily orders page where the admin will be able to view all the orders taken in that specific day 
						response.redirect("ManagerDailyOrders.asp")
					End IF 
				' To check if the recordset of field password is the same as the variable password and to check if the type of user being chosen is Chef  						
				ELSEIF rs("PA") = password AND request.form("TOU") = "Chef"  THEN 
					' To check if the recordset TOU is Chef 				
					IF rs("TOU") = "Chef" THEN 
					' If the conditional statements is true,  the variable username will be assigned to the session username 
					session("username") = username
					' The chef will be redired to the chef all orders page where the chef will be able to view all the orders which has been placed by either the customer or the waiter and mark the ones that has been made 
					response.redirect("ChefAllOrders.asp")
					ELSE
					' IF It's the end of file and the username does not exist an error message will be displayed notifying the user that the username does not exist 
					msg = "<center><b><span style=""color:#F00""> Username doesn't exist, Please try again </span></b></center>"
					' False will be assigned to the variable attempt which is of type boolean 					
					attempt = false
					' The Session object which named attempt and will increment  the session attempt by 1, which means that the session will store how many times the user has failed to sign in  					
					session("attempt") = session("attempt") + 1
					' The IP address of the user who is trying to sign in will be assigned to a variable called LoginIP						
					LoginIP =  Request.ServerVariables("remote_addr")
					END IF 
				ELSE
				'IF the username exist and the password is wrong an error message will be displayed notifying the user that the password is wrong 				
				msg = "<center><b><span style=""color:#F00""> password is wrong, Please try again  </span></b></center>"
				' IF the end of file of the recordset is false then 				
				attempt = false
				' The Session object which named attempt and will increment  the session attempt by 1, which means that the session will store how many times the user has failed to sign in  				
				session("attempt") = session("attempt") + 1
				' The IP address of the user who is trying to sign in will be assigned to a variable called LoginIP						
				LoginIP =  Request.ServerVariables("remote_addr")
				END IF 
			ELSE
			' If the username does not exist an error message will be displayed notying the user 
			msg = "<center><b><span style=""color:#F00""> Username doesn't exist, Please try again </span></b></center>"
			' False will be assigned to the variable attempt 			
			attempt = false
			' Session attempt will be incremented 			
			session("attempt") = session("attempt") + 1
			' The IP address of the user will be assigned to the LogIn variable 			
			LoginIP =  Request.ServerVariables("remote_addr")
			END IF
		END IF
	END IF
'END IF 


' The session attempt will be assigned to the variable n 
n = session("attempt")

' IF the the variable attempt is false and the session attempt is bigger than zero then 
IF attempt = false and session("attempt")  > 0 THEN 
' 2 power of the variable n is passed to the function MyDelay 
	Call MyDelay(2^n)
END IF  

%>
	</head>

	<body onLoad="MM_preloadImages('images/SignIn2.png')">

        <div class="container">
        	<div class="content">

				 <!--The banner of the restaurant -->  
                <center><img src="images/banner.jpg" width="1200" height="100" /></center>
                <hr />
                <center>
				<!-- The navigation bar -->                 
                <font size ="5"><a href="index.asp">Home</a> | <a href="menu.asp">Menu</a> | <a href="About.asp">About</a> |<a href="SignUP.asp">Sign Up</a> </font>  
                </center> 
                <hr />
                <h1> Home </h1>
 			<!--Two tables are being made one inside another -->                  
            <table width="100%" border="1" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="30" align="center" bgcolor="#FF3333"><strong>Please enter your username and password</strong></td>
                        </tr>
                        <tr>                 
                            <td><form action=<%Response.Write "index.asp?"&Request.QueryString%> method="post">
                            <center>
                            <BR>
                            <table width="400" border="3" cellspacing="0" cellpadding="0">

                                <td height="30" align="center" bgcolor="#FFFF00"><strong>Type Of User</strong></td>
  								<!--List menu is used for the user to choose the type of the user that they are -->                               
                                <td align="center" bgcolor="#FFFF33"><label for="TOU"></label>
                                <select name="TOU" id="TOU">
                                <option>Customer</option>
                                <option>Waiter</option>
                                <option>Chef</option>
                                <option>Admin</option>
                                </select>
                                </td>
                            <tr>
                                <td width="200" height="30" align="center" bgcolor="#FFFF00"><strong>Username</strong></td>
                                <td bgcolor="#FFFF00"><label for="UT"></label>
								<!-- A text field is used and named UN where the user types in the username  -->                                 
                                <center><input type="text" name="UN" VALUE='' id="txtUserName"></center></td>
                            </tr>
                            <tr>
                                <td width="200" height="30" align="center" bgcolor="#FFFF00"><strong>Password</strong></td>
                                <td bgcolor="#FFFF00"><label for="txtPassword"></label>
								<!-- A text field is used and named PA where the user types in the password  -->                                 
                                <center><input type="password" name="PA" VALUE='' id="txtPassword"></center></td>
                            </tr>
                            <tr bgcolor="#FF9900">
                                <td height="30" bgcolor="#FFFF00"></td>
                                <td align="center" bgcolor="#FFFF33"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('SignIn','','images/SignIn2.png',1)">
								<!-- A button is used for the user to press to try to sign in  -->                                 
                                <input type="submit" name="button" id="button" value="LOG IN">
                                </a>
                                </td>
                             </tr>
                             <tr bgcolor="#FF9900">             
                             </tr>
                			</table>
                        <BR>
						</center>
                		</form></td>
                </tr>
                <tr>
 					<!--The variable msg is displayed after the tables -->               
                	<td height="30" align="center" bgcolor="#339933"> <%response.write(msg)%></td>
                </tr>
                </table>
  			<!--The image if the restaurant -->                 
			<p><center><img src="images/res1.jpg" width="1200" height="300"></center></p>

        </div>    
	</div> 
        
	</body>
    
</html>
