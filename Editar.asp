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
    con.open "Proyecto1"

    'Collect data'
    opcion=Request.Form("opcionB")
    nuevo=Request.Form("nuevoB")
    idBen= CInt(Request.Form("idB"))

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
        On Error Resume Next
        con.execute("UPDATE Beneficiario SET Porcentaje="&CInt(nuevo)&" WHERE Id="&idBen)
        con.close
        set con=nothing
        Response.Redirect("BeneficiariosP.asp")
        IF Err.Number <> 0 THEN
            Response.write("<script type=""text/javascript"">alert(""Error: el porcentaje debe ser un número entero"");</script>")  
            Response.End 
        END IF
        On Error GoTo 0
            

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