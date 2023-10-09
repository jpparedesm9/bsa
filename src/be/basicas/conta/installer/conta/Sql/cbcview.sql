USE [cob_conta]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 

create view [dbo].[ts_area] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa,cod_area,area_padre,descripcion,
	estado,nivel_area
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cod_oficina,ts_oficina_padre,
 	ts_descripcion,ts_estado,ts_nivel_cuenta
from   cb_tran_servicio
where  ts_tipo_transaccion = 6511 or
	ts_tipo_transaccion = 6512 or
	ts_tipo_transaccion = 6513

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
     create view [dbo].[ts_asoemp] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa
from   cb_tran_servicio
where  ts_tipo_transaccion = 6261

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create view [dbo].[ts_banco] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,banco,nombre,cuenta, operacion
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_ctaasoc,ts_descripcion,ts_cuenta, ts_oper_ent
from   cb_tran_servicio
where   ts_tipo_transaccion = 6741 or
	ts_tipo_transaccion = 6742 or
	ts_tipo_transaccion = 6743

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_categoria] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,categoria,nombre,signo
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_categoria,ts_descripcion,ts_movimiento
from   cb_tran_servicio
where  ts_tipo_transaccion = 6521 or
	ts_tipo_transaccion = 6522 or
	ts_tipo_transaccion = 6523

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_concica] (
        empresa,			/* JCG10 */
	secuencial, tipo_transaccion, clase, fecha,usuario,
	terminal,oficina,
	codigo, descripcion, base, porcentaje, ciudad,
	debcred				/* JCG10 */
)
as select ts_empresa,			/* JCG10 */ 
	  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	  ts_terminal,ts_oficina,
	  ts_codigo_conc, ts_descripcion_conc, ts_base_conc, ts_porcentaje_conc, ts_ciudad_ica,
	  ts_control			/* JCG10 */
from   cb_tran_servicio
where   ts_tipo_transaccion > 6968 and
        ts_tipo_transaccion < 6971

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE VIEW [dbo].[ts_conciva] (
empresa,			
secuencial, tipo_transaccion, clase, fecha,usuario,
terminal,oficina,
codigo, descripcion, base, porcentaje, 
descontado, des_porcen,
debcred, porc_espec		
)
as select ts_empresa,			
	  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	  ts_terminal,ts_oficina,
	  ts_codigo_conc, ts_descripcion_conc, ts_base_conc, ts_porcentaje_conc,
	  ts_descontado, ts_des_porcen,
	  ts_control, ts_porc_espec	
from   cb_tran_servicio
where   ts_tipo_transaccion >= 6964 and
	ts_tipo_transaccion < 6967

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_concivapagado] (
        empresa,			 
	secuencial, tipo_transaccion, clase, fecha,usuario,
	terminal,oficina,
	codigo, descripcion, porcentaje, 
	debcred				
)
as select ts_empresa,			 
	  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	  ts_terminal,ts_oficina,
	  ts_codigo_conc, ts_descripcion_conc, ts_porcentaje_conc,
	  ts_control			
from   cb_tran_servicio
where   ts_tipo_transaccion > 6288 and
	ts_tipo_transaccion < 6294

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_control] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,login,ofic,area,tipo
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
      ts_terminal,ts_oficina,ts_empresa,ts_login,ts_ofic_orig,ts_area,ts_estado
from   cb_tran_servicio
where  ts_tipo_transaccion = 6731 or
	ts_tipo_transaccion = 6733

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
     create view [dbo].[ts_corte] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	corte,periodo,empresa,fecha_ini,fecha_fin,tipo  
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_corte,ts_periodo,ts_empresa,ts_fecha_ini,
	ts_fecha_fin,ts_estado
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6101 or
	ts_tipo_transaccion = 6102 or
	ts_tipo_transaccion = 6103

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_cotizacion] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	fecha_cotz,moneda,valor,compra,venta                 
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_fecha_ini,ts_moneda,ts_tot_debito,
	ts_tot_debito_me,ts_tot_credito_me
from   cb_tran_servicio
where  ts_tipo_transaccion = 6141 or
	ts_tipo_transaccion = 6142 or
	ts_tipo_transaccion = 6143

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_cuenta_asociada] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	cod_oficina,empresa,proceso,cuenta,oficina,numero,
	cta_asoc,condicion,debcred
)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_proceso,ts_cuenta,
	ts_cod_oficina,ts_ofic_orig,ts_ctaasoc,ts_area,
	ts_movimiento
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6231 or
	ts_tipo_transaccion = 6232 or
	ts_tipo_transaccion = 6233

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_cuenta_proceso] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	cod_oficina,empresa,proceso,cuenta,oficina,texto,condicion,imprime
)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_proceso,ts_cuenta,
	ts_cod_oficina,ts_descripcion,ts_causa,ts_estado
