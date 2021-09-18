<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<html>

<%
    Dim con 'Objeto de conexion'
    Dim message

    Dim num 'Numero de beneficiario'
    Dim iden 'numero de identificacion'

    'Crear objeto de conexion'
    Set con = Server.CreateObject("Adodb.Connection")

    'Open the connection'
    con.open "BasesD"

    'Collect data'
    opcion=Request.Form("EditOp")
    nuevo=Request.Form("Infotxt")
    idBen= CInt(Request.Form("quantity"))
 
%>


 </HTML>