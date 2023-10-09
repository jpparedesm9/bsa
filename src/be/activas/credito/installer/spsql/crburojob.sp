/*************************************************************************/  
/*   Archivo:              sp_buro_ln_nf_job.sp          	             */
/*   Stored procedure:     sp_buro_ln_nf_job                             */
/*   Base de datos:        cob_credito                                   */
/*   Producto:             Crédito                                       */
/*   Disenado por:         Sonia Rojas                                   */
/*   Fecha de escritura:   Enero 2019                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Programa para Buro en Colectivos.                                   */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    14/Enero/2019          SRO               Emision inicial           */
/*                                 -                                      */
/*************************************************************************/
use cob_credito
go

IF OBJECT_ID ('dbo.sp_buro_ln_nf_job') IS NOT NULL
	DROP PROCEDURE dbo.sp_buro_ln_nf_job
GO

create procedure sp_buro_ln_nf_job (
   @i_operacion            char(1),
   @i_ente                 int     = null,
   @i_tramite              int     = null,
   @i_tiene_buro           char(1) = 'N'--(S)i o (N)o
)as

declare
@w_msg                     varchar(255),
@w_sp_name                 varchar(50),
@w_ente                    int,
@w_tramite                 int,
@w_ssn                     int,
@w_oficina                 int,
@w_id_inst_proc            int,
@w_intentos_buc_cta        int,
@w_fecha_ult_intento       datetime,
@w_nro_dias_ult_intento    int,
@w_var_intento             int,
@w_var_dias_ult_intento    int,
@w_fecha_proceso           datetime,
@w_error                   int,
@w_mail_cliente            varchar(255),
@w_mail_oficial            varchar(255),
@w_email_body              varchar(255),
@w_oficial                 int,
@w_id                      int,
@w_resultado_ln            smallint,
@w_resultado_nf            smallint,
@w_novedades               varchar(2),
@w_sesn                    int

select @w_sp_name = 'cob_credito..sp_santander_cuenta_buc_job'


if @i_operacion = 'Q' begin
   
   select 
   bj_ente,
   bj_tramite
   from cr_buro_ln_nf_job
   where bj_estado   in ('I', 'P') 
end

if @i_operacion = 'U' begin

   if @i_ente is null or @i_tramite is null begin
      select @w_error = 2108073
	  goto ERROR
   end
   begin tran
   
   
   select @w_novedades = 'NO'
   select @w_fecha_ult_intento = getdate()
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
   
   select @w_id_inst_proc = io_id_inst_proc
   from cob_workflow..wf_inst_proceso
   where io_campo_3 = @i_tramite
   
   if @@rowcount = 0 begin
      print 'ERROR: NO EXISTE UNA INSTANCIA DE PROCESO PARA EL TRAMITE '+ convert(varchar,@i_tramite)
      select @w_error = 2108073
      goto ERROR
   end   
   

   exec @w_error   = sp_li_negra_cliente
   @i_ente         = @i_ente,
   @o_resultado    = @w_resultado_ln output
   
   if @w_error <> 0 begin
      goto ERROR
   end   
   
   exec @w_error   = sp_negative_file
   @i_ente         = @i_ente,
   @o_resultado    = @w_resultado_nf output   
   
   if @w_error <> 0 begin
      goto ERROR
   end
   
   if @w_resultado_ln <> 1 or @w_resultado_nf <> 1 begin
      select @w_novedades  = 'SI'
   end
            
   update cob_credito..cr_buro_ln_nf_job set
   bj_novedades_ln_nf  = @w_novedades,
   bj_estado           = 'T' --'Terminado, tiene cuenta y buc Santander'
   where bj_tramite    = @i_tramite 
	     
   if @@error <> 0 begin	  
      select @w_error = 2108070
      goto ERROR
   end	  
	  
   exec @w_ssn = cob_cartera..sp_gen_sec 
   @i_operacion  = -1

   exec @w_sesn = cob_cartera..sp_gen_sec 
   @i_operacion  = -1
  
   exec @w_error =    cob_cartera..sp_ruteo_actividad_wf  
   @s_ssn              =   @w_ssn, 
   @s_user             =   'usrbatch',
   @s_sesn             =   @w_sesn,
   @s_term             =   'JOB-CTS',
   @s_date             =   @w_fecha_proceso,
   @s_srv              =   'CTSSRV',
   @s_lsrv             =   'CTSSRV',
   @s_ofi              =   @w_oficina,     
   @i_tramite          =   @i_tramite, 
   @i_param_etapa      =  'ETABLN',
   @i_pa_producto      =  'CRE',
   @i_actualiza_var    =  'S'
   
      
   if @w_error <> 0 begin 
      select 
      @w_msg = 'ERROR AL EJECUTAR PROCESO RUTEO DE ACTIVIDAD AUTOMATICA: ' + convert(varchar,@i_tramite)      
    
      goto ERROR 
   end 
   
   commit tran
   
   
end


return 0

ERROR:

if @@trancount > 0 
   rollback tran
   
exec cobis..sp_cerror 
@t_from = @w_sp_name, 
@i_num = @w_error, 
@i_msg = @w_msg

return @w_error

GO

