-- Se deben crear primero las tablas --

USE PXml -- Noombre de la base de datos a usar
GO

DECLARE @myxml XML = '<Datos>
  <Tipo_Doc>
    <TipoDocuIdentidad Id="1" Nombre="Cedula Nacional"/>
    <TipoDocuIdentidad Id="2" Nombre="Cedula Residente"/>
    <TipoDocuIdentidad Id="3" Nombre="Pasaporte"/>
    <TipoDocuIdentidad Id="4" Nombre="Cedula Juridica"/>
    <TipoDocuIdentidad Id="5" Nombre="Permiso de Trabajo"/>
    <TipoDocuIdentidad Id="6" Nombre="Cedula Extranjera"/>
  </Tipo_Doc>

  <Tipo_Moneda>
    <TipoMoneda Id="1" Nombre="Colones"/>
    <TipoMoneda Id="2" Nombre="Dolares"/>
    <TipoMoneda Id="3" Nombre="Euros"/>
  </Tipo_Moneda>
  
  <Parentezcos>
    <Parentezco Id="1" Nombre="Padre"/>
    <Parentezco Id="2" Nombre="Madre"/>
    <Parentezco Id="3" Nombre="Hijo"/>
    <Parentezco Id="4" Nombre="Hija"/>
    <Parentezco Id="5" Nombre="Hermano"/>
    <Parentezco Id="6" Nombre="Hermana"/>
    <Parentezco Id="7" Nombre="Amigo"/>
    <Parentezco Id="8" Nombre="Amiga"/>
  </Parentezcos>


  <Tipo_Cuenta_Ahorros>
    <TipoCuentaAhorro Id="1" Nombre="Proletario" IdTipoMoneda="1" SaldoMinimo="25000.00" MultaSaldoMin="3000.00" CargoAnual = "5000" NumRetirosHumano="5" NumRetirosAutomatico ="8" ComisionHumano="300" ComisionAutomatico="300" Interes ="10" />
    <TipoCuentaAhorro Id="2" Nombre="Profesional" IdTipoMoneda="1" SaldoMinimo="50000.00" MultaSaldoMin="3000.00" CargoAnual = "15000" NumRetirosHumano="5" NumRetirosAutomatico ="8" ComisionHumano="500" ComisionAutomatico="500" Interes ="15" />
    <TipoCuentaAhorro Id="3" Nombre="Exclusivo" IdTipoMoneda="1" SaldoMinimo="100000.00" MultaSaldoMin="3000.00" CargoAnual = "30000" NumRetirosHumano="5" NumRetirosAutomatico ="8" ComisionHumano="1000" ComisionAutomatico="1000" Interes ="20" />
  </Tipo_Cuenta_Ahorros>

  <!-- catalogos-->
  <Personas>
    <Persona TipoDocuIdentidad="1" Nombre="Javith Aguero Hernandez" ValorDocumentoIdentidad="117370445" FechaNacimiento="1999-03-20" Email="aguerojavith@gmail.com" Telefono1="85343403" Telefono2="24197636"/>
    <Persona TipoDocuIdentidad="1" Nombre="Osvaldo Aguero Hernandez" ValorDocumentoIdentidad="12738545" FechaNacimiento="1994-10-13" Email="osadage@gmail.com" Telefono1="87541766" Telefono2="24197545"/>
    <Persona TipoDocuIdentidad="1" Nombre="Franco Quiros Ramirez" ValorDocumentoIdentidad="106030039" FechaNacimiento="1963-04-09" Email="fquiros@itcr.ac.cr" Telefono1="87128720" Telefono2="22124523"/>
    <Persona TipoDocuIdentidad="1" Nombre="Juana Perez Mendez" ValorDocumentoIdentidad="144488000" FechaNacimiento="1973-10-09" Email="perezjuana@yahoo.com" Telefono1="70112205" Telefono2="22064286"/>
    <Persona TipoDocuIdentidad="1" Nombre="Marco Orozco Guevara" ValorDocumentoIdentidad="153816920" FechaNacimiento="1982-09-27" Email="orozcomarco@yahoo.com" Telefono1="84846568" Telefono2="20436193"/>
    <Persona TipoDocuIdentidad="1" Nombre="Guadalupe Zu�iga Chacon" ValorDocumentoIdentidad="105711321" FechaNacimiento="1988-06-05" Email="zu�igaguadalupe@gmail.com" Telefono1="75624554" Telefono2="24415744"/>
    <Persona TipoDocuIdentidad="1" Nombre="Juana Oviedo Trejos" ValorDocumentoIdentidad="195864670" FechaNacimiento="1992-09-22" Email="oviedojuana@gmail.com" Telefono1="74584726" Telefono2="28517141"/>
    <Persona TipoDocuIdentidad="1" Nombre="�scar Villalobos Romero" ValorDocumentoIdentidad="145019786" FechaNacimiento="1977-03-01" Email="villalobos�scar@hotmail.com" Telefono1="72639471" Telefono2="23969186"/>
    <Persona TipoDocuIdentidad="1" Nombre="Ana Hernandez Gomez" ValorDocumentoIdentidad="149892757" FechaNacimiento="1971-01-06" Email="hernandezana@gmail.com" Telefono1="84257486" Telefono2="24381362"/>
    <Persona TipoDocuIdentidad="1" Nombre="Jose Flores Arguedas" ValorDocumentoIdentidad="179934028" FechaNacimiento="1971-01-26" Email="floresjose@yahoo.com" Telefono1="67707206" Telefono2="25114511"/>
    <Persona TipoDocuIdentidad="1" Nombre="�scar Alvarado Lobo" ValorDocumentoIdentidad="176790244" FechaNacimiento="2003-09-12" Email="alvarado�scar@gmail.com" Telefono1="85669123" Telefono2="23768261"/>
    <Persona TipoDocuIdentidad="1" Nombre="Ruben Cubero Duarte" ValorDocumentoIdentidad="167231980" FechaNacimiento="1996-06-01" Email="cuberoruben@yahoo.com" Telefono1="78241767" Telefono2="27668408"/>
    <Persona TipoDocuIdentidad="1" Nombre="Elena Flores Varela" ValorDocumentoIdentidad="159471918" FechaNacimiento="1998-05-06" Email="floreselena@gmail.com" Telefono1="66198589" Telefono2="24834379"/>
    <Persona TipoDocuIdentidad="1" Nombre="Jose Ulloa Ulate" ValorDocumentoIdentidad="163482829" FechaNacimiento="2006-10-20" Email="ulloajose@outlook.com" Telefono1="75054233" Telefono2="25115426"/>
    <Persona TipoDocuIdentidad="1" Nombre="Armando Mendez Fonseca" ValorDocumentoIdentidad="163444875" FechaNacimiento="1970-07-08" Email="mendezarmando@gmail.com" Telefono1="83318758" Telefono2="27319086"/>
    <Persona TipoDocuIdentidad="1" Nombre="Araceli Serrano Arroyo" ValorDocumentoIdentidad="124532423" FechaNacimiento="1972-06-06" Email="serranoaraceli@hotmail.com" Telefono1="81135107" Telefono2="23020064"/>
    <Persona TipoDocuIdentidad="1" Nombre="Victor Moreno Melendez" ValorDocumentoIdentidad="143217478" FechaNacimiento="1998-10-08" Email="morenovictor@yahoo.com" Telefono1="78758222" Telefono2="20054709"/>
    <Persona TipoDocuIdentidad="1" Nombre="Agustin Guevara Oviedo" ValorDocumentoIdentidad="182157649" FechaNacimiento="1972-01-27" Email="guevaraagustin@yahoo.com" Telefono1="64151372" Telefono2="23261725"/>
    <Persona TipoDocuIdentidad="1" Nombre="Araceli Artavia Gamboa" ValorDocumentoIdentidad="117359964" FechaNacimiento="2009-04-16" Email="artaviaaraceli@gmail.com" Telefono1="68960591" Telefono2="26030512"/>
    <Persona TipoDocuIdentidad="1" Nombre="Ana Ulloa Cubero" ValorDocumentoIdentidad="144127398" FechaNacimiento="2002-02-01" Email="ulloaana@gmail.com" Telefono1="74484886" Telefono2="22554608"/>
    <Persona TipoDocuIdentidad="1" Nombre="Luisa Barrantes Artavia" ValorDocumentoIdentidad="123168420" FechaNacimiento="1979-01-03" Email="barrantesluisa@gmail.com" Telefono1="74976638" Telefono2="20704613"/>
 </Personas>


  <Cuentas>
   <Cuenta ValorDocumentoIdentidadDelCliente="117370445" TipoCuentaId="1" NumeroCuenta="11000001" FechaCreacion="2020-10-13" Saldo="1000000.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="197009534" TipoCuentaId="3" NumeroCuenta="11013939" FechaCreacion="2020-07-04" Saldo="45670345.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="185351883" TipoCuentaId="1" NumeroCuenta="11493715" FechaCreacion="2016-10-13" Saldo="55904600.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="105711321" TipoCuentaId="1" NumeroCuenta="11592082" FechaCreacion="2018-01-23" Saldo="54996631.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="101995117" TipoCuentaId="2" NumeroCuenta="11860716" FechaCreacion="2020-03-23" Saldo="39121797.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="131567071" TipoCuentaId="3" NumeroCuenta="11687607" FechaCreacion="2014-09-23" Saldo="15877051.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="139813320" TipoCuentaId="1" NumeroCuenta="11010717" FechaCreacion="2016-10-18" Saldo="30630724.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="118427232" TipoCuentaId="1" NumeroCuenta="11469827" FechaCreacion="2013-05-16" Saldo="55323336.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="100673640" TipoCuentaId="1" NumeroCuenta="11117419" FechaCreacion="2020-01-15" Saldo="19503297.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="182157649" TipoCuentaId="1" NumeroCuenta="11108731" FechaCreacion="2018-12-09" Saldo="11593590.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="123485695" TipoCuentaId="3" NumeroCuenta="11260649" FechaCreacion="2016-05-19" Saldo="20511890.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="195864670" TipoCuentaId="2" NumeroCuenta="11327131" FechaCreacion="2010-02-02" Saldo="44960377.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="118882593" TipoCuentaId="2" NumeroCuenta="11620727" FechaCreacion="2020-04-03" Saldo="70129925.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="174808854" TipoCuentaId="1" NumeroCuenta="11385711" FechaCreacion="2010-04-16" Saldo="42254864.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="174009421" TipoCuentaId="1" NumeroCuenta="11534267" FechaCreacion="2010-07-08" Saldo="84241403.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="105711321" TipoCuentaId="3" NumeroCuenta="11024586" FechaCreacion="2019-10-13" Saldo="5502422.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="177230015" TipoCuentaId="1" NumeroCuenta="11589496" FechaCreacion="2020-04-20" Saldo="85578897.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="144488000" TipoCuentaId="3" NumeroCuenta="11794632" FechaCreacion="2012-01-28" Saldo="32301567.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="174808854" TipoCuentaId="1" NumeroCuenta="11514529" FechaCreacion="2019-03-24" Saldo="30164562.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="143217478" TipoCuentaId="3" NumeroCuenta="11405188" FechaCreacion="2010-01-02" Saldo="36362498.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="171426907" TipoCuentaId="3" NumeroCuenta="11085499" FechaCreacion="2017-02-20" Saldo="23236720.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="139329273" TipoCuentaId="1" NumeroCuenta="11373328" FechaCreacion="2016-01-03" Saldo="15594614.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="146448431" TipoCuentaId="3" NumeroCuenta="11392498" FechaCreacion="2019-11-13" Saldo="40362710.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="188410319" TipoCuentaId="1" NumeroCuenta="11704963" FechaCreacion="2012-08-06" Saldo="23329481.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="108487167" TipoCuentaId="2" NumeroCuenta="11335073" FechaCreacion="2013-11-20" Saldo="87306987.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="152668209" TipoCuentaId="2" NumeroCuenta="11796772" FechaCreacion="2015-04-05" Saldo="61940918.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="105711321" TipoCuentaId="2" NumeroCuenta="11665553" FechaCreacion="2014-08-23" Saldo="88940010.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="118427232" TipoCuentaId="1" NumeroCuenta="11683263" FechaCreacion="2016-04-27" Saldo="8884311.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="136975395" TipoCuentaId="1" NumeroCuenta="11329729" FechaCreacion="2011-05-24" Saldo="23324323.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="145019786" TipoCuentaId="1" NumeroCuenta="11589772" FechaCreacion="2013-05-28" Saldo="73494620.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="171426907" TipoCuentaId="1" NumeroCuenta="11463737" FechaCreacion="2012-04-19" Saldo="29379485.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="153062089" TipoCuentaId="2" NumeroCuenta="11943543" FechaCreacion="2017-04-03" Saldo="460083.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="137030304" TipoCuentaId="1" NumeroCuenta="11559857" FechaCreacion="2014-12-03" Saldo="73834739.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="131927856" TipoCuentaId="1" NumeroCuenta="11107814" FechaCreacion="2020-10-10" Saldo="39125732.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="143062990" TipoCuentaId="3" NumeroCuenta="11245285" FechaCreacion="2018-01-07" Saldo="54771930.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="180881845" TipoCuentaId="1" NumeroCuenta="11184977" FechaCreacion="2019-03-05" Saldo="44992914.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="143062990" TipoCuentaId="3" NumeroCuenta="11656323" FechaCreacion="2011-11-18" Saldo="19028303.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="161104984" TipoCuentaId="1" NumeroCuenta="11906350" FechaCreacion="2017-11-27" Saldo="68393567.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="160713985" TipoCuentaId="1" NumeroCuenta="11326139" FechaCreacion="2018-01-23" Saldo="39031990.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="143713856" TipoCuentaId="3" NumeroCuenta="11090371" FechaCreacion="2019-12-02" Saldo="50031566.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="167231980" TipoCuentaId="2" NumeroCuenta="11331999" FechaCreacion="2018-06-16" Saldo="54852072.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="108498449" TipoCuentaId="3" NumeroCuenta="11572464" FechaCreacion="2011-09-26" Saldo="2655771.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="125000522" TipoCuentaId="2" NumeroCuenta="11688942" FechaCreacion="2016-07-17" Saldo="76271760.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="150445262" TipoCuentaId="2" NumeroCuenta="11619085" FechaCreacion="2017-05-10" Saldo="15793587.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="101995117" TipoCuentaId="3" NumeroCuenta="11876702" FechaCreacion="2018-09-17" Saldo="49714501.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="110839943" TipoCuentaId="1" NumeroCuenta="11946763" FechaCreacion="2018-07-05" Saldo="72997918.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="106261426" TipoCuentaId="2" NumeroCuenta="11662844" FechaCreacion="2016-05-01" Saldo="16501112.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="135878368" TipoCuentaId="3" NumeroCuenta="11164352" FechaCreacion="2015-05-25" Saldo="22462337.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="110852503" TipoCuentaId="2" NumeroCuenta="11744607" FechaCreacion="2010-05-20" Saldo="57455222.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="144488000" TipoCuentaId="1" NumeroCuenta="11271116" FechaCreacion="2018-02-15" Saldo="81230932.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="174329739" TipoCuentaId="2" NumeroCuenta="11559001" FechaCreacion="2012-07-01" Saldo="74130436.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="180881845" TipoCuentaId="2" NumeroCuenta="11911212" FechaCreacion="2014-04-02" Saldo="13445239.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="159471918" TipoCuentaId="3" NumeroCuenta="11926871" FechaCreacion="2017-10-01" Saldo="46072920.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="150445262" TipoCuentaId="2" NumeroCuenta="11231182" FechaCreacion="2015-09-05" Saldo="43382699.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="163444875" TipoCuentaId="1" NumeroCuenta="11369347" FechaCreacion="2013-01-16" Saldo="51789553.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="189149822" TipoCuentaId="3" NumeroCuenta="11887844" FechaCreacion="2011-05-28" Saldo="26660696.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="171426907" TipoCuentaId="1" NumeroCuenta="11550097" FechaCreacion="2012-02-09" Saldo="64142625.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="182017351" TipoCuentaId="3" NumeroCuenta="11353150" FechaCreacion="2020-10-03" Saldo="20540625.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="123485695" TipoCuentaId="2" NumeroCuenta="11523965" FechaCreacion="2011-09-18" Saldo="55349163.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="161104984" TipoCuentaId="1" NumeroCuenta="11718078" FechaCreacion="2016-04-08" Saldo="65039711.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="138597348" TipoCuentaId="1" NumeroCuenta="11857673" FechaCreacion="2011-01-19" Saldo="77004852.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="139329273" TipoCuentaId="1" NumeroCuenta="11743285" FechaCreacion="2013-09-14" Saldo="59633911.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="130982238" TipoCuentaId="1" NumeroCuenta="11810863" FechaCreacion="2013-04-18" Saldo="20522082.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="117359964" TipoCuentaId="2" NumeroCuenta="11580263" FechaCreacion="2012-06-26" Saldo="83964960.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="140728483" TipoCuentaId="3" NumeroCuenta="11376583" FechaCreacion="2012-11-14" Saldo="37441791.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="158453180" TipoCuentaId="2" NumeroCuenta="11803382" FechaCreacion="2013-08-06" Saldo="80178488.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="163482829" TipoCuentaId="3" NumeroCuenta="11912657" FechaCreacion="2017-08-01" Saldo="82726427.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="139813320" TipoCuentaId="2" NumeroCuenta="11723762" FechaCreacion="2020-07-20" Saldo="57816903.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="176967894" TipoCuentaId="3" NumeroCuenta="11485022" FechaCreacion="2017-10-10" Saldo="51078662.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="169839045" TipoCuentaId="1" NumeroCuenta="11461191" FechaCreacion="2018-01-01" Saldo="10622102.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="108487167" TipoCuentaId="1" NumeroCuenta="11030946" FechaCreacion="2020-07-05" Saldo="74887194.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="174009421" TipoCuentaId="2" NumeroCuenta="11646718" FechaCreacion="2017-06-14" Saldo="19535130.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="159471918" TipoCuentaId="1" NumeroCuenta="11276446" FechaCreacion="2019-05-23" Saldo="16112370.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="190123830" TipoCuentaId="2" NumeroCuenta="11515832" FechaCreacion="2019-11-01" Saldo="12116117.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="185351883" TipoCuentaId="1" NumeroCuenta="11878561" FechaCreacion="2013-05-27" Saldo="50418712.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="176967894" TipoCuentaId="1" NumeroCuenta="11177296" FechaCreacion="2018-09-17" Saldo="79011299.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="195864670" TipoCuentaId="3" NumeroCuenta="11047707" FechaCreacion="2013-05-22" Saldo="84212113.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="158742839" TipoCuentaId="2" NumeroCuenta="11727944" FechaCreacion="2015-06-15" Saldo="70559981.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="140728483" TipoCuentaId="2" NumeroCuenta="11367221" FechaCreacion="2011-10-04" Saldo="14863181.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="188410319" TipoCuentaId="1" NumeroCuenta="11074472" FechaCreacion="2015-05-18" Saldo="88079747.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="134914730" TipoCuentaId="1" NumeroCuenta="11717523" FechaCreacion="2016-03-03" Saldo="48513697.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="130982238" TipoCuentaId="2" NumeroCuenta="11698661" FechaCreacion="2015-10-14" Saldo="1990325.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="147441451" TipoCuentaId="1" NumeroCuenta="11195546" FechaCreacion="2011-06-21" Saldo="66263244.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="163663784" TipoCuentaId="3" NumeroCuenta="11960326" FechaCreacion="2015-07-22" Saldo="86363295.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="118427232" TipoCuentaId="2" NumeroCuenta="11718762" FechaCreacion="2020-03-04" Saldo="34188760.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="109067704" TipoCuentaId="3" NumeroCuenta="11901258" FechaCreacion="2019-01-11" Saldo="51664899.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="199403646" TipoCuentaId="1" NumeroCuenta="11481862" FechaCreacion="2010-10-02" Saldo="13154702.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="177230015" TipoCuentaId="1" NumeroCuenta="11575136" FechaCreacion="2017-08-07" Saldo="72550649.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="139329273" TipoCuentaId="1" NumeroCuenta="11749619" FechaCreacion="2012-09-14" Saldo="64869066.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="180881845" TipoCuentaId="3" NumeroCuenta="11053263" FechaCreacion="2020-10-27" Saldo="4552056.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="108498449" TipoCuentaId="2" NumeroCuenta="11554662" FechaCreacion="2020-03-13" Saldo="33772600.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="136975395" TipoCuentaId="1" NumeroCuenta="11893632" FechaCreacion="2015-03-07" Saldo="8157087.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="131567071" TipoCuentaId="2" NumeroCuenta="11046419" FechaCreacion="2020-11-02" Saldo="30252285.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="100673640" TipoCuentaId="2" NumeroCuenta="11275551" FechaCreacion="2013-04-22" Saldo="26411934.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="131927856" TipoCuentaId="2" NumeroCuenta="11383961" FechaCreacion="2018-03-10" Saldo="59700529.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="139813320" TipoCuentaId="3" NumeroCuenta="11208369" FechaCreacion="2010-07-17" Saldo="30743099.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="167231980" TipoCuentaId="2" NumeroCuenta="11620444" FechaCreacion="2013-05-15" Saldo="85402806.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="161104984" TipoCuentaId="3" NumeroCuenta="11606859" FechaCreacion="2012-05-11" Saldo="68939625.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="182157649" TipoCuentaId="1" NumeroCuenta="11234701" FechaCreacion="2019-09-23" Saldo="30238252.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="143062990" TipoCuentaId="2" NumeroCuenta="11316046" FechaCreacion="2020-03-28" Saldo="47710940.00"/>
   <Cuenta ValorDocumentoIdentidadDelCliente="117359964" TipoCuentaId="2" NumeroCuenta="11717598" FechaCreacion="2016-08-28" Saldo="26745278.00"/>
  </Cuentas>


  <!-- Entre 20 y 30-->

  <Beneficiarios>
    <Beneficiario NumeroCuenta="11000001" ValorDocumentoIdentidadBeneficiario="12738545" ParentezcoId="5" Porcentaje="25" />
    <Beneficiario NumeroCuenta="11461191" ValorDocumentoIdentidadBeneficiario="105711321" ParentezcoId="7" Porcentaje="87"/>
    <Beneficiario NumeroCuenta="11717523" ValorDocumentoIdentidadBeneficiario="153062089" ParentezcoId="1" Porcentaje="74"/>
    <Beneficiario NumeroCuenta="11260649" ValorDocumentoIdentidadBeneficiario="150205835" ParentezcoId="3" Porcentaje="36"/>
    <Beneficiario NumeroCuenta="11013939" ValorDocumentoIdentidadBeneficiario="168556538" ParentezcoId="7" Porcentaje="10"/>
    <Beneficiario NumeroCuenta="11857673" ValorDocumentoIdentidadBeneficiario="110839943" ParentezcoId="2" Porcentaje="10"/>
    <Beneficiario NumeroCuenta="11688942" ValorDocumentoIdentidadBeneficiario="152348362" ParentezcoId="3" Porcentaje="51"/>
    <Beneficiario NumeroCuenta="11665553" ValorDocumentoIdentidadBeneficiario="153816920" ParentezcoId="4" Porcentaje="59"/>
    <Beneficiario NumeroCuenta="11010717" ValorDocumentoIdentidadBeneficiario="106261426" ParentezcoId="1" Porcentaje="46"/>
    <Beneficiario NumeroCuenta="11943543" ValorDocumentoIdentidadBeneficiario="122111670" ParentezcoId="4" Porcentaje="24"/>
    <Beneficiario NumeroCuenta="11090371" ValorDocumentoIdentidadBeneficiario="117359964" ParentezcoId="3" Porcentaje="27"/>
    <Beneficiario NumeroCuenta="11857673" ValorDocumentoIdentidadBeneficiario="128965552" ParentezcoId="8" Porcentaje="90"/>
    <Beneficiario NumeroCuenta="11717598" ValorDocumentoIdentidadBeneficiario="144488000" ParentezcoId="3" Porcentaje="43"/>
    <Beneficiario NumeroCuenta="11717523" ValorDocumentoIdentidadBeneficiario="169098517" ParentezcoId="2" Porcentaje="26"/>
    <Beneficiario NumeroCuenta="11559857" ValorDocumentoIdentidadBeneficiario="177230015" ParentezcoId="6" Porcentaje="53"/>
    <Beneficiario NumeroCuenta="11717598" ValorDocumentoIdentidadBeneficiario="174329739" ParentezcoId="2" Porcentaje="27"/>
    <Beneficiario NumeroCuenta="11656323" ValorDocumentoIdentidadBeneficiario="199403646" ParentezcoId="5" Porcentaje="1"/>
    <Beneficiario NumeroCuenta="11090371" ValorDocumentoIdentidadBeneficiario="131927856" ParentezcoId="1" Porcentaje="68"/>
    <Beneficiario NumeroCuenta="11245285" ValorDocumentoIdentidadBeneficiario="165553974" ParentezcoId="8" Porcentaje="51"/>
    <Beneficiario NumeroCuenta="11392498" ValorDocumentoIdentidadBeneficiario="138597348" ParentezcoId="3" Porcentaje="62"/>
    <Beneficiario NumeroCuenta="11405188" ValorDocumentoIdentidadBeneficiario="177230015" ParentezcoId="4" Porcentaje="15"/>
    <Beneficiario NumeroCuenta="11047707" ValorDocumentoIdentidadBeneficiario="143217478" ParentezcoId="7" Porcentaje="100"/>
    <Beneficiario NumeroCuenta="11946763" ValorDocumentoIdentidadBeneficiario="180881845" ParentezcoId="8" Porcentaje="75"/>
    <Beneficiario NumeroCuenta="11717598" ValorDocumentoIdentidadBeneficiario="131927856" ParentezcoId="1" Porcentaje="21"/>
    <Beneficiario NumeroCuenta="11013939" ValorDocumentoIdentidadBeneficiario="125000522" ParentezcoId="1" Porcentaje="90"/>
    <Beneficiario NumeroCuenta="11592082" ValorDocumentoIdentidadBeneficiario="179934028" ParentezcoId="7" Porcentaje="3"/>
    <Beneficiario NumeroCuenta="11893632" ValorDocumentoIdentidadBeneficiario="118882593" ParentezcoId="2" Porcentaje="63"/>
    <Beneficiario NumeroCuenta="11046419" ValorDocumentoIdentidadBeneficiario="133186390" ParentezcoId="8" Porcentaje="61"/>
    <Beneficiario NumeroCuenta="11107814" ValorDocumentoIdentidadBeneficiario="182017351" ParentezcoId="8" Porcentaje="80"/>
    <Beneficiario NumeroCuenta="11717598" ValorDocumentoIdentidadBeneficiario="136191600" ParentezcoId="7" Porcentaje="9"/>
    <Beneficiario NumeroCuenta="11260649" ValorDocumentoIdentidadBeneficiario="169618231" ParentezcoId="7" Porcentaje="64"/>
    <Beneficiario NumeroCuenta="11385711" ValorDocumentoIdentidadBeneficiario="105711321" ParentezcoId="4" Porcentaje="13"/>
    <Beneficiario NumeroCuenta="11887844" ValorDocumentoIdentidadBeneficiario="118343518" ParentezcoId="3" Porcentaje="93"/>
    <Beneficiario NumeroCuenta="11550097" ValorDocumentoIdentidadBeneficiario="149892757" ParentezcoId="7" Porcentaje="66"/>
    <Beneficiario NumeroCuenta="11177296" ValorDocumentoIdentidadBeneficiario="110852503" ParentezcoId="7" Porcentaje="64"/>
    <Beneficiario NumeroCuenta="11550097" ValorDocumentoIdentidadBeneficiario="131567071" ParentezcoId="5" Porcentaje="34"/>
    <Beneficiario NumeroCuenta="11912657" ValorDocumentoIdentidadBeneficiario="108487167" ParentezcoId="1" Porcentaje="30"/>
    <Beneficiario NumeroCuenta="11117419" ValorDocumentoIdentidadBeneficiario="160713985" ParentezcoId="3" Porcentaje="71"/>
    <Beneficiario NumeroCuenta="11331999" ValorDocumentoIdentidadBeneficiario="182017351" ParentezcoId="4" Porcentaje="57"/>
    <Beneficiario NumeroCuenta="11276446" ValorDocumentoIdentidadBeneficiario="139813320" ParentezcoId="8" Porcentaje="9"/>
    <Beneficiario NumeroCuenta="11554662" ValorDocumentoIdentidadBeneficiario="163482829" ParentezcoId="7" Porcentaje="38"/>
    <Beneficiario NumeroCuenta="11554662" ValorDocumentoIdentidadBeneficiario="113219168" ParentezcoId="7" Porcentaje="62"/>
    <Beneficiario NumeroCuenta="11926871" ValorDocumentoIdentidadBeneficiario="108487167" ParentezcoId="7" Porcentaje="10"/>
    <Beneficiario NumeroCuenta="11688942" ValorDocumentoIdentidadBeneficiario="153062089" ParentezcoId="7" Porcentaje="5"/>
    <Beneficiario NumeroCuenta="11580263" ValorDocumentoIdentidadBeneficiario="146448431" ParentezcoId="1" Porcentaje="94"/>
    <Beneficiario NumeroCuenta="11887844" ValorDocumentoIdentidadBeneficiario="106261426" ParentezcoId="1" Porcentaje="7"/>
    <Beneficiario NumeroCuenta="11316046" ValorDocumentoIdentidadBeneficiario="111266789" ParentezcoId="8" Porcentaje="6"/>
    <Beneficiario NumeroCuenta="11534267" ValorDocumentoIdentidadBeneficiario="108487167" ParentezcoId="5" Porcentaje="15"/>
    <Beneficiario NumeroCuenta="11335073" ValorDocumentoIdentidadBeneficiario="153816920" ParentezcoId="5" Porcentaje="7"/>
    <Beneficiario NumeroCuenta="11383961" ValorDocumentoIdentidadBeneficiario="180881845" ParentezcoId="3" Porcentaje="85"/>
    <Beneficiario NumeroCuenta="11469827" ValorDocumentoIdentidadBeneficiario="167231980" ParentezcoId="1" Porcentaje="4"/>
    <Beneficiario NumeroCuenta="11926871" ValorDocumentoIdentidadBeneficiario="163663784" ParentezcoId="7" Porcentaje="90"/>
    <Beneficiario NumeroCuenta="11665553" ValorDocumentoIdentidadBeneficiario="174808854" ParentezcoId="5" Porcentaje="41"/>
    <Beneficiario NumeroCuenta="11316046" ValorDocumentoIdentidadBeneficiario="161104984" ParentezcoId="6" Porcentaje="33"/>
    <Beneficiario NumeroCuenta="11177296" ValorDocumentoIdentidadBeneficiario="159471918" ParentezcoId="7" Porcentaje="36"/>
    <Beneficiario NumeroCuenta="11373328" ValorDocumentoIdentidadBeneficiario="101995117" ParentezcoId="5" Porcentaje="31"/>
    <Beneficiario NumeroCuenta="11810863" ValorDocumentoIdentidadBeneficiario="106261426" ParentezcoId="6" Porcentaje="91"/>
    <Beneficiario NumeroCuenta="11943543" ValorDocumentoIdentidadBeneficiario="165057936" ParentezcoId="7" Porcentaje="54"/>
    <Beneficiario NumeroCuenta="11810863" ValorDocumentoIdentidadBeneficiario="110839943" ParentezcoId="3" Porcentaje="9"/>
    <Beneficiario NumeroCuenta="11376583" ValorDocumentoIdentidadBeneficiario="145224763" ParentezcoId="4" Porcentaje="66"/>
    <Beneficiario NumeroCuenta="11208369" ValorDocumentoIdentidadBeneficiario="158453180" ParentezcoId="7" Porcentaje="64"/>
    <Beneficiario NumeroCuenta="11534267" ValorDocumentoIdentidadBeneficiario="163482829" ParentezcoId="1" Porcentaje="42"/>
    <Beneficiario NumeroCuenta="11108731" ValorDocumentoIdentidadBeneficiario="118343518" ParentezcoId="5" Porcentaje="27"/>
    <Beneficiario NumeroCuenta="11727944" ValorDocumentoIdentidadBeneficiario="150445262" ParentezcoId="2" Porcentaje="46"/>
    <Beneficiario NumeroCuenta="11481862" ValorDocumentoIdentidadBeneficiario="178375881" ParentezcoId="2" Porcentaje="47"/>
    <Beneficiario NumeroCuenta="11514529" ValorDocumentoIdentidadBeneficiario="108487167" ParentezcoId="7" Porcentaje="30"/>
    <Beneficiario NumeroCuenta="11662844" ValorDocumentoIdentidadBeneficiario="122111670" ParentezcoId="7" Porcentaje="50"/>
    <Beneficiario NumeroCuenta="11534267" ValorDocumentoIdentidadBeneficiario="128965552" ParentezcoId="6" Porcentaje="10"/>
    <Beneficiario NumeroCuenta="11744607" ValorDocumentoIdentidadBeneficiario="189149822" ParentezcoId="4" Porcentaje="98"/>
    <Beneficiario NumeroCuenta="11316046" ValorDocumentoIdentidadBeneficiario="100673640" ParentezcoId="2" Porcentaje="17"/>
    <Beneficiario NumeroCuenta="11493715" ValorDocumentoIdentidadBeneficiario="174808854" ParentezcoId="2" Porcentaje="93"/>
    <Beneficiario NumeroCuenta="11164352" ValorDocumentoIdentidadBeneficiario="143062990" ParentezcoId="1" Porcentaje="4"/>
    <Beneficiario NumeroCuenta="11053263" ValorDocumentoIdentidadBeneficiario="138597348" ParentezcoId="7" Porcentaje="67"/>
    <Beneficiario NumeroCuenta="11687607" ValorDocumentoIdentidadBeneficiario="165057936" ParentezcoId="2" Porcentaje="58"/>
    <Beneficiario NumeroCuenta="11743285" ValorDocumentoIdentidadBeneficiario="145019786" ParentezcoId="7" Porcentaje="74"/>
    <Beneficiario NumeroCuenta="11335073" ValorDocumentoIdentidadBeneficiario="122111670" ParentezcoId="4" Porcentaje="8"/>
    <Beneficiario NumeroCuenta="11276446" ValorDocumentoIdentidadBeneficiario="111266789" ParentezcoId="7" Porcentaje="20"/>
    <Beneficiario NumeroCuenta="11912657" ValorDocumentoIdentidadBeneficiario="182157649" ParentezcoId="5" Porcentaje="70"/>
    <Beneficiario NumeroCuenta="11024586" ValorDocumentoIdentidadBeneficiario="117359964" ParentezcoId="8" Porcentaje="36"/>
    <Beneficiario NumeroCuenta="11184977" ValorDocumentoIdentidadBeneficiario="134914730" ParentezcoId="7" Porcentaje="69"/>
    <Beneficiario NumeroCuenta="11589772" ValorDocumentoIdentidadBeneficiario="111266789" ParentezcoId="1" Porcentaje="49"/>
    <Beneficiario NumeroCuenta="11718078" ValorDocumentoIdentidadBeneficiario="147441451" ParentezcoId="7" Porcentaje="67"/>
    <Beneficiario NumeroCuenta="11327131" ValorDocumentoIdentidadBeneficiario="110852503" ParentezcoId="7" Porcentaje="26"/>
    <Beneficiario NumeroCuenta="11662844" ValorDocumentoIdentidadBeneficiario="153816920" ParentezcoId="1" Porcentaje="8"/>
    <Beneficiario NumeroCuenta="11316046" ValorDocumentoIdentidadBeneficiario="149892757" ParentezcoId="4" Porcentaje="34"/>
    <Beneficiario NumeroCuenta="11385711" ValorDocumentoIdentidadBeneficiario="165057936" ParentezcoId="2" Porcentaje="87"/>
    <Beneficiario NumeroCuenta="11245285" ValorDocumentoIdentidadBeneficiario="169618231" ParentezcoId="6" Porcentaje="49"/>
    <Beneficiario NumeroCuenta="11589496" ValorDocumentoIdentidadBeneficiario="152668209" ParentezcoId="4" Porcentaje="35"/>
    <Beneficiario NumeroCuenta="11683263" ValorDocumentoIdentidadBeneficiario="195864670" ParentezcoId="7" Porcentaje="41"/>
    <Beneficiario NumeroCuenta="11376583" ValorDocumentoIdentidadBeneficiario="110852503" ParentezcoId="7" Porcentaje="6"/>
    <Beneficiario NumeroCuenta="11572464" ValorDocumentoIdentidadBeneficiario="147441451" ParentezcoId="6" Porcentaje="85"/>
    <Beneficiario NumeroCuenta="11580263" ValorDocumentoIdentidadBeneficiario="106261426" ParentezcoId="4" Porcentaje="4"/>
  </Beneficiarios>

  <Usuarios>
    <Usuario User="jaguero" Pass="LaFacil" ValorDocumentoIdentidad="117370445" EsAdministrador="0" />
    <Usuario User="alebrenes" Pass="Asd1234" ValorDocumentoIdentidad="160713985" EsAdministrador="0" />
    <Usuario User="vmata" Pass="159797530a" ValorDocumentoIdentidad="143062990" EsAdministrador="0" />
    <Usuario User="lcamacho" Pass="love45" ValorDocumentoIdentidad="134225981" EsAdministrador="0" />
    <Usuario User="fquiros" Pass="MyPass123*" ValorDocumentoIdentidad="106030039" EsAdministrador="1" />
  </Usuarios>

  <Usuarios_Ver>
    <UsuarioPuedeVer User="jaguero" NumeroCuenta="11000001" />
    <UsuarioPuedeVer User="alebrenes" NumeroCuenta="11326139" />
    <UsuarioPuedeVer User="vmata" NumeroCuenta="11656323" />
  </Usuarios_Ver>
