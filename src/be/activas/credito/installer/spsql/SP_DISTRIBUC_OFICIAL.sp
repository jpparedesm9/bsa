/************************************************************************/
/*  Archivo:                SP_DISTRIBUIDOR_OFICIAL.sp                  */
/*  Stored procedure:       SP_DISTRIBUIDOR_OFICIAL                     */
/*  Base de Datos:          cob_workflow                                */
/*  Producto:               Credito                                     */
/*  Fecha de Documentacion: 12/Sept/2017                                */
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
/*   Retorna el usuario que es oficial del crédito como destinatario de */
/*   la actividad en el flujo                                           */
/*   Se ejecuta como distribuidor de carga                              */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR           RAZON                                   */
/* **********************************************************************/


use cob_workflow
go

if exists (select 1 from sysobjects where name = 'SP_DISTRIBUIDOR_OFICIAL')
   drop proc SP_DISTRIBUIDOR_OFICIAL
go

create proc SP_DISTRIBUIDOR_OFICIAL
(
   @s_ssn        int         = null,
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
   @i_id_inst_proc     int,
   @i_id_inst_act      int,
   @i_id_empresa       int,
   @i_id_proceso       smallint,
   @i_version_proc     smallint,
   @i_id_actividad     int,
   @i_oficina_asig     smallint,
   @i_id_rol_dest      int,
   @i_id_destinatario  int = null,
   @i_ij_id_item_jerarquia INT = NULL,
   @o_ij_id_item_jerarquia int out,
   @o_id_destinatario  int out
)
as
  declare @w_cod_resultado      smallint,
          @w_tramite            int,
          @w_oficial            INT,
          @w_sp_name            varchar(32),
          @w_id_destinatario    int
    


--El nœmero de trÿmite siempre se guarda en el io_campo_3
select @w_tramite = io_campo_3 
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

if @w_tramite = 0 
begin
   print 'No existe tramite a procesar'
   return 0
end

--select @w_cargo_jag = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'JEFAGE' and pa_producto = 'APR'

-- Selecciona la oficina del tramite 
select @w_oficial = tr_oficial
from   cob_credito..cr_tramite
where  tr_tramite = @w_tramite


select @w_id_destinatario = us_id_usuario
from cob_workflow..wf_usuario, cobis..cl_funcionario, cobis..cc_oficial
where oc_oficial = @w_oficial 
and oc_funcionario = fu_funcionario
and us_login = fu_login
and us_estado_usuario    = 'ACT'


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
go
