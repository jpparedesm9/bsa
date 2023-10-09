/************************************************************************/
/*  Archivo:                sp_eje_calendario_dia_pago.sp               */
/*  Stored procedure:       sp_eje_calendario_dia_pago                  */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           ACH                                         */
/*  Fecha de Documentacion: 15/Nov/2022                                 */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                           PROPOSITO                                  */
/* Procedure tipo Variable, Retorna 'SI' cuando cumple la regla caso    */
/* contrario NO                                                         */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA        AUTOR                   RAZON                          */
/*  15/11/2022    ACH     Emision Inicial - REQ#194284 Dia de Pago      */
/* **********************************************************************/
use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_eje_calendario_dia_pago')
	drop proc sp_eje_calendario_dia_pago
go

create procedure sp_eje_calendario_dia_pago
(
 @s_ssn               int         = null,
 @s_ofi               smallint    = null,
 @s_user              login       = null,
 @s_date              datetime    = null,
 @s_srv		          varchar(30) = null,
 @s_term	          descripcion = null,
 @s_rol		          smallint    = null,
 @s_lsrv	          varchar(30) = null,
 @s_sesn	          int         = null,
 @s_org		          char(1)     = NULL,
 @s_org_err           int         = null,
 @s_error             int         = null,
 @s_sev               tinyint     = null,
 @s_msg               descripcion = null,
 @t_rty               char(1)     = null,
 @t_trn               int         = null,
 @t_debug             char(1)     = 'N',
 @t_file              varchar(14) = null,
 @t_from              varchar(30) = null,
 --variables
 @i_id_inst_proc      int,    --codigo de instancia del proceso
 @o_respuesta         varchar(256) out 
 )
as
declare
@w_sp_name       	varchar(32),
@w_tramite       	int,
@w_return        	int,
@w_cliente          int,
@w_variable_producto varchar(256),
@w_es_promo          varchar(256),
@w_oficina           int,
@w_dia_atraso        int,
@w_num_cliclo_grupal int,
@w_num_cliclo_ind    int,
@w_frecuencia_pago   varchar(256),
@w_num_dias          int,
@w_error              int,
@w_valores            varchar(255),
@w_resultado          varchar(255),
@w_banco              varchar(24),
@w_fecha_proceso      datetime,
@w_tdividendo         varchar(256),
@w_num_ciclo_ant      int,
@w_operacion          int,
@w_est_vigente        tinyint,
@w_est_vencido        tinyint,
@w_est_no_vigente     tinyint,
@w_est_cancelado      tinyint,
@w_msg                varchar(255),
@w_periodo_int        smallint,
@w_tplazo             catalogo,
@w_fecha_dispersion   datetime,
@w_dia_pago           datetime,
@w_fecha_ini_tmp      datetime,
@w_dia_inicio         int

select @w_sp_name='sp_var_eje_calendario_dia_pago'
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select @w_resultado = 'NO'

--CONSULTAR ESTADOS
exec @w_error     = cob_cartera..sp_estados_cca
@o_est_vigente    = @w_est_vigente    out,--1
@o_est_vencido    = @w_est_vencido    out,--2
@o_est_novigente  = @w_est_no_vigente out,--0
@o_est_cancelado  = @w_est_cancelado  out --3

---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>
select @w_tramite = io_campo_3,
       @w_cliente = io_campo_1
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc = @i_id_inst_proc

--Se agrega esto porque la variable se ejecuta al crear la solicitud.
if (@w_tramite is null or @w_tramite <= 0)begin
    print 'No Existe tramite para el proceso: ' +  convert(varchar, @i_id_inst_proc) 
    goto ERROR
end

select @w_variable_producto = op_toperacion, -->> VARIABLE PRODUCTO
       @w_es_promo = case when op_promocion = 'S' then 'SI' -->> VARIABLE PROMOCION
                          when op_promocion = 'N' then 'NO' else '' end,
	   @w_oficina = op_oficina,-->> VARIABLE OFICINA
       @w_banco   = op_banco,
	   @w_frecuencia_pago = case when op_tdividendo = 'W' and op_periodo_int = 2 and op_periodo_cap = 2 then 'BW' -->> FRECUENCIA PAGO
	                        else op_tdividendo end,
	   @w_operacion = op_operacion,
	   @w_periodo_int      = op_periodo_int,
	   @w_tplazo           = op_tplazo
from cob_cartera..ca_operacion 
where op_tramite = @w_tramite

if (@w_variable_producto = 'GRUPAL') begin
	select @w_num_cliclo_ind = 0 -->> VARIABLE NÚMERO CICLO INDIVIDUAL
    select @w_num_cliclo_grupal = isnull(gr_num_ciclo,0) + 1, -->> NÚMERO CICLO GRUPAL
	       @w_dia_atraso = isnull(gr_dias_atraso,0) -->> VARIABLE DIAS ATRASO
    from cobis..cl_grupo
    where gr_grupo = @w_cliente
	
