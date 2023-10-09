/************************************************************************/
/*   Archivo:              sp_xml_cuestionario.sp                       */
/*   Stored procedure:     sp_xml_cuestionario                          */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         ACHP                                         */
/*   Fecha de escritura:   07/08/2017                                   */
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
/* Registra informacion de los cuestionarios en las tablas              */
/* cob_sincroniza, si_sincroniza y genera el XML si_sincroniza_det      */
/************************************************************************/
/*                               CAMBIOS                                */
/*     FECHA         AUTOR            CAMBIO                            */
/*   03/08/2017     ACHP     Emision Inicial                            */
/*   15/03/2019     SRO      Corrección esquema secuenciales            */
/*                           en si_sincroniza                           */
/*   10/12/2019     SRO      Colectivos                                 */
/*   30/06/2021     SRO      Error #161777                              */
/*   02/05/2023     ACH      Error #200142                              */
/************************************************************************/
USE cob_credito
GO

if exists (select 1 from sysobjects where name = 'sp_xml_cuestionario')
drop proc sp_xml_cuestionario
go

create proc sp_xml_cuestionario (
    @i_inst_proc  int         = NULL,
	@i_modo       int         = 1
)
as
declare
@w_tramite             INT,
@w_cod_entidad         VARCHAR(10),
@w_codigo              INT,
@w_fecha_proceso       DATETIME,
@w_des_entidad         VARCHAR(64),
@w_accion              VARCHAR(255),
@w_observacion         VARCHAR(255),
@w_error               INT,
@w_sp_name             VARCHAR(32),
@w_msg                 VARCHAR(100),
@w_user                login,
@w_toperacion          catalogo,
@w_cliente             int,
@w_nombre_cl           varchar(64),
@w_grupal              bit,
@w_filas               int,
@w_oficial             smallint,
@w_oficial_superior    smallint,
@w_asesor_ext          int,
@w_aa_id_asig_act      int, 
@w_texto               varchar(max) = '',
@w_id_inst_act_parent  int,
@w_inst_actividad      int,
--Por caso#200142
@w_id_destinatario        int,
@w_ij_id_item_jerarquia   int,
@w_codigo_cat_rol         varchar(30),
@w_min_orden              int,
@w_id_rol_w               varchar(256)

select @w_sp_name = 'sp_xml_cuestionario'

SET ROWCOUNT 0

--Fecha de Proceso
SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso
SELECT @w_accion        = 'INGRESAR'
print '@i_inst_proc:'+convert(varchar, @i_inst_proc)

if @i_modo = 0 begin
--Tramite
   SELECT 
   @w_tramite              = io_campo_3, 
   @w_toperacion           = io_campo_4, 
   @w_cliente              = io_campo_1,
   @w_inst_actividad       = ia_id_inst_act
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
   and io_id_inst_proc     = @i_inst_proc
   
   if @@rowcount = 0
   begin
       select @w_error = 150000 -- ERROR EN INSERCION,
       select @w_msg = 'No existe informacion para esa instancia de proceso'
       goto ERROR
   end   
   
   select @w_id_inst_act_parent = id_inst_act_parent 
   from cob_workflow..wf_inst_actividad 
   where ia_id_inst_act = @w_inst_actividad
   
   select @w_aa_id_asig_act  = aa_id_asig_act
   from cob_workflow..wf_asig_actividad
   where  aa_id_inst_act     = @w_id_inst_act_parent 
   
   -- Observaciones
   select @w_observacion = @w_observacion + ' ' + ol_texto
   from cob_workflow..wf_observaciones OB, cob_workflow..wf_ob_lineas OL
   where OB.ob_id_asig_act = OL.ol_id_asig_act
   and ob_id_asig_act      = @w_aa_id_asig_act
   
end else if @i_modo = 1 begin
   
   SELECT 
   @w_tramite              = io_campo_3,
   @w_toperacion           = io_campo_4, 
   @w_cliente              = io_campo_1
   FROM cob_workflow..wf_inst_proceso 
   WHERE io_id_inst_proc = @i_inst_proc
   
end


IF EXISTS(SELECT 1 FROM cob_credito..cr_tramite WHERE tr_tramite = @w_tramite AND tr_grupal = 'S') -- GRUPAL
    SELECT @w_grupal = 1  -- GRUPAL
else
    SELECT @w_grupal = 0 -- INDIVIDUAL