</Datos>'

-- Se agregan los tipos --

-- Tipo de documento de identidad
INSERT INTO dbo.TipoDocuIdentidad(Id, Nombre)
	SELECT
		T.X.value('@Id', 'int'),
		T.X.value('@Nombre', 'varchar(40)')
	FROM @myxml.nodes('//Datos/Tipo_Doc/TipoDocuIdentidad') AS T(X)

-- Tipo de moneda --
INSERT INTO dbo.TipoMoneda(Id, Nombre)
	SELECT
		T.X.value('@Id', 'int'),
		T.X.value('@Nombre', 'varchar(40)')
	FROM @myxml.nodes('//Datos/Tipo_Moneda/TipoMoneda') AS T(X)

-- Tipo de parentezo --
INSERT INTO dbo.Parentezco(Id, Nombre)
	SELECT
		T.X.value('@Id', 'int'),
		T.X.value('@Nombre', 'varchar(40)')
	FROM @myxml.nodes('//Datos/Parentezcos/Parentezco') AS T(X)

-- Tipo de cuenta de ahorro --
INSERT INTO dbo.TipoCuentaAhorro(Id, Nombre, IdTipoMoneda, SaldoMinimo, MultaSaldoMin, CargoAnual, 
								NumRetirosHumano, NumRetirosAutomatico, ComisionHumano, ComisionAutomatico, Interes)
	SELECT
		T.X.value('@Id', 'int'),
		T.X.value('@Nombre', 'varchar(40)'),
		T.X.value('@IdTipoMoneda', 'int'),
		T.X.value('@SaldoMinimo', 'float'),
		T.X.value('@MultaSaldoMin', 'float'),
		T.X.value('@CargoAnual', 'int'),
		T.X.value('@NumRetirosHumano', 'int'),
		T.X.value('@NumRetirosAutomatico', 'int'),
		T.X.value('@ComisionHumano', 'int'),
		T.X.value('@ComisionAutomatico', 'int'),
		T.X.value('@Interes', 'int')
	FROM @myxml.nodes('//Datos/Tipo_Cuenta_Ahorros/TipoCuentaAhorro') AS T(X)

