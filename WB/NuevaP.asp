<%
			Dim iden 'identificacion'
			Dim nombre 
			Dim email
			Dim tel1
			Dim tel2
			Dim parentezco
			Dim porcentaje
			Dim tipoD 'tipo documento identidad'
			Dim fecha
			Dim inst 'instruccion sql'
			Dim con 'Objeto de conexion'

			'Crear objeto de conexion'
		    Set con = Server.CreateObject("Adodb.Connection")

		    'Open the connection'
		    con.open "BasesD"

		    nombre=Request.Form("nombre")
			iden=Request.Form("ValorDocumentoIdentidad")
			email=Request.Form("Email")
			tel1=Request.Form("Telefono1")
			tel2=Request.Form("Telefono2")
			parentezco=Request.Form("Parentezco")
			porcentaje=Request.Form("Porcentaje")
			tipoD=Request.Form("TipoDocuIdentidad")
			fecha=Request.Form("FechaNacimiento")

			'Insertar Persona'
			Set cmd = Server.CreateObject("ADODB.command")
			cmd.ActiveConnection = con
			cmd.CommandType = 4
			cmd.CommandText = "InsPersona"
			cmd.Parameters.Append cmd.CreateParameter ("@inTipoD", 3, 1, 4, tipoD)
			cmd.Parameters.Append cmd.CreateParameter ("@inNombre", 200, 1, 40, nombre)
			cmd.Parameters.Append cmd.CreateParameter ("@inIdent", 3, 1, 4, iden)
			cmd.Parameters.Append cmd.CreateParameter ("@inFecha", 200, 1, 40, fecha)
	        cmd.Parameters.Append cmd.CreateParameter ("@inEmail", 200, 1, 40, email)
			cmd.Parameters.Append cmd.CreateParameter ("@inTelefono1", 3, 1, 4, tel1)
			cmd.Parameters.Append cmd.CreateParameter ("@inTelefono2", 3, 1, 4, tel2)
			cmd.Parameters.Append cmd.CreateParameter ("@outCodeResult", 3, 2)
			cmd.Execute
				
			' Insertar Beneficiario
			Set cmd2 = Server.CreateObject("ADODB.command")
			cmd2.ActiveConnection = con
			cmd2.CommandType = 4
			cmd2.CommandText = "InsBeneficiario2"
			cmd2.Parameters.Append cmd2.CreateParameter ("@inIdCuenta", 3, 1, 4, Session("IdCuenta"))
			cmd2.Parameters.Append cmd2.CreateParameter ("@inIden", 3, 1, 4, iden)
			cmd2.Parameters.Append cmd2.CreateParameter ("@inParentezo", 200, 1, 40, parentezco)  
			cmd2.Parameters.Append cmd2.CreateParameter ("@inPorcentaje", 3, 1, 4, porcentaje)
			cmd2.Parameters.Append cmd2.CreateParameter ("@inIdUsuario", 3, 1, 4, Session("IdUsuario"))
			cmd2.Parameters.Append cmd2.CreateParameter ("@outCodeResult", 3, 2)
			cmd2.Execute
			Response.Redirect "BeneficiariosP.asp"
		%>