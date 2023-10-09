/************************************************************************/
/*   Archivo:                 datcabop.sp                               */
/*   Stored procedure:        sp_datocab_operacion                      */
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
/*   Disenado por:            DFu                                       */
/*   Fecha de Documentacion:  Oct. 2016                                 */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                                PROPOSITO                             */
/*   Consulta  datos de cabecera de una operacion especifica            */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA        AUTOR             RAZON                                */
/*  20/oct/2016  DFu               Emision inicial                      */
/* 15/May/2019        AGO                Req 113305                     */
/* 12/May/2022        KVI        Err.#178974-agregar ca_estado          */
/************************************************************************/

use cob_cartera
go

if exists(select * from sysobjects where name = 'sp_datocab_operacion')
   drop proc sp_datocab_operacion
go

create proc sp_datocab_operacion (
    @s_user                  varchar(14),
    @s_term                  varchar(30),
    @s_date                  datetime,
    @s_ofi                   smallint,
    @i_banco                 cuenta,
    @i_formato_fecha         smallint = 101,
    @i_operacion             char(1) = null
)
as

declare
@w_operacionca    int,
@w_error          int,
@w_msg            varchar(255),
@w_min_dividendo  int,
@w_max_dividendo  int,
@w_return         int,
@w_est_novigente  smallint,
@w_est_vigente    smallint,
@w_est_vencido    smallint,
@w_est_cancelado  smallint,
@w_est_castigado  smallint,
@w_est_diferido   smallint,
@w_est_anulado    smallint,
@w_est_condonado  smallint,
@w_est_suspenso   smallint,
@w_est_credito    smallint,

@w_op_fecha_ult_proceso datetime,
@w_valor_exigible       money,
@w_valor_proxima_cuota  money,
@w_max_fecha_ven        datetime,
@w_fecha_fin            datetime,
@w_estado               tinyint,
@w_estado_desc          descripcion,
@w_promocion               char(1) ,
@w_referencia_grupal   cuenta

exec @w_error = sp_estados_cca
@o_est_novigente  = @w_est_novigente out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_diferido   = @w_est_diferido  out,
@o_est_anulado    = @w_est_anulado   out,
@o_est_condonado  = @w_est_condonado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_credito    = @w_est_credito   out

if @w_error <> 0 goto ERROR


/*
exec @w_return = sp_qr_operacion
@s_term = @s_term ,
@s_user = @s_user,
@s_date = @s_date,
@s_ofi  =  @s_ofi,
@i_formato_fecha = @i_formato_fecha,
@i_operacion = @i_operacion,
@i_banco =@i_banco

if @w_return <> 0
   begin
        goto ERROR
   end*/


select
@w_operacionca          = op_operacion,
@w_op_fecha_ult_proceso = op_fecha_ult_proceso,
@w_fecha_fin            = op_fecha_fin
from  ca_operacion
where op_banco = @i_banco

if @@rowcount = 0
begin
    select @w_error = 710201 ,
           @w_msg   = 'PRESTAMO: ' + @i_banco
    goto ERROR
end

if exists (select 1 from ca_ciclo where ci_prestamo = @i_banco) 
begin
    
    --LGU-ini: actulizar operacion grupal
    exec sp_actualiza_grupal
    @i_banco             = @i_banco,
    @i_desde_cca         = 'N'
    --LGU-ini: actulizar operacion grupal
    
    select @w_estado = min(op_estado)
    from   ca_operacion, ca_det_ciclo, ca_estado --Err.#178974 
    where  op_operacion = dc_operacion
    and    dc_referencia_grupal = @i_banco 
	and    op_estado = es_codigo --Err.#178974 
    and    es_procesa = 'S'      --Err.#178974 
	
	if @w_estado is null         --Err.#178974
	begin
	  select @w_estado = min(op_estado)
      from   ca_operacion, ca_det_ciclo
      where  op_operacion = dc_operacion
      and    dc_referencia_grupal = @i_banco 
	end
end 
else 
begin
    select @w_estado = op_estado 
    from   ca_operacion 
    where  op_banco = @i_banco
end

/*CALCULO DE VALOR EXIGIBLE DEL PRESTAMO*/
select
@w_min_dividendo = isnull(min(di_dividendo),0),
@w_max_dividendo = isnull(max(di_dividendo),0),
@w_max_fecha_ven = isnull(max(di_fecha_ven),@w_fecha_fin)
from   ca_dividendo
where  di_operacion = @w_operacionca
and   (di_estado    = @w_est_vencido or (di_estado = @w_est_vigente and di_fecha_ven <= @w_op_fecha_ult_proceso))

