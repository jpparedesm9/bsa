/************************************************************************/
/*   Archivo:              sp_sync_verificar_datos.sp                   */
/*   Stored procedure:     sp_sync_verificar_datos.sp                   */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         Sonia Rojas                                  */
/*   Fecha de escritura:   10/09/2019                                   */
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
/*   El programa sincroniza la etapa de documentos lcr del              */
/*   oficial que recibe como parámetro			                        */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      26/03/2019     SRO              Emision Inicial                 */
/************************************************************************/
use cob_credito
go
if OBJECT_ID ('sp_sync_verificar_datos') is not null
	drop procedure sp_sync_verificar_datos
go

create proc sp_sync_verificar_datos (
    @i_oficial 	int
)

as
declare
@w_sp_name                     varchar(32),
@w_accion                      varchar(255),
@w_observacion                 varchar(255),
@w_cod_entidad		           smallint,
@w_des_entidad                 varchar(64),
@w_fecha_proceso               datetime,
@w_actividad		           int,
@w_user				           login,
@w_codigo                      int,
@w_error                       int,
@w_msg                         varchar(100),
@w_count_proces                int,
@w_inst_process                int,
@w_inst_activity               int,
@w_tramite                     int,
@w_nombre_actividad            varchar(50)

declare @w_tipo_solicitud      table(
   tipo                        varchar(30)
)

set @w_sp_name='sp_sync_verificar_datos'
set @w_accion='COMPLETAR DOCUMENTOS'
set @w_observacion='POR SINCRONIZACION DE DISPOSITIVO'
set @w_count_proces = 0

select @w_nombre_actividad = pa_char
from cobis..cl_parametro
where pa_nemonico = 'ETAVDA' --VERIFICAR DATOS

if @@rowcount = 0 begin
   select @w_error = 2108063
   goto ERROR
end 

insert into @w_tipo_solicitud values ('REVOLVENTE')
insert into @w_tipo_solicitud values ('INDIVIDUAL')

select @w_fecha_proceso = fp_fecha 
from cobis..ba_fecha_proceso

select @w_actividad = ac_codigo_actividad 
from cob_workflow..wf_actividad 
where ac_nombre_actividad = @w_nombre_actividad

select @w_user = fu_login
from  cobis..cl_funcionario
where fu_funcionario = @i_oficial

if @w_user is null
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'No existe el Oficial'
    goto ERROR   
end

-- Se guarda en una variable tabla para poder recorrerlo desde un while
declare @tabla table(io_id_inst_proc int ,ia_id_inst_act int,io_campo_3 int )

insert into  @tabla (io_id_inst_proc,ia_id_inst_act,io_campo_3)
select io_id_inst_proc, ia_id_inst_act, io_campo_3      
from cob_workflow..wf_inst_proceso,
cob_workflow..wf_inst_actividad,
cob_workflow..wf_actividad,
cob_workflow..wf_asig_actividad,
cob_workflow..wf_usuario
where ia_id_inst_proc   = io_id_inst_proc
and ia_codigo_act       = ac_codigo_actividad
and aa_id_inst_act      = ia_id_inst_act
and us_id_usuario       = aa_id_destinatario
and io_estado           = 'EJE'
and aa_estado           = 'PEN'
and io_campo_4          in (select tipo from @w_tipo_solicitud)
and ac_nombre_actividad = @w_nombre_actividad 
and us_login            = @w_user
order by io_id_inst_proc

-- Cantidad de registros en la actividad para el oficial a sincronizar de la tabla @tabla
select @w_count_proces =  count(*) from @tabla
   
if  @w_count_proces  > 0
begin     
   select @w_inst_process = 0
   while 1 = 1
   begin
      
      select top 1 
	  @w_inst_process  = io_id_inst_proc,
	  @w_inst_activity = ia_id_inst_act
      from @tabla
	  where io_id_inst_proc > @w_inst_process
      order by io_id_inst_proc asc
	      										   
	  if @@rowcount = 0 break 
         
      -- Insert en si_sincroniza_det
      exec @w_error      = cob_credito..sp_xml_cuestionario 
      @i_inst_proc       = @w_inst_process,
	  @i_modo            = 0
      
      if @w_error <> 0
      begin
         select 
         @w_error = @@error,
         @w_msg = 'Al ejecutra sp_xml_cuestionario'
         goto  ERROR
      end   
	  
   end 
end else
begin
   print 'El oficial ' + convert(varchar(25),@w_user) + ' no tiene sincronizacion de documentos pendiente'
end

return 0

ERROR:
begin 
	exec cobis..sp_cerror
  		@t_debug = 'N',
   		@t_file  = 'S',
   		@t_from  = @w_sp_name,
   		@i_num   = @w_error,
      	@i_msg   = @w_msg
    return @w_error
end

GO
