use cob_workflow
go
if exists (select 1 from sysobjects
            where name = 'sp_reasigna_actividad_wf')
begin
  -- print 'ELIMINANDO EL PROCEDIMIENTO sp_reasigna_actividad_wf'
  drop procedure sp_reasigna_actividad_wf
end
go
-- print 'CREANDO EL PROCEDIMIENTO sp_reasigna_actividad_wf'
go
/************************************************************/
/*   ARCHIVO:         wf_reasigna_actividad.sp              */
/*   NOMBRE LOGICO:   sp_reasigna_actividad_wf              */
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
/*  Reasigna la actividad a otro usuario.                   */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA        AUTOR             RAZON                   */
/*   05-Jul-2001  Mario Valarezo A. Emision Inicial.        */
/************************************************************/
create procedure sp_reasigna_actividad_wf
(
  @s_ssn                int,
  @s_user               varchar(30),
  @s_sesn               int,
  @s_term               varchar(30),
  @s_date               datetime,
  @s_srv                varchar(30),
  @s_lsrv               varchar(30),
  @s_ofi                smallint,
  @t_trn                int,
  @t_debug              char(1)     = 'N',
  @t_file               varchar(14) = null,
  @t_from               varchar(30) = null,

  @s_rol                smallint    = null,
  @s_org_err            char(1)     = null,
  @s_error              int         = null,
  @s_sev                tinyint     = null,
  @s_msg                descripcion = null,
  @s_org                char(1)     = null,
  @s_service            int         = null,
  @t_rty                char(1)     = null,

  @i_id_inst_act        int,
  @i_id_asig_act        int,
  @i_id_proceso         smallint    = null,
  @i_version_proc       smallint    = null,
  @i_id_actividad       int		    = null,
  @i_id_usuario         int,
  @i_id_rol             int,
  @i_id_oficina         smallint,
  
    -- Campos para comentarios
  
  @i_sub_operacion      char(1)      = null,
  @i_numero             smallint     = null,
  @i_categoria          varchar(10)  = null,
  @i_oficial            char(1)      = null,
  @i_linea              smallint     = null,
  @i_texto              varchar(255) = null,
  @i_texto_completo     varchar(600) = null,
  @i_delete_temp_obs	char(1)	     = 'N',

  @o_siguiente          int         = null out
)
As declare
  @w_sp_name            varchar(64),
  @w_id_asig_act        int,
  @w_retorno            int,
  @w_id_destinatario    int,           -- OGU 18/09/2015 No permitir reasignación al mismo usuario
  @aa_estado            varchar(10),   -- OGU 22/09/2015 No permitir reasignación si la tarea ha sido COM
  @w_id_item_jerarquia  int,           -- MCA 25/04/2016 Copia también el id de la jerarquía.
  @w_oficina_inicio     int,
  @w_canal              int
  
select @w_sp_name = 'sp_reasigna_actividad_wf'

if @s_service is not null
begin
	select @w_canal = @s_service
end

if @w_canal is  null
begin
	select @w_canal = -1
end

if @w_oficina_inicio is null
begin
	select @w_oficina_inicio = @s_ofi
end

select @w_id_destinatario = aa_id_destinatario 
	from wf_asig_actividad 
	where aa_id_inst_act = @i_id_inst_act and aa_id_asig_act = @i_id_asig_act

if (@w_id_destinatario = @i_id_usuario) -- OGU 18/09/2015 No permite reasignar al mismo usuario
	begin -- OGU 18/09/2015 No permite reasignar al mismo usuario
            exec cobis..sp_cerror 
                 @t_from = @w_sp_name, 
                 @i_num  = 3107520      --NO ES POSIBLE ASIGNAR, YA QUE FUE ASOCIADO PREVIAMENTE CON LA MISMA INFORMACION.    
            return 1 
	end -- OGU 18/09/2015 No permite reasignar al mismo usuario
