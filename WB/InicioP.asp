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
      <a href="InicioP.asp">Estados de Cuenta</a>
      <a href="InicioP.asp">Consulta EC</a>
      <a href="InicioP.asp">Cuentas Objetivo</a>
      <a href="InicioP.asp">Admin</a>
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
        con.open "Proyecto1" ' nombre del DSN creado

        Response.Write("<div style='padding-left:16px'> <h3> Cuentas: </h3></div>")

        ' Determinar el Id Persona del usuario
        Set cmd0 = Server.CreateObject("ADODB.command")
        cmd0.ActiveConnection = con
        cmd0.CommandType = 4
        cmd0.CommandText = "ConsultaIdPersona"
        cmd0.Parameters.Append cmd0.CreateParameter ("@inUsuario", 200, 1, 40, Session("nombreUsuario"))
        cmd0.Parameters.Append cmd0.CreateParameter ("@outIdPersona", 3, 2)
        cmd0.Execute
        Session("IdPersonaUsuario") = CInt(cmd0.Parameters("@outIdPersona"))
    %>
    <div style='padding-left:16px'>
        <table>
            <tr bgcolor="grey" width="700">
                <th>Id Cuenta</th>
                <th>Tipo Cuenta</th>
                <th>Numero Cuenta</th>
                <th>Fecha Creacion</th>
                <th>Saldo</th>
            </tr>
            <%
                ' Se determina si hay que mostrar todas las cuentas (administrador)
                ' o solo las del usuario
                IF (Session("EsAdministrador") = "1") THEN
                    ' Determinar cantidad de filas
                    Set cmd = Server.CreateObject("ADODB.command")
                    cmd.ActiveConnection = con
                    cmd.CommandType = 4
                    cmd.CommandText = "ConsultaFilasCuentaAhorro"
                    cmd.Parameters.Append cmd.CreateParameter ("@outCantFilas", 3, 2)
                    cmd.Execute
                    Session("CantFilas1") = CInt(cmd.Parameters("@outCantFilas"))
                    
                    ' Mostrar todas las cuentas 
                    FOR i = 1 to Session("CantFilas1")
                        Set cmd2 = Server.CreateObject("ADODB.command")
                        cmd2.ActiveConnection = con
                        cmd2.CommandType = 4
                        cmd2.CommandText = "ConsultaFilaCA"
                        Response.Write("<tr bgcolor='lightgrey' align='center'>")
                        cmd2.Parameters.Append cmd2.CreateParameter ("@inId", 3, 1, 4, i)
                        cmd2.Parameters.Append cmd2.CreateParameter ("@outNombre", 200, 2, 40)
                        cmd2.Parameters.Append cmd2.CreateParameter ("@outNumeroCuenta", 200, 2, 40)
                        cmd2.Parameters.Append cmd2.CreateParameter ("@outFechaCreacion", 200, 2, 40)
                        cmd2.Parameters.Append cmd2.CreateParameter ("@outSaldo", 5, 2)
                        cmd2.Execute
                        Response.Write("<td>" & i & "</td>")
                        Response.Write("<td>" & cmd2.Parameters("@outNombre") & "</td>")
                        Response.Write("<td>" & cmd2.Parameters("@outNumeroCuenta") & "</td>")
                        Response.Write("<td>" & cmd2.Parameters("@outFechaCreacion") & "</td>")
                        Response.Write("<td>" & cmd2.Parameters("@outSaldo") & "</td>")
                        Response.Write("</tr>")
                    NEXT
                ELSE
                    ' Determinar cantidad de filas
                    Set cmd3 = Server.CreateObject("ADODB.command")
                    cmd3.ActiveConnection = con
                    cmd3.CommandType = 4
                    cmd3.CommandText = "ConsultarFilasCuentaAhorro2"
                    cmd3.Parameters.Append cmd3.CreateParameter ("@inId", 3, 1, 4, Session("IdUsuario"))
                    cmd3.Parameters.Append cmd3.CreateParameter ("@outCantFilas", 3, 2)
                    cmd3.Execute
                    Session("CantFilas2") = CInt(cmd3.Parameters("@outCantFilas"))
                    ' Mostrar las cuentas del usuario
                    FOR i = 0 to Session("CantFilas2")-1
                        Set cmd4 = Server.CreateObject("ADODB.command")
                        cmd4.ActiveConnection = con
                        cmd4.CommandType = 4
                        cmd4.CommandText = "ConsultaFilaCA2"
                        Response.Write("<tr bgcolor='lightgrey' align='center'>")
                        cmd4.Parameters.Append cmd4.CreateParameter ("@inCont", 3, 1, 4, i)
                        cmd4.Parameters.Append cmd4.CreateParameter ("@inIdPersona", 3, 1, 4, Session("IdPersonaUsuario"))
                        cmd4.Parameters.Append cmd4.CreateParameter ("@outNombre", 200, 2, 40)
                        cmd4.Parameters.Append cmd4.CreateParameter ("@outNumeroCuenta", 200, 2, 40)
                        cmd4.Parameters.Append cmd4.CreateParameter ("@outFechaCreacion", 200, 2, 40)
                        cmd4.Parameters.Append cmd4.CreateParameter ("@outSaldo", 5, 2)
                        cmd4.Execute
                        Response.Write("<td>" & Session("IdUsuario") & "</td>") ' ARREGLAR ACA, DEBE SER EL ID DE CUENTA NO USUARIO
                        Response.Write("<td>" & cmd4.Parameters("@outNombre") & "</td>")
                        Response.Write("<td>" & cmd4.Parameters("@outNumeroCuenta") & "</td>")
                        Response.Write("<td>" & cmd4.Parameters("@outFechaCreacion") & "</td>")
                        Response.Write("<td>" & cmd4.Parameters("@outSaldo") & "</td>")
                        Response.Write("</tr>")
                    NEXT
                END IF
             %>   
        </table>
    <form method="post" action="InicioP.asp">
        <h3> Digite el # de la cuenta con la que quiere trabajar: </h3>
        <input class="textbox" type="text" id="Cuenta" name="Cuenta">
        <input class="boton" type="submit" value="Aceptar">  
    </form>
    <%
        ' Determinar si el # de cuenta digitado existe
        On Error Resume Next
        Session("NumeroCuenta") = request.form("Cuenta")
        Session("existeCuenta") = "0"
        Session.Timeout = 60
        Set cmd5 = Server.CreateObject("ADODB.command")
        cmd5.ActiveConnection = con
        cmd5.CommandType = 4
        cmd5.CommandText = "ValidarCuentaAhorro"
        cmd5.Parameters.Append cmd5.CreateParameter ("@inNumCuenta", 3, 1, 4, CLng(Session("NumeroCuenta")))
        cmd5.Parameters.Append cmd5.CreateParameter ("@outExiste", 3, 2)
        cmd5.Parameters.Append cmd5.CreateParameter ("@outIdCuenta", 3, 2)
        cmd5.Parameters.Append cmd5.CreateParameter ("@outCodeResult", 3, 2)
        cmd5.Execute
        Session("existeCuenta") = cmd5.Parameters("@outExiste")
        Session("IdCuenta") = cmd5.Parameters("@outIdCuenta")
        IF Err.Number <> 0 THEN
            Response.Write()              
        END IF
        On Error GoTo 0
        ' Si la cuenta existe, pasa a la siguiente pagina
        IF (Session("existeCuenta") = "1") THEN
            Response.Redirect("BeneficiariosP.asp")
        END IF

    %>
    </div>
    </body>
</html>
