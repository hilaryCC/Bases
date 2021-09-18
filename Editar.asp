<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<html>

<%
    Dim con 'Objeto de conexion'
    Dim message

    Dim num 'Numero de beneficiario'
    Dim nuevo 'nuevo valor para la caractreristica'
    Dim opcion 'caracteristica a cambiar'
    Dim idBen 'Id de beneficiario a cambiar'

    'Crear objeto de conexion'
    Set con = Server.CreateObject("Adodb.Connection")

    'Open the connection'
    con.open "BasesD"

    'Collect data'
    opcion=Request.Form("EditOp")
    nuevo=Request.Form("Infotxt")
    idBen= CInt(Request.Form("quantity"))

    'Ejecutar un comando SQL'
    IF (opcion="nombre") THEN
        con.execute("UPDATE Persona SET Nombre='"&nuevo&"' WHERE Id=(SELECT IdPersona FROM Beneficiario WHERE Id="&idBen&")")
        con.close
        set con=nothing
        Response.Redirect("BeneficiariosP.asp")

    ELSEIF (opcion="identificacion") THEN
        con.execute("UPDATE Persona SET ValorDocumentoIdentidad="&nuevo&" WHERE Id=(SELECT IdPersona FROM Beneficiario WHERE Id="&idBen&")")
        con.close
        set con=nothing
        Response.Redirect("BeneficiariosP.asp")

    ELSEIF (opcion="parentezco") THEN
        con.execute("UPDATE Beneficiario SET ParentezcoId=(SELECT Id FROM Parentezco WHERE Nombre='"&nuevo&"') WHERE Id="&idBen)
        con.close
        set con=nothing
        Response.Redirect("BeneficiariosP.asp")

    ELSEIF (opcion="porcentaje") THEN
        con.execute("UPDATE Beneficiario SET Porcentaje="&CInt(nuevo)&" WHERE Id="&idBen)
        con.close
        set con=nothing
        Response.Redirect("BeneficiariosP.asp")

    ELSEIF (opcion="fechanacimiento") THEN
        con.execute("UPDATE Persona SET FechaNacimiento='"&nuevo&"' WHERE Id=(SELECT IdPersona FROM Beneficiario WHERE Id="&idBen&")")
        con.close
        set con=nothing
        Response.Redirect("BeneficiariosP.asp")

    ELSEIF (opcion="telefono1") THEN
        con.execute("UPDATE Persona SET telefono1="&nuevo&" WHERE Id=(SELECT IdPersona FROM Beneficiario WHERE Id="&idBen&")")
        con.close
        set con=nothing
        Response.Redirect("BeneficiariosP.asp")

    ELSEIF (opcion="telefono2") THEN   
        con.execute("UPDATE Persona SET telefono2="&nuevo&" WHERE Id=(SELECT IdPersona FROM Beneficiario WHERE Id="&idBen&")")
        con.close
        set con=nothing
        Response.Redirect("BeneficiariosP.asp")

    END IF
 
%>


 </HTML>