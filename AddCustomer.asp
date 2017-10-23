<!--This is inclufing the file ACN where the function ProtectSQL is held-->
<!--#include file="ACN.asp"-->

<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" href="styles.css" > 
        <!--Changeging the icon to the restaurant's icon --> 
        <link rel="icon" href="Images/favicon.ico">
        <title>Rojava restaurant - Add customer	</title>
	</head>

	<body>

        <div class="container">
            <div class="content">
            	 <!--The logo image of the restaurant --> 
                <center><img src="images/logo.png" /></center>
                <hr />
                <!-- The navigation bar -->  
                <center><font size ="5"><a href="index.asp">Home</a> | <a href="menu.asp">Menu</a> | <a href="About.asp">About</a> |<a href="SignUP.asp">Sign Up</a> </font></center>  
                <hr />
                <h1>Create an account </h1>
            </div>
        </div>
	</body>
    
</html>
<%
' Using the function ProtectSQL The value of the button is requested safely 
getSub =  ProtectSQL(Request.form("Submit"))
'If the user pressed on Register button then 
IF getSub = "Register" THEN 
	'Declare variables  
	Dim UN,FN,SN,cn,Email,AD,PA,REPA,getSub,PN,FThreecn, goby
	' Using the function ProtectSQL The text that has been entered in the Username field is being selected safely
	UN = ProtectSQL(Request.form("UN"))
	' Using the function ProtectSQL The text that has been entered in the First name field is being selected safely
	FN = ProtectSQL(Request.form("FN"))
	' Using the function ProtectSQL The text that has been entered in the Surname field is being selected safely
	SN = ProtectSQL(request.form("SN"))
	' Using the function ProtectSQL The text that has been entered in the contact number field is being selected safely
	cn = ProtectSQL(request.form("cn"))
	' Using the function ProtectSQL The text that has been entered in the Email field is being selected safely
	Email = ProtectSQL(request.form("Email"))
	' Using the function ProtectSQL The text that has been entered in the Address field is being selected safely
	AD = ProtectSQL(request.form("AD"))
	' Using the function ProtectSQL The text that has been entered in the Password field is being selected safely
	PA = ProtectSQL(request.form("PA"))
	' Using the function ProtectSQL The text that has been entered in the Re-Enter Password field is being selected safely
	REPA = ProtectSQL(request.form("REPA"))
	' The First three degits of the contact number is assigned to the variable FThreecn
	FThreecn = Left (cn, 3)

	' 0 is assigned to the variable goby
	goby=0
	'If the length of the variable Email is not in between 5 and 39 characters then 
	IF len(Email)<= 5 or len(Email) > 40 then
		' 1 is assigned to the variable goby
		goby=1
	END IF
	'The InStr function checks if the email has @ sign after the first character 
	IF Instr(1, Email, "@", 1) < 2 then
		' 1 is assigned to the variable goby
		goby=1
	Else
		'The InStr function checks if the email has dot (.) after the first character 
		IF Instr(1, Email, ".", 1) < 4 then
			goby=1
		END IF
	END IF

	' connecting to the database 
	Set con = Server.CreateObject("ADODB.Connection")
	con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
	' Creating a recordset
	Set rs = Server.CreateObject("ADODB.Recordset")
	' The SQL statement selects all the details of the customer from the cusetom details where the UN is the variable username and the Email is the variable Email 
	sql = "SELECT * FROM Customer WHERE UN = '" & UN & "' OR Email = '" & Email & "'"
	' Opens the recordset
	rs.Open sql, con

	' IF the end of file of the recordset is false then 
	IF rs.EOF = false then
		' IF the recordset Email is the same as the variable Email then 
		IF rs("Email") = Email then 
			'An error message will be displayed to the user informing them that the Email that they have entered exsists in the database 
			response.Write("<center><b><span style=""color:#F00"">  Email exist, please try another email  </span></b></center>")    
		Else 
			'An error message will be displayed to the user informing them that the USername that they have entered exsists in the database 
			response.Write("<center><b><span style=""color:#F00""> Username already exist, please try another Username  </span></b></center>")  
		END IF
	END IF 

	'To check if the username is empty, if so then an error message will be displayed informing the user to type in the username 
	IF UN ="" then 
		response.Write("<center><b><span style=""color:#F00"">Please provide your Username, Click Sign up again</span></b></center>")
	'To check if the length of the username is in between 3 and 10 characters, if not then an error message will be displayed informing the user to check the length of the username 
	ELSEIF len(UN) > 10 or len(UN) < 3 then
		response.Write("<center><b><span style=""color:#F00"">Please make sure that the username is in between 3 and 10 characters</span></b></center>")
	'To check if the username consists of just numbers, If so an error message will be displayed infroming the user that the username cannot be just numbers 
	ELSEIF IsNumeric(UN) Then
		response.Write("<center><b><span style=""color:#F00"">Please make sure that the username is not just number </span></b></center>")
	'To check if the First name is empty, if so then an error message will be displayed informing the user to type in the username 
	ELSEIF FN ="" then 
		response.Write("<center><b><span style=""color:#F00"">Please provide your First Name, Click Sign up again</span></b></center>")
	'To check iF the First name is in between 3 and 20 characters, if not then an error message will be displayed informing the user that the first name should be in between 3 and 20 characters 
	ELSEIF len(FN) > 20 or len(FN) < 3 then
		response.Write("<center><b><span style=""color:#F00"">Please make sure that the first name is in between 3 and 20 characters</span></b></center>")
	'To check if the First name does not consists of numbers, If does then an error message will be displayed infroming the user that the first name cannot be numbers 
	ELSEIF IsNumeric(FN) Then 
		response.Write("<center><b><span style=""color:#F00"">Please make sure that the first name does not have any numbers</span></b></center>")
	'To check if the surname is not empty, if is then an error message will be displayed informing the user to type in the surname 
	ELSEIF SN ="" then 
		response.Write("<center><b><span style=""color:#F00"">Please provide your Surname, Click Sign up again</span></b></center>")
	'To check if the surname is in between 3 and 20 characters, if not then an error message will be displayed informing the user that the surename should be in between 3 and 20 characters 
	ELSEIF len(SN) > 20  or len(SN) < 3 then
		response.Write("<center><b><span style=""color:#F00"">Please make sure that the surname is in between 3 and 20 characters</span></b></center>")
	'To check if the surname is in between 3 and 20 characters, if not then an error message will be displayed informing the user that the surename should be in between 3 and 20 characters 
	ELSEIF IsNumeric(SN) Then 
		response.Write("<center><b><span style=""color:#F00"">Please make sure that the surname does not have any numbers</span></b></center>")
	'To check if the contact number text field is not empty, if is then an error message will be displayed informing the user to type in the contact number 
	ELSEIF cn ="" then 
		response.Write("<center><b><span style=""color:#F00"">Please provide your phone number, Click Sign up again</span></b></center>")
	'To check if the contact number consists of 11 degits, if not then an error message will be displayed informing the user to type in a real number 
	ELSEIF len(cn) <> 11 then 
		response.Write("<center><b><span style=""color:#F00"">Please provide a real contact number</span></b></center>")
	'To check if the contact number consists just numbers, if not then an error message will be displayed informing the user that the contact number should not have any letters
	ELSEIF NOT IsNumeric(cn) Then
		response.Write("<center><b><span style=""color:#F00"">Please provide a real phone number, the phone number should not have any letters </span></b></center>")
	' To check if the 3 first degirs of the contact number starts with either 070 to 079 or starts with 020, if not then an error message will be displayed informing the user to type in a contact number that is registered in London
	ELSEIF NOT ((FThreecn >= 070 and FThreecn <= 079) OR FThreecn = 020) then 
		response.Write("<center><b><span style=""color:#F00"">Please provide a mobile number which is served in the UK or check if the phone number is registered in London</span></b></center>")
	'To check if the Email text field is not empty, if is then an error message will be displayed informing the user to type in the Email 
	ELSEIF Email ="" then 
		response.Write("<center><b><span style=""color:#F00"">Please provide your Email, Click Sign up again</span></b></center>")
	' To check if the variable goby is not zero ( which means that the Email must have the @ sign or the . ), If not ( if either the @ sign or the . is missing or both) then an error message will be displayed informing the user toy type in a real email address
	ELSEIF goby<>0 then
		response.Write("<center><b><span style=""color:#F00"">Please provide a real email address</span></b></center>")
	'To check if the address text field is not empty, if is then an error message will be displayed informing the user to type in the address 
	ELSEIF AD ="" then 
		response.Write("<center><b><span style=""color:#F00"">Please provide your Address, Click Sign up again</span></b></center>")
	'To check if the address does not only consisting of numbers, If does then an error message will be displayed infroming the user that the address cannot be just numbers
	ELSEIF IsNumeric(AD) Then
		response.Write("<center><b><span style=""color:#F00"">Please make sure that the address is not just number </span></b></center>")
	' To check the length of the Address is not more than 50 characters, if is then an error message will be displayed infroming the user that address must be less than 50 characters 
	ELSEIF len(AD) > 50  then 
		response.Write("<center><b><span style=""color:#F00"">Please make sure that the address is not more than 50 characters</span></b></center>")
	'To check if the Password text field is not empty, if is then an error message will be displayed informing the user to type in the Password 
	ELSEIF PA ="" then 
		response.Write("<center><b><span style=""color:#F00"">Please provide your Password, Click Sign up again</span></b></center>")
	'To check if the length of the Password is in between 8 and 15 characters, if not then an error message will be displayed informing the user that the password must be more than 7 characters and less than 15  	
	ELSEIF len(PA) < 7 And len(PA) >= 15 then 
		response.Write("<center><b><span style=""color:#F00"">Please make sure that the Password length is more than 7 characters and less than 15 characters, Click Sign up again</span></b></center>")
	'To check that the password is not the same as the username, if so then an error message will be displayed informing the user that the password cannot be the same as the username 
	ELSEIF PA=UN then
		response.Write("<center><b><span style=""color:#F00"">Please make sure that the Password cannot be the same as Username</span></b></center>")
	' To check that the password must has the @ sign which increases the protection of the password, if not then an error message will be displayed to inform the user that the password must has the @ sign 
	ELSEIF Instr(1, PA, "@", 1) <2 then 
		response.Write("<center><b><span style=""color:#F00"">Please make sure that the Password contains @ sign, Click Sign up again</span></b></center>")
	' To check if the username cannot be present in the password, If it is then an error message will be displayed informing the user that the username cannot exist fully in the password 
	ELSEIF instr(lcase(PA), lcase(UN))>0 then
		response.Write("<center><b><span style=""color:#F00"">Username cannot be contained fully within the Password</span></b></center>")
	'To check if the Re-Enter password text field is not empty, if is then an error message will be displayed informing the user to type in the Re-Enter password 	
	ELSEIF REPA ="" then 
		response.Write("<center><b><span style=""color:#F00"">Please provide your Re-Password, Click Sign up again</span></b></center>")
	' To check if the password is the smae as the Re-Enter password, if not then an error message will be displayed informing the user that the password must be the same as the Re-Enter password
	ELSEIF PA <> REPA then 
		response.Write("<center><b><span style=""color:#F00"">Please make sure that the password and the Re-password matches</span></b></center>")
	ELSE
		' Connects to the database 
		dim Con
		'Creating a recordset 
		Set Con = Server.CreateObject("ADODB.Connection")
		Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
		' The SQL statement inserts the data that the user has entered in each of the previous text fields after checking each one of them 
		sql = "INSERT INTO Customer (UN,FN,SN,cn,Email,AD,PA) VALUES ('"&request.form("UN")&"','"&request.form("FN")&"','"&request.form("SN")&"','"&request.form("cn")&"','"&request.form("Email")&"','"&request.form("AD")&"','"&request.form("PA")&"')"
		'Executes the sql statement 
		con.execute(sql)
		' A message will be displayed to the user using the username that they have entered to thank them 
		msg= "<center><b><span style=""color:#F00"">Thank you " & UN &", We hope you enjoy our products</span></b></center> "
		' Displays the variable msg 
		response.Write(msg)
	END IF 
	
End IF 


%>