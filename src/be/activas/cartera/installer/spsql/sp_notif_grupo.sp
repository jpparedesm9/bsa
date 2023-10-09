/************************************************************************/
/*  Archivo:                sp_notif_grupo.sp           				*/
/*  Stored procedure:       sp_notif_grupo               				*/
/*  Base de Datos:          cob_workflow                                */
/*  Producto:               cob_workflow                                */
/*  Disenado por:           E. Báez                                     */
/*  Fecha de Documentacion: 26/AGO/2019                                 */
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
/*  Permite determinar si el cliente cumple con todas las validaciones  */
/*  requeridas para acceder a un crédito revolvente                     */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 21/AGO/2019    JHCH              Emision Inicial                     */
/* **********************************************************************/

use cob_workflow
go
if exists (select 1 from sysobjects where name = 'sp_notif_grupo')
   drop proc sp_notif_grupo
go
go
create proc sp_notif_grupo
        (@s_ssn           int          = null,
         @s_ofi           smallint,    
         @s_user          login,       
         @s_date          datetime,    
         @s_srv           varchar(30)  = null,
         @s_term          descripcion  = null,
         @s_rol           smallint     = null,
         @s_lsrv          varchar(30)  = null,
         @s_sesn          int          = null,
         @s_org           char(1)      = NULL,
         @s_org_err       int          = null,
         @s_error         int          = null,
         @s_sev           tinyint      = null,
         @s_msg           descripcion  = null,
         @t_rty           char(1)      = null,
         @t_trn           int          = null,
         @t_debug         char(1)      = 'N',
         @t_file          varchar(14)  = null,
         @t_from          varchar(30)  = null,
         --variables
         @i_id_inst_proc  int		    ,    --codigo de instancia del proceso
         @i_id_inst_act   int		   =0,
         @i_id_empresa    int		   =0,
         @o_id_resultado  smallint  out
)as
declare
@w_ente            int,
@w_banco           varchar(30),
@w_return          int,
@w_email_body      varchar(1000),
@w_cod_oficial     smallint,
@w_tramite         int,
@w_nombre          varchar(50),
@w_mail_oficial    varchar(30),
@w_cod_alterno     varchar(50),
@w_grupal          char(1),
@w_tmail           varchar(10),
@w_cliente         int,
@w_grupo           int,
@w_sp_name         varchar(32),
@w_correo          varchar(64),
@w_ttramite        varchar(255),
@w_error_1         int,
@w_error_2         int,
@w_fecha           datetime,
@w_p_apellido      varchar(64),
@w_s_apellido      varchar(64),
@w_registro_id     varchar(100),
@w_msg             varchar(255)

select @w_sp_name='sp_notif_grupo'

select @w_ente       = convert(int,io_campo_1),
	   @w_tramite    = convert(int,io_campo_3),
	   @w_ttramite   = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc


--llamada a sp de apertura de línea de crédito revolvente

if @w_ttramite = 'GRUPAL'
begin
    print 'Se va inicialziar la ejecucion del sp sp_lcr_ingresar_registro '	
	exec @w_error_2 = cob_credito..sp_lcr_ingresar_registro 
	@i_id_inst_proc	= @i_id_inst_proc, 
	@o_registro_id	= @w_registro_id output, 
	@o_msg        	= @w_msg output     
	
	if(@w_error_2 <> 0)
	begin		
		exec cobis..sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 1,
			@i_msg   = 'ERROR:EN LA TAREA AUTOMATICA DE WORKFLOW'
		return 1		
	end
	set @o_id_resultado = 1
	return 0
end
else
begin
set @o_id_resultado = 1
return 0
end

set @o_id_resultado = 1
return 0
go










