/************************************************************************/
/*  Archivo:                sp_var_pago_ant_cred.sp                     */
/*  Stored procedure:       sp_var_pago_ant_cred                        */
/*  Base de Datos:          Credito                                     */
/*  Producto:               Credito                                     */
/*  Disenado por:           ACH                                         */
/*  Fecha de Documentacion: 03/May/2021                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Retorna un SI o NO dependiendo del parametro VBIO y la paramtria de  */
/* oficinas que validan biocheck									    */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*     Fecha      Nombre                    Proposito                   */
/*  03/05/2020    ACH       Emision Inicial, caso#158401 gl y ant       */
/*  15/06/2020    ACH       REQ#185234-validacion para operacion no GRL */
/* **********************************************************************/
use cob_credito
go

if object_id('dbo.sp_var_pago_ant_cred') is not null
	drop procedure dbo.sp_var_pago_ant_cred
go

create proc sp_var_pago_ant_cred(
	@s_ssn          int          = null,
	@s_ofi          smallint     = null,
	@s_user         login        = null,
    @s_date         datetime     = null,
	@s_srv		    varchar(30)  = null,
	@s_term	        descripcion  = null,
	@s_rol		    smallint     = null,
	@s_lsrv	        varchar(30)  = null,
	@s_sesn	        int 	     = null,
	@s_org		    char(1)      = NULL,
	@s_org_err      int 	     = null,
    @s_error        int 	     = null,
    @s_sev          tinyint      = null,
    @s_msg          descripcion  = null,
    @t_rty          char(1)      = null,
    @t_trn          int          = null,
    @t_debug        char(1)      = 'N',
    @t_file         varchar(14)  = null,
    @t_from         varchar(30)  = null,
	@i_id_inst_proc int,    
	@i_id_inst_act  int,
	@i_id_asig_act  int,
	@i_id_empresa   int,
	@i_id_variable  smallint
	)
as
declare @w_sp_name       	varchar(32),
		@w_val_param		char(1),
		@w_valor_ant      	varchar(255),
        @w_valor_nuevo    	varchar(255),
		@w_tramite			int,
		@w_oficina          smallint,
		@w_param_ofis		int,
		@w_monto            money,
		@w_toperacion       varchar(10)

select @w_tramite = io_campo_5,
       @w_toperacion = io_campo_4 
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_valor_nuevo = 'NO'

--porCaso#185234
if(@w_toperacion = 'GRUPAL') begin
    select @w_monto = sum(am_acumulado - am_pagado) 
    from cob_credito..cr_tramite_grupal, cob_cartera..ca_amortizacion
    where tg_operacion = am_operacion
    and tg_tramite = @w_tramite 
    and tg_prestamo <> tg_referencia_grupal
    and tg_participa_ciclo = 'S' 
    and tg_monto > 0
end else begin
    select @w_monto = sum(am_acumulado - am_pagado) 
    from cob_cartera..ca_operacion, cob_cartera..ca_amortizacion
    where op_operacion = am_operacion
    and op_tramite = @w_tramite
end

if (@w_monto = 0)
    select @w_valor_nuevo = 'SI'

print 'VALIDA SALIDA POR PAGO CREDITO ANTERIOR: ' + @w_valor_nuevo + '--Monto: ' + convert(varchar(30), @w_monto) +
      '--INSTANCIA DE PROCESO: ' + convert(varchar(30), @i_id_inst_proc)
	
--insercion en estrucuturas de variables

if @i_id_asig_act is null
  select @i_id_asig_act = 0

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
  update cob_workflow..wf_variable_actual
     set va_valor_actual = @w_valor_nuevo 
   where va_id_inst_proc = @i_id_inst_proc
     and va_codigo_var   = @i_id_variable    
end
else
begin
  insert into cob_workflow..wf_variable_actual
         (va_id_inst_proc, va_codigo_var, va_valor_actual)
  values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )

end
--print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc AND
                    mv_codigo_var= @i_id_variable AND
                    mv_id_asig_act = @i_id_asig_act)
begin
    insert into cob_workflow..wf_mod_variable
           (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act,
            mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
    values (@i_id_inst_proc, @i_id_variable, @i_id_asig_act,
            @w_valor_ant, @w_valor_nuevo , getdate())
			
	if @@error > 0
	begin
            --registro ya existe
			
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file = @t_file, 
          @t_from = @t_from,
          @i_num = 2101002
    return 1
	end 

end

go
