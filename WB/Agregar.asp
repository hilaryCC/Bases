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
    con.open "Proyecto1"

    ' Se crea el objeto recordset
    Set rec = Server.CreateObject("Adodb.recordset")

    'Collect data'
    iden=Request.Form("ValorDocumentoIdentidad")
    par=Request.Form("parentezco")
    porcen=Request.Form("porcentaje")
    Set cmd = Server.CreateObject("ADODB.command")
    cmd.ActiveConnection = con
    cmd.CommandType = 4
    cmd.CommandText = "ValidarIdentificacion"
    cmd.Parameters.Append cmd.CreateParameter ("@inIdentificacion", 3, 1, 4, iden)
    cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
    cmd.Parameters.Append cmd.CreateParameter ("@Encontrado", 3, 2)
    cmd.Parameters.Append cmd.CreateParameter ("@outIdPersona", 3, 2)
    cmd.Execute
  	existe = cmd.Parameters("@Encontrado")
    idP = cmd.Parameters("@outIdPersona")
    IF existe = "0" THEN
        Response.Redirect("AgregarNuevo.asp?iden="&iden&"&par="&par&"&por="&porcen)
    ELSE
        Set cmd2 = Server.CreateObject("ADODB.command")
        cmd2.ActiveConnection = con
        cmd2.CommandType = 4
        cmd2.CommandText = "InsBeneficiario"
        cmd2.Parameters.Append cmd2.CreateParameter ("@inIdCuenta", 3, 1, 4, Session("IdCuenta"))
        cmd2.Parameters.Append cmd2.CreateParameter ("@inIdPersona", 3, 1, 4, idP)
        cmd2.Parameters.Append cmd2.CreateParameter ("@inParentezo", 200, 1, 40, par)  
        cmd2.Parameters.Append cmd2.CreateParameter ("@inPorcentaje", 3, 1, 4, porcen)
        cmd2.Parameters.Append cmd2.CreateParameter ("@outCodeResult", 3, 2)
        cmd2.Execute
        Response.Redirect("BeneficiariosP.asp")
    END IF
%>
 </HTML>