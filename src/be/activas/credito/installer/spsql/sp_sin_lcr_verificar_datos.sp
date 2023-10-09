
/************************************************************************/
/*   Archivo:              sp_sin_lcr_verificar_datos.sp                */
/*   Stored procedure:     sp_sin_lcr_verificar_datos                   */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         AINCA                                        */
/*   Fecha de escritura:   11/01/2019                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/* Registra informacion de los documentos  en las tablas                */
/* cob_sincroniza, si_sincroniza y genera el XML si_sincroniza_det      */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      11/01/2019     AINCA             Emision Inicial                */
/************************************************************************/
USE cob_credito
GO

if exists (select 1 from sysobjects where name = 'sp_sin_lcr_verificar_datos')
drop proc sp_sin_lcr_verificar_datos
go

create proc sp_sin_lcr_verificar_datos
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
declare
         @w_error INT,
         @w_sp_name VARCHAR(30),
         @w_tramite  INT,
         @w_nombre_actividad     varchar(30)     = null,
         @w_toperacion          catalogo

SELECT @w_sp_name = 'sp_sin_lcr_verificar_datos'


EXEC @w_error= cob_credito..sp_xml_documentos_lcr 
@i_inst_proc=@i_id_inst_proc

     
    IF @w_error <> 0 
       BEGIN 
           SELECT @o_id_resultado = 3, -- Error
           @w_error = @@ERROR
           GOTO ERROR
       END

set @o_id_resultado = 1  --OK

return 0
ERROR:
    exec cobis..sp_cerror @t_from = @w_sp_name, @i_num = @w_error
    return @w_error