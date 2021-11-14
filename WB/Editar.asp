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

    'Collect data
    opcion=Request.Form("opcionB")
    nuevo=Request.Form("nuevoB")
    idBen= CInt(Request.Form("idB"))
    Set cmd = Server.CreateObject("ADODB.command")
    cmd.ActiveConnection = con
    cmd.CommandType = 4
            

    'Ejecutar un comando SQL
    IF (opcion="nombre") THEN
        cmd.CommandText = "EditNombre"
        cmd.Parameters.Append cmd.CreateParameter ("@inNuevoNombre", 200, 1, 40, nuevo)
        cmd.Parameters.Append cmd.CreateParameter ("@inIdBen", 3, 1, 4, idBen)
        cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
        cmd.Execute
        cmd.Parameters.Delete 1
        Response.Redirect("BeneficiariosP.asp")

    ELSEIF (opcion="identificacion") THEN
        cmd.CommandText = "EditIdentidad"
        cmd.Parameters.Append cmd.CreateParameter ("@inNuevaIden", 3, 1, 4, nuevo)
        cmd.Parameters.Append cmd.CreateParameter ("@inIdBen", 3, 1, 4, idBen)
        cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
        cmd.Execute
        cmd.Parameters.Delete 1
        Response.Redirect("BeneficiariosP.asp")

    ELSEIF (opcion="parentezco") THEN
        cmd.CommandText = "EditParentezco"
        cmd.Parameters.Append cmd.CreateParameter ("@inNuevoParentezco", 200, 1, 40, nuevo)
        cmd.Parameters.Append cmd.CreateParameter ("@inIdBen", 3, 1, 4, idBen)
        cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
        cmd.Execute
        cmd.Parameters.Delete 1
        Response.Redirect("BeneficiariosP.asp")

    ELSEIF (opcion="porcentaje") THEN
        On Error Resume Next
        cmd.CommandText = "EditPorcentaje"
        cmd.Parameters.Append cmd.CreateParameter ("@inNuevoPorcentaje", 200, 1, 40, nuevo)
        cmd.Parameters.Append cmd.CreateParameter ("@inIdBen", 3, 1, 4, idBen)
        cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
        cmd.Execute
        cmd.Parameters.Delete 1
        Response.Redirect("BeneficiariosP.asp")
        IF Err.Number <> 0 THEN
            Response.write("<script type=""text/javascript"">alert(""Error: el porcentaje debe ser un número entero"");</script>")  
            Response.End 
        END IF
        On Error GoTo 0
            

    ELSEIF (opcion="fechanacimiento") THEN
        cmd.CommandText = "EditFecha"
        cmd.Parameters.Append cmd.CreateParameter ("@inNuevaFecha", 200, 1, 40, nuevo)
        cmd.Parameters.Append cmd.CreateParameter ("@inIdBen", 3, 1, 4, idBen)
        cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
        cmd.Execute
        cmd.Parameters.Delete 1
        Response.Redirect("BeneficiariosP.asp")

    ELSEIF (opcion="telefono1") THEN
        cmd.CommandText = "EditTelefono1"
        cmd.Parameters.Append cmd.CreateParameter ("@inNuevoTelefono1", 3, 1, 4, nuevo)
        cmd.Parameters.Append cmd.CreateParameter ("@inIdBen", 3, 1, 4, idBen)
        cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
        cmd.Execute
        cmd.Parameters.Delete 1
        Response.Redirect("BeneficiariosP.asp")

    ELSEIF (opcion="telefono2") THEN   
        cmd.CommandText = "EditTelefono2"
        cmd.Parameters.Append cmd.CreateParameter ("@inNuevoTelefono2", 3, 1, 4, nuevo)
        cmd.Parameters.Append cmd.CreateParameter ("@inIdBen", 3, 1, 4, idBen)
        cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
        cmd.Execute
        cmd.Parameters.Delete 1
        Response.Redirect("BeneficiariosP.asp")
    END IF
%>


 </HTML>