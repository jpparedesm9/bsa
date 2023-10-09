/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-R123407 Campo Experiencia - Flujo Individual
--Descripción del Problema   : SE añade campos nuevos 
--Responsable                : Adriana Chiluisa
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_table.sq

PRINT 'MODIFICACION DE LA TABLA CR_TRAMITE - SE AÑADEN CAMPOS tr_experiencia Y tr_monto_max'
use cob_credito
go

IF NOT EXISTS (select 1 from sysobjects a, syscolumns b where a.name = 'cr_tramite' and b.name='tr_experiencia')
BEGIN
    print 'columna tr_experiencia insertada'
    ALTER TABLE dbo.cr_tramite ADD tr_experiencia CHAR(1) NULL
END

IF NOT EXISTS (select 1 from sysobjects a, syscolumns b where a.name = 'cr_tramite' and b.name='tr_monto_max')
BEGIN
    print 'columna tr_monto_max insertada'
    ALTER TABLE dbo.cr_tramite ADD tr_monto_max MONEY NULL
END

go


--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMx/SSSuite/BusinessProcess/source/backend/sql
--Nombre Archivo             : service_authorization.sql

print '-- REGISTRO DE SERVICIOS'
go

use cobis
go

declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.RuleExecutionManagement.QueryRuleAmountMaxInd'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.RuleExecutionManagement.QueryRuleAmountMaxInd', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.RuleExecutionManagement.QueryRuleAmountMaxInd')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.RuleExecutionManagement.QueryRuleAmountMaxInd','cobiscorp.ecobis.businessprocess.creditmanagement.service.IRuleExecutionManagement','queryRuleAmountMaxInd', '',0, null, null, null)
go

--------------------------------------------------------------------------------------------
-- REGISTRO DE VISTA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_view.sql
PRINT 'CREACION DE VISTA DE TRAMITE'
use cob_credito
go

IF OBJECT_ID ('dbo.ts_tramite') IS NOT NULL
	DROP VIEW dbo.ts_tramite
GO

CREATE view [dbo].[ts_tramite]
as
select     ts_secuencial AS secuencial, ts_tipo_transaccion AS tipo_transaccion, ts_clase AS clase, ts_fecha AS fecha, ts_usuario AS usuario, 
                      ts_terminal AS terminal, ts_oficina AS oficina, ts_tabla AS tabla, ts_lsrv AS lsrv, ts_srv AS srv, ts_int01 AS tramite, ts_char101 AS tipo, 
                      ts_smallint02 AS oficina_tr, ts_login01 AS usuario_tr, ts_fecha01 AS fecha_crea, ts_smallint01 AS oficial, ts_char102 AS sector, ts_int07 AS ciudad, 
                      ts_char103 AS estado, ts_tinyint01 AS nivel_ap, ts_fecha02 AS fecha_apr, ts_login02 AS usuario_apr, ts_tinyint02 AS truta, ts_smallint04 AS secuencia,
                      ts_int04 AS numero_op, ts_cuenta01 AS numero_op_banco, ts_catalogo01 AS proposito, ts_catalogo02 AS razon, ts_texto2 AS txt_razon, 
                      ts_catalogo03 AS efecto, ts_int02 AS cliente, ts_int03 AS grupo, ts_fecha03 AS fecha_inicio, ts_smallint05 AS num_dias, ts_catalogo04 AS per_revision,
                      ts_texto AS condicion_especial, ts_int05 AS linea_credito, ts_catalogo05 AS toperacion, ts_catalogo06 AS producto, ts_money01 AS monto, 
                      ts_tinyint03 AS moneda, ts_catalogo07 AS periodo, ts_smallint06 AS num_periodos, ts_catalogo08 AS destino, ts_int08 AS ciudad_destino, 
                      ts_cuenta02 AS cuenta_corriente, ts_smallint08 AS renovacion, ts_char107 AS precancelacion, ts_catalogo09 AS comite, ts_cuenta03 AS acta, 
                      ts_float01 AS rent_actual, ts_float02 AS rent_solicitud, ts_float03 AS rent_recomend, ts_money02 AS prod_actual, ts_money03 AS prod_solicitud, 
                      ts_money04 AS prod_recomend, ts_catalogo10 AS clasecca, ts_money05 AS admisible, ts_money06 AS noadmis, ts_int06 AS relacionado, 
                      ts_float04 AS pondera, ts_char117 AS subtipo, ts_catalogo13 AS tipo_producto, ts_catalogo14 AS origen_bienes, ts_catalogo15 AS localizacion, 
                      ts_catalogo16 AS plan_inversion, ts_catalogo17 AS naturaleza, ts_catalogo18 AS tipo_financia, ts_char118 AS sobrepasa, ts_char119 AS forward, 
                      ts_char120 AS elegible, ts_int09 AS emp_emisora, ts_smallint09 AS num_acciones, ts_int10 AS responsable, ts_cuenta04 AS negocio, 
                      ts_char124 AS reestructuracion, ts_catalogo19 AS concepto_credito, ts_catalogo20 AS aprob_gar, ts_char127 AS cont_admisible, 
                      ts_catalogo21 AS mercado_objetivo, ts_vchar2401 AS tipo_productor, ts_money07 AS valor_proyecto, ts_char121 AS sindicado, 
                      ts_float05 AS margen_redescuento, ts_fecha16 AS fecha_ap_anti, ts_char143 AS asociativo, ts_char104 AS incentivo, ts_fecha04 AS fecha_eleg, 
                      ts_int11 AS op_redescuento, ts_fecha15 AS fecha_redes, ts_cuenta01 AS llave_redes, ts_int23 AS solicitud, ts_money08 AS montop, 
                      ts_money09 AS montodesembolsop, ts_catalogo22 AS mercado, ts_catalogo23 AS cod_actividad, ts_int12 AS num_desemb, 
                      ts_vchar6401 AS carta_apr, ts_fecha06 AS fecha_aprov, ts_fecha07 AS fmax_redes, ts_fecha08 AS f_prorroga, ts_catalogo24 AS sujcred, 
                      ts_catalogo25 AS fabrica, ts_catalogo26 AS callcenter, ts_catalogo27 AS apr_fabrica, ts_money10 AS monto_solicitado, ts_char132 AS tipo_plazo, 
                      ts_char133 AS tipo_cuota, ts_smallint13 AS plazo, ts_money20 AS cuota_aproximada, ts_int13 AS fuente_recurso, ts_char134 AS tipo_credito, 
                      ts_smallint14 AS nivel_por, ts_int14 AS campana, ts_cod_alterno AS alterno, ts_int15 as alianza, ts_char135 as exp_cliente,  ts_money21 as monto_max_tr
FROM         dbo.cr_tran_servicio
WHERE     (ts_tipo_transaccion = 21020) OR
          (ts_tipo_transaccion = 21120) OR
          (ts_tipo_transaccion = 21220)