else 
	begin	-- OGU 18/09/2015 Si no corresponde al mismo usuario

		select @aa_estado = aa_estado              -- OGU 22/09/2015 Consulta estado de la actividad a rutear
		  from wf_asig_actividad
		 where aa_id_asig_act = @i_id_asig_act
		   and aa_id_inst_act = @i_id_inst_act
	
	if(@aa_estado = 'COM' or @aa_estado = 'REA')   -- OGU 22/09/2015 No permite reasignar si la actividad tiene estado COM
		begin -- OGU 22/09/2015 No permite reasignar si la actividad tiene estado COM
            exec cobis..sp_cerror       
                 @t_from = @w_sp_name, 
                 @i_num  = 3107543      --NO ES POSIBLE RUTEAR, LA ACTIVIDAD YA FUE TERMINADA
            return 1 

		end -- OGU 22/09/2015 No permite reasignar si la actividad tiene estado COM
	else	
		begin -- OGU 22/09/2015 Se realiza la reasignación de la actividad
			begin tran

select @i_id_rol = aa_id_rol, --OGU 20/10/2015 Se obtiene el rol de la actividad que se va a reasignar para mantener el rol 
	   @w_id_item_jerarquia  = aa_id_item_jerarquia --MCA 25/04/2016 Se obtiene el id de la jerarquía para mantenerlo en el momento de reasignar.
