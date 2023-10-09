USE cobis
GO

print 'INICIA TRUNCADO DE TABLAS'

TRUNCATE TABLE ad_tran_servicio
go

TRUNCATE TABLE ba_error_batch
GO

TRUNCATE TABLE ba_error_batch_his
GO

TRUNCATE TABLE ba_fecha_cierre
GO

TRUNCATE TABLE ba_log_operador
GO

TRUNCATE TABLE ba_login_batch
GO

TRUNCATE TABLE cl_actividad_economica
GO

TRUNCATE TABLE cl_actualiza
GO

TRUNCATE TABLE cl_at_instancia
GO

TRUNCATE TABLE cl_casilla
GO

TRUNCATE TABLE cl_cliente
GO

TRUNCATE TABLE cl_cliente_grupo
GO

TRUNCATE TABLE cl_contacto
GO

TRUNCATE TABLE cl_dat_merc_ente
GO

TRUNCATE TABLE cl_datos_actualizar
GO

TRUNCATE TABLE cl_det_producto
GO

TRUNCATE TABLE cl_dgeografica
GO

TRUNCATE TABLE cl_direccion
GO

TRUNCATE TABLE cl_direccion_geo
GO

TRUNCATE TABLE cl_ejecutivo
GO

TRUNCATE TABLE cl_ente
GO

TRUNCATE TABLE cl_ente_aux
GO

TRUNCATE TABLE cl_estatuto_com
GO

TRUNCATE TABLE cl_grupo
GO

TRUNCATE TABLE cl_hijos
GO

TRUNCATE TABLE cl_his_ejecutivo
GO

TRUNCATE TABLE cl_his_relacion
GO

TRUNCATE TABLE cl_infocred_central
GO

TRUNCATE TABLE cl_instancia
GO

TRUNCATE TABLE cl_mercado
GO

TRUNCATE TABLE cl_mercado_error
GO

TRUNCATE TABLE cl_mod_estados
GO

TRUNCATE TABLE cl_mod_segmento
GO

TRUNCATE TABLE cl_objeto_com
GO

TRUNCATE TABLE cl_propiedad
GO

TRUNCATE TABLE cl_ref_personal
GO

TRUNCATE TABLE cl_registro_identificacion
GO

TRUNCATE TABLE cl_relacion_inter
GO

TRUNCATE TABLE cl_telefono
GO

TRUNCATE TABLE cl_trabajo
GO

TRUNCATE TABLE cl_tran_servicio
GO

truncate table cl_negocio_cliente
go

TRUNCATE TABLE in_intento
GO

truncate table cl_seccion_validar
go

truncate table grupo_tmp
go
truncate table ba_log
go
truncate table ba_sarta_batch_log
go
truncate table in_login
go

truncate table ts_negocio_cliente
go
truncate table cl_error_log
go
truncate table ns_notificaciones_despacho
go


use cob_conta_super
GO
truncate table sb_dato_cliente
go
truncate table sb_dato_deudores
go

print 'FINALIZA TRUNCADO DE TABLAS'

use cobis
go
-- SEQNOS
print 'ACTUALIZANDO SEQNOS cobis'
--Actualizar Seqnos Tablas Fisicas
update cl_seqnos set siguiente = (select isnull(max(no_nodo),0) + 1 from ad_nodo)
 where bdatos = 'cobis' and tabla = 'ad_nodo' 
go
update cl_seqnos set siguiente = (select isnull(max(nl_secuencial),0) + 1 from ad_nodo_oficina)
 where bdatos = 'cobis' and tabla = 'ad_nodo_oficina' 
go
update cl_seqnos set siguiente = (select isnull(max(pd_procedure),0) + 1 from ad_procedure)
 where bdatos = 'cobis' and tabla = 'ad_procedure' 
go
update cl_seqnos set siguiente = (select isnull(max(pc_id),0) + 1 from ad_pseudo_catalogo)
 where bdatos = 'cobis' and tabla = 'ad_pseudo_catalogo' 
go
update cl_seqnos set siguiente = (select isnull(max(ro_rol),0) + 1 from ad_rol)
 where bdatos = 'cobis' and tabla = 'ad_rol' 
go
update cl_seqnos set siguiente = (select isnull(max(so_sis_operativo),0) + 1 from ad_sis_operativo)
 where bdatos = 'cobis' and tabla = 'ad_sis_operativo' 
go
update cl_seqnos set siguiente = (select isnull(max(te_terminal),0) + 1 from ad_terminal)
 where bdatos = 'cobis' and tabla = 'ad_terminal' 
go
update cl_seqnos set siguiente = (select isnull(max(th_tipo),0) + 1 from ad_tipo_horario)
 where bdatos = 'cobis' and tabla = 'ad_tipo_horario' 
go
update cl_seqnos set siguiente = (select isnull(max(lo_sec),0) + 1 from ba_log_lectura)
 where bdatos = 'cobis' and tabla = 'ba_log_lectura' 
go
update cl_seqnos set siguiente = (select isnull(max(lo_sec),0) + 1 from ba_log_operador)
 where bdatos = 'cobis' and tabla = 'ba_log_operador' 
go
update cl_seqnos set siguiente = (select isnull(max(lo_sec),0) + 1 from ba_log_supervisor)
 where bdatos = 'cobis' and tabla = 'ba_log_supervisor' 
