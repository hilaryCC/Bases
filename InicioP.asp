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
      <a class="seleccionada" href="#home">Inicio</a>
      <a href="InicioP.asp">Beneficiarios</a>
    </div>
        
    <%
        Response.Write("<br><div style='padding-left:16px'><label class='titulo'> Bienvenido: " & _
                        Session("nombreUsuario") & "</label></div>")
        Dim con 'variable para objeto de conexion
        Dim rec 'variable para objeto recordset
        Dim rs 'variable para guardar el puntero
        Dim x 'contador


        ' Se crea el objeto de conexion
        Set con = Server.CreateObject("Adodb.Connection")

        ' Se crea el objeto recordset
        Set rec = Server.CreateObject("Adodb.recordset")

        ' Se abre la conexion
        con.open "BasesD" ' nombre del DSN creado

        Set rs = con.execute("Select * from Beneficiario")

        ' Determinar el id persona y si es administrador
        Set rs = con.Execute("Select * from Usuario")
        DO UNTIL rs.EOF 
            FOR EACH x IN rs.Fields
                IF (x.name = "User") AND (x.value = Session("nombreUsuario")) THEN
                    Session("IdPersona") = rs("IdPersona").value
                    Session("EsAdministrador") = rs("EsAdministrador").value
                END IF
            NEXT
            rs.movenext
        LOOP

        Response.Write("<div style='padding-left:16px'> <h3> Cuentas: </h3></div>")
    %>
    <div style='padding-left:16px'>
        <table>
            <tr bgcolor="grey" width="700">
                <th>Tipo Cuenta</th>
                <th>Numero Cuenta</th>
                <th>Fecha Creacion</th>
                <th>Saldo</th>
            </tr>
            <%
                ' Se determina si hay que mostrar todas las cuentas (administrador)
                ' o solo las del usuario
                IF (Session("EsAdministrador") = "1") THEN
                    'Mostrar todas las cuentas
                    Set rs = con.execute("SELECT T.Nombre, C.NumeroCuenta, C.FechaCreacion, C.Saldo FROM CuentaAhorro C INNER JOIN TipoCuentaAhorro T ON C.TipoCuentaId = T.Id")
                    DO UNTIL rs.EOF
                        Response.Write("<tr bgcolor='lightgrey' align='center'>")
                            FOR EACH x IN rs.Fields
                                Response.Write("<td>" & x.value & "</td>")
                            NEXT
                        Response.Write("</tr>")
                        rs.movenext
                    LOOP
                ELSE
                    'Mostrar solo las de usuario
                    Set rs = con.execute("SELECT T.Nombre, C.NumeroCuenta, C.FechaCreacion, C.Saldo FROM CuentaAhorro C INNER JOIN Usuarios_Ver U ON U.IdCuenta=C.Id INNER JOIN TipoCuentaAhorro T ON C.TipoCuentaId = T.Id WHERE U.Id="&Session("IdUsuario"))
                    DO UNTIL rs.EOF
                        Response.Write("<tr bgcolor='lightgrey' align='center'>")
                            FOR EACH x IN rs.Fields
                                    Response.Write("<td>" & x.value & "</td>")
                            NEXT
                        Response.Write("</tr>")
                        rs.movenext
                    LOOP
                END IF
             %>   
        </table>
    <form method="post" action="InicioP.asp">
        <h3> Digite el # de la cuenta con la que quiere trabajar: </h3>
        <input class="textbox" type="text" id="Cuenta" name="Cuenta">
        <input class="boton" type="submit" value="Aceptar">  
    </form>
    <%
        Session("existeCuenta") = "0"
        Session.Timeout = 60
        'Validar que exista el ID Cuenta
        Set rs = con.execute("SELECT NumeroCuenta FROM CuentaAhorro")
        
        DO UNTIL rs.EOF 
            FOR EACH x IN rs.Fields
                IF (CStr(x.value) = CStr(request.form("Cuenta"))) THEN
                    Session("existeCuenta") = "1"
                    Session("NumeroCuenta") = rs("NumeroCuenta").value
                END IF
            NEXT
            rs.movenext
        LOOP
        
        IF (Session("existeCuenta") = "1") THEN
            rec.open("SELECT Id FROM CuentaAhorro WHERE NumeroCuenta="&Session("NumeroCuenta")), con
            Session("IdCuenta") = CInt(rec.GetString())
            Response.Redirect("BeneficiariosP.asp")
        END IF
    %>
    </div>
    </body>
</html>
