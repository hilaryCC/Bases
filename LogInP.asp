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
                        <input class="textbox" type="text" id="contrasena" name="contrasena" placeholder="Password">
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
                    
                        ' Se crea el objeto de conexion
                        Set con = Server.CreateObject("Adodb.Connection")

                        ' Se crea el objeto recordset
                        Set rec = Server.CreateObject("Adodb.recordset")

                        ' Se abre la conexion
                        con.open "BasesD" ' nombre del DSN creado
                        
                        Set rs = con.execute("Select [User] from Usuario")

                        'Validar usuario
                        DO UNTIL rs.EOF 'EOF = end of file
                            FOR EACH x IN rs.Fields
                                IF (x.value = request.form("usuario")) THEN
                                    Session("existeU") = "1"
                                    Session("nombreUsuario") = request.form("usuario")
                                END IF
                            NEXT
                            rs.movenext
                        LOOP
                        
                        IF (Session("existeU")<>"0") THEN
                            rec.open("SELECT Id FROM Usuario WHERE [User]='"&Session("nombreUsuario")&"'"), con
                            Session("IdUsuario") = CInt(rec.GetString())

                            Set rs = con.execute("Select Pass from Usuario WHERE [User]='"&Session("nombreUsuario")&"'")

                            'Validar contraseña 
                            DO UNTIL rs.EOF 'EOF = end of file
                                FOR EACH x IN rs.Fields
                                    IF (x.value = request.form("contrasena")) THEN
                                        Session("existeC") = "1"
                                    END IF
                                NEXT
                                rs.movenext
                            LOOP
                            
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