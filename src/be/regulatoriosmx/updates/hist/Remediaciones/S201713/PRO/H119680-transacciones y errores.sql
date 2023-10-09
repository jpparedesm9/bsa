/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S119680 Impresión de documentos - Documentos (3) - Flujo Grupal
--Fecha                      : 06/07/2017
--Descripción del Problema   :
--Descripción de la Solución : Creacion de Errores y transacciones
--Autor                      : Pedro Romero
--Instalador                 : cr_errrores.sql,cr_transact
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
/**********************************************************************************************************************/
use cobis
go
delete from cl_errores where numero in (2108034,2108035)
go
insert into cobis..cl_errores (numero, severidad, mensaje) values (2108034,  0, 'NO EXISTE TRAMITE.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2108035,  0, 'NO EXISTE TRAMITE GRUPAL.')
go
	insert into cl_parametro values ('TIPO TELEFONO DEFAULT GRUPALES','TTD','C','D',null,null,null,null,null,null,'CRE')
go
delete from cl_ttransaccion where tn_trn_code=21821
go
	insert into cl_ttransaccion values ( 21821, 'CONSULTAS CREDITOS GRUPALES',              '21821',       'QUERY GRUPALES')
go
delete from ad_pro_transaccion where pt_transaccion=21821
go

	declare @w_moneda  tinyint

	select @w_moneda = pa_tinyint
	  from cobis..cl_parametro
	 where pa_nemonico = 'CMNAC'
	   and pa_producto = 'ADM'

	insert into ad_pro_transaccion values ( 21, 'R', @w_moneda,  21821,  'V', getdate(),   21701, null)
go
delete from ad_tr_autorizada where ta_transaccion = 21821
go
	declare @w_rol     smallint,
        @w_moneda  tinyint

	select @w_moneda = pa_tinyint
	  from cobis..cl_parametro
	 where pa_nemonico = 'CMNAC'
	   and pa_producto = 'ADM'

	select @w_rol = ro_rol
	  from ad_rol
	 where ro_descripcion = 'MENU POR PROCESOS' 
	   and ro_filial = 1
	   
	insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
	values ( 21,           'R',  @w_rol,  21821,           @w_moneda, getdate(),  1,'V', getdate())
go