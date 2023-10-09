/************************************************************************/
/*  Archivo:                SP_DISTRIBUIDOR_CUESTIONARIO.sp             */
/*  Stored procedure:       SP_DISTRIBUIDOR_CUESTIONARIO                */
/*  Base de Datos:          cob_workflow                                */
/*  Producto:               Credito                                     */
/*  Fecha de Documentacion: 15/Mar/2023                                 */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la AT&T       */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus usuario   */
/*  sin el debido consentimiento por escrito de la Presidencia          */
/*  Ejecutiva de MACOSA o su representante                              */
/************************************************************************/
/*                          PROPOSITO                                   */
/*   Retorna el usuario destinatario considerando los roles de WORKFLOW */
/*   Se ejecuta como distribuidor de carga                              */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA       AUTOR           RAZON                                   */
/* **********************************************************************/


use cob_workflow
go

if exists (select 1 from sysobjects where name = 'SP_DISTRIBUIDOR_CUESTIONARIO')
   drop proc SP_DISTRIBUIDOR_CUESTIONARIO
go

create proc SP_DISTRIBUIDOR_CUESTIONARIO
(
   @s_ssn        int         = null,
   @s_ofi        smallint    = null,
   @s_user       login       = null,
   @s_date       datetime    = null,
   @s_srv		 varchar(30) = null,
   @s_term	     descripcion = null,
   @s_rol		 smallint    = null,
   @s_lsrv	     varchar(30) = null,
   @s_sesn	     int 	     = null,
   @s_org		 char(1)     = NULL,
   @s_org_err    int 	     = null,
   @s_error      int 	     = null,
   @s_sev        tinyint     = null,
   @s_msg        descripcion = null,
   @t_rty        char(1)     = null,
   @t_trn        int         = null,
   @t_debug      char(1)     = 'N',
   @t_file       varchar(14) = null,
   @t_from       varchar(30) = null,
   @i_id_inst_proc     int,
   @i_id_inst_act      int,
   @i_id_empresa       int,
   @i_id_proceso       smallint, --->>>este
   @i_version_proc     smallint,
   @i_id_actividad     int,
   @i_oficina_asig     smallint,
   @i_id_rol_dest      int = null,--->>rol a enviar
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
          @w_cargo_jag   	    tinyint,
          @w_num_act            int,
          @w_id_rol_regla       int,
          @w_login_cen          login,
          @w_oficial            int,
          @w_oficial_superior   int,
          @w_id_rol_param_coord int,
		  @w_ij_id_item_jerarquia   int

--El numero de tramite siempre se guarda en el io_campo_3
select @w_tramite = io_campo_3 
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

if @w_tramite = 0 
begin
   print 'No existe tramite a procesar'
   return 0
end

select @w_id_rol_param_coord = pa_int --4
from cobis..cl_parametro 
where pa_nemonico = 'CDWCOO' and pa_producto = 'CRE'

--Toma el valor del rol resultado de la regla -- se llenara en la variable Aplica Cuestionario en el flujo
select @w_id_rol_regla = null

select @w_id_rol_regla = convert(int, va_valor_actual)
from cob_workflow..wf_variable_actual
where va_codigo_var   in (select vb_codigo_variable
  from cob_workflow..wf_variable
 where vb_abrev_variable = 'ROLWF')
and va_id_inst_proc = @i_id_inst_proc

--El valor que ingresa es cero porque en este sp se le asignara un destinario
if(@w_id_rol_regla > 0)
    select @i_id_rol_dest = @w_id_rol_regla

-- Selecciona la oficina del tramite
select @w_oficina = tr_oficina,
       @w_oficial = tr_oficial
from   cob_credito..cr_tramite
where  tr_tramite = @w_tramite

print '-->>@i_id_rol_dest: ' + convert(varchar, @i_id_rol_dest)
print '-->>@w_id_rol_param: ' + convert(varchar, @w_id_rol_param_coord)
print '-->>@w_oficina: ' + convert(varchar, @w_oficina)
print '-->>@w_oficial: ' + convert(varchar, @w_oficial)

if (@i_id_rol_dest = @w_id_rol_param_coord) begin --Para coordinadores
	-->Retorna el id del usuario a asignar la tarea
    print '-->>Ingreso a Coordinador el proceso: ' + convert(varchar, @i_id_inst_proc)	
    begin try
		exec cob_workflow..SP_DISTRIBUIDOR_COOR
             @i_id_inst_proc     = @i_id_inst_proc,
             @i_id_inst_act      = 0,
             @i_id_empresa       = 1,
             @i_id_proceso       = 0,
             @i_version_proc     = 0,
             @i_id_actividad     = 0,
             @i_oficina_asig     = 0,
             @i_id_rol_dest      = 0,
             --@i_id_destinatario  int = null, -- su uso esta comentando en el sp
          	 @o_ij_id_item_jerarquia = @w_ij_id_item_jerarquia out,
             @o_id_destinatario  = @w_id_destinatario out
    end try
    begin catch
        print 'Error en el distribuidor SP_DISTRIBUIDOR_CUESTIONARIO en CUESTIONARIO'
    end catch
	
	select @w_id_destinatario = @w_id_destinatario
	
end else begin
    print '-->>Ingreso a Gerente el proceso: ' + convert(varchar, @i_id_inst_proc)
    --Listado de usuarios por oficina segUn el cargo.
    select  @w_id_destinatario = us_id_usuario
    from cob_workflow..wf_usuario, wf_usuario_rol, 
         cob_workflow..wf_rol, cobis..cl_funcionario
    where us_id_usuario = ur_id_usuario
    and ur_id_rol = ro_id_rol
    and ur_id_rol = @i_id_rol_dest
    and us_estado_usuario    = 'ACT'
    and us_login = fu_login
    and fu_oficina = @w_oficina
end

print 'Sale el id_destinatario: ' + convert(varchar, @w_id_destinatario)
		
if @w_id_destinatario is not null begin
   select @o_id_destinatario = @w_id_destinatario
end else
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
