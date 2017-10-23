<!--This is inclufing the file ACN where the function ProtectSQL is held-->
<!--#include file="ACN.asp"-->
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" href="styles.css" > 
        <!--changing the icon to the restaurant's icon --> 
        <link rel="icon" href="Images/favicon.ico"> 
		<title>Rojava restaurant - Add Order</title>
		<style type="text/css">
		
		.DNS
		{
		
		float: left;
		margin-left: 100px;
		position: absolute;
		
		}
		
		.popup {
		zoom:1.0;
		position:relative;
		text-decoration:none;
		}
		.popup span {
		position:absolute;
		top:0px;
		left:400px;
		width:350px;
		padding:7px;
		border:7px solid #000;
		border-radius:10px;
		left:-999em;
		z-index:990;
		
		}
		.popup:hover {visibility:visible}
		.popup:hover span {left:200px;}
		* html .popup span {position:absolute;}
		</style>
<%
'Declare variables
dim Con, rs1, rs2, sql1, sql2, sql3, sql4, exist, exist2, MyDate, Mytime, AddItem, MakeanOrder, FinishOrder, ItemID, ItemQuantity 
' Assigning the date that the user opens the page into the variable MyDate
MyDate = Date
' Assigning the time that the user opens the page into the variable MyDate
Mytime = FormatDateTime(now(),vbshorttime)
' Using the function ProtectSQL The value of the button is requested safely 
AddItem = ProtectSQL(request.form("AddItem"))
' Using the function ProtectSQL The value of the button is requested safely 
MakeanOrder = ProtectSQL(request.form("MakeanOrder"))
' Using the function ProtectSQL The value of the button is requested safely
FinishOrder = ProtectSQL(request.form("FinishOrder"))
' Using the function ProtectSQL The text that has been entered in the ItemID field is being selected safely 
ItemID = ProtectSQL(request.form("OrderID"))
' Using the function ProtectSQL The text that has been entered in the ItemQuantity field is being selected safely 
ItemQuantity  = ProtectSQL(request.form("Quant"))

' If the user tries to enter this page without signing in they will be redirected to the index page where they need to enter the login details 
if session("Username") = ""  then
response.redirect("index.asp")
end if

' Connecting to the databse and setting three recordsets 
Set Con = Server.CreateObject("ADODB.Connection")
Set rs1 = Server.CreateObject("ADODB.Recordset")
set rs2 = Server.CreateObject("ADODB.Recordset")
set rs3 = Server.CreateObject("ADODB.Recordset")

' opens the connection 
Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb")) 

'SQL1 selecting all the items in the database which is used for the menu 
sql1 = "SELECT * FROM Item Order By ItemID"

'opens the recordset 
rs1.Open sql1, Con

' IF statement is used to allow the customer to place orders only when the restaurant is open, if the time is not when the restaunrant is open, an error message will be displayed
'If not time>#09:00AM# and time < #11:00PM# then 
	'msg="<center><b><span style=""color:#F00""> Sorry, You can only make an order in the opening  time of the restaurant </span></b>	</center>"