go
update cl_seqnos set siguiente = (select isnull(max(ac_secuencial),0) + 1 from cl_asoc_clte_serv)
 where bdatos = 'cobis' and tabla = 'cl_asoc_clte_serv' 
go
update cl_seqnos set siguiente = (select isnull(max(ti_grp_atr_inf),0) + 1 from cl_atr_tbl_inf)
 where bdatos = 'cobis' and tabla = 'cl_atr_tbl_inf' 
go
update cl_seqnos set siguiente = (select isnull(max(ti_atr_val),0) + 1 from cl_atr_valores)
 where bdatos = 'cobis' and tabla = 'cl_atr_valores' 
go
update cl_seqnos set siguiente = (select isnull(max(ci_ciudad),0) + 1 from cl_ciudad)
 where bdatos = 'cobis' and tabla = 'cl_ciudad' 
go
update cl_seqnos set siguiente = (select isnull(max(dp_det_producto),0) + 1 from cl_det_producto)
 where bdatos = 'cobis' and tabla = 'cl_det_producto' 
go
update cl_seqnos set siguiente = (select isnull(max(dg_secuencial),0) + 1 from cl_direccion_geo)
 where bdatos = 'cobis' and tabla = 'cl_direccion_geo' 
go
update cl_seqnos set siguiente = (select isnull(max(en_ente),0) + 1 from cl_ente)
 where bdatos = 'cobis' and tabla = 'cl_ente' 
go
update cl_seqnos set siguiente = (select isnull(max(fi_filial),0) + 1 from cl_filial)
 where bdatos = 'cobis' and tabla = 'cl_filial' 
go
update cl_seqnos set siguiente = (select isnull(max(fu_funcionario),0) + 1 from cl_funcionario)
 where bdatos = 'cobis' and tabla = 'cl_funcionario' 
go
update cl_seqnos set siguiente = (select isnull(max(gr_grupo),0) + 1 from cl_grupo)
 where bdatos = 'cobis' and tabla = 'cl_grupo' 
go
update cl_seqnos set siguiente = (select isnull(max(me_codigo),0) + 1 from cl_mercado)
 where bdatos = 'cobis' and tabla = 'cl_mercado' 
go
update cl_seqnos set siguiente = (select isnull(max(nc_codigo),0) + 1 from cl_negocio_cliente)
 where bdatos = 'cobis' and tabla = 'cl_negocio_cliente' 
go
update cl_seqnos set siguiente = (select isnull(max(ng_codigo),0) + 1 from cl_notificacion_general)
 where bdatos = 'cobis' and tabla = 'cl_notificacion_general' 
go
update cl_seqnos set siguiente = (select isnull(max(of_secuencial),0) + 1 from cl_ofic_func)
 where bdatos = 'cobis' and tabla = 'cl_ofic_func' 
go
update cl_seqnos set siguiente = (select isnull(max(pa_pais),0) + 1 from cl_pais)
 where bdatos = 'cobis' and tabla = 'cl_pais' 
go
update cl_seqnos set siguiente = (select isnull(max(pq_parroquia),0) + 1 from cl_parroquia)
 where bdatos = 'cobis' and tabla = 'cl_parroquia' 
go
update cl_seqnos set siguiente = (select isnull(max(pl_secuencial),0) + 1 from cl_pro_oficina)
 where bdatos = 'cobis' and tabla = 'cl_pro_oficina' 
go
update cl_seqnos set siguiente = (select isnull(max(pd_producto),0) + 1 from cl_producto)
 where bdatos = 'cobis' and tabla = 'cl_producto' 
go
update cl_seqnos set siguiente = (select isnull(max(in_codigo),0) + 1 from cl_refinh)
 where bdatos = 'cobis' and tabla = 'cl_refinh' 
go
update cl_seqnos set siguiente = (select isnull(max(re_relacion),0) + 1 from cl_relacion)
 where bdatos = 'cobis' and tabla = 'cl_relacion' 
go
update cl_seqnos set siguiente = (select isnull(max(codigo),0) + 1 from cl_tabla)
 where bdatos = 'cobis' and tabla = 'cl_tabla' 
 go
update cl_seqnos set siguiente = (select isnull(max(nd_id),0) + 1 from ns_notificaciones_despacho)
 where bdatos = 'cobis' and tabla = 'ns_notificaciones_despacho' 
go

print 'FIN LIMPIEZA COBIS'
go

use cob_sincroniza
go
truncate table si_sincroniza_det
go
truncate table si_sincroniza
go
truncate table si_dispositivo
go

declare @w_fecha datetime

select @w_fecha = fp_fecha
from cobis..ba_fecha_proceso

update cobis..ba_fecha_proceso
set fp_fecha = convert(date, getdate())
go

declare @w_fecha datetime

select @w_fecha = fp_fecha from cobis..ba_fecha_proceso

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(1, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(2, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(3, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(4, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(6, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(7, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(8, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(10, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(14, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(17, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(19, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(21, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(36, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(43, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(69, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(73, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(87, @w_fecha, NULL)

INSERT INTO [cobis].[dbo].[ba_fecha_cierre]([fc_producto], [fc_fecha_cierre], [fc_fecha_propuesta])
VALUES(99, @w_fecha, NULL)

go