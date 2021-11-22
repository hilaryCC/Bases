<html>
    <head>
        <title>Cuentas Objetivo</title>
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

            .alert2 {
              padding: 15px;
              background-color: #0fbe0c;
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
            <a href="CuentasObjetivo.asp">Consulta EC</a>
            <a class="seleccionada" href="#cuentasObjetivo">Cuentas Objetivo</a>
            <a href="Admin.asp">Admin</a>
        </div>
        <div style="padding-left:16px">

          <br><br>
          <label class="titulo">Cuentas Objetivo</label>
          <br><br>
          <!-- MOSTRAR CUENTAS OBJETIVO -->
            
          <table>
            <tr bgcolor="grey" width="700">
                  <th>Id</th>
                  <th>Fecha Inicio</th>
                  <th>Fecha Fin</th>
                  <th>Cuota</th>
                  <th>Objetivo</th>
                  <th>Saldo</th>
                  <th>Interes Acumulado</th>
            </tr>
          <%
            'Crear objeto de conexion'
            Set con = Server.CreateObject("Adodb.Connection")

            'Open the connection'
            con.open "Proyecto1"

            Set cmd = Server.CreateObject("ADODB.command")
            cmd.ActiveConnection = con
            cmd.CommandType = 4
            cmd.CommandText = "ConsultaFilasCO"
            cmd.Parameters.Append cmd.CreateParameter ("@inId", 3, 1, 4, Session("IdCuenta"))
            cmd.Parameters.Append cmd.CreateParameter ("@outCantFilas", 3, 2)
            cmd.Execute
            Session("CantFilasCO") = CInt(cmd.Parameters("@outCantFilas"))
            IF Session("CantFilasCO") > 0 THEN
              ' Mostrar tabla de Cuentas Objetivo 
              FOR i = 1 to Session("CantFilasCO")
                  Set cmd2 = Server.CreateObject("ADODB.command")
                  cmd2.ActiveConnection = con
                  cmd2.CommandType = 4
                  cmd2.CommandText = "ConsultaFilaCO"
                  cmd2.Parameters.Append cmd2.CreateParameter ("@inId", 3, 1, 4, i)
                  cmd2.Parameters.Append cmd2.CreateParameter ("@inIdCuenta", 3, 1, 4, Session("IdCuenta"))
                  cmd2.Parameters.Append cmd2.CreateParameter ("@outFechaI", 200, 2, 40)
                  cmd2.Parameters.Append cmd2.CreateParameter ("@outFechaF", 200, 2, 40)
                  cmd2.Parameters.Append cmd2.CreateParameter ("@outCuota", 3, 2, 4)
                  cmd2.Parameters.Append cmd2.CreateParameter ("@outObjetivo", 200, 2, 40)
                  cmd2.Parameters.Append cmd2.CreateParameter ("@outSaldo", 3, 2, 4)
                  cmd2.Parameters.Append cmd2.CreateParameter ("@outInteres", 3, 2, 4)
                  cmd2.Execute
                  fechaI = cmd2.Parameters("@outFechaI")
                  IF IsNull(fechaI) = False THEN
                      Response.Write("<tr bgcolor='lightgrey' align='center'>")
                      Response.Write("<td>" & i & "</td>")
                      Response.Write("<td>" & fechaI & "</td>")
                      Response.Write("<td>" & cmd2.Parameters("@outFechaF") & "</td>")
                      Response.Write("<td>" & cmd2.Parameters("@outCuota") & "</td>")
                      Response.Write("<td>" & cmd2.Parameters("@outObjetivo") & "</td>")
                      Response.Write("<td>" & cmd2.Parameters("@outSaldo") & "</td>")
                      Response.Write("<td>" & cmd2.Parameters("@outInteres") & "</td>")
                      Response.Write("</tr>")
                  END IF
              NEXT
            END IF
          %>
          </table>
          <br><hr><br>

          <!-- AGREGAR CUENTA OBJETIVO -->
          <form action="AgregarCO.asp" method="post">
            <label class="titulo">Agregar Cuenta Objetivo</label>
             
            <br><br>
            <label for="optionlbl" >Fecha Inicio:</label>
            <input type="date" id="FechaInicio" name="FechaInicio" placeholder="Fecha Inicio">
              
            <br><br>
            <label for="optionlbl" >Fecha Fin:</label>
            <input type="date" id="FechaFin" name="FechaFin" placeholder="Fecha Fin">
             
            <br><br>
            <label for="Cuota">Cuota: </label>
            <input type="number" id="Cuota" name="Cuota" required>
              
            <br><br>
            <label for="lbl2">Objetivo: </label>
            <input class="textbox" type="text" id="Objetivo" name="Objetivo" required>
            
            <br><br>
            <label for="InteresAnual">Interes Acumulado: </label>
            <input type="number" id="InteresAnual" name="InteresAnual" required>
             
            <br><br>
            <button id="aceptarAgregar" class="boton" type="submit">Aceptar</button>
            <br><br>
          </form>

            <!-- EDITAR CUENTA OBJETIVO -->
          <form action="CuentasObjetivo.asp" method="post">
              <br><hr><br>
              <label class="titulo">Editar Cuenta Objetivo</label>
            
              <br><br>
              <label for="numCuenta">Digite el Id de la Cuenta Objetivo que desea editar: </label>
              <input type="number" id="quantity" name="quantity" required>
            
              <br><br>
              <label for="optionlbl">Escoja lo que va a editar:</label>
              <select id="EditOp" name="EditOp">
                  <option value="fechaInicio">Fecha Inicio</option>
                  <option value="fechaFin">Fecha Fin</option>
                  <option value="objetivo">Objetivo</option>
              </select>

              <br><br>
              <label for="lbl2">Digite la nueva informacion segun lo escogido: </label>
              <input class="textbox" type="text" id="Infotxt" name="Infotxt" placeholder="Nueva fecha o etc" required>

              <br><br>
              <button id="aceptarEdit" class="boton" type="submit">Aceptar</button>
              <br><br>
          </form>
          <!-- VERIFICAR LA CUENTA -->
          <%
          Dim viene0
          viene0=Request.Form("quantity")
          IF (viene0<>"") THEN
              Set cmd4 = Server.CreateObject("ADODB.command")
              cmd4.ActiveConnection = con
              cmd4.CommandType = 4
              cmd4.CommandText = "ValidarCO"
              cmd4.Parameters.Append cmd4.CreateParameter ("@inId", 3, 1, 4, viene0)
              cmd4.Parameters.Append cmd4.CreateParameter ("@outCodeResult", 3, 2)
              cmd4.Parameters.Append cmd4.CreateParameter ("@outEncontrado", 3, 2)
              cmd4.Execute
  		      existe0 = cmd4.Parameters("@outEncontrado")
              IF existe0 = "0" THEN
          %>
              <br>
              <div class="alert">
                  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                  <strong>Error!</strong> El Id de la cuenta objetivo no existe.
              </div>
          <%
              ELSE
          %>
              <form id="EditCO" name="EditCO" action="EditarCO.asp" method="post" style="display:block">
                  <input type="hidden" id="opcionB" name="opcionCO" value="<%Response.write(Request.form("EditOp"))%>">
                  <input type="hidden" id="nuevoB" name="nuevoCO" value="<%Response.write(Request.form("Infotxt"))%>">
                  <input type="hidden" id="idB" name="idCO" value="<%Response.write(Request.form("quantity"))%>">
              </form>
              <script>document.getElementById("EditCO").submit()</script>
          <%
            END IF
          END IF
          %>
          <!-- DESACTIVAR CUENTA OBJETIVO -->
          <form action="CuentasObjetivo.asp" method="post">
              <br><hr><br>
              <label class="titulo">Desactivar Cuenta Objetivo</label>
              <br><br>
              <label for="lbl3">Digite el id de la cuenta objetivo que desea desactivar: </label>
              <input class="textbox" type="text" id="desactivarId" name="desactivarId" required>
              <br><br>
              <button id="aceptarEliminar" class="boton" type="submit">Aceptar</button>
              <br><br>
          </form>
          <!-- VERIFICAR LA CUENTA -->
          <%
          Dim viene1
          viene1=Request.Form("desactivarId")
          IF (viene1<>"") THEN
              Set cmd5 = Server.CreateObject("ADODB.command")
              cmd5.ActiveConnection = con
              cmd5.CommandType = 4
              cmd5.CommandText = "ValidarCO"
              cmd5.Parameters.Append cmd5.CreateParameter ("@inId", 3, 1, 4, viene1)
              cmd5.Parameters.Append cmd5.CreateParameter ("@outCodeResult", 3, 2)
              cmd5.Parameters.Append cmd5.CreateParameter ("@outEncontrado", 3, 2)
              cmd5.Execute
  		      existe = cmd5.Parameters("@outEncontrado")
              IF existe = "0" THEN
          %>
              <br>
              <div class="alert">
                  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                  <strong>Error!</strong> El Id de la cuenta objetivo no existe.
              </div>
          <%
              ELSE
                  Set cmd6 = Server.CreateObject("ADODB.command")
                  cmd6.ActiveConnection = con
                  cmd6.CommandType = 4
                  cmd6.CommandText = "EliminarCO"
                  cmd6.Parameters.Append cmd6.CreateParameter ("@inId", 3, 1, 4, viene1)
                  cmd6.Parameters.Append cmd6.CreateParameter ("@outCodeResult", 3, 2)
                  cmd6.Execute
                  Response.Redirect("CuentasObjetivo.asp")
              END IF
          END IF
          %>
                

          <!-- ACTIVAR CUENTA OBJETIVO -->
          <form action="CuentasObjetivo.asp" method="post">
              <br><hr><br>
              <label class="titulo">Activar Cuenta Objetivo</label>
              <br><br>
              <label for="lbl3">Digite el id de la cuenta objetivo que desea activar: </label>
              <input class="textbox" type="text" id="activarId" name="activarId" required>
              <br><br>
              <button id="aceptarActivar" class="boton" type="submit">Aceptar</button>
              <br><br>
          </form>
          <!-- VERIFICAR LA CUENTA -->
          <%
          Dim viene2
          viene2=Request.Form("activarId")
          IF (viene2<>"") THEN
              Set cmd7 = Server.CreateObject("ADODB.command")
              cmd7.ActiveConnection = con
              cmd7.CommandType = 4
              cmd7.CommandText = "ValidarCO"
              cmd7.Parameters.Append cmd7.CreateParameter ("@inId", 3, 1, 4, viene2)
              cmd7.Parameters.Append cmd7.CreateParameter ("@outCodeResult", 3, 2)
              cmd7.Parameters.Append cmd7.CreateParameter ("@outEncontrado", 3, 2)
              cmd7.Execute
              Dim existe2
  		      existe2 = cmd7.Parameters("@outEncontrado")
              IF existe2 = "0" THEN
          %>
              <br>
              <div class="alert">
                  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                  <strong>Error!</strong> El Id de la cuenta objetivo no existe.
              </div>
          <%
              ELSE
                  Set cmd8 = Server.CreateObject("ADODB.command")
                  cmd8.ActiveConnection = con
                  cmd8.CommandType = 4
                  cmd8.CommandText = "ActivarCO"
                  cmd8.Parameters.Append cmd8.CreateParameter ("@inId", 3, 1, 4, viene2)
                  cmd8.Parameters.Append cmd8.CreateParameter ("@outCodeResult", 3, 2)
                  cmd8.Execute
                  Response.Redirect("CuentasObjetivo.asp")
              END IF
          END IF
          %>

        </div>
    </body>
</html>