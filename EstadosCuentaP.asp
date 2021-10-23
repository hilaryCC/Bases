<html>
    <head>
        <title>Estados de Cuenta</title>
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
            <a class="seleccionada" href="#estadosdecuenta">Estados de Cuenta</a>
            <a href="EstadosCuentaP.asp">Consulta EC</a>
            <a href="CuentasObjetivo.asp">Cuentas Objetivo</a>
        </div>

        <div style="padding-left:16px">

            <br><br>
            <label class="titulo">Estados de Cuenta</label>
            <br><br>

            <!--MOSTRAR TABLA DE ESTADOS DE CUENTA-->
            <table>
              <tr bgcolor="grey" width="700">
                    <th>Id</th>
                    <th>Fecha Inicio</th>
                    <th>Fecha Fin</th>
                    <th>Saldo Inicial</th>
                    <th>Saldo Final</th>
              </tr>
            <%
              'Crear objeto de conexion
              Set con = Server.CreateObject("Adodb.Connection")

              'Open the connection
              con.open "Proyecto1"
              
              ' Obtener la cantidad de filas 
              Set cmd = Server.CreateObject("ADODB.command")
              cmd.ActiveConnection = con
              cmd.CommandType = 4
              cmd.CommandText = "ConsultarFilasEC"
              cmd.Parameters.Append cmd.CreateParameter ("@inId", 3, 1, 4, Session("IdCuenta"))
              cmd.Parameters.Append cmd.CreateParameter ("@outCantFilas", 3, 2)
              cmd.Execute
              Session("CantFilasEC") = CInt(cmd.Parameters("@outCantFilas"))
              IF Session("CantFilasEC") > 0 THEN
                  ' Mostrar tabla de Estados de Cuenta
                  FOR i = 0 to Session("CantFilasEC")-1
                      Set cmd2 = Server.CreateObject("ADODB.command")
                      cmd2.ActiveConnection = con
                      cmd2.CommandType = 4
                      cmd2.CommandText = "ConsultaFilaEC"
                      cmd2.Parameters.Append cmd2.CreateParameter ("@inCont", 3, 1, 4, i)
                      cmd2.Parameters.Append cmd2.CreateParameter ("@inIdCuenta", 3, 1, 4, Session("IdCuenta"))
                      cmd2.Parameters.Append cmd2.CreateParameter ("@outId", 3, 2, 4)
                      cmd2.Parameters.Append cmd2.CreateParameter ("@outFechaI", 200, 2, 40)
                      cmd2.Parameters.Append cmd2.CreateParameter ("@outFechaF", 200, 2, 40)
                      cmd2.Parameters.Append cmd2.CreateParameter ("@outSaldoI", 5, 2, 4)
                      cmd2.Parameters.Append cmd2.CreateParameter ("@outSaldoF", 5, 2, 4)
                      cmd2.Execute
                      FechaF = cmd2.Parameters("@outFechaF") 
                      SaldoF = cmd2.Parameters("@outSaldoF")
                      IF IsNull(FechaF) THEN
                          FechaF = "-"
                      END IF
                      IF IsNull(SaldoF) THEN
                          SaldoF = "-"
                      END IF
                      IdEC = cmd2.Parameters("@outId")
                      IF IsNull(IdEC) = False THEN
                          Response.Write("<tr bgcolor='lightgrey' align='center'>")
                          Response.Write("<td>" & IdEC & "</td>")
                          Response.Write("<td>" & cmd2.Parameters("@outFechaI") & "</td>")
                          Response.Write("<td>" & FechaF & "</td>")
                          Response.Write("<td>" & cmd2.Parameters("@outSaldoI") & "</td>")
                          Response.Write("<td>" & SaldoF & "</td>")
                          Response.Write("</tr>")
                      END IF
                  NEXT
              END IF
            %>
            </table> 
            <br><hr><br>

            <!--SELECCIONAR ESTADO CUENTA-->
            <form method="post" action="">
              <h3> Digite el id del estado de cuenta que desea consultar: </h3>
              <input class="textbox" type="text" id="estadoCuenta" name="estadoCuenta">
              <input class="boton" type="submit" value="Aceptar">  
            </form>
            <%
            ON ERROR RESUME NEXT
            Session("IdEstadoCuenta") = request.form("estadoCuenta")
            Session("existeEC") = 0
            Set cmd2 = Server.CreateObject("ADODB.command")
            cmd2.ActiveConnection = con
            cmd2.CommandType = 4
            cmd2.CommandText = "ValidarEC"
            cmd2.Parameters.Append cmd2.CreateParameter ("@inId", 3, 1, 4, Session("IdEstadoCuenta"))
            cmd2.Parameters.Append cmd2.CreateParameter ("@inIdCuenta", 3, 1, 4, Session("IdCuenta"))
            cmd2.Parameters.Append cmd2.CreateParameter ("@outCodeResult", 3, 2)
            cmd2.Parameters.Append cmd2.CreateParameter ("@outEncontrado", 3, 2)
            cmd2.Execute
            Session("existeEC") = cmd2.Parameters("@outEncontrado")
            IF Err.Number <> 0 THEN
                Response.Write()              
            END IF
            ON ERROR GOTO 0
            ' Si la cuenta existe, pasa a la siguiente pagina
            IF (Session("existeEC") = 1) THEN
                Response.Redirect("ConsultaEC.asp")
            END IF
            %>
        </div>
    </body>
</html>