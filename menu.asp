<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="styles.css" > 
		<link rel="icon" href="Images/favicon.ico"> 
		<title>Rojava restaurant - Menu</title>
        <!--part of the CSS is used for the menu so when the user hover over the text image the image of the item will pop up --> 	
		<style type="text/css">
	.DNS
	{
	
		float: left;
		margin-left: 100px;
		position: absolute;

	}

	.popup 
	{
		zoom:1.0;
		position:relative;
		text-decoration:none;
		margin-bottom: 200px;
	}
			
	.popup span 
	{
		position:absolute;
		top:0px;
		left:100px;
		width:350px;
		padding:10px;
		border:7px solid #000;
		border-radius:7px;
		left:-999em;
		z-index:990;      
	}
				
	.popup:hover {visibility:visible}
	.popup:hover span {left:200px;}
	* html .popup span {position:absolute;}
		</style>
	</head>
    
 <%
	
	' Connecting to the database 
	dim Con, rs, sql
	Set Con = Server.CreateObject("ADODB.Connection")
	' Creating a recordset
	Set rs = Server.CreateObject("ADODB.Recordset")
	Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))	
	'SQL statement to select all the items in the Item table and order them by the Item ID 
	sql = "SELECT * FROM Item Order By ItemID"
	' open the recordset 
	rs.Open sql, Con
		
%>
    
	<body>

        <div class="container">
            <div class="content">
            <center><img src="images/logo.png" /></center>
            <hr />
           <!-- The navigation bar --> 
            <center><font size ="5"><a href="index.asp">Home</a> | <a href="menu.asp">Menu</a> | <a href="About.asp">About</a> |<a href="SignUP.asp">Sign Up</a> </font></center>  
            <hr />
            <h1> Menu </h1>
            <!-- A table is being created with five fields ( Item ID, Item Name, Item Ingredients, Item Price, Image of the item --> 
            <center><table width="500" border="1" cellpadding="0" cellspacing="0" class="DNS">
            <tr>
                <td align="center"><strong><p> Item ID </p></strong></td>
                <td align="center"><strong><p> Item Name </p></strong></td>
                <td align="center"><strong><p> Ingredient </p></strong></td>
                <td align="center"><strong><p> Price </p></strong></td>
                <td align="center"><strong><p> Image </p></strong></td>
            </tr>
            <!-- A while not loop is used to loop in the recordset to display all the Items --> 
            <% while not rs.EOF%>
            <tr align="center">
            	<!-- A recordset ItemID is used to displat the Item ID --> 
                <td><strong><%=rs("ItemID")%></strong></td>
                <!-- A recordset ItemName is used to displat the Item Name --> 	
                <td><strong><%=rs("ItemName")%></strong></td>
               <!-- A recordset Ingredient is used to displat the Ingredient --> 
                <td><strong><%=rs("Ingredient")%></strong></td>
              <!-- A recordset IPrice is used to displat the Price, The default function FormatCurrency is used to display the price in Pounds --> 
                <td><strong><%=(FormatCurrency(rs("Price")))%></strong></td>
               <!-- A recordset Item ID is used to displat the Item ID --> 
                <td><a class="popup" href="#">Image<span><img src="<%=rs("Image")%>"></span></a></td>
            </tr>	
            <%
			' move to the next record in the recordset
            rs.movenext
			' Endinf the while loop 
            wend
            %>
            </table></center>
            </div>
		</div>
	</body>
</html>
