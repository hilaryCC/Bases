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

            ' Se crea el objeto de conexion
            Set con = Server.CreateObject("Adodb.Connection")

            ' Se crea el objeto recordset
            Set rec = Server.CreateObject("Adodb.recordset")

            ' Se abre la conexion
            con.open "BasesD" ' nombre del DSN creado

            Set rs = con.execute("Select * from Beneficiario")
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

            ' Mostrar tabla de beneficiarios
            rsql="SELECT B.Id, P.Nombre, P.ValorDocumentoIdentidad, P.FechaNacimiento, P.telefono1, P.telefono2, Pa.Nombre, B.Porcentaje"
            rsql=rsql+" FROM dbo.Persona P INNER JOIN dbo.Beneficiario B ON P.Id=B.IdPersona"
            rsql=rsql+" INNER JOIN dbo.Parentezco Pa ON B.ParentezcoId=Pa.Id where B.IdCuenta="&Session("IdCuenta")
            rsql=rsql+" AND B.Activo=1"
            
            rec.open(rsql), con
          IF  not rec.EOF THEN
              infot=rec.GetString(,,"</td><td>","</td></tr><tr><td>"," ")

              %>
              <tr>
                <%Response.Write("<tr bgcolor='lightgrey' align='center'>")%>
               <td><%Response.Write(infot)%></td>
             </tr>
          </table>

  				<%
            rec.close
  					rec.open("SELECT SUM(porcentaje) FROM dbo.Beneficiario WHERE IdCuenta="&Session("IdCuenta")), con
  					suma = CInt(rec.GetString())
            rec.close
  					rec.open("SELECT COUNT(*) FROM dbo.Beneficiario WHERE IdCuenta="&Session("IdCuenta")), con
  					cant = CInt(rec.GetString())

            IF (suma<>100)THEN%>
              <br>
    					<div class="alert">
                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                <strong>Alerta!</strong> La suma de los porcentajes no da 100.
              </div>

          <%END IF 
            IF (cant<>3) THEN%>
              <br>
              <div class="alert">
                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                <strong>Alerta!</strong> La cantidad de beneficiarios es incorrecta.
              </div>

          <%END IF
  					rec.close
  					con.close
  					set rec=nothing
  					set con=nothing
          ELSE%>
            <br>
              <div class="alert">
                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                <strong>Alerta!</strong> No existen beneficiarios
              </div>
          <%END IF

        %>
			</div>

        <!-- EDITAR BENEFICIARIOS -->
        <br><hr><br>
        <form action="Editar.asp" method="post">
          <label class="titulo">Editar Beneficiarios</label>
          <br><br>
          <label for="numBen">Digite el Id del beneficiario que desea editar: </label>
          <input type="number" id="quantity" name="quantity">
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

          <label for="lbl2">Digite la nueva información según lo escogido: </label>
          <input class="textbox" type="text" id="Infotxt" name="Infotxt" placeholder="Nuevo nombre o etc">
          <br><br>
          <!--Boton editar beneficiarios-->
          <button id="aceptarEdit" class="boton" type="submit">Aceptar</button>
      </form>

      <br><br><hr><br>

      <!-- AGREGAR BENEFICIARIOS -->
      <form action="Agregar.asp" method="post">
        <label class="titulo">Agregar Beneficiarios</label>
        <br><br>
        <label for="optionlbl">Digite la siguiente información:</label>
        <br><br>
        <input class="textbox" type="text" name="ValorDocumentoIdentidad" placeholder="Identificación">
        <br><br>
        <input class="textbox" type="text" name="parentezco" placeholder="Parentezco">
        <br><br> 
        <label for="numBen">Porcentaje: </label>
        <input type="number" name="porcentaje" min="1" max="100">
        <br><br>

        <!--Boton agregar beneficiarios-->
        <button id="aceptarAgregar" class="boton" type="submit">Aceptar</button>
      </form>
      <br><br><br><hr><br>

        <label class="titulo">Eliminar Beneficiarios</label>
        <br><br>
        <label for="numBen">Digite el Id del beneficiario que desea eliminar: </label>
        <input type="number" id="quantity" name="quantity" min ="0" max="3">
        <br><br>
        <!--Boton eliminar beneficiarios-->
        <button id="aceptarEliminar" class="boton" type="button">Aceptar</button>
        <br><br><br><br>
      </div>



    </body>
</html>