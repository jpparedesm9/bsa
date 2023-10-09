/*************************************************************************/  
/*   Archivo:              sp_santander_cuenta_buc_job.sp	             */
/*   Stored procedure:     sp_santander_cuenta_buc_job                   */
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
/*   Programa para Consultar Job de Cuenta y Buc Santander               */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    14/Enero/2019          SRO               Emision inicial           */
/*                                                                       */
/*************************************************************************/
USE cob_credito
go

IF OBJECT_ID ('dbo.sp_santander_cuenta_buc_job') IS NOT NULL
	DROP PROCEDURE dbo.sp_santander_cuenta_buc_job
GO

create procedure sp_santander_cuenta_buc_job (
   @i_operacion            char(1),
   @i_ente                 int     = null,
   @i_tramite              int     = null,
   @i_tiene_cta_buc        char(1) = 'N'--(S)i o (N)o
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
@w_intentos                int,
@w_dias_intento            INT,
@w_commit                  CHAR(1) = 'N'

select @w_sp_name = 'cob_credito..sp_santander_cuenta_buc_job'
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso



if @i_operacion = 'Q' begin
   
   
   select @w_intentos = pa_int 
   from cobis..cl_parametro
   where pa_nemonico = 'NICBS'
   
   select @w_intentos = isnull(@w_intentos,4)
   
   select @w_dias_intento = pa_int 
   from cobis..cl_parametro
   where pa_nemonico = 'NDCBS'
   
   select @w_dias_intento = isnull(@w_dias_intento,4)   
   
   select 
   cbs_ente,
   cbs_tramite
   into #tramites
   from cr_cuenta_buc_santander_job
   where cbs_intentos <= @w_intentos
   and   datediff(dd, cbs_fecha_ult_intento, @w_fecha_proceso) > @w_dias_intento
   and   cbs_estado   in ('I', 'P') 
   
   insert into #tramites
   select cbs_ente, cbs_tramite
   from cr_cuenta_buc_santander_job
   where cbs_intentos = 0
   and   cbs_estado   = 'I'
   
   select * from #tramites
   
   RETURN 0
end

if @i_operacion = 'U' begin


   if @i_ente is null or @i_tramite is null begin
      select @w_error = 2108073
	  goto ERROR
   end   
   
   select @w_oficina = tr_oficina 
   from cob_credito..cr_tramite 
   where tr_tramite  = @i_tramite
   
   select 
   @w_intentos_buc_cta     = cbs_intentos + 1,
   @w_nro_dias_ult_intento = datediff(dd, cbs_fecha_ult_intento,@w_fecha_proceso)
   from cob_credito..cr_cuenta_buc_santander_job
   where cbs_estado         IN ('I','P') --'Pediente'
   and   cbs_tramite        = @i_tramite
   
   select @w_id_inst_proc = io_id_inst_proc
   from cob_workflow..wf_inst_proceso
   where io_campo_3 = @i_tramite
   
   if @@rowcount = 0 begin
      print 'ERROR: NO EXISTE UNA INSTANCIA DE PROCESO PARA EL TRAMITE '+ convert(varchar,@i_tramite)
      select @w_error = 2108073
      goto ERROR
   end
      
   select @w_var_intento = vb_codigo_variable 
   from cob_workflow..wf_variable
   where vb_abrev_variable = 'INTCTABUC'
   
   if @@rowcount = 0 begin
      select @w_error = 2108071
      goto ERROR
   END
   
   IF @w_commit = 'N' begin
      SELECT @w_commit = 'S'
      begin TRAN
   END
    
   update cob_workflow..wf_variable_actual set
   va_valor_actual         = convert(varchar, @w_intentos_buc_cta)
   where va_id_inst_proc   = @w_id_inst_proc
   and   va_codigo_var     = @w_var_intento   
   
   
   select @w_var_dias_ult_intento = vb_codigo_variable 
   from cob_workflow..wf_variable
   where vb_abrev_variable = 'DIASULTINT'
   
   if @@rowcount = 0 begin
      select @w_error = 2108072
      goto ERROR
   end
   
   update cob_workflow..wf_variable_actual set
   va_valor_actual         = convert(varchar, @w_nro_dias_ult_intento)
   where va_id_inst_proc   = @w_id_inst_proc
   and   va_codigo_var     = @w_var_dias_ult_intento 
						   
   if @i_tiene_cta_buc = 'S' begin
      update cob_credito..cr_cuenta_buc_santander_job set
      cbs_intentos          = @w_intentos_buc_cta,
      cbs_fecha_ult_intento = @w_fecha_proceso,
      cbs_estado            = 'T' --'Terminado, tiene cuenta y buc Santander'
      where cbs_tramite     = @i_tramite 
	     
      if @@error <> 0 begin	  
         select @w_error = 2108070
         goto ERROR
      end
	  
	  
	  exec @w_ssn = ADMIN...rp_ssn
      IF @w_ssn = 0 BEGIN
         select @w_error = 710225, @w_msg = 'ERROR AL GENERAR SSN PARA EL CREDITO COLECTIVO'
         goto ERROR
      END
	  
	  
	  PRINT 'ANTES RUTEO'
	  exec @w_error =    cob_cartera..sp_ruteo_actividad_wf  
      @s_ssn              =   @w_ssn, 
      @s_user             =   'usrbatch',
      @s_sesn             =   @w_ssn,
      @s_term             =   'JOB-CTS',
      @s_date             =   @w_fecha_proceso,
      @s_srv              =   'CTSSRV',
      @s_lsrv             =   'CTSSRV',
      @s_ofi              =   @w_oficina,     
      @i_tramite          =   @i_tramite, 
      @i_param_etapa      =  'ETACCB',
      @i_pa_producto      =  'CRE'
         
      if @w_error <> 0 begin
         select 
         @w_msg = 'ERROR AL EJECUTAR PROCESO RUTEO DE ACTIVIDAD AUTOMATICA: ' + convert(varchar,@i_tramite)      
       
         goto ERROR 
      end  	
	  
	  PRINT 'DESPUES RUTEO'
      
   end
   if @i_tiene_cta_buc = 'N' begin
   
      if exists (select 1 from cob_credito..cr_cuenta_buc_santander_job    
                 where cbs_intentos = 4 
	   	         and   cbs_estado = 'P' 
                 and   cbs_tramite  = @i_tramite) BEGIN
 
         update cob_credito..cr_cuenta_buc_santander_job set
         cbs_estado            = 'F',--'Fallido se terminaron los intentos'
         cbs_intentos          = cbs_intentos
         where cbs_tramite     = @i_tramite 
	     
	     
	     if @@error <> 0 begin	  
	        select @w_error = 2108070
	        goto ERROR
	     end 
		 
		 select @w_mail_cliente = di_descripcion
         from cobis..cl_direccion 
         where di_ente = @i_ente
         and   di_tipo = 'CE'
         	 
         select @w_oficial = tr_oficial 
         from cr_tramite 
         where tr_tramite = @i_tramite
         
         select @w_mail_oficial  = mf_descripcion
         from cobis..cl_medios_funcio, cobis..cl_funcionario, cobis..cc_oficial
         where mf_funcionario = fu_funcionario
         and   fu_funcionario = oc_funcionario
         and   oc_oficial     = @w_oficial
         
         select @w_id = te_id 
         from   cobis..ns_template
         where  te_nombre = 'NotifNoCtaSantander.xslt'
	  
         -- creacion xml con el buc que tiene relacion con el template
         select @w_email_body = '<?xml version="1.0" encoding="ISO-8859-1"?><data></data>'
	     
         -- Ejecucion del sp para las notificaciones y envio de mail
         exec @w_error =  cobis..sp_despacho_ins
         @i_cliente          = @i_ente,
         @i_template         = @w_id,
         @i_servicio         = 1,
         @i_estado           = 'P',
         @i_tipo             = 'MAIL',
         @i_tipo_mensaje     = 'I',
         @i_prioridad        = 1,
         @i_from             = null,
         @i_to               = @w_mail_cliente,
         @i_cc               = @w_mail_oficial,
         @i_bcc              = null,
         @i_subject          = 'NOTIFICACION AUTOMATICA - Solicitud Declinada',
         @i_body             = @w_email_body,
         @i_content_manager  = 'HTML',
         @i_retry            = 'S',
         @i_fecha_envio      = null,
         @i_hora_ini         = null,
         @i_hora_fin         = null,
         @i_tries            = 0,
         @i_max_tries        = 2,
         @i_var1             = null	
         
         if @w_error <> 0 begin
             select @w_msg = 'ERROR AL ENVIAR NOTIFICACION DEL CLIENTE '+convert(varchar(100),@i_ente),
                    @w_error = 5000
             goto ERROR
         end   
	     
	     print 'El cliente '+ convert(VARCHAR,@i_ente) + ' con tramite '+convert(VARCHAR,@i_tramite) + ' no tiene cuenta ni buc en Santander (Finaliza intentos)'
	     GOTO FINALIZA
      end
   	  
      update cob_credito..cr_cuenta_buc_santander_job set
      cbs_intentos          = @w_intentos_buc_cta,
      cbs_fecha_ult_intento = @w_fecha_proceso,
      cbs_estado            = 'P' --'Pediente'
      where cbs_tramite     = @i_tramite 
	     
      if @@error <> 0 begin	  
         select @w_error = 2108070
         goto ERROR
      end
	  
	  
   end
   
   
end


GOTO FINALIZA

ERROR:

IF @w_commit = 'S'
   rollback tran
   
exec cobis..sp_cerror 
@t_from = @w_sp_name, 
@i_num = @w_error, 
@i_msg = @w_msg

RETURN @w_error

FINALIZA:

IF @w_commit = 'S'
   commit tran

RETURN 0
GO

