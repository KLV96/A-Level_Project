<%
OrderID = session("WOrderID")
  Dim Con, rs1, sql
  Set Con1 = Server.CreateObject("ADODB.Connection")
  Set rs1 = Server.CreateObject("ADODB.Recordset")
  
  Con1.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb")) 
  sql1 = "SELECT * FROM ItemOrder where OrderID ="&OrderID&" "
 ' response.Write(sql1)

  rs1.Open sql1, Con1


OLDItemID = request.QueryString("ItemID")
ItemID = request.form("ItemID")
UPDATEButton = request.form("UPDATEButton")
ItemQuantity = request.form("Quantity")
Price = request.form("Price")
OLDITEMID= session("OLDITEMID")





If UPDATEButton <> "" then 
	
	If ItemID = "" then 
	msg="<center><b><span style=""color:#F00""> Please enter the Item code </span></b></center>"
	elseif len(ItemID) > 3 then 
	msg="<center><b><span style=""color:#F00""> Please make sure that the length is maximum of 3 characters </span></b></center>"
	Elseif ItemQuantity = "" then 
	msg="<center><b><span style=""color:#F00""> Please enter the Quantity </span></b></center>"
	elseif ItemQuantity > 21 then 
	msg="<center><b><span style=""color:#F00""> Please enter a quantity less than or equal to 20  </span></b></center>"
	elseif ItemQuantity = 0 then 
	Set Con = Server.CreateObject("ADODB.Connection")
	Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
	vare = request.QueryString("ItemID")
	sql = "DELETE * FROM ItemOrder WHERE OrderID ="&OrderID&" and ItemID='"&ItemID&"'"
	con.execute(sql)

		
ELSE 

Set Con = Server.CreateObject("ADODB.Connection")
Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
vare = request.QueryString("ItemID")
sql = "UPDATE ItemOrder SET Quantity= '"&ItemQuantity&"' where OrderID ="&OrderID&" and ItemID='"&ItemID&"'"
con.execute(sql)


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
  <center>
     <font size ="5"><a href="TakeOrder.asp"> Take an Order</a>  |<a href="AddAndDelete.asp"> Edit orders </a>|<a href="index.asp"> Logout</a> </font>
   </center> 
    <hr />
    <h1>Edit Menu</h1>
    
   

<%response.Write(msg)

Response.AddHeader "Refresh", "3;AddAndDelete.asp" 




%>
  </div>
 </div>
</body>
</html>