-- Se agregan los catalogos --

-- Personas --
INSERT INTO dbo.Persona(TipoDocuIdentidad, Nombre, ValorDocumentoIdentidad, FechaNacimiento,
						Email, telefono1, telefono2)
	SELECT
		T.X.value('@TipoDocuIdentidad', 'int'),
		T.X.value('@Nombre', 'varchar(40)'),
		T.X.value('@ValorDocumentoIdentidad', 'int'),
		T.X.value('@FechaNacimiento', 'date'),
		T.X.value('@Email', 'varchar(40)'),
		T.X.value('@Telefono1', 'int'),
		T.X.value('@Telefono2', 'int')
	FROM @myxml.nodes('//Datos/Personas/Persona') AS T(X)

-- Cuentas --
DECLARE @Tcuentas TABLE(
	[id] [int] IDENTITY(1,1),
	[iden] [int],
	[tipoCuenta] [int],
	[numCuenta] [int],
	[fecha] [date],
	[saldo] [float]
	);
DECLARE	@iden INT,
		@tipoC INT,
		@numC INT,
		@fecha DATE,
		@saldo FLOAT,
		@tamanno INT,
		@Ididen INT,
		@actual INT

INSERT INTO @Tcuentas(iden, tipoCuenta, numCuenta, fecha, saldo)
	SELECT
		T.X.value('@ValorDocumentoIdentidadDelCliente', 'int'),
		T.X.value('@TipoCuentaId', 'int'),
		T.X.value('@NumeroCuenta', 'int'),
		T.X.value('@FechaCreacion', 'date'),
		T.X.value('@Saldo', 'float')
	FROM @myxml.nodes('//Datos/Cuentas/Cuenta') AS T(X)