'ELSE
	' If the user has pressed the Make an Order button, the sql2 will run where the username, date and time will be inserted into the tblOrder tabel. 
	IF MakeanOrder  <>  "" then 
		sql2 = "INSERT INTO tblOrder (UN,Orderdate, Ordertime) VALUES ( '"&session("Username")&"', '"&MyDate&"', '"&Mytime&"' )"
		con.execute(sql2)
	End if 
	
	' IF the Add an Item to the order has been pressed then series of validation will occur 
	If AddItem <> "" then 
		' Checking if the ItemID text field is empty. If so an error message will be displayed 
		IF ItemID = "" then 
			msg="<center><b><span style=""color:#F00""> Please enter the Item code </span></b></center>"
			' Checking if the length of the value that has been entered by the user in the ItemID text field is less than 3, If it is 3 or more an error message will be displayed  
			elseif len(ItemID) > 3 then 
			msg="<center><b><span style=""color:#F00""> Please enter a valid Item ID  </span></b></center>"
			' Checking if the ItemQuantity text field is empty. If so an error message will be displayed 
			Elseif  ItemQuantity = "" then 
			msg="<center><b><span style=""color:#F00""> Please enter the Quantity </span></b></center>"
			' Checking if the length of the value that has been entered by the user in the ItemQuantity text field is more than 2, If so an error message will be displayed  
			elseif len(ItemQuantity) > 2 then 
			msg="<center><b><span style=""color:#F00""> Please enter a valid quantity  </span></b></center>"
			' Checking if the value that has been entered by the user in the ItemQuantity text field is more than 21, If so an error message will be displayed  
			elseif ItemQuantity > 21 then 
			msg="<center><b><span style=""color:#F00""> Please enter a quantity less than or equal to 20  </span></b></center>"
		
		'If the data that has been entered by the user is valid then it will connect to the database inorder to perfome further validations and addding the order to the database 
		Else 
			
			' This SQL statement selects the order ID of the last time the user has pressed the Make an Order button 
			sql3 = "SELECT TOP 1 (OrderID) FROM tblOrder WHERE UN='"& Session("Username")&"' AND TypeOfOrder='PO' ORDER BY OrderID DESC"
			'recordset2 is opened 
			rs2.open sql3, con
			' the last orderId which is selected using sql3 is assigned into the variable OrderID 
			OrderID = rs2("OrderID")
			' the Order ID variable is assigned to secction OrderID 
			session("OrderID") = OrderID
			' Recordset 2 is closed
			rs2.close
			
			' This sql statement selects the ItemID from the ItemOrder tabel Where the orderID is the same as the one is given to the user after pressing the Make an Order button
			sql4 = "SELECT ItemID from ItemOrder WHERE 	OrderID ="& OrderID
			
			'Opends recordset2 
			rs2.open sql4, con
			
			'Initialising the exist and esist2 variables 
			exist = False
			exist2 = False
	
			
			' Going through the recorset3 using a while loop while it is not end of file and exist2 is false. This is used to check if the user has oreder the same Item or not ( to prevent duplicate data)
			while not rs2.EOF AND not exist 
				'If the Item ID has been entered already exists in the database (ItemOrder tabel) then True will be assigned to exist 
				If rs2("ItemID") = ItemID then 
				exist = TRUE
				End if 
				' moving to the next record in the recordset2 
				rs2.movenext
			'end of the while loop
			wend

			'sql3 selects every field in the Item tabel and orders it by the Item ID 
			sql3 = "SELECT * FROM Item Order By ItemID"
			rs3.open sql3, con
			
			'Going through the recorset2 using a while loop while it is not end of file and exist is true. This is used to check whether or not the Item ID entered by the user is valid or not ( exists in the menu or not ) 
			while not rs3.EOF AND not exist2 
				'If the Item ID has been entered already exist in the database then True will be assigned to exist 
				If rs3("ItemID") = ItemID then 
				' True is assigned to exist2
				exist2 = TRUE
				End if 
				' moving to the next record in the recordset3 
				rs3.movenext
			wend
			
			' A nested IF statement has been used to determine whether or not the Item ID exsist in the menu and the nested if statement checks if the Item ID entered already exist in the order or not  
			IF not exist then 
				IF  exist2 then 	
					sql4 = "INSERT INTO ItemOrder (OrderID,ItemID,Quantity) VALUES ('"&OrderID&"','"&ItemID&"','"&ItemQuantity&"')"
					con.execute(sql4)
				Else
					'IF the Item ID does not exist in the menu, an error message will be displayed 
					msg="<center><b><span style=""color:#F00""> Please enter a valid Item ID  </span></b></center>"
				End if 
			Else
				'IF the Item ID already exists in the tblOrder tabel, an error message will be displayed 
				msg = "<center><b><span style=""color:#F00""> Item ID already exist ( You have ordered this item )</span></b></center>" 
			End IF
		End IF	
	End if 


	' This If statement is used to determine the time that the order was made 
	If FinishOrder <> "" then 
		'the minute that the Make an Order button has been presed will be assigned to the FMT variable 
		FMT = Minute(time) 
		' FMT variable is stored into the session Time variable which will be used in the receipt.asp page 
		session("Time") = FMT
		' The user will be redirected to the receipts page where they will be able to submit or cancel the order within a limited amount of time 
		response.redirect("receipt.asp")
	End if 

