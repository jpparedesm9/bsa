/*************************************************************************/
/*   Archivo:            sp_validacion_bio_monto.sp                      */
/*   Stored procedure:   sp_validacion_bio_monto                         */
/*   Base de datos:      cob_credito                                     */
/*   Producto:           Crédito                                         */
/*   Disenado por:       MBA                                             */
/*   Fecha de escritura: 18-04-2022                                      */
/*************************************************************************/
/*                             IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "COBISCORP"                                                         */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante.              */
/*************************************************************************/
/*                              PROPOSITO                                */
/*   Este programa se encarga de ejecutar la conversion al formato xml   */
/*************************************************************************/
/*                             OPERACIONES                               */
/*   OPER. OPCION                     DESCRIPCION                        */
/*************************************************************************/
/*                           MODIFICACIONES                              */
/*   FECHA         AUTOR          RAZON                                  */
/*   28-04-2022    Sonia Rojas    Emisión Inicial                        */
/*************************************************************************/
USE cob_credito
go

IF OBJECT_ID ('dbo.sp_validacion_bio_monto') IS NOT NULL
    DROP PROCEDURE dbo.sp_validacion_bio_monto
GO

create proc sp_validacion_bio_monto (
   @s_ssn            int         = null,
   @s_ofi            smallint,
   @s_user           login,
   @s_date           datetime,
   @s_srv            varchar(30) = null,
   @s_term           descripcion = null,
   @s_rol            smallint    = null,
   @s_lsrv           varchar(30) = null,
   @s_sesn           int         = null,
   @s_org            char(1)     = null,
   @s_org_err        int         = null,
   @s_error          int         = null,
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
   @i_id_empresa     int, 
   @o_id_resultado   smallint  out
)as
declare 
@w_sp_name           varchar(64),
@w_error             int,
@w_toperacion        varchar(100),
@w_tramite           int,
@w_monto             money,
@w_ente              int     = 0,
@w_resultado_monto   varchar(255),
@w_cliente           int = 0,
@w_promocion         varchar(2),
@w_integrantes       int,
@w_integ_reg_bio     int,
@w_op_anterior       varchar(24)

select @w_sp_name 	= 'sp_validacion_bio_monto'

select 
@w_ente               = io_campo_1,
@w_tramite            = io_campo_3,
@w_toperacion         = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc


select @w_op_anterior = op_anterior from cob_cartera..ca_operacion where op_tramite = @w_tramite

if ( @w_toperacion = 'GRUPAL' and @w_op_anterior is not null ) begin
   select @w_toperacion = 'RENOVACION'
end

if ( @w_toperacion = 'GRUPAL' or @w_toperacion = 'RENOVACION') begin
      
   while 1 = 1 begin
   
      select top 1
	  @w_monto         = tg_monto,
	  @w_cliente       = tg_cliente,
	  @w_promocion     = case tr_promocion when 'S' then 'SI' else 'NO' end
	  from cr_tramite_grupal, cr_tramite
	  where tg_tramite = tr_tramite
	  and   tg_tramite = @w_tramite
	  and   tg_monto > 0
	  and   tg_participa_ciclo = 'S'
	  and   tg_cliente > @w_cliente
	  order by tg_cliente asc
	  
	  if @@rowcount = 0 break	  
	  
	  exec @w_error    = cob_credito..sp_respuesta_val_bio
	  @s_ssn           = @s_ssn,           
	  @s_ofi           = @s_ofi,            
	  @s_user          = @s_user,           
	  @s_date          = @s_date,           
	  @s_srv           = @s_srv,            
	  @s_term          = @s_term,           
	  @s_rol           = @s_rol,            
	  @s_lsrv          = @s_lsrv,           
	  @s_sesn          = @s_sesn,          
	  @t_debug         = @t_debug,          
	  @t_file          = @t_file,           
	  @t_from          = @t_from,          
	  @i_toperacion    = @w_toperacion,     
	  @i_promocion     = @w_promocion,
	  @i_monto         = @w_monto,          
	  @i_ente          = @w_cliente,           
	  @i_id_inst_proc  = @i_id_inst_proc   
	  
	  if @w_error <> 0 goto ERROR
   
   end
   
    --valida el numero de integrantes
	  select @w_integrantes = count(1)
	  from cr_tramite_grupal, cr_tramite
	  where tg_tramite = tr_tramite
	  and   tg_tramite = @w_tramite
	  and   tg_monto > 0
	  and   tg_participa_ciclo = 'S'

    --registros clientes exognerado
    select @w_integ_reg_bio	 = count(1) 
	from cobis..cl_respuesta_bio 
	where rb_inst_proc = @i_id_inst_proc
	and rb_aprobado_por_monto = 'S'
	
    if ( @w_integrantes = @w_integ_reg_bio) begin
        select @o_id_resultado = 10 -- NO -- NO VA A BIOMETRICO
        return 0
    end

end else if (@w_toperacion = 'REVOLVENTE') begin

   exec @w_error = cob_cartera..sp_ejecutar_regla
   @s_ssn          = @s_ssn,
   @s_ofi          = @s_ofi,
   @s_user         = @s_user,
   @s_date         = @s_date,
   @s_srv          = @s_srv,
   @s_term         = @s_term,
   @s_rol          = @s_rol,
   @s_lsrv         = @s_lsrv,
   @s_sesn         = @s_ssn,
   @i_regla        = 'LCRCUPINI',
   @i_id_inst_proc = @i_id_inst_proc,
   @o_resultado1   = @w_resultado_monto out
   
   if @w_error <> 0 goto ERROR   
   
   select @w_monto = cast(isnull(@w_resultado_monto, '0') as money)
   
   exec @w_error    = cob_credito..sp_respuesta_val_bio
   @s_ssn           = @s_ssn,           
   @s_ofi           = @s_ofi,            
   @s_user          = @s_user,           
   @s_date          = @s_date,           
   @s_srv           = @s_srv,            
   @s_term          = @s_term,           
   @s_rol           = @s_rol,            
   @s_lsrv          = @s_lsrv,           
   @s_sesn          = @s_sesn,          
   @t_debug         = @t_debug,          
   @t_file          = @t_file,           
   @t_from          = @t_from,          
   @i_toperacion    = @w_toperacion,     
   @i_promocion     = @w_promocion,
   @i_monto         = @w_monto,          
   @i_ente          = @w_ente,           
   @i_id_inst_proc  = @i_id_inst_proc

   if @w_error <> 0 goto ERROR    
end else begin
   select @w_monto = op_monto
   from cob_cartera..ca_operacion
   where op_tramite = @w_tramite   
   
   exec @w_error    = cob_credito..sp_respuesta_val_bio
   @s_ssn           = @s_ssn,           
   @s_ofi           = @s_ofi,            
   @s_user          = @s_user,           
   @s_date          = @s_date,           
   @s_srv           = @s_srv,            
   @s_term          = @s_term,           
   @s_rol           = @s_rol,            
   @s_lsrv          = @s_lsrv,           
   @s_sesn          = @s_sesn,          
   @t_debug         = @t_debug,          
   @t_file          = @t_file,           
   @t_from          = @t_from,          
   @i_toperacion    = @w_toperacion,     
   @i_promocion     = @w_promocion,
   @i_monto         = @w_monto,          
   @i_ente          = @w_ente,           
   @i_id_inst_proc  = @i_id_inst_proc
   
   if @w_error <> 0 goto ERROR 

end

select @o_id_resultado = 11 --SI -- VA A BIOMETRICO
return 0

ERROR:
return @w_error

GO