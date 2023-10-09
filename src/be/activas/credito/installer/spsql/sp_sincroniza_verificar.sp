/************************************************************/
/*   ARCHIVO:         sp_sincroniza_verificar.sp            */
/*   NOMBRE LOGICO:   sp_sincroniza_verificar_datos         */
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
/*    Envia la sincronización de la solicitud en una        */
/*    actividad automática                                  */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/* 17/Agosto/2017  VBR                 Emision Inicial      */
/************************************************************/
use cob_workflow
go
if exists (select 1 from sysobjects where name = 'sp_sincroniza_verificar_datos')
   drop proc sp_sincroniza_verificar_datos
go
create proc sp_sincroniza_verificar_datos
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

SELECT @w_sp_name = 'sp_sincroniza_verificar_datos'

select 
@w_tramite        = isnull(io_campo_3,0),
@w_toperacion     = io_campo_4
FROM cob_workflow..wf_inst_proceso
WHERE io_id_inst_proc = @i_id_inst_proc

IF @w_tramite = 0 RETURN 0

if(@w_toperacion = 'GRUPAL')
    SELECT @w_nombre_actividad = 'APLICAR CUESTIONARIO - GRP'

if(@w_toperacion = 'INDIVIDUAL')
    SELECT @w_nombre_actividad = 'APLICAR CUESTIONARIO - IND'

if(@w_toperacion = 'REVOLVENTE')--REVOLVENTE COLECTIVO
    SELECT @w_nombre_actividad = 'VERIFICAR DATOS'

if not exists(select 1 from cob_credito..cr_tr_sincronizar where ti_tramite = @w_tramite and ti_seccion = @w_nombre_actividad)
BEGIN
    print '1...'
    EXEC @w_error       = cob_credito..sp_actividad_sincroniza 
    @i_tramite          = @w_tramite,
    @i_nombre_actividad = @w_nombre_actividad,
    @t_trn              = 2174,
    @i_operacion        ='I',
    @s_srv              = @s_srv,
    @s_user             = @s_user,
    @s_term             = @s_term,
    @s_ofi              = @s_ofi,
    @s_rol              = @s_rol,
    @s_ssn              = @s_ssn,
    @s_lsrv             = @s_lsrv,
    @s_date             = @s_date,
    @s_sesn             = @s_sesn,
    @s_org              ='U',
    @s_culture          ='es_EC'
         
   IF @w_error <> 0 BEGIN 
      SELECT 
      @o_id_resultado = 3, -- Error
      @w_error = @@ERROR
      GOTO ERROR
   END
END

EXEC @w_error       = cob_credito..sp_actividad_sincroniza 
@i_tramite          = @w_tramite,
@i_nombre_actividad = @w_nombre_actividad,
@i_sincroniza       = 'N',
@t_trn              = 2174,
@i_operacion        ='U',
@s_srv              = @s_srv,
@s_user             = @s_user,
@s_term             = @s_term,
@s_ofi              = @s_ofi,
@s_rol              = @s_rol,
@s_ssn              = @s_ssn,
@s_lsrv             = @s_lsrv,
@s_date             = @s_date,
@s_sesn             = @s_sesn,
@s_org              ='U',
@s_culture          ='es_EC'
     
IF @w_error <> 0 BEGIN 
print @w_error
   SELECT 
   @o_id_resultado = 3, -- Error
   @w_error = @@ERROR
   GOTO ERROR
END


EXEC @w_error = cob_credito..sp_xml_cuestionario 
@i_inst_proc  = @i_id_inst_proc,
@i_modo       = 1

     
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
GO
