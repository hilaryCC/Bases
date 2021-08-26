<!DOCTYPE html>
<html>
    <head>
        <title>Test Page</title>
    </head>
    <body>
        <!--TEXTO-->
        <h1 style="color:palegreen; background:black">Hello World</h1>
        <hr> <!--Para dividir una seccion del website-->
        <!--Lineas-->
        <h1>Widgets</h1> <!--Se puede desde h1 a h6 (creo)-->
        <!--Parrafos-->
        <p>Esto es una pagina web sencilla que tiene varios ejemplos para aprender un poco de html... </p>
        <br> <!--Cambio de linea-->
        <p>Esto es otro ejemplo de un parrafo, <b>pero en negrita.</b></p> <!-- La b es para negrita-->
        <p>Esto es otro ejemplo de un parrafo, <i>pero en italic.</i></p>
        <p>Esto es otro ejemplo de un parrafo, <big>pero en grande.</big></p>
        <p>Esto es otro ejemplo de un parrafo, <small>pero en pequeño.</small></p>
        <p>Esto es otro ejemplo de un parrafo, <sub>pero en subscript.</sub></p>
        <p>Esto es otro ejemplo de un parrafo, <sup>pero en superscript.</sup></p>
        <p>Esto es otro ejemplo de un parrafo, <ins>pero subrayado.</ins></p>
        <p>Esto es otro ejemplo de un parrafo, <del>pero tachado.</del></p>
        <p>Esto es otro ejemplo de un parrafo, <mark>pero marcado.</mark></p>

        <!--HIPERVINCULOS-->
        <a href="https://www.youtube.com/" target="_blank" title="Este link lleva a youtube">Youtube</a>

        <br><br>

        <!--BOTONES-->
        <button name="btn1" type="button">
            Click me
        </button>
        <button onclick="alert('Error de algo')">
            ALERT!
        </button>
        <button style="background-color:#d582d2;
            font-size: 20">
            CSS Style
        </button>

        <br><br><br>

        <!--IMAGENES-->
        <img src="hola.jpg" height="100" title="logo html">

        <br><br>
        <!--LISTAS-->
        <h4>Lista desordenada</h4>
        <u>
            <li>ejemplo ajksjan</li>
            <li>Item 2</li>
            <li>Item 3</li>
        </u>

        <h4>Lista ordenada</h4>
        <ol>
            <li>Ejemplo</li>
            <li>Ejemplo</li>
            <li>Ejemplo</li>
        </ol>
        <ol type="A">
            <li>Ejemplo</li>
            <li>Ejemplo</li>
            <li>Ejemplo</li>
        </ol>
        <ol type="I">
            <li>Ejemplo</li>
            <li>Ejemplo</li>
            <li>Ejemplo</li>
        </ol>

        <h4>Lista descripcion</h4>
        <dl>
            <dt>HTML</dt>
            <dd>Agrega estructura a una pagina</dd>
            <dt>CSS</dt>
            <dd>Agrega estilo a una pagina</dd>
            <dt>JavScript</dt>
            <dd>Agrega funcionalidad a una pagina</dd>
        </dl>

        <!--TABLAS-->
        <h4>Tabla</h4>
        <table bgcolor ="black" width="700">
            <tr bgcolor="grey">
                <th width="100">Domingo</th>
                <th width="100">Lunes</th>
                <th width="100">Martes</th>
                <th width="100">Miercoles</th>
                <th width="100">Jueves</th>
                <th width="100">Viernes</th>
                <th width="100">Sabado</th>
            </tr>
            <tr bgcolor="lightgrey" align="center">
                <td>Cerrado</td>
                <td>9-5</td>
                <td>9-5</td>
                <td>9-5</td>
                <td>9-5</td>
                <td>9-5</td>
                <td>Cerrado</td>
            </tr>
        </table>
        <br>

        <!--FORMS-->
        <form action="ACCION.PHP">
            <label form="first_name">Fist Name</label>
            <input type="text" id="first_name"
            name="first_name" placeholder="nombre">
            <br><br>
            <label form="last_name">Last Name</label>
            <input type="text" id="last_name"
            name="first_name" placeholder="apellido">

            <br><br>
            <label for="title">Title:</label>
            <label for="Mr.">Mr.</label>
            <input type="radio" value="Mr." id="Mr." name="title"/>
            <label for="Mrs.">Mrs.</label>
            <input type="radio" value="Ms." id="Ms." name="title"/>
            <label for="Miss.">Miss.</label>
            <input type="radio" value="Miss." id="Miss." name="title"/>
            <br><br>

            <label for="payment">Payment:</label>
            <select id="payment">
                <option value="visa">visa</option>
                <option value="mastercard">mastercard</option>
                <option value="giftcard">giftcard</option>
            </select>
            <br><br>

            <label for="birthday">Birthday:</label>
            <input type="date" id="birthday" name="birhtday">
            <br><br>

            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" min ="0" max="999">
            <br><br>

            <label for="password">Password:</label>
            <input type="password" id="pass" name="pass" maxlength="12">
            <br><br>

            <label for="slider">Rate us:</label>
            1<input type="range" step="25">5
            <br><br>

            <label for="suscribe">Suscribe</label>
            <input type="checkbox" id="suscribe" name="suscribe">
            <br><br>

            <br><br>
            <input type="reset">
            <br><br>
            <input type="submit"> <!--Abre lo que se indica en la linea 107 -->
        </form>

    </body>
</html>