SET @tamanno = (SELECT COUNT(*) FROM @Tcuentas)

WHILE (@tamanno > 0)
BEGIN
	SET @iden = (SELECT TOP(1) [iden] FROM @Tcuentas)
	SET @tipoC = (SELECT TOP(1) [tipoCuenta] FROM @Tcuentas)
	SET @numC = (SELECT TOP(1) [numCuenta] FROM @Tcuentas)
	SET @fecha = (SELECT TOP(1) [fecha] FROM @Tcuentas)
	SET @saldo = (SELECT TOP(1) [saldo] FROM @Tcuentas)
	SET @Ididen = (SELECT [Id] FROM dbo.Persona WHERE ValorDocumentoIdentidad=@iden)
	SET @actual = (SELECT TOP(1) [id] FROM @Tcuentas)

	IF (@Ididen) IS NOT NULL
		INSERT INTO dbo.CuentaAhorro(IdPersona, TipoCuentaId, NumeroCuenta, FechaCreacion, Saldo)
			VALUES (@Ididen, @tipoC, @numC, @fecha, @saldo)

	/*INSERT INTO dbo.CuentaAhorro(IdPersona, TipoCuentaId, NumeroCuenta, FechaCreacion, Saldo)
		VALUES (@Ididen, @tipoC, @numC, @fecha, @saldo)*/
	-- Quitar comentarios para a�adir todas las cuentas aun que no tengan persona asociada (poner en comentario la instruccion anterior)

	DELETE @Tcuentas WHERE id=@actual
	SET @tamanno = @tamanno-1
