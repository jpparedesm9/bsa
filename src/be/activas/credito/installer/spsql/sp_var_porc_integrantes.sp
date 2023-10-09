/************************************************************************/
/*  Archivo:                sp_var_porc_integrantes.sp                  */
/*  Stored procedure:       sp_var_porc_integrantes                     */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 26/Ago/2019                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBOSCORP",representantes exclusivos para el Ecuador de la         */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de COBISCORP o su representante               */
/************************************************************************/
/*          PROPOSITO                                                   */
/*  Permite determinar si los integrantes de un grupo promo tienen      */
/*  experiencia crediticia o es un emprededor                           */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 26/Ago/2019   P. Ortiz             Emision Inicial                   */
/* 29/Oct/2020   S. Rojas             Mejoras                           */
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_porc_integrantes')
	drop proc sp_var_porc_integrantes
GO


CREATE PROC sp_var_porc_integrantes(
@s_ssn            int         = null,
@s_ofi            smallint    = null,
@s_user           login       = null,
@s_date           datetime    = null,
@s_srv		      varchar(30) = null,
@s_term	          descripcion = null,
@s_rol		      smallint    = null,
@s_lsrv	          varchar(30) = null,
@s_sesn	          int 	      = null,
@s_org		      char(1)     = NULL,
@s_org_err        int 	      = null,
@s_error          int 	      = null,
@s_sev            tinyint     = null,
@s_msg            descripcion = null,
@t_rty            char(1)     = null,
@t_trn            int         = null,
@t_debug          char(1)     = 'N',
@t_file           varchar(14) = null,
@t_from           varchar(30) = null,
--variables
@i_id_inst_proc   int,    --codigo de instancia del proceso
@i_id_inst_act    int,    
@i_id_asig_act    int,
@i_id_empresa     int, 
@i_id_variable    smallint )
as
declare  
@w_sp_name       	   varchar(32),
@w_return        	   int,
---var variables	   
@w_valor_ant      	   varchar(255),
@w_valor_nuevo    	   varchar(255),
@w_grupo			   int,
@w_ttramite            varchar(255),
@w_tramite             int,
@w_tramite_ant         int,
@w_clientes_act        float,
@w_clientes_ant        float

select @w_sp_name='sp_var_porc_integrantes'

select   
@w_grupo       = convert(int,io_campo_1),
@w_tramite     = convert(int,io_campo_3),
@w_tramite_ant = convert(int,io_campo_5),
@w_ttramite    = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_grupo = isnull(@w_grupo,0)
if @w_grupo = 0 return 0

declare @clientes_ant as table(
   cliente     int primary key
)

if @w_ttramite = 'GRUPAL'
begin
	
	/* Clientes tramite anterior */
	insert into @clientes_ant
	select tg_cliente
	from cob_credito..cr_tramite_grupal
	where tg_grupo = @w_grupo
	and tg_tramite = @w_tramite_ant
	and tg_participa_ciclo = 'S'
   
   select @w_clientes_ant = count(*) from @clientes_ant
   
   /* Clientes tramite actual*/
	select @w_clientes_act = count(*)
	from cob_credito..cr_tramite_grupal, @clientes_ant
	where tg_grupo = @w_grupo
	and tg_cliente = cliente
	and tg_tramite = @w_tramite
	and tg_participa_ciclo = 'S'
	
	/* Clientes tramite actual pertenecientes al anterior mas 1 */
	select @w_clientes_act = @w_clientes_act - 1
	
	if @w_clientes_ant = 0
	   select @w_valor_nuevo = 0
	else
	   select @w_valor_nuevo = round(((@w_clientes_act * 100)/ @w_clientes_ant),0)
	--print 'El resultado es: ' + @w_valor_nuevo
end



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
              where mv_id_inst_proc = @i_id_inst_proc and
                    mv_codigo_var= @i_id_variable and
                    mv_id_asig_act = @i_id_asig_act)
BEGIN
   insert into cob_workflow..wf_mod_variable
   (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act,
    mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
   values 
   (@i_id_inst_proc, @i_id_variable, @i_id_asig_act,
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

return 0
go
