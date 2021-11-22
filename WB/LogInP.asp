<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="Generator" content="Docukits">
        <title>Página Principal</title>
        <style>
            body {
                background-color: #a7d2f3;
                font-family: 'Ubuntu', sans-serif;
            }

            .main {
                background-color: #FFFFFF;
                width: 400px;
                height: 400px;
                margin: 7em auto;
                border-radius: 1.5em;
                box-shadow: 0px 11px 35px 2px rgba(0, 0, 0, 0.14);
            }

            .titulo {
                padding-top: 40px;
                color: #8C55AA;
                font-family: 'Ubuntu', sans-serif;
                font-weight: bold;
                font-size: 23px;
            }

            .textbox {
                width: 76%;
                color: rgb(38, 50, 56);
                font-weight: 700;
                font-size: 14px;
                letter-spacing: 1px;
                background: rgba(136, 126, 126, 0.04);
                padding: 10px 20px;
                border-radius: 20px;
                box-sizing: border-box;
                border: 2px solid rgba(0, 0, 0, 0.02);
                margin-bottom: 50px;
                margin-left: 46px;
                text-align: center;
                margin-bottom: 27px;
                font-family: 'Ubuntu', sans-serif;
            }

            .boton {
                cursor: pointer;
                border-radius: 1em;
                color: #fff;
                background: #ad69ef;
                padding-left: 40px;
                padding-right: 40px;
                padding-bottom: 10px;
                padding-top: 10px;
                font-family: 'Ubuntu', sans-serif;
                border: 2px solid rgba(0, 0, 0, 0.02);
                margin-left: 35%;
                font-size: 13px;
            }

            .alert {
              padding: 10px;
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
        <meta charset="UTF-8">
        <br><br>
            <div class="main">
                <div style="position: absolute; left: 700px; top: 170px;">
                    <label class="titulo"><h1>Log In</h1></label>
                </div>

                <br><br>
                <br><br>
                <form method="post" action="LogInP.asp">
                    <div style="position: absolute; left: 615px; top: 300px;">
                        <input class="textbox" type="text" id="usuario" name="usuario" placeholder="User">
                    </div>

                    <div style="position: absolute; left: 615px; top: 360px;">
                        <input class="textbox" type="password" id="contrasena" name="contrasena" placeholder="Password">
                    </div>
                
                    <div style="position: absolute; left: 655px; top: 440px;">
                        <input class="boton" type="submit" value="Ingresar">  
                    </div>
                </form>
                <%  
                    Dim con 'variable para objeto de conexion
                    Dim rec 'variable para objeto recordset
                    Dim rs 'variable para guardar el puntero
                    Dim x 'contador
                    Dim viene 'si el formulario ya fue enviado'
                    Session("existeU") = "0" ' para determinar si el usuario existe
                    Session("existeC") = "0"' para determinar si la contraseña es correcta
                    Session.Timeout = 60

                    viene = request.form("usuario")
                    If (viene<>"") THEN
                    
                        Session("nombreUsuario") = request.form("usuario")
                        Set con = Server.CreateObject("Adodb.Connection")
                        con.open "BasesD"
                        
                        ' Validar usuario
                        Set objCommand = Server.CreateObject("ADODB.command")
                        objCommand.ActiveConnection = con
                        objCommand.CommandType = 4
                        objCommand.CommandText = "ValidarUser"
                        objCommand.Parameters.Append objCommand.CreateParameter ("@NameUser", 200, 1, 40, Session("nombreUsuario"))
                        objCommand.Parameters.Append objCommand.CreateParameter ("@outCodeResult", 3, 2)
                        objCommand.Parameters.Append objCommand.CreateParameter ("@Encontrado", 3, 2)
                        objCommand.Execute
                        Session("existeU") = objCommand.Parameters("@Encontrado")
                        
                        ' Si existe el usuario
                        IF (Session("existeU")<>"0") THEN
                            ' Obtener el IdUsuario del Usuario
                            Set cmd1 = Server.CreateObject("ADODB.command")
                            cmd1.ActiveConnection = con
                            cmd1.CommandType = 4
                            cmd1.CommandText = "ConsultaUsuario"
                            cmd1.Parameters.Append cmd1.CreateParameter ("@inNameUser", 200, 1, 40, Session("nombreUsuario"))
                            cmd1.Parameters.Append cmd1.CreateParameter ("@outIdUsuario", 3, 2)
                            cmd1.Parameters.Append cmd1.CreateParameter ("@outIdPersona", 3, 2)
                            cmd1.Parameters.Append cmd1.CreateParameter ("@outEsAdministrador", 3, 2)
                            cmd1.Execute
                            Session("IdUsuario") = CInt(cmd1.Parameters("@outIdUsuario"))
                            Session("IdPersona") = cmd1.Parameters("@outIdPersona")
                            Session("EsAdministrador") = cmd1.Parameters("@outEsAdministrador")

                            ' Validar contraseña 
                            Set cmd2 = Server.CreateObject("ADODB.command")
                            cmd2.ActiveConnection = con
                            cmd2.CommandType = 4
                            Session("contrasena") = request.form("contrasena")
                            cmd2.CommandText = "ValidarPass"
                            cmd2.Parameters.Append cmd2.CreateParameter ("@inNameUser", 200, 1, 40, Session("nombreUsuario"))
                            cmd2.Parameters.Append cmd2.CreateParameter ("@inContrasena", 200, 1, 40, Session("contrasena"))
                            cmd2.Parameters.Append cmd2.CreateParameter ("@outCodeResult", 3, 2)
                            cmd2.Parameters.Append cmd2.CreateParameter ("@outCorrectPass", 3, 2)
                            cmd2.Execute
                            Session("existeC") = cmd2.Parameters("@outCorrectPass")

                            ' Determinar si puede entrar
                            IF (Session("existeU") = "1") AND (Session("existeC") = "1") THEN
                                Response.Redirect("InicioP.asp")
                            ELSE%>
                                <br>
                                <div class="alert">
                                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                                <strong>Error!</strong> Contraseña incorrecta.
                              </div>
                            <%END IF
                        ' No existe el usuario
                        ELSE 
                            %>
                                <br>
                                <div class="alert">
                                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                                <strong>Error!</strong> El usuario no existe.
                              </div>
                            <%
                        END IF
                    END IF
                %>

            </div>
    </body>

</html>