END

/* Quitar comentario para ver:
		1. Cuentas sin una persona asociada (en caso de haber a�adido todas las cuentas)
		2. Personas en la base de datos sin cuenta
		3. Cuentas con una persona asociada*/

/*SELECT * FROM dbo.CuentaAhorro A FULL OUTER JOIN dbo.Persona B 
							ON A.IdPersona = B.Id ORDER BY A.IdPersona*/ 

-- Beneficiarios --
DECLARE @Tbeneficiario TABLE(
	[Id] [int] IDENTITY(1,1),
	[numC] [int],
	[iden] [int],
	[parentezco] [int],
	[porcentaje] [int]
);

INSERT INTO @Tbeneficiario(numC, iden, parentezco, porcentaje)
	SELECT
		T.X.value('@NumeroCuenta', 'int'),
		T.X.value('@ValorDocumentoIdentidadBeneficiario', 'int'),
		T.X.value('@ParentezcoId', 'int'),
		T.X.value('@Porcentaje', 'int')
	FROM @myxml.nodes('//Datos/Beneficiarios/Beneficiario') AS T(X)
		

DECLARE @parentezco INT,
		@porcentaje INT,
		@IdCuenta INT

SET @tamanno = (SELECT COUNT(*) FROM @Tbeneficiario)

