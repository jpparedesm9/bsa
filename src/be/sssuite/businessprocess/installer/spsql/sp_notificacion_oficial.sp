use cob_workflow
go

IF OBJECT_ID ('sp_notificacion_oficial') IS NOT NULL
	DROP PROCEDURE sp_notificacion_oficial
GO
/*************************************************************************/
/*   Archivo:            sp_notificacion_oficial_ori.sp                  */
/*   Stored procedure:   sp_notificacion_oficial                         */
/*   Base de datos:      cob_workflow                                    */
/*   Producto:           Originación			                         */
/*   Disenado por:       VBR                                             */
/*   Fecha de escritura: 19/12/2016                                      */
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
/*   Este procedimiento almacenado, ingresa en una estructura que permite*/
/*   notificar al Oficial que el Cliente está en Lsita Negra             */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA               AUTOR                       RAZON               */
/*   19-12-2016          VBR                   Emision Inicial           */
/*************************************************************************/

go
CREATE PROCEDURE sp_notificacion_oficial
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
@w_sp_name                  VARCHAR(30),
@w_sec                      INT,
@w_nombre					VARCHAR(35),
@w_apellido					VARCHAR(35),
@w_monto                    MONEY



select @w_sp_name = 'sp_notificacion_oficial'

select @w_tramite = convert(int, io_campo_3),
	   @w_codigo_proceso = io_codigo_proc,
	   @w_version_proceso = io_version_proc,
	   @w_codigo_tramite  =  io_campo_3
from wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

/*** Insert en la tabla de contabilidad para el proceso de notificación masiva ***/
SELECT @w_sec = max(ct_secuencial)+1
FROM cob_conta_super..sb_consulta_transacciones 

SELECT @w_cliente  = en_ente,
       @w_nombre   = en_nombre, 		
       @w_apellido = p_p_apellido + ' '+ p_s_apellido, 
       @w_monto    = tr_monto
FROM cob_credito..cr_deudores DEU, cob_credito..cr_tramite, cobis..cl_ente
WHERE de_tramite = @w_tramite
AND de_rol = 'D'
AND de_cliente = en_ente
AND de_tramite = tr_tramite


       INSERT INTO cob_conta_super..sb_consulta_transacciones
       VALUES (
       @w_sec,
       @w_cliente,
       @w_nombre,
       @w_apellido,
       @w_codigo_tramite,
       @w_monto,
       getdate(),
       'APER',
       NULL,
       'G', 
       NULL,
       NULL,
       'N',
       NULL,
       NULL,
       21,
       NULL
       )
   
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
