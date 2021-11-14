<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<html>
    <head>
        <title>Beneficiarios</title>
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
      <a class="seleccionada" href="#beneficiarios">Beneficiarios</a>
      <a href="EstadosCuentaP.asp">Estados de Cuenta</a>
      <a href="BeneficiariosP.asp">Consulta EC</a>
      <a href="CuentasObjetivo.asp">Cuentas Objetivo</a>
      <a href="Admin.asp">Admin</a>
    </div>

    <div style="padding-left:16px">

        <br><br>
        <!-- MOSTRAR TABLA BENEFICIARIOS-->
        <label class="titulo">Beneficiarios</label>
        <br><br>
        <%
            Dim con 'variable para objeto de conexion
            Dim rec 'variable para objeto recordset
            Dim rs 'variable para guardar puntero
            Dim rsql 'Variable para guardar el comando sql'
            Dim infot 'Guarda el string de la tabla'
            Dim x 'contador
            Dim viene 'verificar si el formulario se envio'

            ' Se crea el objeto de conexion
            Set con = Server.CreateObject("Adodb.Connection")

            ' Se crea el objeto recordset
            Set rec = Server.CreateObject("Adodb.recordset")

            ' Se abre la conexion
            con.open "Proyecto1" ' nombre del DSN creado
        %>
        <table>
          <tr bgcolor="grey" width="700">
              <th>Id</th>
              <th>Nombre</th>
              <th>Identificacion</th>
              <th>Fecha Nacimiento</th>
              <th>Telefono 1</th>
              <th>Telefono 2</th>
              <th>Parentezco</th>
              <th>Porcentaje</th>
          </tr>
        <%
            ' Determinar cantidad de filas
            Set cmd = Server.CreateObject("ADODB.command")
            cmd.ActiveConnection = con
            cmd.CommandType = 4
            cmd.CommandText = "ConsultarFilasBN"
            cmd.Parameters.Append cmd.CreateParameter ("@inId", 3, 1, 4, Session("IdCuenta"))
            cmd.Parameters.Append cmd.CreateParameter ("@outCantFilas", 3, 2)
            cmd.Execute
            Session("CantFilasB") = CInt(cmd.Parameters("@outCantFilas"))
            IF Session("CantFilasB") > 0 THEN
                ' Mostrar tabla de beneficiarios 
                FOR i = 1 to Session("CantFilasB")
                    Set cmd2 = Server.CreateObject("ADODB.command")
                    cmd2.ActiveConnection = con
                    cmd2.CommandType = 4
                    cmd2.CommandText = "ConsultaFilaBN"
                    
                    cmd2.Parameters.Append cmd2.CreateParameter ("@inIdCuenta", 3, 1, 4, Session("IdCuenta"))
                    cmd2.Parameters.Append cmd2.CreateParameter ("@inIdPersona", 3, 1, 4, i)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outIdBN", 3, 2)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outNombre", 200, 2, 40)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outValorDocumentoIdentidad", 200, 2, 40)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outFechaNacimiento", 200, 2, 40)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outtelefono1", 200, 2, 40)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outtelefono2", 200, 2, 40)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outNombrePa", 200, 2, 40)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outPorcentaje", 200, 2, 40)
                    cmd2.Execute
                    existeBen = cmd2.Parameters("@outIdBN")
                    IF IsNull(existeBen) = False THEN
                        Response.Write("<tr bgcolor='lightgrey' align='center'>")
                        Response.Write("<td>" & existeBen & "</td>")
                        Response.Write("<td>" & cmd2.Parameters("@outNombre") & "</td>")
                        Response.Write("<td>" & cmd2.Parameters("@outValorDocumentoIdentidad") & "</td>")
                        Response.Write("<td>" & cmd2.Parameters("@outFechaNacimiento") & "</td>")
                        Response.Write("<td>" & cmd2.Parameters("@outtelefono1") & "</td>")
                        Response.Write("<td>" & cmd2.Parameters("@outtelefono2") & "</td>")
                        Response.Write("<td>" & cmd2.Parameters("@outNombrePa") & "</td>")
                        Response.Write("<td>" & cmd2.Parameters("@outPorcentaje") & "</td>")
                        Response.Write("</tr>")
                    END IF
                NEXT
        %>
        </table>

  		<%
            Set cmd3 = Server.CreateObject("ADODB.command")
            cmd3.ActiveConnection = con
            cmd3.CommandType = 4
            cmd3.CommandText = "ConsultaBeneficarios"
            cmd3.Parameters.Append cmd3.CreateParameter ("@inIdCuenta", 3, 1, 4, Session("IdCuenta"))
            cmd3.Parameters.Append cmd3.CreateParameter ("@outSuma", 3, 2)
            cmd3.Parameters.Append cmd3.CreateParameter ("@outCant", 3, 2)
            cmd3.Execute
  			suma = cmd3.Parameters("@outSuma")
  			cant = cmd3.Parameters("@outCant")

            IF (suma<>100)THEN
        %>
                <br>
    	        <div class="alert">
                    <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                    <strong>Alerta!</strong> La suma de los porcentajes no da 100.
                </div>
        <%
            END IF 
            IF (cant < 3) THEN
        %>
                <br>
                <div class="alert">
                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                <strong>Alerta!</strong> La cantidad de beneficiarios es incorrecta.
                </div>
                <script type="text/javascript"> 
                document.getElementById("aceptarAgregar").disabled = false;
                </script>
        <%
            ELSEIF (cant > 3) THEN
        %>
                <br>
                <div class="alert">
                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                <strong>Alerta!</strong> La cantidad de beneficiarios es incorrecta.
                </div>
                <script type="text/javascript"> 
                document.getElementById("aceptarAgregar").disabled = true;
                </script>
        <%
            ELSEIF (cant = 3) THEN
        %>
                <script type="text/javascript"> 
                document.getElementById("aceptarAgregar").disabled = true;
                </script>
        <%
            END IF
            ELSE
        %>
                </table>
                <br>
                <div class="alert">
                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                <strong>Alerta!</strong> No existen beneficiarios
                </div>
        <%
            END IF
        %>
        
        <!-- EDITAR BENEFICIARIOS -->
        <br><hr><br>
        <form action="BeneficiariosP.asp" method="post">
            <label class="titulo">Editar Beneficiarios</label>
            <br><br>
            <label for="numBen">Digite el Id del beneficiario que desea editar: </label>
            <input type="number" id="quantity" name="quantity" required>
            <br><br>

            <label for="optionlbl">Escoja lo que va a editar:</label>
            <select id="EditOp" name="EditOp">
                <option value="nombre">Nombre</option>
                <option value="identificacion">Identificacion</option>
                <option value="parentezco">Parentezco</option>
                <option value="porcentaje">Porcentaje</option>
                <option value="fechanacimiento">Fecha de nacimiento</option>
                <option value="telefono1">Telefono 1</option>
                <option value="telefono2">Telefono 2</option>
            </select>
            <br><br>

            <label for="lbl2">Digite la nueva informacion segun lo escogido: </label>
            <input class="textbox" type="text" id="Infotxt" name="Infotxt" placeholder="Nuevo nombre o etc" required>
            <br><br>
            <!--Boton editar beneficiarios-->
            <button id="aceptarEdit" class="boton" type="submit">Aceptar</button>
        </form>

        <!-- VERIFICAR EL BENEFICIARIO -->
        <%
        viene=Request.Form("Infotxt")
        IF (viene<>"") THEN
          Set cmd4 = Server.CreateObject("ADODB.command")
          cmd4.ActiveConnection = con
          cmd4.CommandType = 4
          cmd4.CommandText = "ValidarBeneficiario"
          cmd4.Parameters.Append cmd4.CreateParameter ("@inIdBeneficiario", 3, 1, 4, Request.Form("quantity"))
          cmd4.Parameters.Append cmd4.CreateParameter ("@inIdCuenta", 3, 1, 4, Session("IdCuenta"))
          cmd4.Parameters.Append cmd4.CreateParameter ("@outCodeResult", 3, 2)
          cmd4.Parameters.Append cmd4.CreateParameter ("@Encontrado", 3, 2)
          cmd4.Execute
  		  existe = cmd4.Parameters("@Encontrado")
          IF existe = "0" THEN
        %>
            <br>
            <div class="alert">
                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                <strong>Alerta!</strong> El Id del beneficiario no existe asociado a su cuenta.
            </div>
        <%
          ELSE
        %>
            <form id="AVBene" name="AVBene" action="Editar.asp" method="post" style="display:block">
                <input type="hidden" id="opcionB" name="opcionB" value="<%Response.write(Request.form("EditOp"))%>">
                <input type="hidden" id="nuevoB" name="nuevoB" value="<%Response.write(Request.form("Infotxt"))%>">
                <input type="hidden" id="idB" name="idB" value="<%Response.write(Request.form("quantity"))%>">
            </form>
            <script>document.getElementById("AVBene").submit()</script>
        <%
          END IF
        END IF
        %>

      <br><br><hr><br>

      <!-- AGREGAR BENEFICIARIOS -->
      <form action="Agregar.asp" method="post">
          <label class="titulo">Agregar Beneficiarios</label>
          <br><br>
          <label for="optionlbl">Digite la siguiente informacion:</label>
          <br><br>
          <input class="textbox" type="text" name="ValorDocumentoIdentidad" placeholder="Identificacion" required>
          <br><br>
          <input class="textbox" type="text" name="parentezco" placeholder="Parentezco" required>
          <br><br> 
          <label for="numBen">Porcentaje: </label>
          <input type="number" name="porcentaje" min="1" max="100" required>
          <br><br>

          <!--Boton agregar beneficiarios-->
          <button id="aceptarAgregar" name="aceptarAgregar" class="boton" type="submit">Aceptar</button>
      </form>
      <br><br><br><hr><br>

      <!-- ELIMINAR BENEFICIARIOS -->
      <form action="BeneficiariosP.asp" method="post">
          <label class="titulo">Eliminar Beneficiarios</label>
          <br><br>
          <label for="numBen">Digite el Id del beneficiario que desea eliminar: </label>
          <input type="number" id="quantity" name="beneficiario" required>
          <br><br>
          <!--Boton eliminar beneficiarios-->
          <button id="aceptarEliminar" class="boton" type="submit">Aceptar</button>
          <br>
      </form>
      <!-- VERIFICAR EL BENEFICIARIO -->
      <%
      Dim viene1
      viene1=Request.Form("beneficiario")
      IF (viene1<>"") THEN
          Set cmd5 = Server.CreateObject("ADODB.command")
          cmd5.ActiveConnection = con
          cmd5.CommandType = 4
          cmd5.CommandText = "ValidarBeneficiario"
          cmd5.Parameters.Append cmd5.CreateParameter ("@inIdBeneficiario", 3, 1, 4, Request.Form("beneficiario"))
          cmd5.Parameters.Append cmd5.CreateParameter ("@inIdCuenta", 3, 1, 4, Session("IdCuenta"))
          cmd5.Parameters.Append cmd5.CreateParameter ("@outCodeResult", 3, 2)
          cmd5.Parameters.Append cmd5.CreateParameter ("@Encontrado", 3, 2)
          cmd5.Execute
  		  existe = cmd5.Parameters("@Encontrado")
          IF existe = "0" THEN
      %>
            <br>
            <div class="alert">
                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                <strong>Alerta!</strong> El Id del beneficiario no existe asociado a su cuenta.
            </div>
      <%
          ELSE
      %>
            <form id="ELBene" name="ELBene" action="Eliminar.asp" method="post" style="display:block">
                <input type="hidden" id="eliminarB" name="eliminarB" value="<%Response.write(Request.form("beneficiario"))%>">
            </form>
            <script>document.getElementById("ELBene").submit()</script>
      <%
          END IF
      END IF
      %>
      <br><br><br><br>
      </div>
    </body>
</html>