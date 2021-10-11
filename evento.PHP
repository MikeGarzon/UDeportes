<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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

//------------------------------------------




//-------------------------------verificar inicio de sesion, (pasar a ventan externa)
if(isset($_GET['inputUser'])){

    $user=$_GET['inputUser'] ; 
    $pass=$_GET['inputPassword'] ; 
    
  // Login
  $busquedaLogin = oci_parse($conexion, "SELECT NOMPERSONA, CODPERSONA
  FROM PERSONA WHERE USERPER LIKE '$user' AND PASSWORD LIKE '$pass'");
  if (!$busquedaLogin) {
  $e = oci_error($conexion);
  trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
  }

  $u = oci_execute($busquedaLogin);
  if (!$u) {
  $e = oci_error($busquedaLogin);
  trigger_error(htmlentities($y['message'], ENT_QUOTES), E_USER_ERROR);
  }else{

     $conteo=0;

      while ($fila = oci_fetch_array($busquedaLogin, OCI_ASSOC+OCI_RETURN_NULLS)) {
        $conteo=1;
        $nombre= $fila['NOMPERSONA'];
        Setcookie("nombre", $nombre);

        $id= $fila['CODPERSONA'];
        Setcookie("id", $id);

        echo'<script type="text/javascript">
        alert("Usuario: '.$nombre.'");
        window.location.href="evento.PHP";
        </script>';
        
      }
      if($conteo==0){

        echo'<script type="text/javascript">
        alert("Error de usuario");
        window.location.href="login.php";
        </script>';
      }

  }



}



//------------------------------------------busqueda de opciones para las sedes

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
$area="Sleccione";
$deporte="Sleccione";



//------------------------------------------------busquedas de opciones para los select
if(isset($_POST['sede'])){


    

    $sede=$_POST['sede'] ; 
    $area=$_POST['area'] ; 
    $deporte=$_POST['deporte'] ; 




    // busqueda de  areas
    $busquedaArea = oci_parse($conexion, "SELECT A.IDAREA , A.NOMAREA, A.UBICACION 
    FROM AREA A WHERE A.IDCOMPLEJO LIKE '$sede'");
    if (!$busquedaArea) {
      $e = oci_error($conexion);
      trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }
    $u = oci_execute($busquedaArea);
    if (!$u) {
    $e = oci_error($busquedaArea);
    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }

    // busqueda de deportes
    $busquedadeporte = oci_parse($conexion, "SELECT P.IDDEPORTE, D.NOMDEPORTE FROM  POLIDEPORTIVO P, DEPORTE D 
    where P.IDAREA like '$area' and P.IDCOMPLEJO like '$sede' and P.IDDEPORTE = D.IDDEPORTE");
    if (!$busquedadeporte) {
      $e = oci_error($conexion);
      trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }
    $i = oci_execute($busquedadeporte);
    if (!$i) {
    $e = oci_error($busquedadeporte);
    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }

    //Nombre de area
    $areaName = oci_parse($conexion, "SELECT NOMAREA FROM AREA WHERE IDAREA = '$area'");
    oci_execute($areaName);

    while ($fila = oci_fetch_array($areaName, OCI_ASSOC+OCI_RETURN_NULLS)) {
      $AreaNombre=$fila['NOMAREA'];
      Setcookie("AreaNombre", $AreaNombre);
    }

    //Nombre de deporte
    $deporteName = oci_parse($conexion, "SELECT NOMDEPORTE FROM DEPORTE WHERE IDDEPORTE = '$deporte'");
    oci_execute($deporteName);

    while ($fila = oci_fetch_array($deporteName, OCI_ASSOC+OCI_RETURN_NULLS)) {
      $DeporteNombre=$fila['NOMDEPORTE'];
      Setcookie("DeporteNombre", $DeporteNombre);
    }




    //guardar evento------------------------------------------------------------------------------------------------
    if($_POST['personas'] > 0 and $_POST['duracion'] > 0 and $sede != 'Seleccione' and $sede != 'Seleccione'
     and $area != 'Seleccione'and $deporte != 'Seleccione'){


     
        //-----------conteo
        $conteo = oci_parse($conexion, "SELECT consec FROM evento");
        if (!$conteo) {
          $e = oci_error($conteo);
          trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
        }
        $o = oci_execute($conteo);
        if (!$o) {
        $e = oci_error($conteo);
        trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
        }

        //-------------conteo 
            $cons=1;
        while ($fila = oci_fetch_array($conteo, OCI_ASSOC+OCI_RETURN_NULLS)) {
                $cons=$cons+1;
                echo $cons;
        }
        
        
        $sede=$_POST['sede'] ; 
        $area=$_POST['area'] ; 
        $deporte=$_POST['deporte'] ; 

        $personas=$_POST['personas'];
        $tiempo= $_POST['duracion'];


        $st= oci_parse($conexion, "INSERT INTO EVENTO (CONSEC,IDDEPORTE, IDCOMPLEJO, IDAREA, ARE_IDCOMPLEJO, CODPERSONA, FECHAHORA, DURACION, NPARTICIPANTE)
                                             VALUES (:CONSEC,:IDDEPORTE, :IDCOMPLEJO, :IDAREA, :ARE_IDCOMPLEJO, :CODPERSONA,current_date ,current_date + :TIEMPO , :NPARTICIPANTE)");
 
        //variables con los datos
        
        $sede=$_POST['sede'] ; 
        $area=$_POST['area'] ; 
        $deporte=$_POST['deporte'] ; 
        $personas=$_POST['personas'];
        $tiempo= $_POST['duracion'];
        $idPersona= $_COOKIE['id'];
         

        //vinculamos las variables a la sentencia sql
        oci_bind_by_name($st, ':CONSEC', $cons);
        oci_bind_by_name($st, ':IDDEPORTE', $deporte);
        oci_bind_by_name($st, ':IDCOMPLEJO', $sede);
        oci_bind_by_name($st, ':IDAREA', $area);
        oci_bind_by_name($st, ':ARE_IDCOMPLEJO', $sede);
        oci_bind_by_name($st, ':CODPERSONA', $idPersona);
        oci_bind_by_name($st, ':TIEMPO', $tiempo);
        oci_bind_by_name($st, ':NPARTICIPANTE', $personas);
        
         
        //ejecutamos el statement
        oci_execute($st);
         
        echo "termino";

    }


}



oci_close($conexion);

?>
<!-- Barra de navegacion -->
<!-- Barra de navegacion -->

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">UDPortes</a>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a  href="prestamo.PHP" class="nav-link">Prestamo</a>
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
            <input class="btn btn-success" type="submit" value="Ver areas" name="enviarSede">

        </div>

        <div class="form-group mx-sm-4 mb-2">
            <label>seleccione una zona </label>
            <select name="area" class="form-control" id="area" ">
                
            <?php  
                print " <option value='".$area."' >".$area."</option> ";
                while ($fil = oci_fetch_array($busquedaArea, OCI_ASSOC+OCI_RETURN_NULLS)) {
                    print "<option value='".$fil[IDAREA]."'>"
                                        .$fil[NOMAREA].'/'
                                    .$fil[UBICACION]."</option>\n";
                }
            ?>
            </select>
            <input class="btn btn-success" type="submit" value="Ver deportes" name="enviarArea">
        </div>

        <div class="form-group mx-sm-4 mb-2">
            <label>seleccione un deporte </label>
            <select name="deporte" class="form-control" id="deporte">
            <?php  
                print " <option value='".$deporte."' >".$deporte."</option> ";
                while ($fil = oci_fetch_array($busquedadeporte, OCI_ASSOC+OCI_RETURN_NULLS)) {
                    print "<option value='".$fil[IDDEPORTE]."'>"
                                        .$fil[NOMDEPORTE]."</option>\n";
                }
            ?>
            </select>
        </div>
        <div class="form-group mx-sm-4 mb-2">
            <label>Cantidad de personas </label>
            <input type="number" id="personas" name="personas">
            <label>Duracion del evento, (dias por el momento)</label>
            <input type="number" id="duracion" name="duracion">
        </div>
        
        <div class="form-group mx-sm-3 mb-2">
            <button class="btn btn-success" id="reservar">Reservar</button>
        </div>

    </form>


</body>
</html>