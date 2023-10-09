
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-B146247: No permite ingresar cliente nuevo al flujo (PROD)
--Fecha                      : 21/11/2017
--Descripción del Problema   : Se modifica registro de an_component
--Descripción de la Solución : Generar el script para registrar el sp en las tablas respectivas
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/


---------------------------------------------------------------------------------------
-------------------------    Volver a Insertar un registro    -------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_component.sql



use cobis
go

DECLARE @w_co_id INT, 
        @w_prod_name varchar(10), 
        @w_mo_id int

select @w_prod_name = 'WF' 
select @w_mo_id = mo_id  
  from cobis..an_module 
 where mo_name = 'IBX.InboxOficial'
 
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
select @w_mo_id = isnull(@w_mo_id ,1)

IF EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Grupos')
begin
	
	delete cobis..an_component  WHERE co_name = 'Grupos' 
	
	INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Grupos', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=INGRESO', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, @w_prod_name) 
end 
else
begin
	
	INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Grupos', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=INGRESO', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, @w_prod_name) 
	
end