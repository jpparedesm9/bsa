/************************************************************/
/*   ARCHIVO:         sp_valida_cancelacion.sp              */
/*   NOMBRE LOGICO:   sp_valida_cancelacion                 */
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
/*   Es un sp que se utiliza en una etapa automática para   */
/*   identificar que se seleccionó la opción de cancelar    */
/*   Con esto permite al grupo volver a solicitar un crédito*/
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/* 30/Enero/2017   VBR                 Emision Inicial      */
/************************************************************/
use cob_workflow
go
if exists (select 1 from sysobjects where name = 'sp_valida_cancelacion')
   drop proc sp_valida_cancelacion
go
create proc sp_valida_cancelacion
        (@s_ssn        int         = null,
         @s_ofi        smallint,
         @s_user       login,
         @s_date       datetime,
         @s_srv        varchar(30) = null,
         @s_term       descripcion = null,
         @s_rol        smallint    = null,
         @s_lsrv       varchar(30) = null,
         @s_sesn       int         = null,
         @s_org        char(1)     = NULL,
         @s_org_err    int         = null,
         @s_error      int         = null,
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
@w_return          INT

set @o_id_resultado = 1

return 0

go





