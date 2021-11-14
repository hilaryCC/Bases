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
        <%
            IF (Session("EsAdministrador") = "1") THEN
        %>
                <div style="padding-left:16px">
                    <br><br>
                    <label class="titulo">Consultas de Administrador</label>
                    <br><br>
                </div>
        <%
            ELSE
        %>
                <br><br>
                <div class="alert" style="padding-left:16px">
                    <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
                    <strong>Alerta!</strong> Usted no es administrador. Por lo tanto, no tiene acceso a esta pagina.
                </div>
        <%
            END IF
        %>
    </body>
</html>