<%

' Declaring the variabels and connecting to the databse 
Dim Con, var, sq 
Set Con = Server.CreateObject("ADODB.Connection")
Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))

' Requesting the ItemID of the Item that the admin has chosen to delete and assigning the value to the a variable named Var
var = request.QueryString("ItemID")
' The sql statement delets all the details of the Item that has the ItemId of the Item of which the admin has chosen to delete
sql = "DELETE * FROM Item WHERE ItemID='"&var&"'"

'response.write(sql)
con.execute(sql)

' Redirect the Admin to the ManagerChangeMenu page where he will be able to view the change ( the deletion of the item ) 
response.Redirect("ManagerChangeMenu.asp")

%>