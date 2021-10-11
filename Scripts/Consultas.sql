--===================================================
--Ejercicio 3
--===================================================
select IDCOMPLEJO,nomcomplejo,direccion from sede;

select A.IDAREA, A.NOMAREA, A.UBICACION from area A, sede S where A.IDCOMPLEJO like 'sedeGuardada'; --se consulta con la variable guardada del html

select P.IDDEPORTE, D.NOMDEPORTE from  POLIDEPORTIVO P, DEPORTE D where P.IDAREA like 'areaguardada' and P.IDCOMPLEJO like 'sedeGaurdada' and P.IDDEPORTE = D.IDDEPORTE;

insert into EVENTO values ('1', 'ID DEPORTE GUARDADO', 'ID SEDE GUARDADO', 'ID AREA GUARDADA','ID SEDE GUARDADO', 'COD PERSONA ', current_date, current_date + 2 , 99)

--ej
insert into EVENTO values ('3', 'socc', 'comp1', 'a01','comp1', '1001', TO_DATE(current_date,'DD-MM-YYYY hh:mi:ss'), current_date + 2 , 99 );

--===================================================
--Ejercicio 4
--===================================================

select IDCOMPLEJO,nomcomplejo,direccion from sede;

select EQ.IDEQUIPO, EQ.NOMEQUIPO, I.CONSECINVE from equipo EQ, INVENTARIO I where I.IDESTADO like '1' and I.IDCOMPLEJO = 'comp1' and I.IDEQUIPO = EQ.IDEQUIPO;

--actualizar 
UPDATE inventario
SET IDESTADO = '4'
WHERE IDCOMPLEJO = 'IDSEDE GUARDADA' and IDEQUIPO = 'ID EQUIPO GUARDADO';    

--crear registro 
insert into PRESTAMO values ('autoID','ESTADO GUARDADO', NUMERO_CONSECUTIVO , 'ID SEDE GUARDADO', 'ID EQUIPO GUARDADO', 'COD PERSONA', current_date );

--ej
insert into PRESTAMO values ('1','4', 5 , 'comp1', 'e01', '1001', current_date );