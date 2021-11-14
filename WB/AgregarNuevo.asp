<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<html>
	<head>
        <!-- CSS -->
        <style>
            /* Estilo para la barra de navegacion */
            body {
              margin: 0;
              font-family: Arial, Helvetica, sans-serif;
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
        </style>
    </head>

    <body>
    	<meta charset="UTF-8">
    	<div style="padding-left:16px">
    		<form method="post" action="NuevaP.asp">
	    		<label class="titulo">Añadir Persona para beneficiario</label>
	    		<br><br>
	    		<label for="optionlbl">Digite la siguiente información:</label>
		        <br><br>
		        <input class="textbox" type="text" name="nombre" placeholder="Nombre">
		        <input class="textbox" type="text" name="ValorDocumentoIdentidad" placeholder="Identificación" value="<%Response.write(Request.QueryString("iden"))%>">
		        <br><br>
		        <input class="textbox" type="text" name="Email" placeholder="Email">
		        <input class="textbox" type="text" id="Telefono1" name="Telefono1" placeholder="Telefono 1">
		        <br><br>
		        <input class="textbox" type="text" name="Telefono2" placeholder="Telefono 2">
		        <input class="textbox" type="text" name="Parentezco" placeholder="Parentezco" value="<%Response.write(Request.QueryString("par"))%>">
		        <br><br>
		        <input class="textbox" type="text" name="Porcentaje" placeholder="Porcentaje" value="<%Response.write(Request.QueryString("por"))%>">
		        <input class="textbox" type="text" name="TipoDocuIdentidad" placeholder="Tipo Documento Identidad">
		        <br><br>
		        <label for="optionlbl" >Fecha Nacimiento:</label>
		        <input type="date" id="FechaNacimiento" name="FechaNacimiento" placeholder="Fecha Nacimiento">
		        <br><br>
		        <!--Boton agregar Persona-->
		        <button id="aceptarAgregar" class="boton" type="submit">Aceptar</button>
	        	<br><br>
        	</form>
    	</div>
	</body>
</html>