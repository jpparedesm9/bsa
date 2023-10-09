/************************************************************************/
/*   Archivo:              SP_DIST_ASIST_COLECT.sp                      */
/*   Stored procedure:     SP_DIST_ASIST_COLECT                         */
/*   Base de datos:        cob_workflow                                 */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Sonia Rojas                                  */
/*   Fecha de escritura:   09 Diciembre 2019                            */
/************************************************************************/
/*   IMPORTANTE                                                         */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/* MODIFICACIONES                                                       */
/************************************************************************/

use cob_workflow
go
 
if exists (select 1 from sysobjects where name = 'SP_DIST_ASIST_COLECT')
   drop proc SP_DIST_ASIST_COLECT
go

CREATE PROCEDURE [dbo].[SP_DIST_ASIST_COLECT]
(
   @s_ssn                       int         =  null,
   @s_ofi                       smallint    =  null,
   @s_user                      login       =  null,
   @s_date                      datetime    =  null,
   @s_srv		                varchar(30) =  null,
   @s_term	   				    descripcion =  null,
   @s_rol		   			    smallint    =  null,
   @s_lsrv	   				    varchar(30) =  null,
   @s_sesn	   				    int 	    =  null,
   @s_org		                char(1)     =  NULL,
   @s_org_err                   int 	    =  null,
   @s_error                     int 	    =  null,
   @s_sev                       tinyint     =  null,
   @s_msg                       descripcion =  null,
   @t_rty                       char(1)     =  null,
   @t_trn                       int         =  null,
   @t_debug                     char(1)     =  'N',
   @t_file                      varchar(14) =  null,
   @t_from                      varchar(30) =  null,
   @i_id_inst_proc              int,
   @i_id_inst_act               int,
   @i_id_empresa                int,
   @i_id_proceso                smallint,
   @i_version_proc              smallint,
   @i_id_actividad              int,
   @i_oficina_asig              smallint,
   @i_id_rol_dest               int,
   @i_id_destinatario           int = null,
   @i_ij_id_item_jerarquia      INT = NULL,
   @o_ij_id_item_jerarquia      int out,
   @o_id_destinatario           int out
)
as
declare 
@w_cod_resultado      smallint,
@w_cod_cli            int,
@w_funcionario        int,
@w_sp_name            varchar(32),
@w_id_destinatario    int
    
select @w_sp_name = 'SP_DIST_ASIST_COLECT'

select @w_funcionario = cc_funcionario
from cob_cartera..ca_colectivo_cargo
where cc_rol          =  'ANALISTA ADMINISTRATIVO'


select @w_id_destinatario   = us_id_usuario
from cob_workflow..wf_usuario, cobis..cl_funcionario
where fu_funcionario        = @w_funcionario 
and   us_login              = fu_login
and   us_estado_usuario     = 'ACT'


if @w_id_destinatario is not null
   select @o_id_destinatario = @w_id_destinatario
else
begin
	--No se puede determinar siguiente estacion de trabajo
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 2101033
    return 1 
end

return 0

GO
