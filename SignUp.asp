<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" href="styles.css" > 
		<!--changing the icon to the restaurant's icon --> 
        <link rel="icon" href="Images/favicon.ico"> 
        <title>Rojava restaurant - Sign up</title>	
	</head>

	<body>

        <div class="container">
          <div class="content">
          <center><img src="images/logo.png" /></center>
            <hr />
           <center>
			<!-- The navigation bar -->             
            <font size ="5"><a href="index.asp">Home</a> | <a href="menu.asp">Menu</a> | <a href="About.asp">About</a> |<a href="SignUP.asp">Sign Up</a> </font>  
            </center>  
            <hr />
            <h1>Create an account </h1>
            <table width="400" border="2" align="center">
			<!-- A form is used to pass the data to the Add customer page -->              
            <form name="form" method="post" action="AddCustomer.asp">
               <tr>
                <td width="300" bgcolor="#FFFF99"><strong>Username</strong></td>
				<!-- A text field is used and named UN where the user types in the username  -->                    
                <td bgcolor="#FFFF99"><input type="text" name="UN" id="UN"></td>
              </tr>
              <tr>
                <td width="300" bgcolor="#33CC66"><strong>First Name</strong></td>
				<!-- A text field is used and named FN where the user types in the First name  -->                 
                <td width="141" bgcolor="#33CC66"><input type="text" name="FN" id="FN"></td>
              </tr>
              <tr>
                <td width="300" bgcolor="#FFFF99"><strong>Surname</strong></td>
				<!-- A text field is used and named SN where the user types in the Surname  -->                 
                <td bgcolor="#FFFF99"><input type="text" name="SN" id="SN"></td>
              </tr>
              <tr>
                <td width="300" bgcolor="#33CC66"><strong>Contact Number</strong></td>
				<!-- A text field is used and named cn where the user types in the contact number  -->                 
                <td bgcolor="#33CC66"><input type="text" name="cn" id="cn"></td>
              </tr>
              <tr>
                <td height="26" align="left" bgcolor="#FFFF99"><strong>Email Address </strong></td>
				<!-- A text field is used and named Email where the user types in the Email  -->                 
                <td height="26" align="center" bgcolor="#33CC66"><input type="text" name="Email" id="Email"></td>
              </tr>
              <tr>
				<!-- A text field is used and named AD where the user types in the Address  -->               
                <td width="300" bgcolor="#33CC66"><strong>Address </strong></td>
                <td bgcolor="#FFFF99"><input type="text" name="AD" id="AD"></td>
              </tr>
              <tr>
				<!-- A text field is used and named PA where the user types in the password  -->               
                <td width="300" bgcolor="#FFFF99"><strong>Password</strong></td>
                <td bgcolor="#33CC66"><input type="password" name="PA" id="PA"></td>
              </tr>
              <tr>
				<!-- A text field is used and named REPA where the user retypes in the password  -->               
                <td width="300" height="26" bgcolor="#33CC66"><strong>Re-Enter Password</strong></td>
                <td bgcolor="#FFFF99"><input type="password" name="REPA" id="REPA"></td>
              </tr>
              <tr>
                <td height="26" colspan="2" align="center" bgcolor="#FFFF99">
				<!-- A button is used for the user to press to try to Register  -->                    
                  <input type="submit" name="Submit" id="SU" value="Register">
                </form></td>
              </tr>
              
            </table>
           </div>
         </div>
	</body>
</html>