WHILE (@tamanno > 0)
BEGIN
	SET @iden = (SELECT TOP(1) [iden] FROM @Tbeneficiario)
	SET @porcentaje = (SELECT TOP(1) [porcentaje] FROM @Tbeneficiario)
	SET @numC = (SELECT TOP(1) [numC] FROM @Tbeneficiario)
	SET @parentezco = (SELECT TOP(1) [parentezco] FROM @Tbeneficiario)
	SET @actual = (SELECT TOP(1) [Id] FROM @Tbeneficiario)
	SET @Ididen = (SELECT [Id] FROM dbo.Persona WHERE ValorDocumentoIdentidad=@iden)
	SET @IdCuenta = (SELECT [Id] FROM dbo.CuentaAhorro WHERE NumeroCuenta=@numC)

	IF(@Ididen IS NOT NULL) AND (@IdCuenta IS NOT NULL) 
		INSERT INTO dbo.Beneficiario(IdCuenta, IdPersona, ParentezcoId, Porcentaje)
						VALUES(@IdCuenta, @Ididen, @parentezco, @porcentaje)
	
	/*INSERT INTO dbo.Beneficiario(IdCuenta, IdPersona, ParentezcoId, Porcentaje)
						VALUES(@IdCuenta, @Ididen, @parentezco, @porcentaje)*/
	-- Quitar comentarios para a�adir todos los beneficiarios aunque la persona y/o la cuenta no este en la BD (poner en comentario la instruccion anterior)

	DELETE @Tbeneficiario WHERE Id=@actual
	SET @tamanno = @tamanno-1
