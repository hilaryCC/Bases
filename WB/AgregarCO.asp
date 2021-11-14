<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<HTML>
    <%
        'Crear objeto de conexion
        Set con = Server.CreateObject("Adodb.Connection")

        'Abrir la conexion
        con.open "Proyecto1"

        ' Obtener la informacion
        Dim fechaI
        Dim fechaF
        Dim cuota
        Dim objetivo
        Dim interes

        fechaI = Request.Form("FechaInicio")
        fechaF = Request.Form("FechaFin")
        cuota = Request.Form("Cuota")
        objetivo = Request.Form("Objetivo")
        interes = Request.Form("InteresAnual")

        ' Insertar Cuenta Objetivo
        Set cmd = Server.CreateObject("ADODB.command")
        cmd.ActiveConnection = con
        cmd.CommandType = 4
        cmd.CommandText = "InsCuentaObjetivo"
        cmd.Parameters.Append cmd.CreateParameter ("@inIdCuenta", 3, 1, 4, Session("IdCuenta"))
        cmd.Parameters.Append cmd.CreateParameter ("@inFechaInicio", 200, 1, 40, fechaI)
        cmd.Parameters.Append cmd.CreateParameter ("@inFechaFinal", 200, 1, 40, fechaF)
        cmd.Parameters.Append cmd.CreateParameter ("@inCuota", 3, 1, 4, cuota)
        cmd.Parameters.Append cmd.CreateParameter ("@inObjetivo", 200, 1, 40, objetivo)
        cmd.Parameters.Append cmd.CreateParameter ("@inSaldo", 3, 1, 4, 0)
        cmd.Parameters.Append cmd.CreateParameter ("@inInteresAnual", 3, 1, 4, interes)
        cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
        cmd.Execute
        Response.Redirect("CuentasObjetivo.asp")
    %>
</HTML>