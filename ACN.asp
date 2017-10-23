
<%
' This is for the ACCESS Database

Set objConn = Server.CreateObject("ADODB.Connection")
objConn.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & Server.MapPath("db/mydb.accdb") & ";"
objConn.open	



' This is for your SQL Server Database Connection, make sure that you change the following area's
'SERVER-NAME
'ID
'Password
'Set objConn = Server.CreateObject("ADODB.Connection")
'objConn.ConnectionString = "Provider=SQLOLEDB;Data Source=SERVER-NAME;Database=Lessons;User ID=USERNAME;Password=****;"
'objConn.open


' This function will help to protect your Database from SQL and XSS Injections.
' Use this to protect all entries that are being submitted to your database.
Function ProtectSQL(SQLString)
SQLString = SQLString
SQLString = Replace(SQLString, ">", "&gt;") ' replace > with &gt;
SQLString = Replace(SQLString, "<", "&lt;") ' replace < with &lt;
SQLString = Replace(SQLString, "(","&#40;") ' replace ( with &#40;
SQLString = Replace(SQLString, ")","&#41;") ' replace ) with &#41;
SQLString = Replace(SQLString, "&", "&amp;")
SQLString = Replace(SQLString, "@@", "")
SQLString = Replace(SQLString, "/", "&#x2F;")
SQLString = Replace(SQLString, vblf,"<br />") ' replace vblf with <br /> (This is mainly used for Memo fields. 
SQLString = Replace(SQLString, "%", "&#37;")
SQLString = Trim(SQLString)
ProtectSQL = SQLString
End Function

' This is used to reverse what we did above, this can be used in your <textarea><%=ReverseSQL(ProAbout)% ></textarea>
' This will remove the <br />, and replace it with the vblf, as well as the other characters as well.
Function ReverseSQL(SQLString)
SQLString = SQLString
SQLString = Replace(SQLString, "&gt;", ">") ' replace > with &gt;
SQLString = Replace(SQLString, "&lt;", "<") ' replace < with &lt;
SQLString = Replace(SQLString,"&#40;", "(") ' replace ( with &#40;
SQLString = Replace(SQLString,"&#41;", ")") ' replace ) with &#41;
SQLString = Replace(SQLString, "&amp;", "&")
SQLString = Replace(SQLString, "&#x2F;", "/")
' This line gets added to the end, so the above does not render it useless
SQLString = Replace(SQLString,"<br />", vblf) ' replace vblf with <br /> (This is mainly used for Memo fields.
SQLString = Replace(SQLString, "&#37;", "%")
SQLString = Trim(SQLString)
ReverseSQL = SQLString
End Function
%>