'End IF 

%>

	</head>

	<body>

        <div class="container">
        	<div class="content">
            	<!--The image of the banner -->
            	<center><img src="images/banner.jpg" width="1200" height="100"/></center>
            	<hr />
                <!--The navigation bar -->
            	<center><font size ="5"> <a href="AddOrder.asp"> Make an Order</a> | <a href="MyOrders.asp">My Orders </a> | <a href="DisplayProfile.asp">Profile</a> | <a href="index.asp">Logout</a> </font></center>
            	<hr />
                <h1> Make an Order</h1>
                 <!-- welcoming the user using the username -->
                <h2>  ** Hello <%=session("username")%> **</h2>
                <!-- a message for the user to let them know that they need to press on the Make an Order button -->
                <p><strong>Please press Make an order button to be able to add the Item ID and Quantity : </strong></p>
                <form name="form1" method="post" action="AddOrder.asp">
                
                <!-- A tabel of 3 rows and 2 columns  -->
                <table width="434" border="1" align="center">
                    <tr>
                        <td colspan="2" align="center" valign="bottom" bgcolor="#FFFFCC"><input type="submit" name="MakeanOrder" id="MakeOrder" value="Make an Order"></td>
                    </tr>
                    <tr>
                        <td width="209" align="center" bgcolor="#66FF66"><strong>Item ID</strong></td>
                        <td width="209" align="center" bgcolor="#66FF66"><strong>Quantity</strong></td>
                    </tr>
                    <tr>
                        <td><input name="OrderID" type="text" id="OrderID" size="34"></td>
                        <td><input name="Quant" type="text" id="Quant" size="34"></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" valign="bottom" bgcolor="#66FF66">
                        <input type="submit" name="AddItem" id="OrderButton" value="Add Item to the order">
                        <input type="submit" name="FinishOrder" id="OrderButton2" value="Finish the Order">
                        </td>
                    </tr>     
                </table>
                </form>
                <!-- Displaying the variable msg which holds the error message -->
					<%response.Write(msg)%>
                </p>
                    <div class="container">
                        <div class="content">
                        <hr />
                        <h1> Menu </h1>
                        </div>
                <center>
                
                <!-- This tabel is used for the menu -->
            	<table class="DNS" width="500" border="1" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center"><strong><p> Item ID </p></strong></td>
                        <td align="center"><strong><p> Item Name </p></strong></td>
                        <td align="center"><strong><p> Ingredient </p></strong></td>
                        <td align="center"><strong><p> Price </p></strong></td>
                        <td align="center"><strong><p> Image </p></strong></td>
                    </tr>
                    <!-- A while loop not end of file is used to display all the items  -->
                    <% while not rs1.EOF%>
                    <tr align="center">
                        <td><strong><%=rs1("ItemID")%></strong></td>
                        <td><strong><%=rs1("ItemName")%></strong></td>
                        <td><strong><%=rs1("Ingredient")%></strong></td>
                        <!-- The function FormatCurrency is used to display the price is pounds  -->
                        <td><strong><%=(FormatCurrency(rs1("Price")))%></td>
                        <!-- A css is used to make the Image pop up when the user hovver over the word Image -->
                        <td><a class="popup" href="#">Image<span><img src="<%=rs1("Image")%>" ></span></a></td>
                    </tr>
                    <%
					' moving to the next record in the recordset to display all the items 
                    rs1.movenext
					'End of the while loop 
                    wend
                    %>
                </table> 
                </center>
        	</div>
		</div>
	</body>
</html>
