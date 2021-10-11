<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>

<body>



<!-- Interfaz del evento (seleccionar sede) -->
<form class="form-row" id = "formLogin" action="evento.PHP" method="GET" >
  <div class="form-group mx-sm-2 mb-2 ">
    <label>Ingrese su usuario registrado por favor:  </label>
    <input type="text" class="form-control" id="inputUser" name="inputUser">
  </div>

  <div class="form-group col-md-6">
      <label>Ingrese la contrase;a:</label>
      <input type="password" class="form-control" id="inputPassword" name="inputPassword">
    </div>
  </div>
  <div class="form-group mx-sm-3 mb-2">
    <button class="btn btn-success" id="btnLogin">Ingresar</button>
  </div>
</form>




</body>
</html>