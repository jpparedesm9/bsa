/*************************************************************************/
/*   Archivo:            sp_respuesta_val_bio.sp                         */
/*   Stored procedure:   sp_respuesta_val_bio                            */
/*   Base de datos:      cob_credito                                     */
/*   Producto:           Crédito                                         */
/*   Disenado por:       Sonia Rojas                                     */
/*   Fecha de escritura: 06/05/2022                                      */
/*************************************************************************/
/*                             IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "COBISCORP"                                                         */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante.              */
/*************************************************************************/
/*                              PROPOSITO                                */
/*   Este programa se encarga de ejecutar la conversión al formato xml   */
/*                                                                       */
/*************************************************************************/
/*                             OPERACIONES                               */
/*   OPER. OPCION                     DESCRIPCION                        */
/*************************************************************************/
/*                           MODIFICACIONES                              */
/*   FECHA         AUTOR          RAZON                                  */
/*   06-05-2022    Sonia Rojas    Emisión Inicial                        */
/*************************************************************************/
USE cob_credito
go

IF OBJECT_ID ('dbo.sp_respuesta_val_bio') IS NOT NULL
    DROP PROCEDURE dbo.sp_respuesta_val_bio
GO

create proc sp_respuesta_val_bio (
   @s_ssn               int         = null,
   @s_ofi               smallint,
   @s_user              login,
   @s_date              datetime,
   @s_srv               varchar(30) = null,
   @s_term              descripcion = null,
   @s_rol               smallint    = null,
   @s_lsrv              varchar(30) = null,
   @s_sesn              int         = null,
   @t_debug             char(1)     = 'N',
   @t_file              varchar(14) = null,
   @t_from              varchar(30) = null,
   @i_toperacion        varchar(100),
   @i_promocion         char(2),
   @i_monto             money,
   @i_ente              int,
   @i_id_inst_proc      int
)as
declare 
@w_sp_name            varchar(255),
@w_error              int,
@w_valores            varchar(255),
@w_nombre             varchar(10),
@w_apellido_paterno   varchar(10),
@w_apellido_materno   varchar(10),
@w_resultado          varchar(255),
@w_secuencia          int


select @w_sp_name 	= 'sp_respuesta_val_bio'
select  @w_valores = @i_toperacion + '|' + @i_promocion + '|' + convert(varchar, @i_monto )
   	
exec @w_error           = cob_cartera..sp_ejecutar_regla
@s_ssn                  = @s_ssn,
@s_ofi                  = @s_ofi,
@s_user                 = @s_user,
@s_date                 = @s_date,
@s_srv                  = @s_srv,
@s_term                 = @s_term,
@s_rol                  = @s_rol,
@s_lsrv                 = @s_lsrv,
@s_sesn                 = @s_sesn,
@i_regla                = 'EXVALBIO', 
@i_tipo_ejecucion       = 'REGLA',     
@i_valor_variable_regla = @w_valores,
@o_resultado1           = @w_resultado out
	  
if @w_error <> 0 goto ERROR

--En el caso que tenga que regresar a evaluar
if exists (select 1 from cobis..cl_respuesta_bio where rb_ente = @i_ente and rb_inst_proc = @i_id_inst_proc and rb_aprobado_por_monto = 'S')
    delete from cobis..cl_respuesta_bio where rb_ente = @i_ente and rb_inst_proc = @i_id_inst_proc and rb_aprobado_por_monto = 'S'

if (@w_resultado is not null and @w_resultado = '0') begin --CUMPLE
    
	if not exists (select 1 from cobis..cl_respuesta_bio where rb_ente = @i_ente and rb_inst_proc = @i_id_inst_proc) begin
	
	    exec @w_error  = cobis..sp_cseqnos
        @t_debug       = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_tabla       = 'cl_respuesta_bio',
        @o_siguiente   = @w_secuencia out
        
        if @w_error <> 0 goto ERROR
	    
        select 
        @w_nombre           =  case when en_nombre is null then 'FALSE' else 'TRUE' end,
        @w_apellido_paterno =  case when p_p_apellido is null then 'FALSE' else 'TRUE' end,
        @w_apellido_materno =  case when p_s_apellido is null then 'FALSE' else 'TRUE' end 
        from cobis..cl_ente
        where en_ente = @i_ente
        
	    if @@rowcount = 0 begin 
           select @w_error = 101146
	       goto ERROR
        end
	    
        insert cobis..cl_respuesta_bio 
        (rb_secuencia,                          rb_ente,                             rb_fecha_registro,                      rb_tipo_situacion_registral, 
        rb_tipo_reporte_robo_extravio,          rb_ano_registro,                     rb_clave_elector,                       rb_apellido_paterno, 
        rb_ano_emision,                         rb_numero_emision_credencial,        rb_nombre,                              rb_apellido_materno, 
        rb_indice_izquierdo,                    rb_indice_derecho,                   rb_hash,                                rb_sequential,
        rb_inst_proc,                           rb_valida_huella,                    rb_aprobado_por_monto,                  rb_resultado) 
        VALUES                                  
	    (@w_secuencia,                          @i_ente,                             getdate(),                              null, 
         null,                                  null,                                null,                                   @w_apellido_paterno, 
         null,                                  null,                                @w_nombre,                              @w_apellido_materno, 
         null,                                  null,                                null,                                   null,
         @i_id_inst_proc,                       'N',                                 'S',                                    'APROBADO')
        
        if @@error <> 0 begin 
           select @w_error = 103118
           goto ERROR
        end  
	end
end

return 0

ERROR:
return @w_error
   
go