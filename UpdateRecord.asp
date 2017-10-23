<!--This is inclufing the file ACN where the function ProtectSQL is held-->
<!--#include file="ACN.asp"-->
<%

' If the user tries to enter this page without signing in they will be redirected to the index page where they need to enter the login details 
if session("Username") = ""  then
  response.redirect("index.asp")
end if

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

'To check if the username is empty, if so then an error message will be displayed informing the user to type in the username 
IF FN ="" then 
	msg="<center><b><span style=""color:#F00"">Please provide your First Name </span></b></center>"
'To check iF the First name is in between 3 and 20 characters, if not then an error message will be displayed informing the user that the first name should be in between 3 and 20 characters 
ELSEIF len(FN) > 20 or len(FN) < 3 then
	msg="<center><b><span style=""color:#F00"">Please make sure that the first name is in between 3 and 20 characters</span></b></center>"
'To check if the First name does not consists of numbers, If does then an error message will be displayed infroming the user that the first name cannot be numbers 	
ELSEIF IsNumeric(FN) Then 
	msg="<center><b><span style=""color:#F00"">Please make sure that the first name does not have any numbers</span></b></center>"
'To check if the surname is not empty, if is then an error message will be displayed informing the user to type in the surname	
ELSEIF SN ="" then 
	msg="<center><b><span style=""color:#F00"">Please provide your Surname </span></b></center>"
'To check if the surname is in between 3 and 20 characters, if not then an error message will be displayed informing the user that the surename should be in between 3 and 20 characters 
ELSEIF len(SN) > 20  or len(SN) < 3 then
	msg="<center><b><span style=""color:#F00"">Please make sure that the surname is in between 3 and 20 characters</span></b></center>"
'To check if the surname is in between 3 and 20 characters, if not then an error message will be displayed informing the user that the surename should be in between 3 and 20 characters 	
ELSEIF IsNumeric(SN) Then 
	msg="<center><b><span style=""color:#F00"">Please make sure that the surname does not have any numbers</span></b></center>"
'To check if the contact number text field is not empty, if is then an error message will be displayed informing the user to type in the contact number 	
ELSEIF cn ="" then 
	msg="<center><b><span style=""color:#F00"">Please provide your Contact number </span></b></center>"
'To check if the contact number consists of 11 degits, if not then an error message will be displayed informing the user to type in a real number 	
ELSEIF len(cn) <> 11 then 
	msg="<center><b><span style=""color:#F00"">Please provide a real phone number</span></b></center>"
'To check if the contact number consists just numbers, if not then an error message will be displayed informing the user that the contact number should not have any letters
ELSEIF not IsNumeric(cn) Then
	msg="<center><b><span style=""color:#F00"">Please provide a real phone number, the phone number should not have any letters </span></b></center>"
' To check if the 3 first degirs of the contact number starts with either 070 to 079 or starts with 020, if not then an error message will be displayed informing the user to type in a contact number that is registered in London
ELSEIF not ((FThreecn >= 070 and FThreecn <= 079) OR FThreecn = 020) then 
	msg="<center><b><span style=""color:#F00"">Please provide a mobile number which is served in the UK or check if the phone number is registered in London</span></b></center>"
'To check if the Email text field is not empty, if is then an error message will be displayed informing the user to type in the Email 
ELSEIF Email ="" then 
	msg="<center><b><span style=""color:#F00"">Please provide your Email </span></b></center>"
' To check if the variable goby is not zero ( which means that the Email must have the @ sign or the . ), If not ( if either the @ sign or the . is missing or both) then an error message will be displayed informing the user toy type in a real email address
ELSEIF goby<>0 then
	msg="<center><b><span style=""color:#F00"">Please provide a real email address</span></b></center>"
'To check if the address text field is not empty, if is then an error message will be displayed informing the user to type in the address 
ELSEIF AD ="" then 
	msg="<center><b><span style=""color:#F00"">Please provide your Address </span></b></center>"
'To check if the address does not only consisting of numbers, If does then an error message will be displayed infroming the user that the address cannot be just numbers
ELSEIF IsNumeric(AD) Then
	msg="<center><b><span style=""color:#F00"">Please make sure that the address is not just number </span></b></center>"
' To check the length of the Address is not more than 50 characters, if is then an error message will be displayed infroming the user that address must be less than 50 characters 
ELSEIF len(AD) > 50  then 
	msg="<center><b><span style=""color:#F00"">Please make sure that the address is not more than 50 characters</span></b></center>"
'To check if the Password text field is not empty, if is then an error message will be displayed informing the user to type in the Password 
elseif PA ="" then 
	msg="<center><b><span style=""color:#F00"">Please provide your Password </span></b></center>"
'To check if the length of the Password is in between 8 and 15 characters, if not then an error message will be displayed informing the user that the password must be more than 7 characters and less than 15  	
elseif len(PA) < 7 And len(PA) >= 15 then 
	msg="<center><b><span style=""color:#F00"">Please make sure that the Password length is more than 7 characters and less than 15 characters </span></b></center>"
'To check that the password is not the same as the username, if so then an error message will be displayed informing the user that the password cannot be the same as the username 
ELSEIF PA=UN then
	msg="<center><b><span style=""color:#F00"">Please make sure that the Password cannot be the same as Username</span></b></center>"
'To check that the password must has the @ sign which increases the protection of the password, if not then an error message will be displayed to inform the user that the password must has the @ sign 
ELSEIF Instr(1, PA, "@", 1) <2 then 
	msg="<center><b><span style=""color:#F00"">Please make sure that the Password contains @ sign</span></b></center>"
'To check if the Re-Enter password text field is not empty, if is then an error message will be displayed informing the user to type in the Re-Enter password 	
ELSEIF REPA ="" then 
	msg="<center><b><span style=""color:#F00"">Please provide your Re-Password, Click Sign up again</span></b></center>"
' To check if the password is the smae as the Re-Enter password, if not then an error message will be displayed informing the user that the password must be the same as the Re-Enter password
ELSEIF PA <> REPA then 
	msg= "<center><b><span style=""color:#F00"">Please make sure that the password and the Re-password matches</span></b></center>"	

ELSE

	' Connects to the database 
	Set con = Server.CreateObject("ADODB.Connection")
	con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
	'Creating a recordset	
	Set rs = Server.CreateObject("ADODB.Recordset")
	' The SQL statement Updates the data that the user has entered in each of the previous text fields after checking each one of them 
	sql = "UPDATE Customer SET fn='"&request.form("FN")&"', SN='"&request.form("SN")&"', cn='"&request.form("cn")&"',Email='"&request.form("Email")&"',AD='"&request.form("AD")&"', PA='"&request.form("PA")&"'  WHERE UN = '"& session("username") & "'"  
	rs.Open sql, con
	'Executes the sql statement 
	con.execute(sql)
	'Redirect the customer to the Display Profile page where they will be able to see the updated data
	response.Redirect("DisplayProfile.asp")

End IF 

%>

