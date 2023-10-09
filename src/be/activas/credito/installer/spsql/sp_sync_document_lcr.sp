/************************************************************************/
/*   Archivo:              sp_sync_document_lcr.sp                      */
/*   Stored procedure:     sp_sync_document_lcr.sp                      */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         AINCA                                        */
/*   Fecha de escritura:   26/03/2019                                   */
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
/*   oficial que recibe como par�metro			                        */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      26/03/2019     AINCA            Emision Inicial               */
/*      30/06/2021     SRO              Error #161777                   */
/************************************************************************/
USE cob_credito
go
IF OBJECT_ID ('sp_sync_document_lcr') IS NOT NULL
	DROP PROCEDURE sp_sync_document_lcr
GO

CREATE proc sp_sync_document_lcr (
    @i_oficial 	INT
)

AS
DECLARE
@w_sp_name             VARCHAR(32),
@w_accion              VARCHAR(255),
@w_observacion         VARCHAR(255),
@w_cod_entidad		   SMALLINT,
@w_des_entidad         VARCHAR(64),
@w_fecha_proceso       DATETIME,
@w_actividad		   INT,
@w_user				   login,
@w_codigo              INT,
@w_error               INT,
@w_msg                 VARCHAR(100),
@w_count_proces        int,
@w_inst_process        int,
@w_inst_activity       int,
@w_tramite             int,
@w_nombre_actividad    varchar(50),
@w_tipo_solicitud      varchar(50)

SET @w_sp_name='sp_sync_document_lcr'
SET @w_accion='COMPLETAR DOCUMENTOS'
SET @w_observacion='POR SINCRONIZACION DE DISPOSITIVO'
SET @w_count_proces = 0

select @w_nombre_actividad = 'CAPTURAR FIRMAS Y DOCUMENTOS'
select @w_tipo_solicitud = 'REVOLVENTE'

SELECT @w_des_entidad = valor , @w_cod_entidad = codigo
FROM cobis..cl_catalogo
WHERE tabla = ( SELECT codigo  FROM cobis..cl_tabla
                WHERE tabla = 'si_sincroniza') AND valor = 'DOCUMENTOS DIGITALIZADOS LCR'

SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso

SELECT @w_actividad = ac_codigo_actividad 
FROM cob_workflow..wf_actividad 
WHERE ac_nombre_actividad = @w_nombre_actividad

select @w_user = fu_login
from  cobis..cl_funcionario, cobis..cc_oficial
where oc_oficial = @i_oficial 
and oc_funcionario = fu_funcionario

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
FROM cob_workflow..wf_inst_proceso,
cob_workflow..wf_inst_actividad,
cob_workflow..wf_actividad,
cob_workflow..wf_asig_actividad,
cob_workflow..wf_usuario
WHERE ia_id_inst_proc = io_id_inst_proc
and ia_codigo_act = ac_codigo_actividad
and aa_id_inst_act = ia_id_inst_act
and us_id_usuario = aa_id_destinatario
and io_estado = 'EJE'
and aa_estado = 'PEN'
and io_campo_4 = @w_tipo_solicitud
and ac_nombre_actividad = @w_nombre_actividad 
and us_login = @w_user
order by io_id_inst_proc

-- Cantidad de registros en la actividad documentos digitalizados para el oficial a sincronizar de la tabla @tabla
select @w_count_proces =  count(*) from @tabla
  
if  @w_count_proces > 0
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
      INSERT INTO cob_sincroniza..si_sincroniza 
      (si_secuencial,si_cod_entidad,si_des_entidad,si_usuario,si_estado,si_fecha_ing,si_fecha_sin,si_num_reg)
      VALUES 
      (@w_codigo, @w_cod_entidad,@w_des_entidad,@w_user,'P',@w_fecha_proceso,NULL,@w_count_proces)
      
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
   
   while @w_count_proces >0
   begin
      
      select top 1 @w_inst_process=io_id_inst_proc,@w_inst_activity=ia_id_inst_act,@w_tramite=io_campo_3
      from @tabla
      order by io_id_inst_proc
          
      -- contador para salir del while
      select  @w_count_proces = @w_count_proces - 1
      
      -- Insert en si_sincroniza_det
      exec @w_error = sp_xml_documentos_lcr_det
      @i_max_si_sincroniza = @w_codigo,
      @i_inst_proc         = @w_inst_process,
      @i_tramite           = @w_tramite,
      @i_accion            = @w_accion,
      @i_observacion       = @w_observacion,
      @i_inst_actividad    = @w_inst_activity


      if @w_error <> 0
      begin
         select @w_error = 150000 -- ERROR EN INSERCION,
         select @w_msg = 'Al ejecutra sp_xml_documentos_lcr_det'
         goto ERROR
      end
      
      delete @tabla where io_id_inst_proc=@w_inst_process

    end
   
end
else
begin
   print 'El oficial ' + convert(varchar(25),@w_user) + ' no tiene sincronizacion de documentos pendiente'
end

RETURN 0


ERROR:
begin 
	exec cobis..sp_cerror
  		@t_debug = 'N',
   		@t_file  = 'S',
   		@t_from  = @w_sp_name,
   		@i_num   = @w_error,
      	@i_msg   = @w_msg
    return @w_error
END

GO