SELECT @w_valor_exigible = isnull(sum((am_cuota + am_gracia) - am_pagado),0)
FROM   ca_amortizacion
WHERE  am_operacion   = @w_operacionca
and    am_dividendo   between @w_min_dividendo and @w_max_dividendo

/*CALCULO PROXIMA CUOTA*/
select
@w_min_dividendo = isnull(min(di_dividendo),0),
@w_max_dividendo = isnull(max(di_dividendo),0)
from   ca_dividendo
where  di_operacion = @w_operacionca
and    di_estado    = @w_est_vigente

SELECT @w_valor_proxima_cuota = isnull(sum((am_cuota + am_gracia) - am_pagado),0)
FROM   ca_amortizacion
WHERE  am_operacion = @w_operacionca
and    am_dividendo between @w_min_dividendo and @w_max_dividendo

select @w_estado_desc = es_descripcion 
from   ca_estado 
where  es_codigo = @w_estado

select @w_promocion = tr_promocion from cob_credito..cr_tramite where tr_numero_op = @w_operacionca



select @w_promocion = 'N'

if exists (select 1 from ca_det_ciclo where dc_referencia_grupal = @i_banco) 
begin 
   
   select @w_promocion = isnull(tr_promocion, 'N')
   from cob_credito..cr_tramite 
   where tr_numero_op_banco = @i_banco

end else begin 

   select @w_referencia_grupal = dc_referencia_grupal 
   from ca_det_ciclo 
   where dc_operacion = @w_operacionca
   
   select  @w_promocion = isnull(tr_promocion, 'N')
   from cob_credito..cr_tramite 
   where tr_numero_op_banco  = @w_referencia_grupal
 
 
 
end 

 


select 'op_toperacion'    =case @w_promocion when 'S' then op_toperacion+'-'+'PROMOCION' else isnull(op_toperacion,'Tipo Préstamo') end ,
       'linea'            = (select case @w_promocion when 'S' then c.valor+'-'+'PROMOCION' else c.valor end 
                             from   cobis..cl_tabla t, cobis..cl_catalogo c
                             where  t.codigo = c.tabla
                             and    t.tabla  = 'ca_toperacion'
                             and    c.codigo = o.op_toperacion),
       'op_oficina'       = op_oficina,
       'oficina'          = (select isnull(of_nombre,'') from cobis..cl_oficina where of_oficina = o.op_oficina),
       'op_banco'         = op_banco,
       'op_operacion'     = op_operacion,
       'moneda'           = (select mo_nemonico from cobis..cl_moneda where mo_moneda = convert(char(10),o.op_moneda)),
       'op_oficial'       = (select f.fu_nombre
                             from   cobis..cc_oficial ofi, cobis..cl_funcionario f
                             where  ofi.oc_funcionario = f.fu_funcionario and
                                    ofi.oc_oficial     = o.op_oficial),
	   'op_monto'         = op_monto,
       'op_cliente'       = op_cliente,
       'op_nombre'        = op_nombre,
       'en_tipo_ced'      = (select isnull(en_tipo_ced,'') from cobis..cl_ente where en_ente = o.op_cliente),
       'en_ced_ruc'       = (select isnull(en_ced_ruc,'')  from cobis..cl_ente where en_ente = o.op_cliente),
       'op_estado'        = @w_estado,
       'es_descripcion'   = @w_estado_desc,
       'fecha_ini'        = op_fecha_ini,
       'fecha_venc'       = op_fecha_fin,
       'fecha_venc_cuota' = @w_max_fecha_ven,
       'exigible'         = @w_valor_exigible,
       'proxima_cuota'    = @w_valor_proxima_cuota,
       'tasa_efec_anual'  = (select sum(ro_porcentaje_efa)
                             from   ca_rubro_op
                             where  ro_operacion  = o.op_operacion
                             and    ro_tipo_rubro = 'I')
from   ca_operacion o
where  op_banco      = @i_banco

if @@rowcount = 0
begin
    select @w_error = 710201
    goto ERROR
end

return 0

ERROR:
exec cobis..sp_cerror
@t_debug = 'N',
@t_file = null,
@t_from = 'sp_datocab_operacion',
@i_num  = @w_error
return @w_error



GO

