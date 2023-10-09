/************************************************************************/
/*  Archivo:                SP_DISTRIBUIDOR_AGE.sp                      */
/*  Stored procedure:       SP_DISTRIBUIDOR_AGENCIA                     */
/*  Base de Datos:          cob_workflow                                */
/*  Producto:               Credito                                     */
/*  Fecha de Documentacion: 18/Sept/2015                                */
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
/*   Retorna el usuario destinatario considerando el rol                */
/*   Jefes de Agencia  JAG                                              */
/*   Se ejecuta como distribuidor de carga                              */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR           RAZON                                   */
/* **********************************************************************/


use cob_workflow
go

if exists (select 1 from sysobjects where name = 'SP_DISTRIBUIDOR_AGENCIA')
   drop proc SP_DISTRIBUIDOR_AGENCIA
go

create proc SP_DISTRIBUIDOR_AGENCIA
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
   @o_ij_id_item_jerarquia INT out,
   @o_id_destinatario  int out
)
as
  declare @w_cod_resultado      smallint,
          @w_tramite            int,
          @w_oficina            smallint,
          @w_sp_name            varchar(32),
          @w_id_destinatario    int,
          @w_cargo_jag   	tinyint,
          @w_num_act            int


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
select @w_oficina = tr_oficina
from   cob_credito..cr_tramite
where  tr_tramite = @w_tramite

-- Seleccionar el jefe de la agencia-oficina

/*select @w_id_destinatario = us_id_usuario
from cob_workflow..wf_usuario, cobis..cl_funcionario
where fu_oficina = @w_oficina
and us_login = fu_login
and fu_cargo = @w_cargo_jag*/


 select @w_num_act           = min(us_num_act_asignadas)
    from wf_usuario, wf_usuario_rol, cobis..cl_funcionario
   where us_id_usuario        = ur_id_usuario
     and us_login             = fu_login
     and fu_oficina           = @w_oficina
     and ur_id_rol            = @i_id_rol_dest
     and ((us_estado_usuario  = 'ACT') or
          ((us_estado_usuario = 'INA') and
           (ur_id_usuario_sustituto in (select us_id_usuario
                                          from wf_usuario
                                         where us_estado_usuario = 'ACT'))))


select @w_id_destinatario = us_id_usuario
from cob_workflow..wf_usuario, cobis..cl_funcionario
where fu_oficina = @w_oficina
and us_login = fu_login
and fu_login in (select isnull(us_login,(select us_login from wf_usuario where us_id_usuario = US.us_id_usuario_sustituto)) 
                 from wf_usuario_rol UR, wf_usuario US 
                 where ur_id_rol  = @i_id_rol_dest
                 and ur_id_usuario= us_id_usuario
                 and us_estado_usuario = 'ACT')
                 and (us_id_usuario in (select us_id_usuario
                                       from wf_usuario
                                       where us_id_usuario in (select ur_id_usuario
                                                                from wf_usuario_rol
                                                                where ur_id_rol = @i_id_rol_dest)
                                       and us_estado_usuario    = 'ACT'
                                       --and us_id_usuario        != @i_id_destinatario
                                       and us_num_act_asignadas = @w_num_act) 
                  or us_id_usuario in (select us_id_usuario_sustituto from wf_usuario
                                       where us_id_usuario in (select ur_id_usuario
                                                               from wf_usuario_rol
                                                               where ur_id_rol = @i_id_rol_dest)
                                       and us_estado_usuario = 'INA'
                                       and us_id_usuario_sustituto is not null
                                       --and us_id_usuario       != @i_id_destinatario
                                       and us_num_act_asignadas = @w_num_act))
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
