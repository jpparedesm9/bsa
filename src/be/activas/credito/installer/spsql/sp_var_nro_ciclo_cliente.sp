/************************************************************************/
/*  Archivo:                sp_var_nro_ciclo_cliente.sp                 */
/*  Stored procedure:       sp_var_nro_ciclo_cliente                    */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           VBR                                         */
/*  Fecha de Documentacion: 03/Ago/2017                                 */
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
/* Procedure tipo Variable, Retorna SI si el grupo acepta renovar el    */
/* crédito                                                              */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR           RAZON                                   */
/*  03/Ago/2017 VBR             Emision Inicial                         */
/* **********************************************************************/
use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_nro_ciclo_cliente')
	drop proc sp_var_nro_ciclo_cliente
go



create proc sp_var_nro_ciclo_cliente
		(@s_ssn        int         = null,
	    @s_ofi        smallint    = null,
	    @s_user       login       = null,
       @s_date       datetime    = null,
	    @s_srv		   varchar(30) = null,
	    @s_term	      descripcion = null,
	    @s_rol		   smallint    = null,
	    @s_lsrv	      varchar(30) = null,
	    @s_sesn	      int 	      = null,
	    @s_org		   char(1)     = null,
		 @s_org_err    int 	      = null,
       @s_error      int 	      = null,
       @s_sev        tinyint     = null,
       @s_msg        descripcion = null,
       @t_rty        char(1)     = null,
       @t_trn        int         = null,
       @t_debug      char(1)     = 'N',
       @t_file       varchar(14) = null,
       @t_from       varchar(30)  = null,
         --variables
		 @i_id_inst_proc int,    --codigo de instancia del proceso
		 @i_id_inst_act  int,    
		 @i_id_asig_act  int,
		 @i_id_empresa   int, 
		 @i_id_variable  smallint 
		 )
as
declare @w_sp_name       	varchar(32),
        @w_return        	int,
        ---var variables	
        @w_asig_actividad 	int,
        @w_valor_ant      	varchar(255),
        @w_valor_nuevo    	varchar(255),
        @w_actividad      	catalogo,
        @w_cliente       	int,
        @w_ttramite        varchar(255),
        @w_ciclo           int,
        @w_tramite         int,
        @w_est_novigente   int,
        @w_est_anulado     int,
        @w_est_credito     int
         

select @w_sp_name='sp_var_nro_ciclo_cliente'

select @w_cliente = convert(int,io_campo_1),
      @w_tramite = convert(int,io_campo_3),
      @w_ttramite = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_cliente = isnull(@w_cliente,0)

if @w_cliente = 0 return 0

exec cob_externos..sp_estados
@i_producto      = 7,
@o_est_novigente = @w_est_novigente out,
@o_est_anulado   = @w_est_anulado out,
@o_est_credito   = @w_est_credito out

select @w_est_novigente = isnull(@w_est_novigente, 0),
@w_est_anulado = isnull(@w_est_anulado, 6),
@w_est_credito = isnull(@w_est_credito, 99)

if @w_ttramite = 'INDIVIDUAL'
begin
   select @w_ciclo = count(*) from cob_cartera..ca_operacion 
   where op_cliente = @w_cliente
   and op_toperacion = @w_ttramite
   and op_tramite <> @w_tramite
   and op_estado not in (@w_est_novigente, @w_est_anulado, @w_est_credito)
   
   if @w_ciclo < 0 or @w_ciclo is null
      select @w_valor_nuevo = 0
   else
      select @w_valor_nuevo = @w_ciclo
end
else
begin
   select @w_valor_nuevo  = convert(varchar(5),isnull(en_nro_ciclo,0))
   from cobis..cl_ente
   where en_ente = @w_cliente
end

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

END

return 0
go

