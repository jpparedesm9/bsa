/*************************************************************************/  
/*   Archivo:              sp_validar_cta_buc_santander.sp	             */
/*   Stored procedure:     sp_validar_cta_buc_santander                  */
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
/*   Genera reporte regulatorio baxico desde la sarta 22                 */
/*                                                                       */
/*       Parametros de Entrada                                           */
/*			Fecha de proceso                                             */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    14/Enero/2019          SRO               Emision inicial           */
/*                                                                       */
/*************************************************************************/
USE cob_credito
GO

IF OBJECT_ID ('dbo.sp_validar_cta_buc_santander') IS NOT NULL
	DROP PROCEDURE dbo.sp_validar_cta_buc_santander
GO


create procedure sp_validar_cta_buc_santander (
   @s_ssn          int         = null,
   @s_ofi          smallint    = null,
   @s_user         login       = null,
   @s_date         datetime    = null,
   @s_srv          varchar(30) = null,
   @s_term	       descripcion = null,
   @s_rol          smallint    = null,
   @s_lsrv	       varchar(30) = null,
   @s_sesn	       int 	     = null,
   @s_org          char(1)     = null,
   @s_org_err      int 	     = null,
   @s_error        int 	     = null,
   @s_sev          tinyint     = null,
   @s_msg          descripcion = null,
   @t_rty          char(1)     = null,
   @t_trn          int         = null,
   @t_debug        char(1)     = 'N',
   @t_file         varchar(14) = null,
   @t_from         varchar(30) = null,
   --variables
   @i_id_inst_proc  int,    --codigo de instancia del proceso
   @i_id_inst_act   int,    
   @i_id_empresa    int, 
   @o_id_resultado  smallint  out
)as

declare
@w_sp_name              varchar(50),
@w_ente                 int,
@w_tramite              int,
@w_error                int,
@w_msg                  varchar(255),
@w_fecha_proceso        datetime

select @w_sp_name = 'cob_credito..sp_validar_cta_buc_santander'
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select 
@w_ente    = io_campo_1,
@w_tramite = io_campo_3
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

if @w_ente is null or @w_tramite is null begin
   select @w_error = 2108060
   goto ERROR
end

if not exists (select 1 from cobis..cl_producto_santander where pr_ente = @w_ente) begin
   insert into cob_credito..cr_cuenta_buc_santander_job 
   (cbs_ente, cbs_tramite, cbs_intentos, cbs_fecha_ult_intento, cbs_estado)
   values
   (@w_ente, @w_tramite, 0, @w_fecha_proceso, 'I')  
   
   if @@error <> 0 begin
      print 'ERROR AL INSERTAR EL REGISTRO EN LA TABLA cr_cuenta_buc_santander_job'
      select
	  @w_error = 2108061,
      @w_msg   = 'ERROR: ERROR AL INSERTAR EL REGISTRO EN LA TABLA cr_cuenta_buc_santander_job'	
      goto ERROR	  
   end
   
end


select @o_id_resultado = 1

return 0

ERROR:
   
exec cobis..sp_cerror 
@t_from = @w_sp_name, 
@i_num = @w_error, 
@i_msg = @w_msg

return @w_error

go