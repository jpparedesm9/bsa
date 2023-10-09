/************************************************************************/
/*  Archivo:                sp_var_es_renovacion.sp                     */
/*  Stored procedure:       sp_var_es_renovacion                        */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 16/Sep/2019                                 */
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
/*  Identifica si un tramite grupal/individual es renovacion            */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 16/Sep/2019   P. Ortiz             Emision Inicial                   */
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_es_renovacion')
	drop proc sp_var_es_renovacion
GO


CREATE PROC sp_var_es_renovacion
		(@s_ssn        int         = null,
	    @s_ofi        smallint    = null,
	    @s_user       login       = null,
       @s_date       datetime    = null,
	    @s_srv		   varchar(30) = null,
	    @s_term	      descripcion = null,
	    @s_rol		   smallint    = null,
	    @s_lsrv	      varchar(30) = null,
	    @s_sesn	      int 	      = null,
	    @s_org		   char(1)     = NULL,
		 @s_org_err    int 	      = null,
       @s_error      int 	      = null,
       @s_sev        tinyint     = null,
       @s_msg        descripcion = null,
       @t_rty        char(1)     = null,
       @t_trn        int         = null,
       @t_debug      char(1)     = 'N',
       @t_file       varchar(14) = null,
       @t_from       varchar(30) = null,
       --variables
		 @i_id_inst_proc int,    --codigo de instancia del proceso
		 @i_id_inst_act  int,    
		 @i_id_asig_act  int,
		 @i_id_empresa   int, 
		 @i_id_variable  smallint 
		 )
as
declare  @w_sp_name       	   varchar(32),
         @w_return        	   int,         
         @w_valor_ant      	varchar(255),
         @w_valor_nuevo    	varchar(255),
         @w_grupo			      int,
         @w_ttramite          varchar(255),
         @w_ciclo             int

select @w_sp_name='sp_var_es_renovacion'

select   @w_grupo    = convert(int,io_campo_1),
	      @w_ttramite = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_grupo = isnull(@w_grupo,0)
if @w_grupo = 0 return 0

if @w_ttramite = 'GRUPAL'
begin
	select top 1 @w_ciclo = isnull(ci_ciclo, 0)
	from cob_cartera..ca_ciclo 
	where ci_grupo = @w_grupo
	order by ci_ciclo desc
	
	if (@w_ciclo >= 1)
	   select @w_valor_nuevo = 'SI'
	else
	   select @w_valor_nuevo = 'NO'
end
else
begin
   select @w_ciclo = isnull(en_nro_ciclo,0)
   from cobis..cl_ente
   where en_ente = @w_grupo
	
	if (@w_ciclo >= 1)
	   select @w_valor_nuevo = 'SI'
	else
	   select @w_valor_nuevo = 'NO'
end
print 'Es renovacion: ' + @w_valor_nuevo

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
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
--print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc and
                    mv_codigo_var= @i_id_variable and
                    mv_id_asig_act = @i_id_asig_act)
BEGIN
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

return 0
go
