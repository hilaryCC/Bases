<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<html>

<%
    Dim con 'Objeto de conexion'
    Dim rec 'variable para objeto recordset
    Dim idP 'Id de la persona'
    Dim iden 'numero de identificacion'
    Dim par 'parentezco'
    Dim porcen 'porcentaje'

    'Crear objeto de conexion'
    Set con = Server.CreateObject("Adodb.Connection")

    'Open the connection'
    con.open "BasesD"

    ' Se crea el objeto recordset
    Set rec = Server.CreateObject("Adodb.recordset")

    'Collect data'
    iden=Request.Form("ValorDocumentoIdentidad")
    par=Request.Form("parentezco")
    porcen=Request.Form("porcentaje")
    rec.open("SELECT Id FROM Persona WHERE ValorDocumentoIdentidad="&iden), con
    IF rec.EOF THEN
        Response.Redirect("AgregarNuevo.asp?iden="&iden&"&par="&par&"&por="&porcen)
    ELSE
        idP = CInt(rec.GetString())
        rec.close
        rec.open("INSERT INTO Beneficiario(IdCuenta, IdPersona, ParentezcoId, Porcentaje, Activo) VALUES ("&Session("IdCuenta")&", "&idP&", (SELECT Id FROM Parentezco WHERE Nombre='"&par&"'), "&porcen&", 1)"), con
        Response.Redirect("BeneficiariosP.asp")
    END IF
 
%>


 </HTML>