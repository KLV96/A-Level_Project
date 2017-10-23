<%

' Declaring the variables and connecting to the database
Dim Con, rs1, sql, ItemID, UPDATEButton, Ingredient, Price, exist
Set Con1 = Server.CreateObject("ADODB.Connection")
Set rs1 = Server.CreateObject("ADODB.Recordset")

Con1.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
' Collects all the Items in the databse  
sql1 = "SELECT * FROM Item Order By ItemID"

' Opends the recordset 
rs1.Open sql1, Con1

' assigning the value that has been entered by the admin in the Item ID text field into the variable ItemID
ItemID = request.form("ItemID")
' assigning the value of the Update button to the variable UPDATEButton
UPDATEButton = request.form("UPDATEButton")
' assigning the value that has been entered by the admin in the Item Name text field into the variable ItemName
ItemName = request.form("ItemName")
' assigning the value that has been entered by the admin in the Ingredient text field into the variable Ingredient
Ingredient = request.form("Ingredient")
' assigning the value that has been entered by the admin in the Price text field into the variable Price
Price = request.form("Price")
'assigning false to the variable exist
exist = False

' To check if the Item ID already exists in the databse. If it does True is assigned to the variable exist
while not rs1.EOF AND not exist 
	If rs1("ItemID") = ItemID then 
		exist = TRUE
	End if 
	' Moving to the next record in the recordset 
	rs1.movenext
wend

' If the admin has pressed the Update button then a series of validation will take place. And if the Item ID was valid then the Item details will be updated 
If UPDATEButton <> "" then 
	' Checking if the Item ID text field is empty. If so an error message will be displayed 	
	If ItemID = "" then 
	msg="<center><b><span style=""color:#F00""> Please enter the Item code </span></b></center>"
	elseif len(ItemID) > 3 then 
	msg="<center><b><span style=""color:#F00""> Please make sure that the length is maximum of 3 characters </span></b></center>"
	' Checking if the Item Name text field is empty. If so an error message will be displayed 
	elseif ItemName = "" then 
	msg="<center><b><span style=""color:#F00""> Please enter Item Name </span></b></center>"
	' Checking if the length of the  Itembame is more than or equal to 20. If so an error message will be displayed f so 
	elseif len(ItemName) => 20 then 
	msg="<center><b><span style=""color:#F00""> Please make sure that the Item name is less than 21 characters </span></b></center>"
	' Checking if the Ingredient text field is empty. If so an error message will be displayed 
	elseif Ingredient = "" then 
	msg="<center><b><span style=""color:#F00""> Please enter the Ingredient </span></b></center>"
	' Checking if the length of the  Ingredient is more than or equal to 40. If so an error message will be displayed f so 
	elseif len(Ingredient) => 40 then 
	msg="<center><b><span style=""color:#F00""> d</span></b></center>"
	' Checking if the Price text field is empty. If so an error message will be displayed 
	elseif Price = "" then 
	msg="<center><b><span style=""color:#F00""> Please enter the Price </span></b></center>"
	elseif exist = TRUE then 
	msg="<center><b><span style=""color:#F00""> The Item ID already exist, please change it   </span></b></center>"
		
	ELSE 
	
	' The data will be updated by executing the sql statement 
	Set Con = Server.CreateObject("ADODB.Connection")
	Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
	vare = request.QueryString("ItemID")
	sql = "UPDATE Item SET ItemID='"&request.form("ItemID")&"', ItemName='"&request.form("ItemName")&"', Ingredient='"&request.form("Ingredient")&"', Price='"&request.form("Price")&"' WHERE ItemID='"&vare&"'"
	response.Write(sql)
	
	con.execute(sql)
	
	' And the admin will be redirected to the ManagerChangeMenu page where the admin will be able to view the changes 
	response.Redirect("ManagerChangeMenu.asp")
	
	END IF 

END IF 



%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" href="styles.css" > 
        <title>Rojava restaurant - About</title>
        </head>
        
        <body>
        
        <div class="container">
          <div class="content">
          <center><img src="images/logo.png" /></center>
            <hr />
          <center><font size ="5"><a href="ManagerDailyOrders.asp">Daily Orders</a> | <a href="ManagerMonthlyOrders.asp">Monthly Orders</a> | <a href="ManagerCalculateProfit.asp">Calculate Profit</a> | <a href="ManagerMonthlyAnalysis.asp">Monthly Profit Analysis</a> | <a href="ManagerOrderAnalysis.asp">Monthly Orders Analysis</a> |<a href="ManagerDisplayMembers.asp"> Cancel Members</a> | <a href="ManagerChangeMenu.asp">Change Menu</a> | <a href="index.asp"> Log Out </a></font></center> 
            <hr />
            <h1>Edit Menu</h1>
            
           
        <!-- The error message will be displayed and the page will be redirected to the ManagerChangeMenu.asp in 3 seconds of clicking the update button  -->
        <%response.Write(msg)
        
        Response.AddHeader "Refresh", "3;ManagerChangeMenu.asp" 
        
        %>
          </div>
         </div>
    </body>
</html>