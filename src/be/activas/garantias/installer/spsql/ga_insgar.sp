/************************************************************************/
/*   Stored procedure:     sp_gar_sicredito                             */
/*   Base de datos:        cob_custodia                                 */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
 
use cob_custodia
go
 
if exists (select 1 from sysobjects where name = 'sp_gar_sicredito')
   drop proc sp_gar_sicredito
go
 
create proc sp_gar_sicredito (
   @i_param1         varchar(255)
)

as

declare
@w_sp_name         varchar(100),
@w_mensaje         varchar(255),
@w_fecha           datetime

select @w_fecha = convert(datetime,@i_param1)

select @w_sp_name = 'sp_gar_sicredito'
select @w_mensaje = null

create table #dato_custodia (
dc_fecha          datetime    null,
dc_aplicativo     tinyint     null,
dc_garantia       varchar(64) null,
dc_oficina        smallint    null,
dc_cliente        int         null,
dc_categoria      varchar(1)  null,
dc_tipo           varchar(14) null,
dc_idonea         varchar(1)  null,
dc_fecha_avaluo   datetime    null,
dc_moneda         tinyint     null,
dc_valor_avaluo   money       null,
dc_valor_actual   money       null,
dc_estado         varchar     null,
dc_abierta        varchar(1)  null,
dc_banco          varchar(24) null,
dc_porcentaje     float       null
)

create table #dato_garantia (
dg_fecha        datetime      null,
dg_banco        varchar(24)   null,
dg_toperacion   varchar(10)   null,
dg_aplicativo   tinyint       null,
dg_garantia     varchar(64)   null,
dg_cobertura    money         null,
dg_porcentaje   float         null
)

insert into #dato_custodia (
dc_fecha,         dc_aplicativo,      dc_garantia,
dc_oficina,       dc_cliente,         dc_categoria,
dc_tipo,          dc_idonea,          dc_fecha_avaluo,
dc_moneda,        dc_valor_avaluo,    dc_valor_actual,
dc_estado,        dc_abierta,         dc_banco,
dc_porcentaje
)
select
@w_fecha,         200,                mgp_solicitud_mig + '_ga',
mcg_sucursal,     en_ente,            'E',
mcg_tipo_cust,    'S',                isnull(mcu_fecha_insp,mcu_fecha_ingreso),
0,                0,                  0,
'V',              mgp_abierta,        mgp_solicitud_mig,
mgp_porcentaje
from cob_custodia..cu_custodia_mig, cob_custodia..cr_gar_propuesta_mig, cob_custodia..cu_cliente_garantia_mig, cobis..cl_ente
where mcu_num_dcto    = mgp_num_dcto
and   mgp_num_dcto    = mcg_num_dcto
and   mcg_cedula      = en_ced_ruc
and   mcg_tipo_cedula = en_tipo_ced

if @@error <> 0 begin
   select @w_mensaje = 'Error en Insert #dato_custodia '
   goto ERRORFIN
end


update #dato_custodia set
dc_categoria = 'E'   --Especiales
from cob_credito..cr_corresp_sib
where tabla      = 'T65'
and   codigo_sib = dc_tipo

if @@error <> 0 begin
   select @w_mensaje = 'Error en Update  #dato_custodia '
   goto ERRORFIN
end

update #dato_custodia set
dc_categoria = 'H'   --Hipotecaria
from cob_credito..cr_corresp_sib
where tabla      = 'T1'
and   codigo_sib = dc_tipo

if @@error <> 0 begin
   select @w_mensaje = 'Error en Update  #dato_custodia '
   goto ERRORFIN
end

update #dato_custodia set
dc_valor_avaluo  = round(do_saldo_cap*(dc_porcentaje/100),0),
dc_valor_actual  = round(do_saldo_cap*(dc_porcentaje/100),0)
from cob_credito..cr_dato_operacion
where dc_banco      = do_numero_operacion_banco
and   do_tipo_reg   = 'M'

if @@error <> 0 begin
   select @w_mensaje = 'Error en Update  #dato_custodia '
   goto ERRORFIN
end

insert into #dato_garantia (
dg_fecha,       dg_banco,                   dg_toperacion,
dg_aplicativo,  dg_garantia,                dg_cobertura,
dg_porcentaje
)
select
@w_fecha,       mgp_solicitud_mig,          '',
200,            mgp_solicitud_mig + '_ga',  0,
mgp_porcentaje
from cob_custodia..cu_custodia_mig, cob_custodia..cr_gar_propuesta_mig, cob_custodia..cu_cliente_garantia_mig, cobis..cl_ente
where mcu_num_dcto    = mgp_num_dcto
and   mgp_num_dcto    = mcg_num_dcto
and   mcg_cedula      = en_ced_ruc
and   mcg_tipo_cedula = en_tipo_ced

if @@error <> 0 begin
   select @w_mensaje = 'Error en Insert #dato_garantia '
   goto ERRORFIN
end

update #dato_garantia set
dg_toperacion      = do_tipo_operacion,
dg_cobertura       = round(do_saldo_cap*(dg_porcentaje/100),0)
from   cob_credito..cr_dato_operacion
where  do_tipo_reg               = 'M'
and    do_numero_operacion_banco = dg_banco

if @@error <> 0 begin
   select @w_mensaje = 'Error en Update #dato_garantia '
   goto ERRORFIN
end

delete cob_conta_super..sb_dato_custodia
where dc_fecha      = @w_fecha
and   dc_aplicativo = 200

if @@error <> 0 begin
   select @w_mensaje = 'Error en Delete sb_dato_custodia '
   goto ERRORFIN
end

insert into cob_conta_super..sb_dato_custodia (
dc_fecha,         dc_aplicativo,           dc_garantia,
dc_oficina,       dc_cliente,              dc_categoria,
dc_tipo,          dc_idonea,               dc_fecha_avaluo,
dc_moneda,        dc_valor_avaluo,         dc_valor_actual,
dc_estado,        dc_abierta
)
select
dc_fecha,         dc_aplicativo,           dc_garantia,
dc_oficina,       dc_cliente,              dc_categoria,
dc_tipo,          dc_idonea,               dc_fecha_avaluo,
dc_moneda,        dc_valor_avaluo,         dc_valor_actual,
dc_estado,        dc_abierta
from #dato_custodia

if @@error <> 0 begin
   select @w_mensaje = 'Error en Insert sb_dato_custodia '
   goto ERRORFIN
end

delete cob_conta_super..sb_dato_garantia
where dg_fecha      = @w_fecha
and   dg_aplicativo = 200

if @@error <> 0 begin
   select @w_mensaje = 'Error en Delete sb_dato_garantia '
   goto ERRORFIN
end

insert into cob_conta_super..sb_dato_garantia (
dg_fecha,       dg_banco,        dg_toperacion,
dg_aplicativo,  dg_garantia,     dg_cobertura
)
select 
dg_fecha,       dg_banco,        dg_toperacion,
dg_aplicativo,  dg_garantia,     dg_cobertura
from #dato_garantia

if @@error <> 0 begin
   select @w_mensaje = 'Error en Insert sb_dato_garantia '
   goto ERRORFIN
end


return 0

ERRORFIN:

while @@trancount > 0 rollback tran

exec cob_cartera..sp_errorlog
@i_fecha       = @w_fecha,
@i_error       = 19001,
@i_usuario     = 'crebatch',
@i_tran        = 19001,
@i_tran_name   = @w_sp_name, 
@i_rollback    = 'N',
@i_cuenta      = '',
@i_descripcion = @w_mensaje

return 1

go