END

-- Usuarios --

DECLARE @Tusuarios TABLE(
	[Id] [int] IDENTITY (1,1),
	[user] [varchar](40),
	[pass] [varchar](40),
	[iden] [int],
	[admin] [int]
);

DECLARE @user VARCHAR(40),
	@pass VARCHAR(40), 
	@admin INT

INSERT INTO @Tusuarios([user], [pass], [iden], [admin])
	SELECT
		T.X.value('@User', 'varchar(40)'),
		T.X.value('@Pass', 'varchar(40)'),
		T.X.value('@ValorDocumentoIdentidad', 'int'),
		T.X.value('@EsAdministrador', 'int')
	FROM @myxml.nodes('//Datos/Usuarios/Usuario') AS T(X)

SET @tamanno = (SELECT COUNT(*) FROM @Tusuarios)

WHILE (@tamanno > 0)
BEGIN
	SET @actual = (SELECT TOP(1) [Id] FROM @Tusuarios)
	SET @user = (SELECT TOP(1) [user] FROM @Tusuarios)
	SET @pass = (SELECT TOP(1) [pass] FROM @Tusuarios)
	SET @iden = (SELECT TOP(1) [iden] FROM @Tusuarios)
	SET @admin = (SELECT TOP(1) [admin] FROM @Tusuarios)
	SET @Ididen = (SELECT [Id] FROM dbo.Persona WHERE ValorDocumentoIdentidad=@iden)

	IF(@Ididen) IS NOT NULL
		INSERT INTO dbo.Usuario VALUES(@user, @pass, @Ididen, @admin)

	/*INSERT INTO dbo.Usuario([User], Pass, IdPersona, EsAdministrador) VALUES(@user, @pass, @Ididen, @admin)*/
		-- Quitar comentarios para a�adir todos los usuarios aun que no exista la persona (poner en comentario la instruccion anterior)

	DELETE @Tusuarios WHERE Id=@actual
	SET @tamanno = @tamanno-1
