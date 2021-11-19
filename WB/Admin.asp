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
            <a href="ConsultaEC.asp">Consulta EC</a>
            <a href="CuentasObjetivo.asp">Cuentas Objetivo</a>
            <a class="seleccionada" href="#Admin">Admin</a>
        </div>
        <!-- USUARIO NO ES ADMINISTRADOR -->
        <%
            IF (Session("EsAdministrador") = "0") THEN
        %>
                <br><br>
                <div class="alert" style="padding-left:16px">
                    <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                    <strong>Alerta!</strong> Usted no es administrador. Por lo tanto, no tiene acceso a esta pagina.
                </div>
                
        <!-- USUARIO ES ADMINISTRADOR -->
        <%
            ELSE
        %>
                <div style="padding-left:16px">
                    
                    <!--INTRO -->
                    <br><br>
                    <label class="titulo">Consultas de Administrador</label>
                    <br><br>
                    <p>Las consultas disponibles son las siguientes:</p>
                    <ol>
                        <li>Consulta sobre CO cuyo retiro no pudo realizarse</li>
                        <li>Consulta sobre cuentas con multas </li>
                        <li>Consulta sobre muerte de beneficiarios</li>
                    </ol>
                    
                    <!-- ELEGIR CONSULTAR A REALIZAR -->
                    <p>Digite el numero de consulta a realizar</p>
                    <form action="Admin.asp" method="post">
                        <input class="textbox" type="text" id="NumConsulta" name="NumConsulta" required>
                        <br><br>
                        <button id="aceptarC" class="boton" type="submit">Aceptar</button>
                    </form>
                    <%
                        viene=Request.Form("NumConsulta")
                        Session("Consulta") = viene
                        IF (viene<>"") THEN
                            
                            IF (Session("Consulta") = "1") THEN
                                Response.Redirect("ConsultaAdm.asp")

                            ELSEIF (Session("Consulta") = "2") THEN
                                Response.Redirect("ConsultaAdm2.asp")
                        
                            ELSEIF (Session("Consulta") = "3") THEN
                                Response.Redirect("ConsultaAdm3.asp")
                            
                            END IF
                        END IF
                    %>
                </div>
        <%
            END IF
        %>
    </body>
</html>