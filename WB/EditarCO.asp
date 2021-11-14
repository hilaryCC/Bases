<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<HTML>
<%
    Dim con 'Objeto de conexion
    Dim nuevo 'Nuevo valor para la caracteristica
    Dim opcion 'Caracteristica a cambiar
    Dim idCO 'Id de la cuenta objetivo a cambiar
    
    'Crear objeto de conexion
    Set con = Server.CreateObject("Adodb.Connection")

    'Open the connection
    con.open "Proyecto1"

    'Collect data
    opcion=Request.Form("opcionCO")
    nuevo=Request.Form("nuevoCO")
    idCO= CInt(Request.Form("idCO"))

    ' Conexion
    Set cmd = Server.CreateObject("ADODB.command")
    cmd.ActiveConnection = con
    cmd.CommandType = 4

    'Ejecutar un comando SQL
    IF (opcion="fechaInicio") THEN
        cmd.CommandText = "EditFecha1CO"
        cmd.Parameters.Append cmd.CreateParameter ("@inNuevaFechaI", 200, 1, 40, nuevo)
        cmd.Parameters.Append cmd.CreateParameter ("@inIdCO", 3, 1, 4, idCO)
        cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
        cmd.Execute
        Response.Redirect("CuentasObjetivo.asp")
    ELSEIF (opcion="fechaFin") THEN
        cmd.CommandText = "EditFecha2CO"
        cmd.Parameters.Append cmd.CreateParameter ("@inNuevaFechaF", 200, 1, 40, nuevo)
        cmd.Parameters.Append cmd.CreateParameter ("@inIdCO", 3, 1, 4, idCO)
        cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
        cmd.Execute
        Response.Redirect("CuentasObjetivo.asp")
    ELSEIF (opcion="objetivo") THEN
        cmd.CommandText = "EditObjetivoCO"
        cmd.Parameters.Append cmd.CreateParameter ("@inObjetivo", 200, 1, 40, nuevo)
        cmd.Parameters.Append cmd.CreateParameter ("@inIdCO", 3, 1, 4, idCO)
        cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
        cmd.Execute
        Response.Redirect("CuentasObjetivo.asp")
    END IF

%>
</HTML>