END

-- Usuarios ver --
DECLARE @Tusuarios_ver TABLE(
	[id][int] IDENTITY(1,1),
	[user][varchar](40),
	[numC][int]
);

DECLARE @iduser INT

INSERT INTO @Tusuarios_ver([user], [numC])
	SELECT
		T.X.value('@User', 'varchar(40)'),
		T.X.value('@NumeroCuenta', 'int')
	FROM @myxml.nodes('//Datos/Usuarios_Ver/UsuarioPuedeVer') AS T(X)

SET @tamanno = (SELECT COUNT(*) FROM @Tusuarios_ver)

WHILE(@tamanno > 0)
BEGIN
	SET @actual = (SELECT TOP(1) [id] FROM @Tusuarios_ver)
	SET @user = (SELECT TOP(1) [user] FROM @Tusuarios_ver)
	SET @numC = (SELECT TOP(1) [numC] FROM @Tusuarios_ver)
	SET @iduser = (SELECT TOP(1) [Id] FROM dbo.Usuario WHERE [User]=@user)
	SET @IdCuenta = (SELECT TOP(1) [Id] FROM dbo.CuentaAhorro WHERE [NumeroCuenta]=@numC)

	IF (@iduser IS NOT NULL) AND (@IdCuenta IS NOT NULL)
		INSERT INTO dbo.Usuarios_Ver(IdUser, IdCuenta) VALUES(@iduser, @IdCuenta)

	DELETE @Tusuarios_ver WHERE id=@actual
	SET @tamanno = @tamanno-1
END

/*SELECT * FROM dbo.Persona P FULL OUTER JOIN dbo.Usuario U ON P.Id=U.IdPersona
			FULL OUTER JOIN dbo.CuentaAhorro C ON P.Id=C.IdPersona 
				FULL OUTER JOIN dbo.Beneficiario B ON P.Id=B.IdPersona
					ORDER BY P.Id*/
-- Quitar comentarios para ver la tabla completa de Personas con cuenta o usuario asociado o si es benficiario
-- Osea la combinacion de dbo.Persona, dbo.Usuario, dbo.CuentaAhorro y dbo.Beneficiario