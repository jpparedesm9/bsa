/************************************************************************/
/*  Archivo:                sp_eje_reg_porc_cobro_gl.sp                 */
/*  Stored procedure:       sp_eje_reg_porc_cobro_gl                    */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           ACH                                         */
/*  Fecha de Documentacion: 29/Dic/2022                                 */
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
/* Procedure para ejecutar la regla porcentaje de cobro para garantias  */
/* liquidas para el caso REQ#198155 OT Regla de Garantías               */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA        AUTOR                   RAZON                          */
/* **********************************************************************/
use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_eje_reg_porc_cobro_gl')
	drop proc sp_eje_reg_porc_cobro_gl
go

create procedure sp_eje_reg_porc_cobro_gl
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
@w_sp_name       	 varchar(32),
@w_tramite       	 int,
@w_return        	 int,
@w_cliente           int,
@w_dia_atraso        int,
@w_num_cliclo        int,
@w_frecuencia_pago   varchar(256),
@w_num_dias          int,
@w_error             int,
@w_valores           varchar(255),
@w_resultado         int,
@w_banco             varchar(24),
@w_fecha_proceso     datetime,
@w_tdividendo        varchar(256),
@w_num_ciclo_ant     int,
@w_operacion         int,
@w_est_vigente       tinyint,
@w_est_vencido       tinyint,
@w_est_no_vigente    tinyint,
@w_est_cancelado     tinyint,
@w_msg               varchar(255),
--NUEVOS
@w_tproducto         varchar(20),
@w_es_promo          varchar(2),
@w_nivel_cliente     varchar(10),
@w_oficina           int,
@w_num_ciclo_act     int,
@w_dia_atraso_max    int

select @w_sp_name = 'sp_eje_reg_porc_cobro_gl'
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select @w_nivel_cliente = ''

--CONSULTAR ESTADOS
exec @w_error     = cob_cartera..sp_estados_cca
@o_est_vigente    = @w_est_vigente    out,--1
@o_est_vencido    = @w_est_vencido    out,--2
@o_est_novigente  = @w_est_no_vigente out,--0
@o_est_cancelado  = @w_est_cancelado  out --3

---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>
select @w_tramite = io_campo_3,
       @w_cliente = io_campo_1,
	   @w_tproducto = io_campo_4
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc = @i_id_inst_proc

--Se agrega esto porque la variable se ejecuta al crear la solicitud.
if (@w_tramite is null or @w_tramite <= 0)begin
    print 'No Existe tramite para el proceso: ' +  convert(varchar, @i_id_inst_proc) 
    goto ERROR
end

if (@w_tproducto != 'GRUPAL')
    select @w_nivel_cliente = ea_nivel_colectivo from cobis..cl_ente_aux where ea_ente = @w_cliente

select @w_tproducto = case when op_anterior is not null and op_toperacion = 'GRUPAL'
                              then 'RENOVACION'
                              else op_toperacion end, -->> VARIABLE PRODUCTO
       @w_es_promo = case when op_promocion = 'S' then 'SI' -->> VARIABLE PROMOCION
                          when op_promocion = 'N' then 'NO' else '' end,
	   @w_oficina = op_oficina,-->> VARIABLE OFICINA
       @w_banco   = op_banco,
	   @w_operacion = op_operacion
from cob_cartera..ca_operacion 
where op_tramite = @w_tramite


if (@w_tproducto = 'GRUPAL') begin
	select @w_num_cliclo = isnull(gr_num_ciclo,0) + 1, -->> NÚMERO CICLO
	       @w_dia_atraso = isnull(gr_dias_atraso,0) -->> VARIABLE DIAS ATRASO
    from cobis..cl_grupo
    where gr_grupo = @w_cliente	
end else begin
	-->> NUMERO CICLO
	print '2'
	select @w_num_cliclo = max(dc_ciclo)
	from cob_cartera..ca_det_ciclo
	where dc_cliente = @w_cliente	

    select @w_num_cliclo = isnull(@w_num_cliclo, 0) + 1
	
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

select  @w_valores = @w_tproducto + '|' + @w_es_promo + '|' + 
                     @w_nivel_cliente + '|' + convert(varchar, @w_oficina) + '|' + 
					 convert(varchar, @w_num_cliclo) + '|' +  convert(varchar, @w_dia_atraso)

PRINT '--->>Trama PORCGARLIQ: ' + @w_valores 
               
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
@i_regla                = 'PORCGARLIQ', -- 
@i_tipo_ejecucion       = 'REGLA',     
@i_valor_variable_regla = @w_valores,
@o_resultado1           = @w_resultado out

if @w_error <> 0
begin
   goto ERROR
end

print '-->>Salida regla PORCGARLIQ: ' + convert(varchar, @w_resultado)
select @o_respuesta = @w_resultado
-->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>
--valor anterior de variable tipo en la tabla cob_workflow..wf_variable

return 0

ERROR:
   return @w_error
go