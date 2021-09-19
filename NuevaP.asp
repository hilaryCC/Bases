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
			inst="INSERT INTO dbo.Persona(TipoDocuIdentidad, Nombre, ValorDocumentoIdentidad, FechaNacimiento, Email, telefono1, telefono2) "
			inst=inst+"VALUES("&tipoD&", '"&nombre&"', "&iden&", '"&fecha&"', '"&email&"', "&tel1&", "&tel2&")"

			con.execute(inst)

			inst="INSERT INTO Beneficiario(IdCuenta, IdPersona, ParentezcoId, Porcentaje, Activo)"
			inst=inst+" VALUES ("&Session("IdCuenta")&", (SELECT Id FROM Persona WHERE ValorDocumentoIdentidad="&iden&"),"
			inst=inst+" (SELECT Id FROM Parentezco WHERE Nombre='"&parentezco&"'), "&porcentaje&", 1)"

			con.execute(inst)
			con.close
			Response.Redirect "BeneficiariosP.asp"
		%>