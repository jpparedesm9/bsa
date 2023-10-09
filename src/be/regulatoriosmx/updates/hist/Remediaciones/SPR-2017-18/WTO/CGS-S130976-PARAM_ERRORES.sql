/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S130976 ENCRIPTACON ARCHIVO ESTADO DE CUENTA
--Descripción del Problema   : creacion de objetos, errores, parametros para la historia
--Responsable                : Walther Toledo
--Ruta TFS                   : En cada Seccion
--Nombre Archivo             : En cada Seccion
/*----------------------------------------------------------------------------------------------------------------*/

-- -----------------------------------------------------------------------------------------
-- -----------------------------------------ERRORES-----------------------------------------
-- TFS: $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql/cr_errores.sql
-- -----------------------------------------------------------------------------------------
use cobis
go
delete from cl_errores where numero in (2101140,2101149)
insert into cl_errores values(2101140, 0, 'ERROR AL INSERTAR/ACTUALIZAR DATOS EN LA TABLA CR_ESTADO_CTA_ENVIADO')
insert into cl_errores values(2101149, 0, 'ERROR AL ENVIAR LA NOTIFICACION DEL REPORTE ESTADO DE CUENTA')
-- -----------------------------------------------------------------------------------------
-- ---------------------------------------PARAMETROS----------------------------------------
-- TFS: $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql/cr_parametro.sql
-- -----------------------------------------------------------------------------------------
delete from cl_parametro where pa_nemonico = 'PWDEEC' and pa_producto = 'CRE'
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('PASSWORD ENVIO ESTADO DE CUENTAS - CLIENTE','PWDEEC','C','cobiscorp2017','CRE')

update cl_direccion set di_descripcion = 'walther.toledo@cobiscorp.com'
where di_ente >= 6740 and di_ente <= 6750 and di_tipo = 'CE' and di_descripcion is null

-- ------------------------------------------------------------------------------------
-- ------------------------------------------TABLAS------------------------------------
-- TFS: $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql/cr_table.sql
-- ------------------------------------------------------------------------------------
use cob_credito
go
if exists(select 1 from sysobjects where name like 'cr_estado_cta_enviado')
begin
   drop table cr_estado_cta_enviado
end
create table cr_estado_cta_enviado(
   ec_id_cliente	int		     ,   
	ec_nombre_arch	varchar(100) null,
	ec_estado		varchar(1)  null, 
	ec_fecha_proc	datetime	null
)
CREATE CLUSTERED INDEX cr_estado_cta_enviado_fk
	ON cr_estado_cta_enviado (ec_id_cliente,ec_estado)
GO

-- ------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------