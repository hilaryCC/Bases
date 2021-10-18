<html>
    <head>
        <title>Estados de Cuenta</title>
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
            <a class="seleccionada" href="#estadosdecuenta">Estados de Cuenta</a>
            <a href="ConsultaEC.asp">Consulta EC</a>
            <a href="CuentasObjetivo.asp">Cuentas Objetivo</a>
        </div>

        <div style="padding-left:16px">

            <br><br>
            <label class="titulo">Estados de Cuenta</label>
            <br><br>

            <!--MOSTRAR TABLA DE ESTADOS DE CUENTA-->
            <table>
              <tr bgcolor="grey" width="700">
                    <th>Id</th>
                    <th>Id Cuenta</th>
                    <th>Fecha Inicio</th>
                    <th>Fecha Fin</th>
                    <th>Saldo Inicial</th>
                    <th>Saldo Final</th>
              </tr>
            </table> <!--QUITAR CUANDO YA SE VAYAN A MOSTRAR LAS TABLAS-->
            <br><hr><br>

            <!--SELECCIONAR ESTADO CUENTA-->
            <form method="post" action="ConsultaEC.asp">
              <h3> Digite el id del estado de cuenta que desea consultar: </h3>
              <input class="textbox" type="text" id="estadoCuenta" name="estadoCuenta">
              <input class="boton" type="submit" value="Aceptar">  
            </form>
        </div>
    </body>
</html>