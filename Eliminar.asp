<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<html>
<%
    Dim con 'Objeto de conexion'
    Dim idB 'Id del beneficiario'

    'Crear objeto de conexion'
    Set con = Server.CreateObject("Adodb.Connection")

    'Open the connection'
    con.open "Proyecto1"

    'Collect data'
    idB = CInt(Request.Form("eliminarB"))
    Set cmd = Server.CreateObject("ADODB.command")
    cmd.ActiveConnection = con
    cmd.CommandType = 4
    cmd.CommandText = "EliminarBeneficiario"
    cmd.Parameters.Append cmd.CreateParameter ("@inIdBen", 3, 1, 4, idB)
    cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
    cmd.Execute
    Response.redirect("BeneficiariosP.asp")
%>
 </HTML>