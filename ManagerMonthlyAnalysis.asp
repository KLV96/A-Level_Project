<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="styles.css" > 
<!--Changeging the icon to the restaurant's icon -->        
<link rel="icon" href="Images/favicon.ico"> 
<title>Rojava restaurant - Monthly Order Analysis</title>
<%  

dim Con, rs, sql

Set Con = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs2 = Server.CreateObject("ADODB.Recordset")
Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))
Tmonth = month(date)
  sql= "SELECT SUM(Quantity) AS Quan, Itemname FROM(SELECT Quantity , Itemname FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID AND Item.ItemID = ItemOrder.ItemID AND Month (OrderDate) = '"&Tmonth&"' AND TypeOfOrder = 'PO' UNION ALL SELECT Quantity , Itemname FROM ItemOrder,Item,tblOrder WHERE tblOrder.OrderID = ItemOrder.OrderID And Item.ItemID = ItemOrder.ItemID AND Item.ItemID = ItemOrder.ItemID AND Month (OrderDate) = '"&Tmonth&"' AND TypeOfOrder = 'WO')GROUP BY Itemname"

   
   rs.Open sql, con	

%>
 <center><script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {


		
		 // Create the data table.
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Topping');
            data.addColumn('number', 'Slices');
            <% while not rs.eof %>
            data.addRows([
                ['<%=rs("itemname")%>',<%=rs("quan")%>]
            ])
            <% 
            rs.MoveNext
            wend
            %>
            ;

        var options = {
          title: 'Orders Analysis',
		  is3D: true,	
		height: 500,
		width: 700,
		backgroundColor: 'transparent'
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(data, options);
      }
    </script><center/>
</head>

<body>
  
<div class="container">
  <div class="content">
  <center><img src="images/logo.png" /></center>
    <hr />
         <center><font size ="5"><a href="ManagerDailyOrders.asp">Daily Orders</a> | <a href="ManagerMonthlyOrders.asp">Monthly Orders</a> | <a href="ManagerCalculateProfit.asp">Calculate Profit</a> | <a href="ManagerMonthlyAnalysis.asp">Chart Order Analysis</a> | <a href="ManagerOrderAnalysis.asp">Monthly Orders Analysis</a> |<a href="ManagerDisplayMembers.asp"> Cancel Members</a> | <a href="ManagerChangeMenu.asp">Change Menu</a> | <a href="ManagerAddstaff.asp">Add staff</a> | <a href="ManagerChangePasswords.asp">Change passwords</a> |<a href="index.asp"> Log Out </a></font></center>
    <hr />
    <div align="left">
    <h1>Chart Order Analysis</h1>
    </div>
    <div id="chart_div"></div>
   
   
   </div>
 </div>
 
 <div id="piechart" style="width: 900px; height: 500px;"></div>
</body>
</html>
