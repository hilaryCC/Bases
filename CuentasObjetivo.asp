<html>
    <head>
        <title>Cuentas Objetivo</title>
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
            <a href="CuentasObjetivo.asp">Consulta EC</a>
            <a class="seleccionada" href="#cuentasObjetivo">Cuentas Objetivo</a>
        </div>
        <div style="padding-left:16px">

          <br><br>
          <label class="titulo">Cuentas Objetivo</label>
          <br><br>
          <!-- MOSTRAR CUENTAS OBJETIVO -->
            
          <table>
            <tr bgcolor="grey" width="700">
                  <th>Id</th>
                  <th>Id Cuenta</th>
                  <th>Fecha Inicio</th>
                  <th>Fecha Fin</th>
                  <th>Cuota</th>
                  <th>Objetivo</th>
                  <th>Saldo</th>
                  <th>Interes Anual</th>
            </tr>
          </table> <!--QUITAR CUANDO YA SE VAYAN A MOSTRAR LAS TABLAS-->
          <br><hr><br>

          <!-- AGREGAR CUENTA OBJETIVO -->
          <form action="CuentasObjetivo.asp" method="post">
            <label class="titulo">Agregar Cuenta Objetivo</label>
             
            <br><br>
            <label for="optionlbl" >Fecha Inicio:</label>
            <input type="date" id="FechaInicio" name="FechaInicio" placeholder="Fecha Inicio">
              
            <br><br>
            <label for="optionlbl" >Fecha Fin:</label>
            <input type="date" id="FechaFin" name="FechaFin" placeholder="Fecha Fin">
             
            <br><br>
            <label for="Cuota">Cuota: </label>
            <input type="number" id="Cuota" name="Cuota" required>
              
            <br><br>
            <label for="lbl2">Objetivo: </label>
            <input class="textbox" type="text" id="Objetivo" name="Objetivo" required>
            
            <br><br>
            <label for="InteresAnual">Interes Anual: </label>
            <input type="number" id="InteresAnual" name="InteresAnual" required>
             
            <br><br>
            <button id="aceptarAgregar" class="boton" type="submit">Aceptar</button>
            <br><br>
          </form>

            <!-- EDITAR CUENTA OBJETIVO -->
          <form action="CuentasObjetivo.asp" method="post">
            <br><hr><br>
            <label class="titulo">Editar Cuenta Objetivo</label>
            
            <br><br>
            <label for="numBen">Digite el Id de la Cuenta Objetivo que desea editar: </label>
            <input type="number" id="quantity" name="quantity" required>
            
            <br><br>
            <label for="optionlbl">Escoja lo que va a editar:</label>
            <select id="EditOp" name="EditOp">
                <option value="fechaInicio">Fecha Inicio</option>
                <option value="fechaFin">Fecha Fin</option>
                <option value="cuota">Cuota</option>
                <option value="objetivo">Objetivo</option>
                <option value="interesAnual">Interes Anual</option>
            </select>

            <br><br>
            <label for="lbl2">Digite la nueva informacion segun lo escogido: </label>
            <input class="textbox" type="text" id="Infotxt" name="Infotxt" placeholder="Nueva fecha o etc" required>

            <br><br>
            <button id="aceptarEdit" class="boton" type="submit">Aceptar</button>
            <br><br>
          </form>

          <!-- ACTIVAR/DESACTIVAR CUENTA OBJETIVO -->
          <form action="CuentasObjetivo.asp" method="post">
            <br><hr><br>
            <label class="titulo">Activar/Desactivar Cuenta Objetivo</label>
            <br><br>
            <label for="lbl3">Digite el id de la cuenta objetivo que desea activa/desactivar: </label>
            <input class="textbox" type="text" id="Infotxt2" name="Infotxt2" required>
            <br><br>
            <button id="aceptarEliminar" class="boton" type="submit">Aceptar</button>
            <br><br>
        </form>
        </div>
    </body>
</html>