if @w_toperacion <> 'REVOLVENTE' begin
    SELECT 
    @w_toperacion = op_toperacion,
    @w_oficial    = op_oficial,
    @w_cliente    = op_cliente,
    @w_nombre_cl  = op_nombre
    FROM cob_cartera..ca_operacion OP 
    WHERE op_tramite = @w_tramite

    --validaciOnEtapa
	update cr_ej_regla_aplica_cuest
    set er_in_etapa = 'N'
    where er_id_inst_proc = @i_inst_proc	
	
    ----Caso#200142
	-->Retorna el id del usuario a asignar la tarea
    begin try
       	print 'IniciaXXXX SP_DISTRIBUIDOR_CUESTIONARIO'
		exec @w_error = cob_workflow..SP_DISTRIBUIDOR_CUESTIONARIO
             @i_id_inst_proc     = @i_inst_proc,
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
    
	select @w_user = us_login from cob_workflow..wf_usuario where us_id_usuario = @w_id_destinatario
	
    print '<> REVOLVENTE - Proceso: ' + convert(varchar, @i_inst_proc) + '-->>Id rol Workflow: ' + convert(varchar, @w_codigo_cat_rol) + '-->>usuarioAsignado: @w_user: ' + convert(varchar, @w_user)
    
    if @w_user is null begin
        select @w_error = 150000 -- ERROR EN INSERCION,
        select @w_msg = 'No existe usuario con el rol: ' + convert(varchar, @w_id_destinatario)
        goto ERROR
    end

    --ASIGNACION DE USUARIO        
    select @w_id_rol_w = convert(int, va_valor_actual)
    from cob_workflow..wf_variable_actual
    where va_codigo_var   in (select vb_codigo_variable
      from cob_workflow..wf_variable
     where vb_abrev_variable = 'ROLWF')
    and va_id_inst_proc = @i_inst_proc

	update cr_ej_regla_aplica_cuest
    set er_login = @w_user,
        er_in_etapa = 'S'
    where er_id_inst_proc = @i_inst_proc
    and er_rol_w = @w_id_rol_w

end else begin
PRINT 'OTRO @w_cliente: ' + convert(varchar, @w_cliente)
   select @w_asesor_ext = ea_asesor_ext
   from cobis..cl_ente_aux
   where ea_ente       = @w_cliente
 PRINT @w_asesor_ext  
   SELECT @w_user = fu_login
   FROM cobis..cc_oficial, cobis..cl_funcionario
   WHERE oc_funcionario = fu_funcionario
   AND oc_oficial       = @w_asesor_ext
   PRINT @w_user
end

-- Comentarios
SELECT @w_observacion = isnull(@w_observacion,'INGRESAR CUESTIONARIO')

if(@w_toperacion = 'GRUPAL') begin
   select @w_des_entidad = valor, @w_cod_entidad = codigo
   from cobis..cl_catalogo
   where tabla = ( select codigo  
                   from cobis..cl_tabla
                   where tabla = 'si_sincroniza') 
				   and valor = 'CUESTIONARIO GRUPAL'    --Datos de la Entidad -- Grupal

end else if(@w_toperacion = 'INDIVIDUAL' ) begin
   select @w_des_entidad = valor, @w_cod_entidad = codigo
   from cobis..cl_catalogo
   where tabla = ( select codigo  
                   from cobis..cl_tabla
                   where tabla = 'si_sincroniza') 
				   and valor = 'CUESTIONARIO INDIVIDUAL'   --Datos de la Entidad -- Individual
end else if (@w_toperacion = 'REVOLVENTE') begin
   select @w_des_entidad = valor, @w_cod_entidad = codigo
   from cobis..cl_catalogo
   where tabla = ( select codigo  
                   from cobis..cl_tabla
                   where tabla = 'si_sincroniza') 
				   and valor = 'CUESTIONARIO COLECTIVO'
end 

print '@w_des_entidad:'+@w_des_entidad

if @w_des_entidad is null
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'Tipo de operacion no corresponde a GRUPAL/INDIVIDUAL'
    goto ERROR
end

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

create table #tmp_items_xml (
sec    int,
value  varchar(200),
numero int not null
)


create table #tmp_deudores (
cliente  int,
resultado  varchar(255),
nombre     varchar(300),
rol        char(1)
)

print 'rastro 4'
print @w_codigo
print @w_cod_entidad
print @w_des_entidad
print @w_user


if not exists (select 1 from cob_sincroniza..si_sincroniza where si_secuencial = @w_codigo) begin
   -- Insert en si_sincroniza
   INSERT INTO cob_sincroniza..si_sincroniza 
   (si_secuencial,           si_cod_entidad, si_des_entidad,
   si_usuario,               si_estado,      si_fecha_ing,
   si_fecha_sin,             si_num_reg)
   VALUES                             
   (@w_codigo,               @w_cod_entidad, @w_des_entidad,
   @w_user,                  'P',            GETDATE(),
   NULL,                     1)
   
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

print 'rastro 5'
-- Insert en si_sincroniza_det
exec @w_error            = sp_xml_cuestionario_det
    @i_fecha_proceso     = @w_fecha_proceso,
    @i_max_si_sincroniza = @w_codigo,
    @i_inst_proc         = @i_inst_proc,
    @i_tramite           = @w_tramite,
    @i_cliente           = @w_cliente,
    @i_nombre_cl         = @w_nombre_cl,
    @i_grupal            = @w_grupal,
    @i_accion            = @w_accion,
    @i_observacion       = @w_observacion,
    @i_toperacion        = @w_toperacion,
    @o_filas             = @w_filas output

if @w_error <> 0
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'Al ejecutra sp_xml_cuestionario_det'
    goto ERROR
end

if @w_filas<>0
    update cob_sincroniza..si_sincroniza set
    si_num_reg = @w_filas
    where si_secuencial = @w_codigo
else
    DELETE FROM  cob_sincroniza..si_sincroniza
    WHERE si_secuencial = @w_codigo

return 0

ERROR:
    begin --Devolver mensaje de Error
        exec cobis..sp_cerror
             @t_debug = 'N',
             @t_file  = 'S',
             @t_from  = @w_sp_name,
             @i_num   = @w_error,
             @i_msg   = @w_msg
        return @w_error
    end

go
