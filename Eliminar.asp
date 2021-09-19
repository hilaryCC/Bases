<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<html>

<%
    Dim con 'Objeto de conexion'
    Dim idB 'Id del beneficiario'

    'Crear objeto de conexion'
    Set con = Server.CreateObject("Adodb.Connection")

    'Open the connection'
    con.open "BasesD"

    'Collect data'
    idB = CInt(Request.Form("eliminarB"))
    con.execute("UPDATE dbo.Beneficiario SET Activo=0 WHERE Id="&idB&" UPDATE dbo.Beneficiario SET FechaDesactivacion=GETDATE() WHERE Id="&idB)
    Response.redirect("BeneficiariosP.asp")
%>


 </HTML>