from wf_asig_actividad 
 where aa_id_asig_act       = @i_id_asig_act
   and aa_id_inst_act       = @i_id_inst_act


			-- En la tabla asignacion_actividad para el usuario actual cambia el estado a REASIGNADA.
			update wf_asig_actividad
			   set aa_estado            = 'REA',
				   aa_id_usr_reasignado = @i_id_usuario,
				   aa_id_rol_reasignado = @i_id_rol,
				   aa_fecha_fin         = getdate()
			 where aa_id_asig_act       = @i_id_asig_act
			   and aa_id_inst_act       = @i_id_inst_act

			if @@error <> 0
			begin -- Error en la actualizacion de Asignacion.
			  exec cobis..sp_cerror
				   @t_from  = @w_sp_name,
				   @i_num   = 3107506
			  rollback tran
			  return 1
			end

			-- Se actualiza la tabla de Resumenes de Asignacion.
			exec @w_retorno       = sp_m_res_asig_act_wf
				 @s_ssn           = @s_ssn,
				 @s_user          = @s_user,
				 @s_sesn          = @s_sesn,
				 @s_term          = @s_term,
				 @s_date          = @s_date,
				 @s_srv           = @s_srv,
				 @s_lsrv          = @s_lsrv,
				 @s_rol           = @s_rol,
				 @s_ofi           = @s_ofi,
				 @s_org_err       = @s_org_err,
				 @s_error         = @s_error,
				 @s_sev           = @s_sev,
				 @s_msg           = @s_msg,
				 @s_org           = @s_org,
				 @t_rty           = @t_rty,
				 @t_trn           = @t_trn,
				 @t_debug         = @t_debug,
				 @t_file          = @t_file,
				 @t_from          = @t_from,
				 @i_operacion     = 'I',
				 @i_id_inst_act   = @i_id_inst_act,
				 @i_id_asig_act   = @i_id_asig_act,
				 @i_id_proceso    = @i_id_proceso,
				 @i_version_proc  = @i_version_proc,
				 @i_id_actividad  = @i_id_actividad,
				 @i_id_usuario    = @i_id_usuario,
				 @i_id_rol        = @i_id_rol,
				 @i_oficina_inicio= @w_oficina_inicio,
				 @i_canal         = @w_canal

			if @w_retorno <> 0
			begin
			  exec cobis..sp_cerror
				   @i_num  = @w_retorno,
				   @t_from = @w_sp_name
			  rollback tran
			  return 1
			end

			-- En la tabla asignacion_actividad, para el nuevo usuario inserta un nuevo
			-- registro con estado PENDIENTE.  Y actualiza la tabla de Resumenes de Asignacion.
			exec @w_retorno       = sp_m_asig_act_wf
				 @s_ssn           = @s_ssn,
				 @s_user          = @s_user,
				 @s_sesn          = @s_sesn,
				 @s_term          = @s_term,
				 @s_date          = @s_date,
				 @s_srv           = @s_srv,
				 @s_lsrv          = @s_lsrv,
				 @s_rol           = @s_rol,
				 @s_ofi           = @s_ofi,
				 @s_org_err       = @s_org_err,
				 @s_error         = @s_error,
				 @s_sev           = @s_sev,
				 @s_msg           = @s_msg,
				 @s_org           = @s_org,
				 @t_rty           = @t_rty,
				 @t_trn           = @t_trn,
				 @t_debug         = @t_debug,
				 @t_file          = @t_file,
				 @t_from          = @t_from,

				 @i_operacion     = 'I',
				 @i_id_inst_act   = @i_id_inst_act,
				 @i_id_dest       = @i_id_usuario,
				 @i_id_rol        = @i_id_rol,
				 @i_oficina_asig  = @i_id_oficina,
				 @i_id_proceso    = @i_id_proceso,
				 @i_version_proc  = @i_version_proc,
				 @i_id_actividad  = @i_id_actividad,
				 @i_ij_id_item_jerarquia = @w_id_item_jerarquia,
				 @i_oficina_inicio= @w_oficina_inicio,
				 @i_canal         = @w_canal,
				 @i_manual        = 0,
				 @o_siguiente     = @w_id_asig_act out

			if @w_retorno <> 0
			begin
			  exec cobis..sp_cerror
				   @i_num  = @w_retorno,
				   @t_from = @w_sp_name
			  rollback tran
			  return 1
			end

			exec @w_retorno     	   = sp_observacion_asig_wf
							@s_ssn 		           = @s_ssn,
							@s_user		           = @s_user,
							@s_sesn		           = @s_sesn,
							@s_term  	           = @s_term,
							@s_date		           = @s_date,
							@s_srv	               = @s_srv,
							@s_lsrv		           = @s_lsrv,
							@s_ofi	               = @s_ofi,
							@t_trn				   = @t_trn,
							@t_debug			   = @t_debug,
							@t_file				   = @t_file,
							@t_from				   = @t_from,
							@s_rol				   = @s_rol,
							@s_org_err			   = @s_org_err,
							@s_error			   = @s_error,
							@s_sev				   = @s_sev,
							@s_msg				   = @s_msg,
							@s_org				   = @s_org,
							@i_asig_act            = @i_id_asig_act,
							@i_operacion           = 'I',
							@i_sub_operacion       = @i_sub_operacion,
							@i_numero              = @i_numero,
							@i_categoria           = @i_categoria,
							@i_oficial             = @i_oficial,
							@i_linea               = @i_linea,
							@i_texto               = @i_texto,
							@i_texto_completo      = @i_texto_completo,
							@i_delete_temp_obs     = @i_delete_temp_obs
					
						if @w_retorno != 0
						begin
							return @w_retorno
						end


						exec @w_retorno     	   = sp_observacion_asig_wf
							@s_ssn 		           = @s_ssn,
							@s_user		           = @s_user,
							@s_sesn		           = @s_sesn,
							@s_term  	           = @s_term,
							@s_date		           = @s_date,
							@s_srv	               = @s_srv,
							@s_lsrv		           = @s_lsrv,
							@s_ofi	               = @s_ofi,
							@t_trn				   = @t_trn,
							@t_debug			   = @t_debug,
							@t_file				   = @t_file,
							@t_from				   = @t_from,
							@s_rol				   = @s_rol,
							@s_org_err			   = @s_org_err,
							@s_error			   = @s_error,
							@s_sev				   = @s_sev,
							@s_msg				   = @s_msg,
							@s_org				   = @s_org,
							@i_asig_act            = @i_id_asig_act,
							@i_operacion           = 'T',
							@i_sub_operacion       = @i_sub_operacion,
							@i_numero              = @i_numero,
							@i_categoria           = @i_categoria,
							@i_oficial             = @i_oficial,
							@i_linea               = @i_linea,
							@i_texto               = @i_texto,
							@i_texto_completo      = @i_texto_completo,
							@i_delete_temp_obs     = @i_delete_temp_obs
					
						if @w_retorno != 0
						begin
							return @w_retorno
						end

			select @o_siguiente = @w_id_asig_act

			commit tran
		end	 -- OGU 22/09/2015 No permitir reasignación si el estado de la actividad es COM
	end -- OGU 18/09/2015 No permitir reasignación al mismo usuario
return 0
go