from   cb_tran_servicio
where  ts_tipo_transaccion = 6221 or
	ts_tipo_transaccion = 6222 or
	ts_tipo_transaccion = 6223

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_dinamica] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa,cuenta,siguiente,tipo_dinamica,texto,
	disp_legal
)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cuenta,
	ts_numero_actual,ts_estado,ts_concepto,ts_descripcion
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6201 or
	ts_tipo_transaccion = 6202 or
	ts_tipo_transaccion = 6203

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ts_empresa] (
	secuencial,     tipo_transaccion,        clase,        fecha,
        usuario,        terminal,                oficina,      empresa,
        ruc,            descripcion,             replegal,     contgen,
        moneda,         direccion,               empresarev,   nitrev, 
        matrevisoria
)
as
select  ts_secuencial,  ts_tipo_transaccion,     ts_clase,            ts_fecha,
        ts_usuario,    	ts_terminal,             ts_oficina,          ts_empresa,   
        ts_ruc,         ts_descripcion,          ts_replegal,         ts_contgen,     
        ts_moneda,      ts_direccion,            ts_descripcion_conc, ts_cuenta,
        ts_categoria
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6031 or
	ts_tipo_transaccion = 6032 or
	ts_tipo_transaccion = 6033

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_nivel_area] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa,nivel,descripcion
)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_nivel_cuenta,ts_descripcion
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6501 or
	ts_tipo_transaccion = 6502 or
	ts_tipo_transaccion = 6503

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_nivel_cuenta] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,nivel_cuenta,descripcion,longitud
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_nivel_cuenta,ts_descripcion,
	ts_longitud
from   cb_tran_servicio
where  ts_tipo_transaccion = 6021 or
	ts_tipo_transaccion = 6022 or
	ts_tipo_transaccion = 6023

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_oficina] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa,cod_oficina,oficina_padre,descripcion,
	estado,organizacion
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cod_oficina,ts_oficina_padre,
 	ts_descripcion,ts_estado,ts_nivel_cuenta
from   cb_tran_servicio
where  ts_tipo_transaccion = 6151 or
	ts_tipo_transaccion = 6152 or
	ts_tipo_transaccion = 6153

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_organizacion]  (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,organizacion,descripcion
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_nivel_cuenta,ts_descripcion 
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6051 or
	ts_tipo_transaccion = 6052 or
	ts_tipo_transaccion = 6053

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_plan_general] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,cuenta,cod_oficina,area
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cuenta,ts_cod_oficina,ts_area
from   cb_tran_servicio
where  ts_tipo_transaccion = 6071 or
	ts_tipo_transaccion = 6072 or
	ts_tipo_transaccion = 6073

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
    create view [dbo].[ts_relofi] (
        secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
        empresa,ofic
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
        ts_terminal,ts_oficina,ts_empresa,ts_ofic_orig
from   cb_tran_servicio
where  ts_tipo_transaccion = 6843 or
       ts_tipo_transaccion = 6844

go

if exists (select 1 from cob_conta..sysobjects where name = 'ts_parametro' and type = 'V')begin
   drop view ts_parametro 
end
go

create view [dbo].[ts_parametro] (
secuencial,    tipo_transaccion,    clase, 
fecha,         usuario,             terminal,
oficina,       empresa,             parametro,
descripcion,   stored,              transaccion
)
as 
select 
ts_secuencial,       ts_tipo_transaccion, ts_clase, 
ts_fecha,            ts_usuario,          ts_terminal,         
ts_oficina,          ts_empresa,          ts_cuenta,           
ts_descripcion,      ts_categoria,        ts_proceso
from   cb_tran_servicio
where   ts_tipo_transaccion > 6921 
and     ts_tipo_transaccion < 6930
go

    create view ts_perfil (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,producto,perfil,descripcion
) as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_moneda,ts_cuenta,ts_descripcion
from   cb_tran_servicio
where   ts_tipo_transaccion > 6901 and
	ts_tipo_transaccion < 6910
go

    /* FS001 */
create view ts_cuenta (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,cuenta,descripcion,estado,movimiento,categoria,acceso,
	presupuesto
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cuenta,ts_descripcion,ts_estado,
	ts_movimiento,ts_categoria,ts_causa,ts_presupuesto
from   cb_tran_servicio
where  ts_tipo_transaccion = 6011 or
	ts_tipo_transaccion = 6012 or
	ts_tipo_transaccion = 6013

go

