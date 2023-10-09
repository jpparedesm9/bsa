use cob_workflow
go

IF OBJECT_ID ('sp_aprobar_tramite') IS NOT NULL
	DROP PROCEDURE sp_aprobar_tramite
GO
/*************************************************************************/
/*   Archivo:            sp_aprobar_tramite.sp                           */
/*   Stored procedure:   sp_aprobar_tramite                              */
/*   Base de datos:      cob_workflow                                    */
/*   Producto:           Originación			                         */
/*   Disenado por:       VBR                                             */
/*   Fecha de escritura: 09/01/2017                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier acion o agregado hecho por alguno de sus                  */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este procedimiento almacenado, cambia el estado del trámite  a A    */
/*   en una actividad automática                                         */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA               AUTOR                       RAZON               */
/*   09-01-2017          VBR                   Emision Inicial           */
/*************************************************************************/

go
CREATE PROCEDURE sp_aprobar_tramite
	    (@s_ssn        int         = null,
	     @s_ofi        smallint,
	     @s_user       login,
         @s_date       datetime,
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
DECLARE
@w_error          			int,
@w_return          			int,
@w_tramite         			int,
@w_codigo_proceso  			int,
@w_version_proceso 			int,
@w_cliente					INT,
@w_codigo_tramite           CHAR(50),
@w_sp_name                  VARCHAR(30)


select @w_sp_name = 'sp_aprobar_tramite'

select @w_tramite = convert(int, io_campo_3),
	   @w_codigo_proceso = io_codigo_proc,
	   @w_version_proceso = io_version_proc,
	   @w_codigo_tramite  = io_campo_3
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

/*** Estado A para el trámite, estado Aprobado ***/

UPDATE cob_credito..cr_tramite
SET tr_estado = 'A'
WHERE tr_tramite = @w_tramite

       IF @@ERROR <> 0 
       BEGIN 
           SELECT @o_id_resultado = 3, -- Error
           @w_error = @@ERROR
           GOTO ERROR
       END
                          
select @o_id_resultado = 1 --OK
  
return 0
ERROR:
    exec cobis..sp_cerror @t_from = @w_sp_name, @i_num = @w_error
    return @w_error
GO
