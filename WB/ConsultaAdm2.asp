<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<html>
    <head>
        <title>Consulta Admin 2</title>
        <style>
            body {
              margin: 0;
              font-family: Arial, Helvetica, sans-serif;
            }

            .navbar {
              overflow: hidden;
              background-color: #333;
            }

            .navbar a {
              float: left;
              color: #f2f2f2;
              padding: 14px 16px;
              text-decoration: none;
              font-size: 17px;
            }

            .navbar a:hover {
              background-color: #ddd;
              color: black;
            }

            .navbar a.seleccionada {
              background-color: #aa6aff;
              color: white;
            }
            .titulo {
                padding-top: 40px;
                color: #8C55AA;
                font-family: 'Ubuntu', sans-serif;
                font-weight: bold;
                font-size: 23px;
            }
            .boton {
                cursor: pointer;
                border-radius: 1em;
                color: #fff;
                background: #ad69ef;
                padding-left: 40px;
                padding-right: 40px;
                padding-bottom: 5px;
                padding-top: 5px;
                font-family: 'Ubuntu', sans-serif;
                border: 2px solid rgba(0, 0, 0, 0.02);
                margin-left: 0%;
                font-size: 13px;
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <a href="InicioP.asp">Inicio</a>
            <a href="BeneficiariosP.asp">Beneficiarios</a>
            <a href="EstadosCuentaP.asp">Estados de Cuenta</a>
            <a href="BeneficiariosP.asp">Consulta EC</a>
            <a href="CuentasObjetivo.asp">Cuentas Objetivo</a>
            <a href="Admin.asp">Admin</a>
            <a class="seleccionada" href="#ConsultaAdm">Consulta Admin</a>
        </div>
    </body>
    <div style="padding-left:16px">
        <br><br><label class='titulo'>Consulta # 2</label>
        <p>Digite la cantidad de días</p>
        <form action="ConsultaAdm2.asp" method="post">
            <input class="textbox" type="text" id="CantDias" name="CantDias" required>
            <br><br>
            <button id="aceptarC" class="boton" type="submit">Aceptar</button><br><br>
        </form>
        <%
            viene=Request.Form("CantDias")
            IF (viene<>"") THEN
        %>
                <table>
                <tr bgcolor="grey" width="700">
                    <th>Id</th>
                    <th>Numero Cuenta</th>
                    <th>Promedio operaciones ATM por mes</th>
                    <th>Mes con mayor cant de operaciones ATM</th>
                    <th>Año con mayor cant de operaciones ATM</th>
                </tr>
                <%
                Dim con 
                Dim rec
                ' Se crea el objeto de conexion
                Set con = Server.CreateObject("Adodb.Connection")

                ' Se crea el objeto recordset
                Set rec = Server.CreateObject("Adodb.recordset")

                ' Se abre la conexion
                con.open "BasesD" ' nombre del DSN creado

                ' Mostrar todas las cuentas 
                FOR i = 1 to Session("CantFilas1")
                    Set cmd = Server.CreateObject("ADODB.command")
                    cmd.ActiveConnection = con
                    cmd.CommandType = 4
                    cmd.CommandText = "ConsultaAdmin2"
                    cmd.Parameters.Append cmd.CreateParameter ("@inIdCuenta", 3, 1, 4, i)
                    cmd.Parameters.Append cmd.CreateParameter ("@inDias", 3, 1, 4, viene)
                    cmd.Parameters.Append cmd.CreateParameter ("@outInfo", 3, 2)
                    cmd.Parameters.Append cmd.CreateParameter ("@outMesMasOp", 3, 2)
                    cmd.Parameters.Append cmd.CreateParameter ("@outAnoMasOp", 3, 2)
                    cmd.Parameters.Append cmd.CreateParameter ("@outProm", 3, 2)
                    cmd.Parameters.Append cmd.CreateParameter ("@outNumeroCuenta", 200, 2, 40)
                    cmd.Execute

                    vieneInfo = cmd.Parameters("@outInfo")
                    IF vieneInfo = 1 THEN
                        Response.Write("<tr bgcolor='lightgrey' align='center'>")
                        Response.Write("<td>" & i & "</td>")
                        Response.Write("<td>" & cmd.Parameters("@outNumeroCuenta") & "</td>")
                        Response.Write("<td>" & cmd.Parameters("@outProm") & "</td>")
                        Response.Write("<td>" & cmd.Parameters("@outMesMasOp") & "</td>")
                        Response.Write("<td>" & cmd.Parameters("@outAnoMasOp") & "</td>")
                        Response.Write("</tr>")
                    END IF
                NEXT
                %>
                </table><br><br>
        <%
            END IF
        %>
    </div>
</html>