<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>

<body>


<?php  
// crear conexion con oracle
$conexion = oci_connect("system", "esteban0017", "localhost/xe"); 
if (!$conexion) {    
  $m = oci_error();    
  trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
  echo $m['message'], "n";    
  exit; 
} else {    
  echo "UDeportes online...!";
} 

//---------Tomar y los datos--------------------

$stid = oci_parse($conexion, 'SELECT IDCOMPLEJO , NOMCOMPLEJO, DIRECCION FROM SEDE');
if (!$stid) {
    $e = oci_error($conexion);
    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}

// Realizar la lógica de la consulta
$r = oci_execute($stid);
if (!$r) {
    $e = oci_error($stid);
    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}

$sede="Seleccione";
$equipo="Seleccione";
$estado="Seleccione";

if(isset($_POST['sede'])){

    
    $sede=$_POST['sede'] ; 
    $equipo=$_POST['equipo'] ; 
    $estado=$_POST['estado'] ; 


    // Recolectar datos del equipo
    $busquedaEquipo = oci_parse($conexion, "select EQ.IDEQUIPO, EQ.NOMEQUIPO, I.CONSECINVE from equipo EQ, INVENTARIO I 
                                            where I.IDESTADO like '1' and I.IDCOMPLEJO LIKE '$sede' and I.IDEQUIPO = EQ.IDEQUIPO");
    if (!$busquedaEquipo) {
      $e = oci_error($conexion);
      trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }
    $u = oci_execute($busquedaEquipo);
    if (!$u) {
    $e = oci_error($busquedaEquipo);
    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }

    // Recolectar datos de estado
    $busquedaEstado = oci_parse($conexion, "select IDESTADO, DESCESTADO from estado");
    if (!$busquedaEstado) {
      $e = oci_error($conexion);
      trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }
    $i = oci_execute($busquedaEstado);
    if (!$i) {
    $e = oci_error($busquedaEstado);
    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }

    // Recolectar datos del inventario
    $busquedaEstado = oci_parse($conexion, "select IDESTADO, DESCESTADO from estado");
    if (!$busquedaEstado) {
      $e = oci_error($conexion);
      trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }
    $i = oci_execute($busquedaEstado);
    if (!$i) {
    $e = oci_error($busquedaEstado);
    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }

    //Guardar prestamo-----------------------------------
    if($sede != 'Seleccione' and $estado != 'Seleccione'and $equipo != 'Seleccione'){

      
      //variables con los datos
      $consec_inv=1;
      $sede=$_POST['sede'] ; 
      $equipo=$_POST['equipo'] ; 
      $estado=$_POST['estado'] ;
      $cons=1;
      $idPersona= $_COOKIE['id'];

      //Tomamos el consecutivo del inventario de la sede y equipo
      $inv = oci_parse($conexion, "select CONSECINVE from INVENTARIO where IDCOMPLEJO = '$sede' and IDEQUIPO = '$equipo'");
      oci_execute($inv);

      while ($fila = oci_fetch_array($inv, OCI_ASSOC+OCI_RETURN_NULLS)) {
        $consec_inv=$fila['CONSECINVE'];
      }

       //buscamos el cons
      $prest = oci_parse($conexion, "select * from prestamo");
      oci_execute($prest);

      while ($fila = oci_fetch_array($prest, OCI_ASSOC+OCI_RETURN_NULLS)) {
        $cons= $cons+1;
      }
      echo $cons;
      echo $consec_inv;

      //Tomamos el nombre de las variables del select
      $sedeName = oci_parse($conexion, "SELECT NOMCOMPLEJO FROM SEDE WHERE IDCOMPLEJO = '$sede'");
      oci_execute($sedeName);

      while ($fila = oci_fetch_array($sedeName, OCI_ASSOC+OCI_RETURN_NULLS)) {
        $sedeNombre=$fila['NOMCOMPLEJO'];
        Setcookie("sedeNombre", $sedeNombre);
      }

      //Nombre de equipo
      $equipoName = oci_parse($conexion, "SELECT NOMEQUIPO FROM EQUIPO WHERE IDEQUIPO = '$equipo'");
      oci_execute($equipoName);

      while ($fila = oci_fetch_array($equipoName, OCI_ASSOC+OCI_RETURN_NULLS)) {
        $EquipoNombre=$fila['NOMEQUIPO'];
        Setcookie("EquipoNombre", $EquipoNombre);
      }

      //Nombre de estado
      $estadoName = oci_parse($conexion, "SELECT DESCESTADO FROM ESTADO WHERE IDESTADO = '$estado'");
      oci_execute($estadoName);

      while ($fila = oci_fetch_array($estadoName, OCI_ASSOC+OCI_RETURN_NULLS)) {
        $estadoNombre=$fila['DESCESTADO'];
        Setcookie("estadoNombre", $estadoNombre);
      }

      //Actualizamos y registramos el prestamo
      $st= oci_parse($conexion, "INSERT INTO PRESTAMO (CONSECPRESTA, IDESTADO, CONSECINVE, IDCOMPLEJO, IDEQUIPO, CODPERSONA, FECHAPREST)
                                  VALUES (:CONSECPRESTA,:IDESTADO, :CONSECINVE, :IDCOMPLEJO, :IDEQUIPO, :CODPERSONA,current_date)");
        
         
        //vinculamos las variables a la sentencia sql
        oci_bind_by_name($st, ':CONSECPRESTA', $cons);
        oci_bind_by_name($st, ':IDESTADO', $estado);
        oci_bind_by_name($st, ':CONSECINVE', $consec_inv);
        oci_bind_by_name($st, ':IDCOMPLEJO', $sede);
        oci_bind_by_name($st, ':IDEQUIPO', $equipo);
        oci_bind_by_name($st, ':CODPERSONA', $idPersona);

        oci_execute($st);
        
        $ac= oci_parse($conexion, "UPDATE INVENTARIO SET IDESTADO = '4' WHERE IDCOMPLEJO = :IDCOMPLEJO and IDEQUIPO = :IDEQUIPO");
        
        oci_bind_by_name($ac, ':IDEQUIPO', $equipo);
        oci_bind_by_name($ac, ':IDCOMPLEJO', $sede);

        oci_execute($ac);
        echo "termine";
        
    }

}
oci_close($conexion);

?>

<!-- ----------------------------COSAS DEL HTML------------------------- -->
<!-- Barra de navegacion -->

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">UDPortes</a>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a  href="evento.PHP" class="nav-link">Eventos</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="login.php">Cerrar sesion</a>
      </li>
    </ul>
  </div>
</nav>


    <!-- Interfaz del evento (seleccionar sede) -->
    <form class="form-row" id = "evento" action="<?php htmlspecialchars($_SERVER['PHP_SELF']) ?>" method="post" >

        <div class="form-group mx-sm-4 mb-2 ">
            <?php
                print "<input type='text' class='form-control'  name='usuario' value='Bienvenido : ".$_COOKIE['nombre']."' disabled readonly >";
            ?>
        <div>
        <div class="form-group mx-sm-2 mb-2 ">
            <label>Seleccione una sede en donde desea generar el evento:  </label>
            <select type="submit" name="sede" class="form-control" id="sede" >
                <?php  
                    print " <option value='".$sede."' >".$sede."</option> ";
                while ($fila = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
                    print "<option value='".$fila[IDCOMPLEJO]."'>"
                                        .$fila[NOMCOMPLEJO].'   /   '
                                        .$fila[DIRECCION]."</option>\n";
                    }
                ?>
            </select>
            <input class="btn btn-success" type="submit" value="Ver equipos" name="enviarSede">

        </div>

        <div class="form-group mx-sm-4 mb-2">
            <label>seleccione una equipo </label>
            <select name="equipo" class="form-control" id="equipo">
                
            <?php  
                print " <option value='".$equipo."' >".$equipo."</option> ";
                while ($fil = oci_fetch_array($busquedaEquipo, OCI_ASSOC+OCI_RETURN_NULLS)) {
                    print "<option value='".$fil[IDEQUIPO]."'>".$fil[NOMEQUIPO]."</option>\n";
                }
            ?>
            </select>
            <input class="btn btn-success" type="submit" value="Ver estados" name="enviarEquipo">
        </div>

        <div class="form-group mx-sm-4 mb-2">
            <label>seleccione el uso que le dara al equipo </label>
            <select name="estado" class="form-control" id="estado">
            <?php  
                print " <option value='".$estado."' >".$estado."</option> ";
                while ($fil = oci_fetch_array($busquedaEstado, OCI_ASSOC+OCI_RETURN_NULLS)) {
                    print "<option value='".$fil[IDESTADO]."'>".$fil[DESCESTADO]."</option>\n";
                }
            ?>
            </select>
        </div>
        
        <div class="form-group mx-sm-3 mb-2">
            <button class="btn btn-success" id="prestar">Solicitar Prestamo</button>
        </div>

    </form>
    
</body>
</html>