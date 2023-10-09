/************************************************************/
/*   ARCHIVO:         sp_sincroniza_solicitud_ind.sp        */
/*   NOMBRE LOGICO:   sp_sincroniza_solicitud_ind           */
/*   PRODUCTO:        COBIS WORKFLOW                        */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*    Envia la sincronización de la solicitud individual    */ 
/*    en una actividad automática                           */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/* 02/Agosto/2017   VBR                 Emision Inicial     */
/************************************************************/
use cob_workflow
go
if exists (select 1 from sysobjects where name = 'sp_sincroniza_solicitud_ind')
   drop proc sp_sincroniza_solicitud_ind
go
create proc sp_sincroniza_solicitud_ind
        (@s_ssn        int         = null,
	     @s_ofi        smallint    = null,
	     @s_user       login       = null,
         @s_date       datetime    = null,
	     @s_srv		   varchar(30) = null,
	     @s_term	   descripcion = null,
	     @s_rol		   smallint    = null,
	     @s_lsrv	   varchar(30) = null,
	     @s_sesn	   int 	       = null,
	     @s_org		   char(1)     = NULL,
		 @s_org_err    int 	       = null,
         @s_error      int 	       = null,
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
	   	 @i_id_empresa   int, 
		 @o_id_resultado  smallint  out
)as
declare
         @w_error INT,
         @w_sp_name VARCHAR(30)

SELECT @w_sp_name = 'sp_sincroniza_solicitud_ind'

-- Ejecuta la sincronización de los datos de la solicitud grupal 
EXEC @w_error = cob_credito..sp_individual_xml
     @i_inst_proc = @i_id_inst_proc
     
    IF @w_error <> 0 
       BEGIN 
           SELECT @o_id_resultado = 2, -- Error
           @w_error = @@ERROR

       END

set @o_id_resultado = 1  --OK

return 0
ERROR:
    exec cobis..sp_cerror @t_from = @w_sp_name, @i_num = @w_error
    return @w_error
GO