end else begin
    select @w_num_cliclo_ind = isnull(en_nro_ciclo, 0) -->> VARIABLE NÚMERO CICLO INDIVIDUAL
	from cobis..cl_ente 
	where en_ente = @w_cliente
    
	-->> NÚMERO CICLO GRUPAL
	select @w_num_cliclo_grupal = max(dc_ciclo)
	from cob_cartera..ca_det_ciclo
	where dc_cliente = @w_cliente	

    select @w_num_cliclo_grupal = isnull(@w_num_cliclo_grupal, 0) + 1
	
    --->>>--->>>--->>>--->>>--->>>--->>>--->>>--->>>
    select operacion = di_operacion, max_num_atraso = max(datediff(dd, di_fecha_ven, @w_fecha_proceso))
	into #op_dias_atraso_1
    from cob_cartera..ca_dividendo where di_operacion = @w_operacion
	and di_estado in (@w_est_vencido)
	group by di_operacion
	
    --->>>--->>>--->>>--->>>--->>>--->>>--->>>--->>>
    insert #op_dias_atraso_1 (operacion, max_num_atraso)
    select di_operacion, max(datediff(dd, di_fecha_ven, di_fecha_can))
    from cob_cartera..ca_dividendo where di_operacion = @w_operacion
	and di_estado in (@w_est_cancelado)
	group by di_operacion

    --->>>--->>>--->>>--->>>--->>>--->>>--->>>--->>>	
    select @w_dia_atraso = max(max_num_atraso)
	from #op_dias_atraso_1
	where operacion = @w_operacion
	
	-->> DIAS ATRASO
	select @w_dia_atraso = isnull(@w_dia_atraso, 0)
	
end

-->> VAR NUMERO DIAS
select @w_fecha_dispersion = dp_fecha_dispercion,
       @w_num_dias = isnull(dp_dias_regla, -1),
	   @w_dia_pago = dp_fecha_dia_pag
from cob_cartera..ca_dia_pago
where dp_banco = @w_banco

--if @w_fecha_dispersion <> @w_fecha_proceso begin
if @w_fecha_dispersion < @w_fecha_proceso begin
    select @w_fecha_dispersion = @w_fecha_proceso

    exec cob_cartera..sp_valida_diapago
         @i_banco            = @w_banco ,
         @i_fecha_dispersion = @w_fecha_dispersion,
         @i_dia_pago         = @w_dia_pago        ,
         @i_periodo_int      = @w_periodo_int     ,
         @i_tplazo           = @w_tplazo          ,
         @o_fecha_inicio     = @w_fecha_ini_tmp out,
         @o_dia_inicio       = @w_dia_inicio    out,
         @o_error            = @w_error         out 
   	print 'dary1-w_error: ' + convert(varchar, @w_error)
    if @w_error <> 0 begin       
	    goto ERROR
    end

    select @w_num_dias = dp_dias_regla
    from cob_cartera..ca_dia_pago
    where dp_banco = @w_banco
end

select  @w_valores = @w_variable_producto + '|' + @w_es_promo + '|' + 
                     convert(varchar, @w_oficina  ) + '|' + convert(varchar, @w_dia_atraso  ) + '|' + 
                     convert(varchar, @w_num_cliclo_ind  ) + '|' + convert(varchar, @w_num_cliclo_grupal  ) + '|' + 
                     convert(varchar, @w_frecuencia_pago  ) + '|' + convert(varchar, @w_num_dias )

PRINT '--->>TRAMA_ENVIO_para_CALDEPAGO: ' + @w_valores 
               
exec @w_error           = cob_cartera..sp_ejecutar_regla
@s_ssn                  = @s_ssn,
@s_ofi                  = @s_ofi,
@s_user                 = @s_user,
@s_date                 = @s_date,
@s_srv                  = @s_srv,
@s_term                 = @s_term,
@s_rol                  = @s_rol,
@s_lsrv                 = @s_lsrv,
@s_sesn                 = @s_sesn,
@i_regla                = 'CALDEPAGO', -- Calendario de Pago
@i_tipo_ejecucion       = 'REGLA',     
@i_valor_variable_regla = @w_valores,
@o_resultado1           = @w_resultado out

if @w_error <> 0
begin
   goto ERROR
end

print '-->>Salida regla CALDEPAGO: ' + @w_resultado -- SI para cumple --- NO para no cumple
select @w_resultado = isnull(@w_resultado, 'NO')

select @o_respuesta = @w_resultado
-->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>
--valor anterior de variable tipo en la tabla cob_workflow..wf_variable
return 0

ERROR:
select @o_respuesta = @w_resultado
return 0