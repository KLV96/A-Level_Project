<%

Dim Con

Set Con = Server.CreateObject("ADODB.Connection")

Con.Open("DRIVER={Microsoft Access Driver (*.mdb, *.accdb)}; DBQ=" & Server.MapPath("db/mydb.accdb"))


var = request.QueryString("UN")
sql = "DELETE * FROM Customer WHERE UN='"&var&"'"

con.execute(sql)
response.Redirect("ManagerDisplayMembers.asp")


%>