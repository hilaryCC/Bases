<html>
    <head>
        <title>Consulta EC</title>
        <!-- CSS -->
        <style>
            /* Estilo para la barra de navegacion */
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
            /* Estilo para botones y texto */
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

            .titulo {
              padding-top: 40px;
              color: #8C55AA;
              font-family: 'Ubuntu', sans-serif;
              font-weight: bold;
              font-size: 23px;
            }

            .alert {
              padding: 15px;
              background-color: #f44336;
              color: white;
            }

            .closebtn {
              margin-left: 15px;
              color: white;
              font-weight: bold;
              float: right;
              font-size: 22px;
              line-height: 20px;
              cursor: pointer;
              transition: 0.3s;
            }

            .closebtn:hover {
              color: black;
            }
        </style>
    </head>

    <body>

        <div class="navbar">
            <a href="InicioP.asp">Inicio</a>
            <a href="BeneficiariosP.asp">Beneficiarios</a>
            <a href="EstadosCuentaP.asp">Estados de Cuenta</a>
            <a class="seleccionada" href="#consultaEC">Consulta EC</a>
            <a href="CuentasObjetivo.asp">Cuentas Objetivo</a>
            <a href="Admin.asp">Admin</a>
        </div>
        <div style="padding-left:16px">
            <br><br>
            <label class="titulo">Consulta de Estado de Cuenta</label>
            <br><br>
            <table>
              <tr bgcolor="grey" width="700">
                    <th>Id</th>
                    <th>Fecha Inicio</th>
                    <th>Fecha Fin</th>
                    <th>Saldo Minimo</th>
                    <th>Saldo Inicial</th>
                    <th>Saldo Final</th>
                    <th>Cant Op ATM</th>
                    <th>Cant Op Cajero Humano</th>
              </tr>
              <%
              'Crear objeto de conexion
              Set con = Server.CreateObject("Adodb.Connection")

              'Open the connection
              con.open "Proyecto1"

              Set cmd = Server.CreateObject("ADODB.command")
              cmd.ActiveConnection = con
              cmd.CommandType = 4
              cmd.CommandText = "ConsultaFilaEC2"
              cmd.Parameters.Append cmd.CreateParameter ("@inId", 3, 1, 4, Session("IdEstadoCuenta"))
              cmd.Parameters.Append cmd.CreateParameter ("@outFechaI", 200, 2, 40)
              cmd.Parameters.Append cmd.CreateParameter ("@outFechaF", 200, 2, 40)
              cmd.Parameters.Append cmd.CreateParameter ("@outSaldoM", 5, 2, 4)
              cmd.Parameters.Append cmd.CreateParameter ("@outSaldoI", 5, 2, 4)
              cmd.Parameters.Append cmd.CreateParameter ("@outSaldoF", 5, 2, 4)
              cmd.Parameters.Append cmd.CreateParameter ("@outOpATM", 3, 2, 4)
              cmd.Parameters.Append cmd.CreateParameter ("@outOpHumano", 3, 2, 4)
              cmd.Execute
              FechaF = cmd.Parameters("@outFechaF") 
              SaldoF = cmd.Parameters("@outSaldoF")
              IF IsNull(FechaF) THEN
                  FechaF = "-"
              END IF
              IF IsNull(SaldoF) THEN
                  SaldoF = "-"
              END IF
              Response.Write("<tr bgcolor='lightgrey' align='center'>")
              Response.Write("<td>" & Session("IdEstadoCuenta") & "</td>")
              Response.Write("<td>" & cmd.Parameters("@outFechaI") & "</td>")
              Response.Write("<td>" & FechaF & "</td>")
              Response.Write("<td>" & cmd.Parameters("@outSaldoM") & "</td>")
              Response.Write("<td>" & cmd.Parameters("@outSaldoI") & "</td>")
              Response.Write("<td>" & SaldoF & "</td>")
              Response.Write("<td>" & cmd.Parameters("@outOpATM") & "</td>")
              Response.Write("<td>" & cmd.Parameters("@outOpHumano") & "</td>")
              Response.Write("</tr>")
              %>
            </table> 
            <br><br>
            <label class="titulo">Movimientos del Estado de Cuenta</label>
            <br><br>
            <table>
              <tr bgcolor="grey" width="700">
                    <th>Id</th>
                    <th>Fecha</th>
                    <th>Tipo Cambio</th>
                    <th>Monto Movimiento</th>
                    <th>Monto Cuenta</th>
                    <th>Descripcion</th>
                    <th>Nuevo Saldo</th>
              </tr>
              <%
              ' Obtener la cantidad de filas 
              Set cmd = Server.CreateObject("ADODB.command")
              cmd.ActiveConnection = con
              cmd.CommandType = 4
              cmd.CommandText = "ConsultarFilasCEC"
              cmd.Parameters.Append cmd.CreateParameter ("@inId", 3, 1, 4, Session("IdEstadoCuenta"))
              cmd.Parameters.Append cmd.CreateParameter ("@outCantFilas", 3, 2)
              cmd.Execute
              Session("CantFilasCEC") = CInt(cmd.Parameters("@outCantFilas"))
              IF Session("CantFilasCEC") > 0 THEN
                  ' Mostrar movimientos del estado de cuenta
                  FOR i = 0 to Session("CantFilasCEC")-1
                      Set cmd2 = Server.CreateObject("ADODB.command")
                      cmd2.ActiveConnection = con
                      cmd2.CommandType = 4
                      cmd2.CommandText = "ConsultaFilaCEC"
                      cmd2.Parameters.Append cmd2.CreateParameter ("@inCont", 3, 1, 4, i)
                      cmd2.Parameters.Append cmd2.CreateParameter ("@inIdEC", 3, 1, 4, Session("IdEstadoCuenta"))
                      cmd2.Parameters.Append cmd2.CreateParameter ("@outId", 3, 2, 4)
                      cmd2.Parameters.Append cmd2.CreateParameter ("@outFecha", 200, 2, 40)
                      cmd2.Parameters.Append cmd2.CreateParameter ("@outMontoM", 5, 2, 4)
                      cmd2.Parameters.Append cmd2.CreateParameter ("@outMontoC", 5, 2, 4)
                      cmd2.Parameters.Append cmd2.CreateParameter ("@outTipoC", 3, 2, 4)
                      cmd2.Parameters.Append cmd2.CreateParameter ("@outDescripcion", 200, 2, 40)
                      cmd2.Parameters.Append cmd2.CreateParameter ("@outNuevoSaldo", 5, 2, 4)
                      cmd2.Execute
                      TipoC = cmd2.Parameters("@outTipoC") 
                      IF TipoC = 0 THEN
                          TipoC = "-"
                      END IF
                      Response.Write("<tr bgcolor='lightgrey' align='center'>")
                      Response.Write("<td>" & cmd2.Parameters("@outId") & "</td>")
                      Response.Write("<td>" & cmd2.Parameters("@outFecha") & "</td>")
                      Response.Write("<td>" & TipoC & "</td>")
                      Response.Write("<td>" & cmd2.Parameters("@outMontoM") & "</td>")
                      Response.Write("<td>" & cmd2.Parameters("@outMontoC") & "</td>")
                      Response.Write("<td>" & cmd2.Parameters("@outDescripcion") & "</td>")
                      Response.Write("<td>" & cmd2.Parameters("@outNuevoSaldo") & "</td>")
                      Response.Write("</tr>")
                  NEXT
              END IF
              %>
            </table>
            <br><br>
        </div>
    </body>
</html>