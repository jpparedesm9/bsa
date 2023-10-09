/************************************************************************/
/*  Archivo:                sp_notif_renovacion_lcr.sp                  */
/*  Stored procedure:       sp_notif_renovacion_lcr                     */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Paul Ortiz Vera                             */
/*  Fecha de Documentacion: 29/Ene/2019                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*          PROPOSITO                                                   */
/*  Ejecuta el envio de la notificacion de renovacion al cliente para   */
/*  una Linea de Credito Revolvente                                     */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/*29/Ene/2019  P. Ortiz Vera           Emision Inicial                  */
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_notif_renovacion_lcr')
	drop proc sp_notif_renovacion_lcr
go


create proc sp_notif_renovacion_lcr
        (@s_ssn          int         = null,
	     @s_ofi          smallint    = null,
	     @s_user         login       = null,
         @s_date         datetime    = null,
	     @s_srv          varchar(30) = null,
	     @s_term	     descripcion = null,
	     @s_rol          smallint    = null,
	     @s_lsrv	     varchar(30) = null,
	     @s_sesn	     int 	     = null,
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
         @i_id_inst_proc int,    --codigo de instancia del proceso
		 @i_id_inst_act  int,    
	   	 @i_id_empresa   int, 
		 @o_id_resultado  smallint  out
)
as
declare @w_sp_name       	    varchar(32),
        @w_return        	    INT,
        ---var variables	
        @w_ente                 int,
        @w_error                int,
        @w_tramite       	    int,
        @w_tramite_ant     	    int,
        @w_ttramite             varchar(255),
        @w_banco                cuenta,
        @w_registro_id 			varchar(100),
        @w_msg           		varchar(255),
        @w_fecha              varchar(10),
        @w_renovacion         varchar(24),
        @w_dias_ven           int
	    
       
print 'Inicio Paul'

select @w_sp_name='sp_notif_renovacion_lcr'

select @w_ente       = convert(int,io_campo_1),
	   @w_tramite    = convert(int,io_campo_3),
	   @w_tramite_ant= convert(int,io_campo_5),
	   @w_ttramite   = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

/* Tipo de mensaje */
select @w_renovacion = 'RENO_LCR'--'RENO_LCR' ES PARA RENOVACION

/* Obtengo banco */
select @w_banco = op_banco 
from cob_cartera..ca_operacion
where op_tramite = @w_tramite_ant

/* Obtener dias de vencimiento */
select @w_dias_ven = tm_dias_vigencia from cob_bvirtual..bv_b2c_tipo_msg where tm_tipo_msg= 'RENO_LCR'

/* Fecha Proceso */
select @w_fecha = convert(varchar, dateadd(dd,@w_dias_ven,fp_fecha), 103) from cobis..ba_fecha_proceso 

select @w_error = 0

if @w_ttramite = 'REVOLVENTE'
begin
	print 'Antes de ejecutar msg_ingresar'
	
	exec @w_error = cob_bvirtual..sp_b2c_msg_ingresar 
	@i_cliente  = @w_ente, 
	@i_banco    = @w_banco, 
	@i_tipo_msg = @w_renovacion, 
	@i_var1     = @w_fecha
    
	if @@error <> 0 or @w_error <> 0 
    begin
		return 2109113
	end
	
	select @o_id_resultado = 1
end
else
begin
	select @o_id_resultado = 3
end

return 0
go


