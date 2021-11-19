<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<html>
    <head>
        <title>Consulta Admin 3</title>
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
            <a href="InicioP.asp">Inicio</a>
            <a href="BeneficiariosP.asp">Beneficiarios</a>
            <a href="EstadosCuentaP.asp">Estados de Cuenta</a>
            <a href="BeneficiariosP.asp">Consulta EC</a>
            <a href="CuentasObjetivo.asp">Cuentas Objetivo</a>
            <a href="Admin.asp">Admin</a>
            <a class="seleccionada" href="#ConsultaAdm">Consulta Admin</a>
        </div>
    </body>
    <div style="padding-left:16px">
        <br><br><label class='titulo'>Consulta # 3</label>
        <br><br>
        <table>
            <tr bgcolor="grey" width="700">
                <th>Id</th>
                <th>Nombre</th>
                <th>Identificacion</th>
                <th>Monto</th>
                <th>Cuenta mayor aporte</th>
                <th>Cant Cuentas</th>
            </tr>
        <%
            Dim con 
            Dim rec
            ' Se crea el objeto de conexion
            Set con = Server.CreateObject("Adodb.Connection")

            ' Se crea el objeto recordset
            Set rec = Server.CreateObject("Adodb.recordset")

            ' Se abre la conexion
            con.open "Proyecto1" ' nombre del DSN creado

            ' Determinar cantidad de filas
            Set cmd = Server.CreateObject("ADODB.command")
            cmd.ActiveConnection = con
            cmd.CommandType = 4
            cmd.CommandText = "ConsultarFilasBN"
            cmd.Parameters.Append cmd.CreateParameter ("@inId", 3, 1, 4, Session("IdCuenta"))
            cmd.Parameters.Append cmd.CreateParameter ("@outCantFilas", 3, 2)
            cmd.Execute
            Session("CantFilasB2") = CInt(cmd.Parameters("@outCantFilas"))
            cantidadF = CInt(Session("CantFilasB2"))
            
            ' Arrays
            Dim arr1() 
            Redim arr1(cantidadF, 5)
            Dim arr2()
            Redim arr2(cantidadF, 2)
            Dim arrFinal() 
            Redim arrFinal(cantidadF, 5)
            
            IF Session("CantFilasB2") > 0 THEN
                FOR i = 1 to Session("CantFilasB2")
                    Set cmd2 = Server.CreateObject("ADODB.command")
                    cmd2.ActiveConnection = con
                    cmd2.CommandType = 4
                    cmd2.CommandText = "ConsultaFilaMuerteBN"

                    cmd2.Parameters.Append cmd2.CreateParameter ("@inId", 3, 1, 4, i)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outNombre", 200, 2, 40)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outIdentificacion", 200, 2, 40)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outMonto", 5, 2, 4)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outMayorCA", 200, 2, 40)
                    cmd2.Parameters.Append cmd2.CreateParameter ("@outCantCA", 3, 2)
                    cmd2.Execute
                    monto = cmd2.Parameters("@outMonto")
                    IF IsNull(monto) = False THEN
                        arr1(i-1, 0) = i
                        arr1(i-1, 1) = cmd2.Parameters("@outNombre")
                        arr1(i-1, 2) = cmd2.Parameters("@outIdentificacion")          
                        arr1(i-1, 3) = monto
                        arr1(i-1, 4) = cmd2.Parameters("@outMayorCA")
                        arr1(i-1, 5) = cmd2.Parameters("@outCantCA")
                        arr2(i-1, 0) = i
                        arr2(i-1, 1) = monto
                    END IF
                NEXT
                
                ' Obtener el maximo x veces
                sizeArr = UBound(arr2)
                Id = 0
                FOR i = 0 to sizeArr-1
                    maxVal = 0
                    ' Obtener el maximo
                    FOR j = 0 to sizeArr-1 
                        IF arr2(j,1) > maxVal THEN
                            maxVal = arr2(j,1)
                            Id = arr2(j,0)
                        END IF
                    NEXT
                    
                    ' Agregar el maximo a un nuevo array
                    arrFinal(i, 0) = arr1(Id-1, 0)
                    arrFinal(i, 1) = arr1(Id-1, 1)
                    arrFinal(i, 2) = arr1(Id-1, 2)
                    arrFinal(i, 3) = arr1(Id-1, 3)
                    arrFinal(i, 4) = arr1(Id-1, 4)
                    arrFinal(i, 5) = arr1(Id-1, 5)
                    
                    ' Evitar que el actual maximo vuelva a ser elegido
                    arr2(Id-1, 1) = 0
                NEXT
                
                ' Agregar a la tabla
                sizeArr2 = UBound(arrFinal)
                FOR i = 0 to sizeArr2-1
                    Response.Write("<tr bgcolor='lightgrey' align='center'>")
                    FOR j = 0 to 5
                        Response.Write("<td>" & arrFinal(i, j) & "</td>")
                    NEXT
                    
                    Response.Write("</tr>")
                NEXT
            END IF
        %>
        </table> 
        <br>
        <br>
    </div>
</html>