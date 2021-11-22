<html>
    <head>
        <meta charset="UTF-8">
        <meta name="Generator" content="Docukits">
        <title>Inicio</title>
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
        <br><br><label class='titulo'>Consulta # 1</label>
        <br><br>
        <table>
            <tr bgcolor="grey" width="700">
                <th>Numero Cuenta</th>
                <th>Id CO</th>
                <th>Descripcion</th>
                <th>Cant retiros real</th>
                <th>Cant retiros no real</th>
                <th>Suma monto debitado real</th>
                <th>Suma monto debitado no real</th>
            </tr>
            <%
            Dim con 
            Dim rec
            ' Se crea el objeto de conexion
            Set con = Server.CreateObject("Adodb.Connection")

            ' Se crea el objeto recordset
            Set rec = Server.CreateObject("Adodb.recordset")

            ' Se abre la conexion
            con.open "Proyecto1" ' nombre del DSN creado

            ' Determinar cantidad de filas
            Set cmd = Server.CreateObject("ADODB.command")
            cmd.ActiveConnection = con
            cmd.CommandType = 4
            cmd.CommandText = "ConsultaFilasCO"
            cmd.Parameters.Append cmd.CreateParameter ("@inId", 3, 1, 4, Session("IdCuenta"))
            cmd.Parameters.Append cmd.CreateParameter ("@outCantFilas", 3, 2)
            cmd.Execute
            Session("CantFilasCO2") = CInt(cmd.Parameters("@outCantFilas"))
            IF Session("CantFilasCO2") > 0 THEN

            END IF
            %>
        </table>
    </div>
</html>