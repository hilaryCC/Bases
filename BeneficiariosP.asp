<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="Generator" content="Docukits">
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
            table, td {
                border: 1px solid black;
            }
        </style>
        <!-- JAVASCRIPT-->
        <script>
            function detInfo() {
                var editarOpcion = document.getElementById("EditOp").value; // variable que guarda la opcion de lo que se va a editar
                var numBeneficiario = document.getElementById("quantity").value;
                //document.getElementById("demo").innerHTML = numBeneficiario; para ver la opcion escogida de algo
                alert("Informacion enviada");
            }

        </script>
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
            Dim rs 'variable para guardar el puntero
            Dim x 'contador

            ' Se crea el objeto de conexion
            Set con = Server.CreateObject("Adodb.Connection")

            ' Se crea el objeto recordset
            Set rec = Server.CreateObject("Adodb.recordset")

            ' Se abre la conexion
            con.open "Proyecto1" ' nombre del DSN creado

            Set rs = con.execute("Select * from Beneficiario")
        %>
        <table>
            <tr bgcolor="grey" width="700">
                <th>Nombre</th>
                <th>Identificacion</th>
                <th>Fecha Nacimiento</th>
                <th>Telefono 1</th>
                <th>Telefono 2</th>
                <th>Parentezco</th>
                <th>Porcentaje</th>
            </tr>
            <%
                ' Determinar el id de la cuenta
                Set rs = con.execute("SELECT * FROM CuentaAhorro")
        
                DO UNTIL rs.EOF 
                    FOR EACH x IN rs.Fields
                        IF (CStr(x.value) = CStr(Session("NumeroCuenta")) ) THEN
                            Session("IdCuenta") = rs("Id").value
                        END IF
                    NEXT
                    rs.movenext
                LOOP
                

                ' Mostrar tabla de beneficiarios
                Set rs = con.execute("SELECT * FROM dbo.Persona P FULL OUTER JOIN dbo.Beneficiario B ON P.Id=B.IdPersona where B.IdCuenta is not null")
                DO UNTIL rs.EOF 'EOF = end of file
                    Response.Write("<tr bgcolor='lightgrey' align='center'>")
                        FOR EACH x IN rs.Fields
                            IF (x.name = "Nombre") Or (x.name = "ValorDocumentoIdentidad") Or _
                               (x.name = "FechaNacimiento") Or (x.name = "telefono1") Or _
                               (x.name = "telefono2") Or (x.name = "ParentezcoId") Or _
                               (x.name = "Porcentaje") THEN
                                IF (rs("IdCuenta").value = Session("IdCuenta")) then
                                    Response.Write("<td>" & x.value & "</td>")
                                END IF
                            END IF
                        NEXT
                    Response.Write("</tr>")
                    rs.movenext
                LOOP
            %>
        </table>
        
        <!-- EDITAR BENEFICIARIOS -->
        <br><br><br><hr><br>
        <label class="titulo">Editar Beneficiarios</label>
        <br><br>
        <label for="numBen">Digite el numero del beneficiario que desea editar: </label>
        <input type="number" id="quantity" name="quantity" min="0" max="3">
        <br><br>

        <label for="optionlbl">Escoja lo que va a editar:</label>
        <select id="EditOp">
            <option value="nombre">Nombre</option>
            <option value="parentezco">Parentezco</option>
            <option value="porcentaje">Porcentaje</option>
            <option value="fechanacimiento">Fecha de nacimiento</option>
            <option value="telefono1">Telefono 1</option>
            <option value="telefono2">Telefono 2</option>
        </select>
        <br><br>

        <label for="lbl2">Digite la nueva información según lo escogido: </label>
        <input class="textbox" type="text" id="Infotxt" ame="Infotxt" placeholder="Nuevo nombre o etc">
        <br><br>
        <button id="aceptarEdit" class="boton" type="button" onclick="detInfo()">Aceptar</button>
        <!--  <p id="demo"></p> para ver la opcion escogida en un label-->
        <br><br><br><hr><br>

        <!-- AGREGAR BENEFICIARIOS -->
        <label class="titulo">Agregar Beneficiarios</label>
        <br><br>
        <label for="optionlbl">Digite la siguiente información:</label>
        <br><br>
        <input class="textbox" type="text" id="nombre" ame="nombre" placeholder="Nombre">
        <input class="textbox" type="text" id="ValorDocumentoIdentidad" ame="ValorDocumentoIdentidad" placeholder="Identificación">
        <br><br>
        <input class="textbox" type="text" id="Email" ame="Email" placeholder="Email">
        <input class="textbox" type="text" id="Telefono1" ame="Telefono1" placeholder="Telefono 1">
        <br><br>
        <input class="textbox" type="text" id="Telefono2" ame="Telefono2" placeholder="Telefono 2">
        <input class="textbox" type="text" id="Parentezco" ame="Parentezco" placeholder="Parentezco">
        <br><br>
        <input class="textbox" type="text" id="Porcentaje" ame="Porcentaje" placeholder="Porcentaje">
        <input class="textbox" type="text" id="TipoDocuIdentidad" ame="TipoDocuIdentidad" placeholder="Tipo Documento Identidad">
        <br><br>
        <label for="optionlbl">Fecha Nacimiento:</label>
        <input type="date" id="FechaNacimiento" name="FechaNacimiento" placeholder="Fecha Nacimiento">
        <br><br>
        <button id="aceptarAgregar" class="boton" type="button">Aceptar</button>
        <br><br><br><hr><br>

        <!-- ELIMINAR BENEFICIARIOS -->
        <label class="titulo">Eliminar Beneficiarios</label>
        <br><br>
        <label for="numBen">Digite el numero del beneficiario que desea eliminar: </label>
        <input type="number" id="quantity" name="quantity" min="0" max="3">
        <br><br>
        <button id="aceptarEliminar" class="boton" type="button">Aceptar</button>
        <br><br><br><br>


    </div>
    </body>
</html>
