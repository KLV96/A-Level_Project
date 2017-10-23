<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" href="styles.css" > 
        <!--Changeging the icon to the restaurant's icon -->        
        <link rel="icon" href="Images/favicon.ico"> 
        <title>Rojava restaurant - About</title>
        <style type="text/css">    
			.col
			{
				color:Red
			}
		</style>
<%  

' If the user tries to enter this page without signing in they will be redirected to the index page where they need to enter the login details
if session("Username") = ""  then
 response.redirect("index.asp")
end if

'The month of the date that the user views the page will be assigned to the variable Tmonth 
Tmonth = month(date)
' The value that is inputted by the user into the Electricity bill text field is converted into Currency 
Electricity = CCur(request.Form("EB"))
' The value that is inputted by the user into the Gas bill text field is converted into Currency 
Gas = CCur(request.Form("GB"))
' The value that is inputted by the user into the Water bill text field is converted into Currency
Water = CCur(request.Form("WB"))
' The value that is inputted by the user into the Taxes bill text field is converted into Currency 
Taxes = CCur(request.Form("TX"))
' The value that is inputted by the user into the WorkersSalaries  text field is converted into Currency
WorkersSalaries = CCur(request.Form("WS"))
' The value that is inputted by the user into the FoodSupply text field is converted into Currency 
FoodSupply =CCur(request.Form("FS"))
' the value of the SubmitButton is assigned into the SubmitButton variable
SubmitButton = request.Form("SB")
dim Con, rs, sql

' Connect to the databse 
Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")

' Opends the connection 
Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))

' The sql variable stores the SQL statemnet which selects the Sum of the orders taken for each item multiplied by the price
sql = "SELECT SUM(SUM) AS ALLCAL FROM (SELECT Quantity , Itemname, price* Quantity AS SUM FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID AND Item.ItemID = ItemOrder.ItemID AND Month (OrderDate) = '"&Tmonth&"' AND TypeOfOrder = 'PO' UNION ALL SELECT Quantity , Itemname,  price* Quantity   AS SUM FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID And Item.ItemID = ItemOrder.ItemID AND Item.ItemID = ItemOrder.ItemID AND Month (OrderDate) = '"&Tmonth&"' AND TypeOfOrder = 'WO')"
rs.Open sql, Con

' The Total cost of the sum of all Item Orders is assigned into the variable sum using the recordset 
sum = rs("ALLCAL")

' If the accountant clicked submit, The profit will be calculated using the total income - The expenses that the accountatn has entered into each of the text fields. The profit will be converted into Currency because of the possibily of having decimal  
 If SubmitButton <> "" then 
	 Profit = FormatCurrency(sum - (Electricity+Gas+Water+Taxes+WorkersSalaries+FoodSupply))
	 ' The profit with a notification text is assigned to the variable msg 
	 msg = "The Profit is: " & Profit
 End If 
 
 
%>
    </head>
    
    <body>
    
        <div class="container">
          <div class="content">
          <center><img src="images/logo.png" /></center>
            <hr />
                <center><font size ="5"><a href="ManagerDailyOrders.asp">Daily Orders</a> | <a href="ManagerMonthlyOrders.asp">Monthly Orders</a> | <a href="ManagerCalculateProfit.asp">Calculate Profit</a> | <a href="ManagerMonthlyAnalysis.asp">Chart Order Analysis</a> | <a href="ManagerOrderAnalysis.asp">Monthly Orders Analysis</a> |<a href="ManagerDisplayMembers.asp"> Cancel Members</a> | <a href="ManagerChangeMenu.asp">Change Menu</a> | <a href="ManagerAddstaff.asp">Add staff</a> | <a href="ManagerChangePasswords.asp">Change passwords</a> |<a href="index.asp"> Log Out </a></font></center>
        
            <hr />
            <h1>Calculate Profit</h1> 
            <!-- A tablel with seven rows six of them hold a text field and the last one has a button -->
             <form name="form" method="post" action="ManagerCalculateProfit.asp">
            <table width="387" border="2" align="center">
              <tr bgcolor="#FFFF99">
                <td width="225">Electricity bill</td>
                <td width="144" align="center"><label for="EB"></label>
                <input type="text" name="EB" id="EB"></td>
              </tr>
              <tr bgcolor="#FFFFCC">
                <td width="225">Gas bill </td>
                <td align="center"><input type="text" name="GB" id="EB2"></td>
              </tr>
              <tr bgcolor="#FFFF99">
                <td width="225">Water bill</td>
                <td align="center"><input type="text" name="WB" id="EB3"></td>
              </tr>
              <tr bgcolor="#FFFFCC">
                <td width="225">Taxes</td>
                <td align="center"><input type="text" name="TX" id="EB4"></td>
              </tr>
              <tr bgcolor="#FFFF99">
                <td width="225">Workers' salaries</td>
                <td align="center"><input type="text" name="WS" id="EB5"></td>
              </tr>
              <tr bgcolor="#FFFFCC">
                <td width="225" height="26">Food Supply </td>
                <td align="center"><input type="text" name="FS" id="EB6"></td>
              </tr>
              <tr bgcolor="#FFFF99">
                <td height="26" colspan="2" align="center"><input type="submit" name="SB" id="Submit " value="Submit">
                </td>
              </tr>
            </table>
           
            </form>
            <!--message is displayed here -->
        <p class="col"><strong><%response.Write(msg)%></strong></p>
           <center></center>
           </div>
         </div>
    </body>
</html>
