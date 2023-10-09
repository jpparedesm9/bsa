/************************************************************************/
/*   Archivo:              sp_sync_document_col.sp                      */
/*   Stored procedure:     sp_sync_document_col.sp                      */
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
/*      26/03/2019     AINCA            Emision Inicial                 */
/*      27/09/2019     AINCA            Sincronizacion masiva           */
/*      30/06/2021     SRO              Error #161777                   */
/************************************************************************/
use cob_credito
go
if OBJECT_ID ('sp_sync_document_col') is not null
	drop procedure sp_sync_document_col
go

create proc sp_sync_document_col (
    @i_oficial 	int
)

as
declare
@w_sp_name             varchar(32),
@w_accion              varchar(255),
@w_observacion         varchar(255),
@w_cod_entidad		   smallint,
@w_des_entidad         varchar(64),
@w_fecha_proceso       datetime,
@w_actividad		   int,
@w_user				   login,
@w_codigo              int,
@w_error               int,
@w_msg                 varchar(100),
@w_count_proces        int,
@w_inst_process        int,
@w_inst_activity       int,
@w_tramite             int,
@w_nombre_actividad    varchar(50),
@w_tipo_solicitud      varchar(50),
@w_id_inst_act_parent  int,
@w_aa_id_asig_act      int

set @w_sp_name='sp_sync_document_col'
set @w_accion='COMPLETAR DOCUMENTOS'
set @w_observacion='POR SINCRONIZACION DE DISPOSITIVO'
set @w_count_proces = 0

select @w_nombre_actividad = pa_char
from cobis..cl_parametro
where pa_nemonico = 'ETACFC' --CAPTURAR FIRMAS Y CUESTIONARIO

if @@rowcount = 0 begin
   select @w_error = 2108063
   goto ERROR
end 

select @w_tipo_solicitud = 'REVOLVENTE'

select @w_des_entidad = valor , @w_cod_entidad = codigo
from cobis..cl_catalogo
where tabla = ( select codigo  from cobis..cl_tabla
                where tabla = 'si_sincroniza') 
				and valor = 'FIRMAS Y CUESTIONARIO COLECTIVO'
				
if @w_des_entidad is null
begin
    select @w_error = 109004 -- ERROR EN INSERCION,
    select @w_msg = 'No existe entidad FIRMAS Y CUESTIONARIO COLECTIVO'
    goto ERROR
end

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
    select @w_error = 151091 -- ERROR EN INSERCION,
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
and io_campo_4          = @w_tipo_solicitud
and ac_nombre_actividad = @w_nombre_actividad 
and us_login            = @w_user
order by io_id_inst_proc

-- Cantidad de registros en la actividad para el oficial a sincronizar de la tabla @tabla
select @w_count_proces =  count(*) from @tabla

if  @w_count_proces  > 0
begin   
   --Secuencial
   exec 
   @w_error     = cobis..sp_cseqnos
   @t_debug     = 'N',
   @t_file      = null,
   @t_from      = @w_sp_name,
   @i_tabla     = 'si_sincroniza',
   @o_siguiente = @w_codigo out
   
   if @w_error <> 0 begin
      goto ERROR
   end
   
   if not exists (select 1 from cob_sincroniza..si_sincroniza where si_secuencial = @w_codigo) begin
      insert into cob_sincroniza..si_sincroniza 
      (si_secuencial,si_cod_entidad,si_des_entidad,si_usuario,si_estado,si_fecha_ing,si_fecha_sin,si_num_reg)
      values 
      (@w_codigo, @w_cod_entidad,@w_des_entidad,@w_user,'P',@w_fecha_proceso,null,@w_count_proces)
      
      if @@error <> 0
      begin
         select @w_error = 150000 -- ERROR EN INSERCION
         select @w_msg = 'Insertar en si_sincroniza'
         goto ERROR
      end
   end else begin
      select @w_error = 2108087, @w_msg = 'ERROR: YA EXISTE UNA SINCRONIZACION CON ESTE SECUENCIAL ' + convert(varchar, @w_codigo)
      print @w_msg
      goto ERROR	
   end
   
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
	  
	  select @w_id_inst_act_parent = id_inst_act_parent 
      from cob_workflow..wf_inst_actividad 
      where ia_id_inst_act = @w_inst_activity
      
      select @w_aa_id_asig_act  = aa_id_asig_act
      from cob_workflow..wf_asig_actividad
      where  aa_id_inst_act     = @w_id_inst_act_parent 

	  -- Observaciones
      select @w_observacion = @w_observacion + ' ' + ol_texto
      from cob_workflow..wf_observaciones OB, cob_workflow..wf_ob_lineas OL
      where OB.ob_id_asig_act = OL.ol_id_asig_act
      and ob_id_asig_act      = @w_aa_id_asig_act
      
      select @w_observacion = isnull(@w_observacion,'FIRMAS Y CUESTIONARIO COLECTIVO')
         
      print 'seccion ejecucion del sp que genera el xml'
      -- Insert en si_sincroniza_det
      exec @w_error      = sp_xml_doc_cuest_col_det
      @i_id_inst_proc    = @w_inst_process,
      @i_id_inst_act     = @w_inst_activity,
      @i_secuencial      = @w_codigo,
	  @i_observacion     = @w_observacion
      
      if @w_error <> 0
      begin
         select 
         @w_error = @@error,
         @w_msg = 'Al ejecutra sp_xml_doc_cuest_col_det'
         goto  ERROR
      end
	  
   end
   
end
else
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
